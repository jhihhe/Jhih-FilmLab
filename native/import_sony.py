#!/usr/bin/env python3
"""Author: @Jhih he. Strict import of pinned Sony recipe data; no Java execution.
Original recipe copyright André Domingues, MIT; see vendor/sony-recipe-lab.
"""
import hashlib,json,pathlib,re,struct,math
ROOT=pathlib.Path(__file__).resolve().parents[1]
SOURCE=ROOT/'vendor/sony-recipe-lab/Recipes.java'
FIELDS=['style','sat','con','sharp','matrix','wbMode','kelvin','ab','gm','pe','ev','dro','sub']
GROUPS=['索尼','富士模拟','富士胶片','柯达','电影','理光 GR','徕卡','哈苏','佳能 / 尼康','松下 / 奥林巴斯','其他胶片','伊尔福德']
GROUP_KEYS=['SONY','FSIM','FFILM','KODAK','CINE','RICOH','LEICA','HASSEL','CANIK','PANOLY','OTHER','ILFORD']
CONSTANTS=dict(zip(GROUP_KEYS,range(12)))
CONSTANTS.update(STD=1,VIVID=2,NEUTRAL=3,PORTRAIT=4,LANDSCAPE=5,MONO=6,CLEAR=7,DEEP=8,LIGHT=9,SUNSET=10,NIGHT=11,AUTUMN=12,SEPIA=14,AUTO=1,K=14,DRO_AUTO=6)
def load():
 text=SOURCE.read_text();body=text.split('public static final Recipe[] ALL = {',1)[1].split('\n    };',1)[0]
 matches=list(re.finditer(r'new Recipe\(([^,]+),\s*"([^"\\]*)"\s*,([^)]*)\)',body))
 if len(matches)!=77 or body.count('new Recipe(')!=77:raise ValueError('Expected exactly 77 fully parsed recipes')
 result=[]
 for i,m in enumerate(matches,1):
  group=CONSTANTS[m[1].strip()];values=[]
  for token in m[3].split(','):
   token=token.strip();values.append(CONSTANTS[token] if token in CONSTANTS else int(token))
  if len(values)==9:values += [0,0,6,0]
  elif len(values)==12:values += [0]
  elif len(values)!=13:raise ValueError('Unknown recipe constructor')
  original=dict(zip(FIELDS,values));fp={k:int(math.copysign(math.floor(min(abs(original[k]),3)*5/3+0.5),original[k])) for k in ['con','sharp','sat']}
  mode_map={1:0,2:1,3:2,4:3,5:4,6:11,7:0,8:1,9:13,10:7,11:2,12:7,14:11}
  if original['wbMode'] not in [1,14]:raise ValueError('Unsupported source WB mode')
  fp.update(colorMode=mode_map[original['style']],wbMode=70 if original['wbMode']==14 else 41,kelvin=original['kelvin'],ab=original['ab'],gm=-original['gm'])
  pending=['style_approximation'] if original['style'] in [7,8,9,10,11,12,14] else []
  pending += ['wb_offset_direction_uncalibrated']
  pending += [k for k in ['matrix','pe','ev','sub'] if original[k]!=0]
  pending += ['dro']
  clamp=[k for k in ['con','sharp','sat'] if abs(original[k])>3]
  if fp['colorMode']==11:fp['sat']=0
  if original['pe']==7:fp.update(colorMode=11,con=5,sat=0)
  if original['pe']==2:fp['sat']=5
  pending += ['normalized_strength_heuristic','wb_step_equivalence_unmeasured']
  result.append(dict(id=i,source_id=i,source_key=f'sony-{i:02d}',origin='sony-upstream',name=m[2],group_id=group,group=GROUPS[group],sony=original,fp=fp,pending_fields=pending,clamped_fields=clamp))
 return result

