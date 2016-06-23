Connector = require '../'

describe 'Connector', ->
  beforeEach (done) ->
    @sut = new Connector
    {@lifx} = @sut
    @lifx.connect = sinon.stub().yields null
    @sut.start {}, done

  afterEach (done) ->
    @sut.close done

  describe '->isOnline', ->
    it 'should yield running true', (done) ->
      @sut.isOnline (error, response) =>
        return done error if error?
        expect(response.running).to.be.true
        done()

  describe '->onConfig', ->
    beforeEach (done) ->
      options =
        bulbNames: ['hi']
        autoDiscover: false
      @sut.onConfig {options}, done

    it 'should call lifx.connect', ->
      expect(@lifx.connect).to.have.been.calledWith bulbNames: ['hi'], autoDiscover: false

  describe '->changeLights', ->
    beforeEach (done) ->
      @lifx.changeLights = sinon.stub().yields null
      options =
        color: 'blue'
        transitionTime: 1
      @sut.changeLights options, done

    it 'should call lifx.changeLights', ->
      options =
        color: 'blue'
        transitionTime: 1
      expect(@lifx.changeLights).to.have.been.calledWith options

  describe '->turnOff', ->
    beforeEach (done) ->
      @lifx.turnOff = sinon.stub().yields null
      @sut.turnOff done

    it 'should call lifx.turnOff', ->
      expect(@lifx.turnOff).to.have.been.called
