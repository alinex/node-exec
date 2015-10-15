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
        vital:
          title: "Vital Sign Check"
          description: "the check for host vital data"
          type: 'object'
          allowedKeys: true
          mandatoryKeys: true
          keys:
            interval:
              title: "Time before Recheck"
              description: "the time to wait before rechecking the host vital signs"
              type: 'interval'
              unit: 'ms'
              min: 0
            startload:
              title: "Start Limit"
              description: "the maximum load% per CPU core per second in usage to start"
              type: 'percent'
              min: 0.01
        queue:
          title: "Work Queue"
          description: "the handling of the queue if load is too high"
          type: 'object'
          allowedKeys: true
          mandatoryKeys: true
          keys:
            interval:
              title: "Recheck Time"
              description: "the time after that the worker will retry to start queued executions"
              type: 'interval'
              min: 0
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
                type: 'array'
                delimiter: /\s/
                minLength: 1
                maxLength: 3
                entries:
                  title: "Max Load"
                  description: "the maximum system load for period"
                  type: 'percent'
                  min: 0
              minFreemem:
                title: "Min free Mem"
                description: "the minimum free memory needed to execute"
                type: 'percent'
                min: 0
              nice:
                title: "Nice"
                description: "the niceness of the process"
                type: 'integer'
                min: -20
                max: 19
          ]
    remote:
      title: "Remote Servers"
      description: "the setup of remote execution servers"
      type: 'object'
      keys:
        server:
          type: 'object'
          entries: [
            title: "Remote Server"
            description: "a remote server ssh connection setup"
            type: 'object'
            allowedKeys: true
            mandatoryKeys: ['host', 'port', 'username']
            keys:
              host:
                title: "Hostname or IP Address"
                description: "the hostname or IP address to connect to"
                type: 'or'
                or: [
                  type: 'hostname'
                ,
                  type: 'ipaddr'
                ]
              port:
                title: "Port NUmber"
                description: "the port on which to connect using ssh protocol"
                type: 'port'
                default: 22
              username:
                title: "Username"
                description: "the username to use for the connection"
                type: 'string'
              password:
                title: "Password"
                description: "the password to use for connecting"
                type: 'string'
                optional: true
              privateKey:
                title: "Private Key"
                description: "the private key file to use for OpenSSH authentication"
                type: 'string'
              passphrase:
                title: "Passphrase"
                description: "the passphrase used to decrypt an encrypted private key"
                type: 'string'
              localHostname:
                title: "Local Hostname"
                description: "the host used for hostbased user authentication"
                type: 'string'
              localUsername:
                title: "Local User"
                description: "the username used for hostbased user authentication"
                type: 'string'
              keepaliveInterval:
                title: "Keepalive"
                description: "the interval for the keepalive packets to be send"
                type: 'interval'
                unit: 'ms'
                default: 1000
              readyTimeout:
                title: "Ready TImeout"
                description: "the time to wait for the ssh handshake to succeed"
                type: 'interval'
                unit: 'ms'
                default: 20000
              startload:
                title: "Start Limit"
                description: "the maximum load for each CPUs per second in usage to start"
                type: 'percent'
                min: 0.01
              debug:
                title: "Extended Debug"
                description: "the DEBUG=exec:ssh messages are extended with server communication"
                type: 'boolean'
          ]
        group:
          type: 'object'
          entries: [
            title: "Remote Server Pool"
            description: "a pool of remote servers which one of them may be used"
            type: 'array'
            entries:
              title: ""
              description: ""
              type: 'object'
              keys:
                host:
                  title: "Reference to host entry"
                  description: "an host entry becomming member of this pool"
                  type: 'string'
                  values: '<<<remote/server>>>'
                weight:
                  title: "Weight"
                  description: "the weight for this host in balancing"
                  type: 'percent'
                  default: 0.5
          ]
