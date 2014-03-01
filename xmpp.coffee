xmpp = require('node-xmpp')
layouts = require('log4js').layouts

send = (client, body) ->
  return unless body

  stanza = new xmpp.Element('message',
    to: config.to
    type: 'chat'
  ).c('body').t(body)
  client.send stanza

xmppAppender = (config, layout) ->
  loggingEvents = []
  client = new xmpp.Client(config.client)
  layout = layout or layouts.messagePassThroughLayout

  client.addListener 'online', (data) ->
    console.log "XMPP client is connected as \
#{data.jid.user}@#{data.jid.domain}/#{data.jid.resource}"

    body = ''
    for i in loggingEvents
      body += layout(i) + '\n'

    loggingEvents = null
    send client, body

  client.addListener 'error', (e) ->
    console.error "XMPP client encountered error, #{e}"

  (loggingEvent) ->
    if loggingEvents
      loggingEvents.push loggingEvent
    else
      send client, layout(loggingEvent)

configure = (config) ->
  layout = layouts.layout(config.layout.type, config.layout) if config.layout
  xmppAppender config, layout

exports.appender = xmppAppender
exports.configure = configure
# vim: ts=2 sw=2 sts=2 et:
