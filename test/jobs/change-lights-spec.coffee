{job} = require '../../jobs/change-lights'

describe 'ChangeLights', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        changeLights: sinon.stub().yields null
      message =
        data:
          color: 'white'
          transitionTime: 1000
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call changeLights', ->
      data =
        color: 'white'
        transitionTime: 1000
      expect(@connector.changeLights).to.have.been.calledWith data

  context 'when given an invalid message', ->
    beforeEach (done) ->
      @connector = {}
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should error', ->
      expect(@error).to.exist
