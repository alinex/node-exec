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
      title: "Retry if Failed"
      description: "how often, and when to retry after failures"
      type: 'object'
      allowedKeys: true
      mandatoryKeys: true
      keys:
        num:
          title: "Number of Attempts"
          description: "the number of maximal attempts to run successfully"
          type: 'integer'
          min: 0
        sleep:
          title: "Time to Wait"
          description: "the time to wait before retrying a failed attempt"
          type: 'interval'
          unit: 'ms'
        calc:
          title: "Calculation Method"
          description: "the method used to calculate each round's wait time"
          type: 'string'
          list: [ 'equal', 'linear', 'exponential' ]
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
            mandatoryKeys: true
            keys:
              maxCpu:
                title: "Max CPU"
                description: "the maximum cpu usage, till that execution may be started"
                type: 'percent'
              maxLoad:
                title: "Max Load"
                description: "the maximum system load, till that execution may be started"
                type: 'percent'
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

