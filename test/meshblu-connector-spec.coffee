Lifx = require '../'

describe 'Lifx', ->
  beforeEach ->
    @sut = new Lifx

  describe '->start', ->
    it 'should be a method', ->
      expect(@sut.start).to.be.a 'function'

    describe 'when called with a device', ->
      it 'should not throw an error', ->
        expect(=> @sut.start({ uuid: 'hello' })).to.not.throw(Error)

  describe '->onMessage', ->
    it 'should be a method', ->
      expect(@sut.onMessage).to.be.a 'function'

    describe 'when called with a message', ->
      it 'should not throw an error', ->
        expect(=> @sut.onMessage({ topic: 'hello', devices: ['123'] })).to.not.throw(Error)
