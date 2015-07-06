# Check definitions
# =================================================

module.exports =
  title: "Exec configuration"
  description: "the configuration for the spawn load balancing"
  type: 'object'
  allowedKeys: true
  entries:
    load:
      title: "Load management"
      description: "the load limit, which may be changed per each machine"
      type: 'object'
      allowedKeys: true
      entries:
        limit:
          title: "Load limit"
          description: "the load limit (not directly equal system load)"
          type: 'float'
          min: 0
          default: 1
        wait:
          title: "Wait interval"
          description: "the time to wait if load is to high (between x sec. and x min.)"
          type: 'interval'
          unit: 'ms'
          min: 1
          default: 3000
    start:
      title: "Start limit"
      description: "the limit of new processes to start per period"
      type: 'object'
      allowedKeys: true
      entries:
        interval:
          title: "Start period"
          description: "the time for each period in which to check the limit"
          type: 'interval'
          unit: 'ms'
          min: 0
          default: 1000
        limit:
          title: "Weight limit"
          description: "the maximum weight to start per each period"
          type: 'float'
          min: 0
          default: os.cpus().length
    weight:
      title: "Process weights"
      description: "the weights per process used in the start limit calculation"
      type: 'object'
      entries:
        type: 'float'
        min: 0
        default:
          DEFAULT: 0.2
          ffmpeg: 10
          lame: 10
    defaults:
      title: "Process defaults"
      description: "the default values for each process"
      type: 'object'
      allowedKeys: true
      entries:
        balance:
          title: "Load Balance"
          description: "a flag indicating if load balancing be done by default"
          type: 'boolean'
          default: 'false'
        priority:
          title: "Default priority"
          description: "the priority for each process, higher means to run earlier"
          type: 'float'
          min: 0
          max: 1
          default: 0.3
        retry:
          title: "Number of retries"
          description: "the number of retries to do if a command failed"
          type: 'integer'
          min: 0
          default: 5

