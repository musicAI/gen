
# namespace for Music Generator

MG = @MG ? {}
MG.instrs =
  'Piano': ['1 Acoustic Grand Piano', '2 Bright Acoustic Piano', '3 Electric Grand Piano', '4 Honky-tonk Piano', '5 Electric Piano 1', '6 Electric Piano 2', '7 Harpsichord', '8 Clavinet'],
  'Chromatic Percussion': ['9 Celesta', '10 Glockenspiel', '11 Music Box', '12 Vibraphone', '13 Marimba', '14 Xylophone', '15 Tubular Bells', '16 Dulcimer'],
  'Organ': ['17 Drawbar Organ', '18 Percussive Organ', '19 Rock Organ', '20 Church Organ', '21 Reed Organ', '22 Accordion', '23 Harmonica', '24 Tango Accordion'],
  'Guitar': ['25 Acoustic Guitar (nylon)', '26 Acoustic Guitar (steel)', '27 Electric Guitar (jazz)', '28 Electric Guitar (clean)', '29 Electric Guitar (muted)', '30 Overdriven Guitar', '31 Distortion Guitar', '32 Guitar Harmonics'],
  'Bass': ['33 Acoustic Bass', '34 Electric Bass (finger)', '35 Electric Bass (pick)', '36 Fretless Bass', '37 Slap Bass 1', '38 Slap Bass 2', '39 Synth Bass 1', '40 Synth Bass 2'],
  'Strings': ['41 Violin', '42 Viola', '43 Cello', '44 Contrabass', '45 Tremolo Strings', '46 Pizzicato Strings', '47 Orchestral Harp', '48 Timpani'],
  'Ensemble': ['49 String Ensemble 1', '50 String Ensemble 2', '51 Synth Strings 1', '52 Synth Strings 2', '53 Choir Aahs', '54 Voice Oohs', '55 Synth Choir', '56 Orchestra Hit'],
  'Brass': ['57 Trumpet', '58 Trombone', '59 Tuba', '60 Muted Trumpet', '61 French Horn', '62 Brass Section', '63 Synth Brass 1', '64 Synth Brass 2'],
  'Reed': ['65 Soprano Sax', '66 Alto Sax', '67 Tenor Sax', '68 Baritone Sax', '69 Oboe', '70 English Horn', '71 Bassoon', '72 Clarinet'],
  'Pipe': ['73 Piccolo', '74 Flute', '75 Recorder', '76 Pan Flute', '77 Blown Bottle', '78 Shakuhachi', '79 Whistle', '80 Ocarina'],
  'Synth Lead': ['81 Lead 1 (square)', '82 Lead 2 (sawtooth)', '83 Lead 3 (calliope)', '84 Lead 4 (chiff)', '85 Lead 5 (charang)', '86 Lead 6 (voice)', '87 Lead 7 (fifths)', '88 Lead 8 (bass + lead)'],
  'Synth Pad': ['89 Pad 1 (new age)', '90 Pad 2 (warm)', '91 Pad 3 (polysynth)', '92 Pad 4 (choir)', '93 Pad 5 (bowed)', '94 Pad 6 (metallic)', '95 Pad 7 (halo)', '96 Pad 8 (sweep)'],
  'Synth Effects': ['97 FX 1 (rain)', '98 FX 2 (soundtrack)', '99 FX 3 (crystal)', '100 FX 4 (atmosphere)', '101 FX 5 (brightness)', '102 FX 6 (goblins)', '103 FX 7 (echoes)', '104 FX 8 (sci-fi)'],
  'Ethnic': ['105 Sitar', '106 Banjo', '107 Shamisen', '108 Koto', '109 Kalimba', '110 Bagpipe', '111 Fiddle', '112 Shanai'],
  'Percussive': ['113 Tinkle Bell', '114 Agogo', '115 Steel Drums', '116 Woodblock', '117 Taiko Drum', '118 Melodic Tom', '119 Synth Drum'],
  'Sound effects': ['120 Reverse Cymbal', '121 Guitar Fret Noise', '122 Breath Noise', '123 Seashore', '124 Bird Tweet', '125 Telephone Ring', '126 Helicopter', '127 Applause', '128 Gunshot']

