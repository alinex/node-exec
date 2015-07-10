# Check definitions
# =================================================

module.exports =
  title: "Exec configuration"
  description: "the configuration for the external command calls"
  type: 'object'
  allowedKeys: true
  mandatoryKeys: true
  keys:
    retry:
      title: "Retry"
      description: "the retry of the process"
      type: 'object'
      allowedKeys: true
      mandatoryKeys: true
      keys:
        ulimit:
          title: "Retry if ULimit"
          description: "the retry if the process limit is reached"
          type: 'object'
          allowedKeys: true
          mandatoryKeys: true
          keys:
            interval:
              title: "Time to Wait"
              description: "the time to wait before retrying a failed attempt"
              type: 'interval'
              unit: 'ms'
              min: 0
        error:
          title: "Retry if Failed"
          description: "the retry after failed retry checks"
          type: 'object'
          allowedKeys: true
          mandatoryKeys: true
          keys:
            times:
              title: "Number of Attempts"
              description: "the number of maximal attempts to run successfully"
              type: 'integer'
              min: 0
            interval:
              title: "Time to Wait"
              description: "the time to wait before retrying a failed attempt"
              type: 'interval'
              unit: 'ms'
              min: 0
    priority:
      title: "Priorities"
      description: "the setup of priorities"
      type: 'object'
      allowedKeys: true
      mandatoryKeys: true
      keys:
        default:
          title: "Default Priority"
          description: "the default priority as reference to one of the defined list entries"
          type: 'string'
          list: '<<< level >>>'
        level:
          title: "Priority Levels"
          description: "the definition of all possible priorities"
          type: 'object'
          entries: [
            title: "Priority Level"
            description: "the definition of one priority level"
            type: 'object'
            allowedKeys: true
            optional: true
            keys:
              maxCpu:
                title: "Max CPU"
                description: "the maximum cpu usage, till that execution may be started"
                type: 'percent'
                min: 0
                max: 1
              maxLoad:
                title: "Max Load"
                description: "the maximum system load, till that execution may be started"
                type: 'percent'
                min: 0
              nice:
                title: "Nice"
                description: "the niceness of the process"
                type: 'integer'
                min: -20
                max: 19
          ]
    queue:
      title: "Work Queue"
      description: "the handling of the queue if load is too high"
      type: 'object'
      allowedKeys: true
      mandatoryKeys: true
      keys:
        recheck:
          title: "Recheck Time"
          description: "the time after that cpu and load will be rechecked"
          type: 'interval'
          min: 0
