MG = @MG || (module? && require? && require('./musical').MG) || {}

###
  player for note sequence
  warn: based of setTimeout, may slow down in background
###
class seqPlayer
  constructor: ->
    @harmony = []
    @instrs = []
    @tracks = []
    @playing = []
    @cur_i = []
    @midi = null
    @raw_midi = '' # midifile as string
    @onend = (n)->
      console.log("track #{n} finished")

  ## play track n
  play: (n) ->

    n ?= 0
    if not @tracks[n]? or @tracks[n].length <= 0
      return

    q = @tracks[n]
    nexti = @cur_i[n]
    cur_i = @cur_i
    cur = q[nexti]
    nexti++
    channel = n
    rate = 1
    onend = @onend
    playing = @playing
    playing[n] = true

    loop1 = =>

      if cur[0] > 0
        notes = if typeof cur[1] != 'object' then [ cur[1] ] else cur[1]
        notes.forEach (e) ->
          if e >= 21 and e <= 108
            MIDI.noteOn channel, e, cur[2]
          return
      dur = if cur[0] >= 0 then cur[0] else -cur[0]
      dur *= rate

      setTimeout (=>
        notes = if typeof cur[1] != 'object' then [ cur[1] ] else cur[1]
        if nexti < 0
          notes.forEach (e) ->
            if e >= 21 and e <= 108
              MIDI.noteOff channel, e
            return
          playing[n] = false
          onend.call @, n
        else
          if q[nexti][0] > 0
            notes.forEach (e) ->
              if e >= 21 and e <= 108
                MIDI.noteOff channel, e
              return
          cur = q[nexti]
          if playing[n]
            nexti++
            if nexti >= q.length
              nexti = -1
              cur_i[n] = 0
          else
            cur_i[n] = nexti
            nexti = -1

          loop1()
        return
      ), dur
      return

    setTimeout loop1, 0
    return

  # to note sequence, array of [dur, [pitches], vol] (single voice)
  # TODO: consider tempo change
  toQ: (arr, ctrlTicks, vol) ->
    info = arr.info ? {}
    vol ?= 110
    m = _.flatten(arr, true)
    res = []
    j = 0
    while j < m.length
      delta = m[j][0]
      while m[j][2] == true and j + 1 < m.length
        j++
        delta += m[j][0]
      res.push [
        delta * ctrlTicks
        m[j][1]
        vol
      ]
      ++j
    res
  # pause track n
  pause: (n) ->
    n ?= 0
    if n >= @tracks.length || n < 0
      return
    @playing[n] = false
    return
  # stop track n
  stop: (n) ->
    n ?= 0
    if n >= @tracks.length
      return
    @playing[n] = false
    @cur_i[n] = 0
    return

  # get note sequence from score
  fromScore: (obj) ->

    ctrlTicks = obj.init_ctrlTicks
    @tracks = []
    @instrs = MG.clone(obj.instrs)
    @playing = []
    @cur_i = []
    @harmony = obj.harmony
    @midi = obj.toMidi()
    @raw_midi = MidiWriter(@midi)

    for i in [0...obj.tracks.length] by 1
      @tracks.push @toQ(obj.tracks[i], ctrlTicks, obj.volumes[i])
      @playing.push false
      @cur_i.push 0

    return
  saveMidi: ->
    if @raw_midi.length < 1
      return
    # bf = new Uint8Array(@raw_midi.split('').map((e) ->
    #   e.charCodeAt 0
    # ))
    # saveAs new Blob([bf], type: 'audio/midi'), 'sample.mid'
    saveAs MG.str2blob(@raw_midi, 'audio/midi'), 'sample.mid'
    return


MG.seqPlayer = seqPlayer