MG.percussion =
  27 : "High-Q", 28 : "Slap", 29 : "Scratch Push", 30 : "Scratch Pull", 31 : "Sticks", 32 : "Square Click", 33 : "Metronome Click",
  34 : "Metronome Bell", 35 : "Acoustic Bass Drum", 36 : "Bass Drum", 37 : "Side Stick", 38 : "Acoustic Snare", 39 : "Hand Clap", 40 : "Electric Snare",
  41 : "Low Floor Tom", 42 : "Closed Hi Hat", 43 : "High Floor Tom",
  44 : "Pedal Hi-Hat", 45 : "Low Tom", 46 : "Open Hi-Hat", 47 : "Low-Mid Tom",
  48 : "Hi-Mid Tom", 49 : "Crash Cymbal 1", 50 : "High Tom", 51 : "Ride Cymbal 1", 52 : "Chinese Cymbal", 53 : "Ride Bell", 54 : "Tambourine", 55 : "Splash Cymbal",
  56 : "Cowbell", 57 : "Crash Cymbal 2", 58 : "Vibraslap", 59 : "Ride Cymbal 2", 60 : "Hi Bongo", 61 : "Low Bongo", 62 : "Mute Hi Conga", 63 : "Open Hi Conga",
  64 : "Low Conga", 65 : "High Timbale", 66 : "Low Timbale", 67 : "High Agogo", 68 : "Low Agogo", 69 : "Cabasa", 70 : "Maracas", 71 : "Short Whistle",
  72 : "Long Whistle",
  73 : "Short Guiro", 74 : "Long Guiro", 75 : "Claves", 76 : "Hi Wood Block", 77 : "Low Wood Block", 78 : "Mute Cuica", 79 : "Open Cuica",
  80 : "Mute Triangle", 81 : "Open Triangle", 82 : "Shaker", 83 : "Jingle Bell", 84 : "Bell Tree", 85 : "Castanets", 86 : "Mute Surdo", 87 : "Open Surdo"


MG.arpeg = {
  "123" : [
    "123", # block, 1 onset
    "13",

    "123 123", # 2 onsets
    "13 13",
    "1 23",
    "1,2 23",

    "1 23 23",
    "1 2 3",
    "1 3 2",


    "1 3 2 3",
    "1 2 3 2",

    "1 2 3 2 3 2"

  ],
  "1231+": [
    "1234",
    "134",

    "1 234",

    "1 2 3 4",
    "1 3 4 3",


    "1 2 3 4 3 2"

  ],
  "132+": [
    "1 2 3 2 3 2 3 2",

  ],
  "1-131+": [
    "12 3 4 3",
    "12,2 2 3 4,2 3,2"
  ]


}

MG.texture = (->

)()



# chord array
MG.chord_class =
  "maj":[0,4,7],
  "min":[0,3,7],
  "dim":[0,3,6],
  "aug":[0,4,8],
  "sus2": [0,2,7],
  "sus4": [0,5,7],

  "dom7":[0,4,7,10],
  "dom7b5":[0,4,6,10],
  "min7":[0,3,7,10],
  "min7b5":[0,3,6,10], # half diminished
  "aug7":[0,4,8,10], # dom7#5

  "maj7":[0,4,7,11],
  "maj7b5":[0,4,6,11],
  "min7#":[0,3,7,11],
  "aug7#": [0,4,8,11],

  "dim7":[0,3,6,9],
  "add9":[0,2,4,7], # add2
  "minadd11": [0,3,5,7],
  "add11": [0,4,5,7] # add4


MG.chord_class_label =
  "maj": "Major triad",
  "min": "Minor triad",
  "aug": "Augmented triad",
  "dim": "Diminished triad",
  "dom7": "Dominant seventh chord",
  "maj7": "Major seventh chord",
  "min7": "Minor seventh chord",
  "aug7": "Augmented seventh chord",
  "dim7": "Diminished seventh chord",

  "min7b5": "Half diminished chord",
  "min7#": "Minor seventh shart fifth chord",


  "sus2": "Suspended second chord",
  "sus4": "Suspended fourth chord"
  "add9": "Add ninth chord",
  "add11": "Add eleventh chord"



# return inverted chord
MG.inverted = (arr,n) ->
  n ?= 1
  n = n %% arr.length
  ret = new Array(arr.length)
  for i in [0...arr.length] by 1
    ret[i] = (arr[(n+i) % arr.length] - arr[n]) %% 12
  return ret

# all chords including invertion
# chord alias handled when parsing
MG.chords = ( ->
  res = {}
  for c,v of MG.chord_class
    ci = c + ''
    for i in [0...v.length] by 1
      res[ci] = MG.inverted(v,i)
      ci += 'i'
  return res;
)()

