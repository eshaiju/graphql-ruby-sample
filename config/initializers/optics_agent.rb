optics_agent = OpticsAgent::Agent.new
# optics_agent.configure { schema GraphqlRubySampleSchema }
optics_agent.configure do
  # The schema you wish to instrument
  schema GraphqlRubySampleSchema

  # Your API key for the Optics service. This defaults to the OPTICS_API_KEY
  # environment variable, but can be overridden here.
  api_key 'service:eshaiju-6368:MUmjT9HLNGeaPdjO6zKHGA'

  # Log detailed debugging messages
  debug true

  # Don't report anything to Optics (useful for testing)
  disable_reporting false

  # Print JSON versions of the data sent to Optics to the log
  print_reports false

  # Send detailed traces along with usage reports
  report_traces true

  # How long to wait before sending a schema report after startup, in
  # milliseconds
  schema_report_delay_ms 10 * 1000

  # How often to send reports in milliseconds. Defaults to 1 minute.
  # You shouldn't need to set this unless you are debugging.
  report_interval_ms 60 * 1000

  # Where to send the reports. Defaults to the production Optics endpoint,
  # or the `OPTICS_ENDPOINT_URL` environment variable if it is set.
  # You shouldn't need to set this unless you are debugging
  endpoint_url 'https://optics-report.apollodata.com'
end
Rails.application.config.middleware.use optics_agent.rack_middleware
