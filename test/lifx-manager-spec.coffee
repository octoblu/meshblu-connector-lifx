LifxManager = require '../src/lifx-manager'

describe 'LifxManager', ->
  beforeEach ->
    @sut = new LifxManager
    @lifx =
      bulbs: [
        name: 'hi'
      ]
      lightsOn: sinon.stub()
      lightsOff: sinon.stub()
      lightsColour: sinon.stub()
    {@Lifx} = @sut
    @Lifx.init = =>
      @lifx

  beforeEach (done) ->
    @sut.connect bulbName: 'hi', done

  describe '->changeLight', ->
    beforeEach (done) ->
      options =
        color: 'blue'
        transitionTime: 0

      @sut.changeLight options, done

    it 'should call lifx.changeLight', ->
      expect(@lifx.lightsColour).to.have.been.calledWith 43690, 65535, 65535, 9000, 0, { name: "hi" }

  describe '->turnOff', ->
    beforeEach (done) ->
      @sut.turnOff done

    it 'should call lifx.turnOff', ->
      expect(@lifx.lightsOff).to.have.been.called