MG.chord_finder = (->
  #console.log 'find chord', Object.keys(MG.chords).length
  ret = {}
  for k,v of MG.chords
    if v.toString() of ret
      #console.log k,v, ret[v.toString()]
    else
      ret[v.toString()] = k
  ret[[0, 5, 7].toString()] = 'sus4'
  #console.log 'uninque', Object.keys(ret).length
  return ret
)()


# intervals
MG.interval_class =
  'u1': 0,
  'm2': 1, 'M2': 2,
  'm3': 3, 'M3': 4,
  'p4': 5, 'a4': 6,
  'd5': 6, 'p5': 7,
  'm6': 8, 'M6': 9,
  'm7': 10, 'M7': 11,
  'o8': 12
MG.consonant_interval = ['u1','p4','p5','m6','M6','o8',0,3,4,5,7,8,9]
MG.dissonant_interval = ['m2','M2','a4','d5','m7','M7',1,2,6,10,11]

# key name to pitch modulo 12
MG.key_class = ( ->
  kn1 = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  kn2 = ['B#', 'C#', 'D', 'D#', 'Fb', 'E#', 'F#', 'G', 'G#', 'A', 'A#', 'Cb']
  res = {}
  kn1.forEach (e,i)->
    res[e] = i
    return
  kn2.forEach (e,i)->
    res[e] = i
    return
  return res
)()

# scale array
# TODO: consider the difference of tonic and key_sig
MG.scale_class =
  'maj': [0,2,4,5,7,9,11],
  'min': [0,2,3,5,7,8,10],
  'min_harmonic': [0,2,3,5,7,8,11],
  'maj_harmonic': [0,2,4,5,8,9,11],
  'min_melodic': [0,2,3,5,7,9,11], # up, down = min
  'chromatic': [0,1,2,3,4,5,6,7,8,9,10,11], # use a-e for 10-15
  'octatonic': [0,1,3,4,6,7,9,10],
  'whole': [0,2,4,6,8,10],
  # add [Dorian, Phrygian, Lydian, Mixolydian]
  'dorian': [0,2,3,5,7,9,10],
  'lydian': [0,2,4,6,7,9,11],
  'pent': [0,2,4,7,9], # Gong
  # add [Gong, Shang, Jue, Zhi, Yu]
  'pent_min': [0,3,5,7,10], # Yu
  'zhi': [0,2,5,7,9],
  'blues': [0,3,5,6,7,10]

@white_key_num = MG.scale_class['maj']
@black_key_num = [1,3,6,8,10]