def catalog():
 source_rows=load()
 config=json.loads((ROOT/'native/hasselblad-presets.json').read_text())
 extra=[]
 for p in config['presets']:
  extra.append(dict(id=0,source_id=None,source_key=p['key'],origin='filmlab-hasselblad-inspired',name=p['name'],group_id=7,group=GROUPS[7],sony=None,fp=p['fp'],pending_fields=['hncs_not_recreated','wb_offset_direction_uncalibrated']+(['community_controls_not_supported'] if 'reference_parameters' in p else []),clamped_fields=[],hud_token=p['hud_token'],provenance=p))
 rows=[r for r in source_rows if r['group_id']==7]+extra+[r for g in [1,2,5,6] for r in source_rows if r['group_id']==g]+[r for r in source_rows if r['group_id'] not in [7,1,2,5,6]]
 names=json.loads((ROOT/'native/bilingual-names.json').read_text())['names']
 count=len(rows)
 for i,r in enumerate(rows,1):
  r['id']=i
  r['fp']['toning']=7 if r['sony'] and r['sony']['style']==14 else 0
  if r['origin']=='filmlab-hasselblad-inspired' and r['fp']['wbMode']==0:r['fp']['wbMode']=41
  r['adaptation_method']='v0.5: Sony normal ±3 mapped to Sigma ±5 indices (rounded, capped); AutoNatural 41; Sigma-authored additions retain native strength; monochrome saturation zero; unsupported effects remain approximations'
  r['capture_evidence']={'reference_series':'FP006006,FP006007,FP006008,FP006010,FP006011','coverage':'Standard Auto(Natural) user-operated WB axes only','direction_trend_observed':True,'firmware_integer_sign_verified':False,'sony_step_equivalence_verified':False,'target_color_mode_measured':r['fp']['colorMode']==0,'recipe_effect_measured':False}
  n=names[r['source_key']]
  scheme_zh=r['name']
  for prefix in ['哈苏参考 · ','哈苏 ','索尼 ','富士 ','GR ','徕卡 ','佳能 ','尼康 ','松下 ','奥林巴斯 ','爱克发 ','伊尔福德 ','柯达 ']:
   if scheme_zh.startswith(prefix):scheme_zh=scheme_zh[len(prefix):];break
  r['names']={**n,'scheme_zh':scheme_zh,'full_zh':n['brand_zh']+' · '+scheme_zh,'full_en':n['brand_en']+' · '+n['scheme_en']}
  shortbrands={'Hasselblad':'HAS','Fujifilm':'FUJI','Ricoh GR':'GR','Panasonic':'PANA','CineStill':'CS','Polaroid':'POLA'}
  brand=shortbrands.get(n['brand_en'],n['brand_en'].upper())
  token=n['scheme_en'].replace(' ','').replace('YellowFilter','Y').replace('RedFilter','R').replace('GreenFilter','G').replace('BleachBypass','Bleach').replace('HighContrast','HiCon').replace('AsteroidCity','Asteroid').replace('NostalgicNegative','NostalgicNeg').replace('Contemporary','Contemp').replace('Community','Comm')
  label=brand+'-'+token
  if len(label)>25:raise ValueError('HUD name exceeds 25 characters: '+label)
  r['hud_en']=f'{i:02d}/{count} '+label
  r['hud_compact']=r['names']['brand_zh']+' · '+r['names']['scheme_en']
  fp=r['fp']
  style={0:'自然色彩',1:'鲜艳色彩',2:'中性柔和',3:'人像色彩',4:'风景色彩',5:'复古电影',7:'暖红色彩',8:'绿色突出',11:'黑白层次',13:'明亮淡蓝'}[fp['colorMode']]
  detail=[style]
  if fp['con']<0:detail.append('柔和反差')
  elif fp['con']>0:detail.append('强反差')
  if fp['colorMode']!=11 and fp['sat']<0:detail.append('低饱和')
  elif fp['colorMode']!=11 and fp['sat']>0:detail.append('高饱和')
  elif fp['sharp']<0:detail.append('低锐度')
  r['style_description_zh']='，'.join(detail)
  r['hud_detail']=f'{i:02d}/{count} · '+r['style_description_zh']
  r['hud']=r['hud_compact']+'\n'+r['hud_detail']

 return rows

def generate():
 rows=catalog();count=len(rows)
 meta=dict(author='@Jhih he',source='https://github.com/jcx396905-gif/recipe-lab-sony-pmca-cn',commit='0107d7a358acac2f8bdb8e6f89081c8cc9ee6b57',source_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest(),source_count=77,additional_count=count-77,count=count,status='v0.5-range-normalized-capture-informed-approximation',recipes=rows)
 meta['native_baseline']={'effect':0,'toning_default':0,'toning_sepia_candidate':7,'raw_snapshot_restored':True,'hardware_verified':False}
 (ROOT/'native/data/film-catalog.json').write_text(json.dumps(meta,ensure_ascii=False,indent=2)+'\n')
 (ROOT/'native/data/catalog.inc').write_text(f'.equ RECIPE_COUNT, {count}\n')
 # Record layout unchanged; zero original fields and provenance flag for extras.
 records=bytearray();strings=bytearray();starts=[]
 for r in rows:
  starts.append(len(strings));strings+=r['hud'].encode('utf-8')+b'\0'
  strings+=r['name'].encode('utf-8')+b'\0'
 for r,start in zip(rows,starts):
  records+=struct.pack('<24i',r['fp']['con'],r['fp']['sharp'],r['fp']['sat'],r['fp']['colorMode'],r['fp']['wbMode'],r['fp']['kelvin'],r['fp']['ab'],r['fp']['gm'],r['group_id'],*[r['sony'][k] if r['sony'] else 0 for k in FIELDS],count*96+start,int(r['sony'] is None))
 blob=bytes(records+strings);blob+=bytes(-len(blob)%4)
 (ROOT/'native/data/film-catalog.bin').write_bytes(blob)
 lines=[f'# Jhih‘s FilmLab {count} 配方清单','', '作者：@Jhih he。完整原始参数保留；机内应用色彩模式、对比度、锐度、饱和度、白平衡、色温及两轴偏移；效果未实机校准。','', '|编号（原Sony编号）|品牌|配方名|fp 色彩/WB/K/AB/GM|fp 对比/锐度/饱和/Toning|裁剪|待实现参数|','|---|---|---|---|---|---|---|']
 for r in rows:lines.append(f"|{r['id']}（{r['source_id'] or '新增'}）|{r['group']}|{r['name']}|{r['fp']['colorMode']}/{r['fp']['wbMode']}/{r['fp']['kelvin']}/{r['fp']['ab']}/{r['fp']['gm']}|{r['fp']['con']}/{r['fp']['sharp']}/{r['fp']['sat']}/{r['fp']['toning']}|{','.join(r['clamped_fields']) or '无'}|{','.join(r['pending_fields'])}|")
 (ROOT/'docs/film-catalog.md').write_text('\n'.join(lines)+'\n')
 return meta
if __name__=='__main__':print('Imported',generate()['count'],'FilmLab recipes')
