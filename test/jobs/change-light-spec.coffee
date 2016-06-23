{job} = require '../../jobs/change-light'

describe 'ChangeLight', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        changeLight: sinon.stub().yields null
      message =
        data:
          on: true
          color: 'white'
          transitionTime: 1000
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call changeLight', ->
      data =
        on: true
        color: 'white'
        transitionTime: 1000
      expect(@connector.changeLight).to.have.been.calledWith data

  context 'when given an invalid message', ->
    beforeEach (done) ->
      @connector = {}
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should error', ->
      expect(@error).to.exist
