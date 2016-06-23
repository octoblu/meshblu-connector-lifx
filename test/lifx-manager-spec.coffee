LifxManager = require '../src/lifx-manager'

describe 'LifxManager', ->
  beforeEach ->
    @sut = new LifxManager
    @bulb =
      on: sinon.stub()
      off: sinon.stub()
      color: sinon.stub()
    {@lifx} = @sut
    @lifx.destroy = sinon.stub()
    @lifx.init = sinon.stub()
    @lifx.lights = => [@bulb]
    @lifx.light = => @bulb

  beforeEach (done) ->
    @sut.connect bulbNames: ['hi'], done

  it 'should call destroy', ->
    expect(@lifx.destroy).to.have.been.called

  it 'should call init', ->
    expect(@lifx.init).to.have.been.called

  describe '->changeLights', ->
    beforeEach (done) ->
      options =
        color: 'blue'
        transitionTime: 0

      @sut.changeLights options, done

    it 'should call bulb.on', ->
      expect(@bulb.on).to.have.been.called

    it 'should call bulb.color', ->
      expect(@bulb.color).to.have.been.calledWith 240, 100, 100, 9000, 0

  describe '->turnOff', ->
    beforeEach (done) ->
      @sut.turnOff done

    it 'should call bulb.off', ->
      expect(@bulb.off).to.have.been.called
