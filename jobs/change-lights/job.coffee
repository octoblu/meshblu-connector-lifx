http = require 'http'

class ChangeLights
  constructor: ({@connector}) ->
    throw new Error 'ChangeLights requires connector' unless @connector?

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.color is required') unless data?.color?
    return callback @_userError(422, 'data.transitionTime is required') unless data?.transitionTime?

    {
      color
      transitionTime
    } = data

    @connector.changeLights { color, transitionTime }, callback

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = ChangeLights