# 'C4' == 4 * scale_len + 0, etc
MG.scaleToPitch = (mode, tonic) ->
  scale = MG.scale_class[mode] ? MG.scale_class['maj']
  ref = MG.key_class[tonic] ? 0
  return (num) ->
    return ref + (num // scale.length) * 12 + scale[num %% scale.length] + 12 # lowest 12

# return format [scale_num, oct, sharp]
MG.pitchToScale = (mode, tonic) ->
  scale = MG.scale_class[mode] ? MG.scale_class['maj']
  ref = MG.key_class[tonic] ? 0
  return (pitch) ->

    pitch -= ref
    oct = pitch // 12 - 1
    pitch = pitch %% 12
    for i in [scale.length-1 ..0] by -1
      if pitch >= scale[i]
        return [i, oct, pitch - scale[i]]
    return [0, oct, pitch-scale[0]]


MG.testPitchScaleConversion = ()->
  for scale, mode of MG.scale_class
    flag = true
    for tonic of MG.key_class
      toPitch = MG.scaleToPitch(scale, tonic)
      toScale = MG.pitchToScale(scale, tonic)
      for i in [21..108]
        tmp = toScale(i)
        j = toPitch(tmp[0]+mode.length*tmp[1]) + tmp[2]
        if j != i
          flag = false
          console.log tonic, scale, i, tmp, j
    if flag
      console.log scale, 'success'
  return

# compatible for such format; C4 C/4 4C etc
MG.keyToPitch = (key) ->
  key_class = /[A-G][#b]{0,2}/.exec(key)[0]
  key_class ?= 'C'
  ref = MG.key_class[key_class] ? 0
  oct = /[0-9]/.exec(key)[0]
  oct = parseInt(oct) ? 4
  return 12 + ref + oct * 12



MG.pitchToKey = (pitch, sharp, nooct) ->
  if pitch < 21 || pitch > 108
    return undefined
  kn = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  if sharp == true
    kn = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
  ref = pitch % 12
  return if nooct? then kn[ref] else [kn[ref],pitch // 12 -1]

MG.testPitchKeyConversion = ()->
  flag = true
  for i in [21..108]
    tmp = MG.pitchToKey(i,true)
    j = MG.keyToPitch(tmp[0]+tmp[1])
    if j != i
      flag = false
      console.log i, tmp, j
  if flag
    console.log 'success'
  return

# transpose pitch in scale degree
MG.transposer = (scale_name, key_sig) ->
  scale_name ?= 'chromatic'
  console.log scale_name, 'transposer'
  key_sig ?= 'C'
  scale_len = MG.scale_class[scale_name].length # default chromatic
  toScale = MG.pitchToScale(scale_name, key_sig)
  toPitch = MG.scaleToPitch(scale_name, key_sig)
  return (pitch, diff)->
    tmp = toScale(pitch)
    return toPitch(tmp[0]+tmp[1]*scale_len+diff) + tmp[2]


# chord alias
alias = {'7':'dom7','':'maj','M':'maj','m':'min','mi':'min','m7':'min7', 'm7#':"min7#", 'm7b5': 'min7b5'}
roman = (->
  arr = ['i','ii','iii','iv','v','vi','vii']
  res = {}
  arr.forEach (e,i)->
    res[e.toUpperCase()] = res[e] = i
  return res
)()

# return format [bass, pitches[]]
MG.getChords = (chord_str, oct, key_sig)->
  ex = /[A-G][b#]{0,2}/
  ex2 = /([VvIi]+)([b#]{0,2})/
  key_sig ?= 'C' # for chords in degree
  oct ?= 4
  r = ex.exec(chord_str)
  root = 'C'
  lastIndex = 0
  if r != null
    root = r[0]
    lastIndex = r.index + r[0].length
  else
    r = ex2.exec(chord_str)
    if r != null
      root = MG.scale_keys[key_sig][roman[r[1]]] + (r[2] || '')
      root = root.replace(/b#/g,'').replace(/#b/g,'')
      lastIndex = r.index + r[0].length

  root_pitch = MG.keyToPitch(root + oct)
  chord_name = chord_str.substr(lastIndex)
  chord_name = alias[chord_name] ? chord_name
  chord_pitches = MG.chords[chord_name] || MG.chords['maj'] # default maj
  return [root_pitch, chord_pitches]

# key to roman numeral
MG.keyToRoman = (key_sig)->
  key_sig ?= 'C'
  arr = ['I','II','III','IV','V','VI','VII']
  toScale = MG.pitchToScale('maj',key_sig)
  return (key)->
    pitch = MG.keyToPitch(key + '4')
    tmp = toScale(pitch)
    num = arr[tmp[0]]
    if tmp[2]>0
      num += '#'
    return num


# MIDI key_sig, positive (negative) for sharp (flat) key
MG.key_sig_rev = {}
MG.key_sig = (()->
  kn = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  res = {}
  for i in [0...12] by 1
    j = (i*7)%12;
    l = (i+6)%12 - 6;
    res[kn[j]] = l;
    MG.key_sig_rev[l] = kn[j];

  res['F#'] = 6;
  MG.key_sig_rev[6] = 'F#'
  return res
)()

# all valid note names for the pitch class
MG.keyNames = (()->
  res = new Array(12).fill(0).map (e)-> []
  ref = MG.scale_class['maj']
  "CDEFGAB".split("").forEach (key,i)->
    #console.log ref[i]
    res[(ref[i]-2) %% 12].push(key + 'bb')
    res[(ref[i]-1) %% 12].push(key + 'b')
    res[ref[i] % 12].push(key)
    res[(ref[i]+1) % 12].push(key + '#')
    res[(ref[i]+2) % 12].push(key + '##')
  return res
)()

# note names in the major scale
MG.scale_keys = (()->
  kn = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']
  res = {}
  res['C'] = "CDEFGAB".split("")
  ref = MG.scale_class['maj']
  kn.forEach (e,i)->
    if e == 'C'
      return
    res[e] = [e]
    for j in [1...ref.length] by 1
      pitch = (i + ref[j]) % 12
      notes = MG.keyNames[pitch]

      for k,v of notes
        if v[0] == res['C'][(res['C'].indexOf(e[0])+j)%7]
          res[e].push v
          break
  return res
)()


# TODO: change chord to random
MG.gen_modes = ['random', 'transpose', 'chord', 'reverse', 'diminuation', 'augmentation']

MG.sample_seeds =
  "s3":
    "mode": "distribution",
    "dur": 12,
    "choices": [[4,4,4]],
    "weights": [1]
  "s0":
    "mode": "distribution",
    "dur": 12,
    "choices": [
      [
        4,
        4,
        4
      ],
      [
        12
      ]
    ],
    "weights": [
      5,
      2
    ]
  's1':
    mode: "distribution",
    dur: 16,
    choices: ('4 4 4 4/8 4 4/4 4 8/4 8 4/4 12/12 4/8 8/16'.split('/').map (e)->
      e.split(/\s+/).map (e2)-> parseInt(e2)
    )
    weights:
      [1,3,3,5,1,5,8,8]
  's2':
    mode: "distribution",
    weights: [1,2,5,12,6,30,  8,30,12,8,3,1,1],
    choices: (->
      Array(13).fill().map (e,i)->
        i-6
    )()


@schema_summer = MG.schema_summer =
  'S':
    structure: "c/A/B/Br/A/C/c".split('/'),
    node: {
      'c':{ # terminal
        mode: 'random'
        dur: 4 * 8
        incomplete_start: 32
        chord_tone : 4
        scale_tone : [2,1,1,0.5,2,1,0.5]

        chords : [
          "E7"
        ]
        rhythm:
          seed: 's1'
          swarp: 0.5
        interval:
          chromatic: false
          seed: 's2'
      },
      'A':{ # terminal
        mode:'random'
        dur: 32 * 8
        chord_tone : 4
        chromatic_tone : 0.5
        chords: [
          "Amin",
          "Bb7",
          "Amin E7",
          "Amin A7"
        ]
        rhythm:
          seed: 's1'
          swarp: 0.5

        interval:
          chromatic: false
          seed: 's2'
        range: [56, 77],
        dist: 'linear'
      },
      'B':{
        structure: ['A'],
        action: {
          'A': {
            mode:'transpose'
            dur: 16 * 8
            offset: 0,
            scale: 'maj',
            interval: 3
          }
        }
      },
      'Br':{
        structure: ['B'],
        action: {
          'B': {
            mode:'reverse',
            deep: true
          }
        }

      },
      'C':{ # terminal
        mode: 'random',
        dur: 28 * 8
        incomplete_end: 32
        chord_tone : 4
        chords: "C Am/D7 E7/Am D7/Bm7".split('/'),
        rhythm:
          seed: 's1'
          swarp: 0.5
        interval:
          chromatic: false,
          seed: 's2'
        range: [56, 77],
        dist: 'quadratic'
      }

    },

  's1': MG.sample_seeds['s1']

  's2': MG.sample_seeds['s2']

MG.schemaAdd = (schema, ident, node, action)->
  if node?
    schema.node[ident] = node
  if action?
    schema.action['_'+schema.structure.length+'_'+ident] = action
  schema.structure.push ident
  return

MG.schemaBuilder = (dur)->
  schema = {structure:[], node:{}, action:{}}
  # TODO: randomize
  MG.schemaAdd schema, 'A', {mode:'random', dur:dur, rhythm:{seed:'s1'}, interval:{seed:'s2'}}
  schema


MG.schema_dance =
  'S'

###
  utilities
###
MG.clone = (->
  clone = (o)->
    if typeof o != 'object' or o == null
      return o
    else
      ret = if Array.isArray(o) then [] else {}
      for i of o
        ret[i] = clone(o[i])
      return ret
  return (o)-> clone(o)
)()


MG.circularClone = (obj) ->
  visited = []
  getVisited = (o) ->
    i = 0
    while i < visited.length
      if visited[i][0] == o
        return visited[i][1]
      ++i
    null

  clone = (o) ->
    if typeof o != 'object' or o == null
      return o
    ret = getVisited(o)
    if ret != null
      return ret
    ret = if Array.isArray(o) then [] else {}
    visited.push [
      o
      ret
    ]
    for i of o
      ret[i] = clone(o[i])
    ret

  clone obj

MG.top_sort = (dependency)->
  #console.log 'top sort', dependency
  n = Object.keys(dependency).length

  remove_one = (o)->
    for k,v of dependency
      while o in v
        v.splice(v.indexOf(o),1)
    delete dependency[o]
  get_one = ->
    for k,v of dependency
      if v.length <= 0
        return k
    return null
  ret = []
  while ret.length < n
    tmp = get_one()
    if tmp == null
      console.log 'circular dependency', dependency
      break
    else
      ret.push tmp
      remove_one(tmp)
  #console.log 'top sort', ret
  return ret

# greatest common divisor
gcd = (a,b)->
  while b > 0
    tmp = b
    b = a % b
    a = tmp
  return a
lcm = (a,b)->
  return a / gcd(a,b) * b
MG.gcd = ()->
  ret = gcd(arguments[0], arguments[1])
  for i in [2...arguments.length] by 1
    ret = gcd(ret, arguments[i])
  ret

# least common multiple
MG.lcm = ()->
  ret = lcm(arguments[0], arguments[1])
  for i in [2...arguments.length] by 1
    ret = lcm(ret, arguments[i])
  ret

MG.rndPicker = (choices, weights) ->
  if arguments.length == 1
    # order can not be reverted
    weights = _.values(arguments[0])
    choices = _.keys(arguments[0])
  s = math.sum weights
  p = weights.map (e)-> e/s
  s = 0
  for i in [0...p.length] by 1
    s = (p[i] += s)

  return gen:  ->
    r = MG.seededRandom() #Math.random()
    for i in [0...p.length] by 1
      if r < p[i]
        return choices[i]
    return choices[p.length-1]

MG.condCopy = (src, dest, props)->
  for i in props
    if src[i]?
      dest[i] = src[i]
  return

MG.obj_sort = (data, decending, map)->
  decending ?= false
  map ?= (e)->e
  kv = _.zip(_.keys(data), _.values(data))
  if decending
    kv.sort (a, b) ->
      map(b[1]) - map(a[1])
  else
    kv.sort (a, b) ->
      map(a[1]) - map(b[1])
  kv

# raw_string, type
MG.str2blob = (s, t) ->
  # implementation 1
  n = s.length
  u8arr = new Uint8Array n
  while n--
    u8arr[n] = s.charCodeAt n
  # implementation 2
  # u8arr = new Uint8Array(s.split('').map((e) ->
  #     e.charCodeAt 0
  # ))

  new Blob [u8arr], type: t

  


# reproducable random number generator
_seed = 6
MG.seededRandom = (max, min) ->
  max = max || 1
  min = min || 0
  _seed = (_seed * 9301 + 49297) % 233280;
  rnd = _seed / 233280
  return min + rnd * (max - min)

# currently just for major scale
funcchords =
  'I': [[0,'maj'],[5,'min']]
  'IV': [[3, 'maj'], [1, 'min']]
  'V': [[4, 'maj'], [2, 'min'], [6, 'min7b5']]
funcmap = ['I', 'IV', 'V', 'IV', 'V', 'I', 'V']
hmm_transit =
  'I': {'I':1, 'IV':3, 'V':3}
  'IV': {'I':2, 'V':5, 'IV':1}
  'V': {'I':5, 'IV':3, 'V':1}
MG.chord_hmm = (key_sig, hmm)->
  hmm ?= hmm_transit
  states = ['I']
  scale = MG.scale_keys[key_sig]
  transit = ()->
    picker = MG.rndPicker(hmm[states.join(',')])
    states[0] = picker.gen()
    ret = funcchords[states[0]]
    return ret[Math.floor(MG.seededRandom() * ret.length)]

  gen = (n)->
    n ?= 1
    ret = []
    for i in [0...n]
      tmp = transit()
      tmp[0] = scale[tmp[0]]
      ret.push tmp.join('')
    ret

  return {
    start: (state)->
      state ?= 'I'
      if typeof hmm[state] == 'undefined'
        state = 'I'
        console.log 'invalid chord func', state
      states[0] = state
      return gen()
    gen: gen
  }



MG.harmony_progresser = (harmony)->
  harmony ?= []
  m_i = 0
  b_i = -1
  delta = 0
  bass = (inv)->
    inv ?= 0
    curchord = harmony[m_i][b_i]
    return (curchord[1] + curchord[2][inv]) % 12
  incr = ()->
    b_i++
    if b_i >= harmony[m_i].length
      b_i = 0
      m_i++
      if m_i >= harmony.length
        m_i = harmony.length - 1
    delta -= harmony[m_i][b_i][0]

    return delta

  chord = (inv) ->
    inv ?= 0
    return MG.inverted(harmony[m_i][b_i][2],inv)
  forward = (d)->
    delta += d

  process = ()->
    while m_i < harmony.length && delta >= 0
      incr()

  return {
  bass: bass,
  chord: chord,
  process: process,
  forward: forward
  }

@MG = MG
