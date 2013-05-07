
## BEGIN library database ##

# TODO verificar se mysql está instalado

##
 # @author : Gabriell Nascimento
 # @date   : 2013-02-19
 #
 # Description: Create a connection to a database using provided settings.
 #              This is a little monkey, because it doesn't open a socket
 #              on the DBMS application; instead it save a string with the
 #              command to run the application and use it to execute the
 #              queries on the DBMS.
 #
 # @param _dsn:
 #      settings to connect do the dbms.
 #      settings needed are (in this format): 
 #          dbms:host:port:user:pass
 #
 # @return: string with command to run the dbms application
 #
 # @usage:
 #      my_dbh="$( db_connect "$my_dsn" )"
 ##
function db_connect() {
    
    local _dsn
    local _dbms _db_host _db_port _db_user _db_pass

    _dsn="$1"

    if [[ -z "$_dsn" ]]; then
        return 1
    fi

    # Split settings 
    _dbms="$( echo "$_dsn" | cut -d':' -f1 )"

    _db_host="$( echo "$_dsn" | cut -d':' -f2 )"
    _db_port="$( echo "$_dsn" | cut -d':' -f3 )"
    _db_user="$( echo "$_dsn" | cut -d':' -f4 )"
    _db_pass="$( echo "$_dsn" | cut -d':' -f5 )"

    # Create the "connection" on the DBMS with the provided settings
    case "$_dbms" in
        "mysql")
            _con="mysql -h${_db_host} -P${_db_port} -u${_db_user} -p${_db_pass}"
        ;;
        
        *)
            return 1
        ;;
    esac

    echo "$_con"
}

##
 # @author : Gabriell Nascimento
 # @date   : 2013-02-19
 #
 # Description: Remove the connection to a database
 #
 # @return: empty string to overwrite database handler
 #
 # @usage:
 #      my_con="$( db_disconnect )"
 ##
function db_disconnect() {
    echo ""
}

##
 # @author : Gabriell Nascimento
 # @date   : 2013-02-19
 #
 # Description: Run a query on the database
 #
 # @param _con   : settings to connect do the dbms.
 # @param _query : query to run on the database.
 #
 # @return: results of the query
 #
 # @usage:
 #      my_result="$( db_fetch "$my_con" "$my_query" )"
 ##
function db_fetch() {

    local _con _query

    _con="$1"
    _query="$2"

    # Run the given query using the "established connection"
    _result="$(
        echo "$_query" |
        echo "$( $_con )"
    )"

    echo "$_result"
}

##
 # @author : Gabriell Nascimento
 # @date   : 2013-02-19
 #
 # Description: Run a query on the database
 #
 # @param _con   : settings to connect do the dbms.
 # @param _query : query to run on the database.
 #
 # @return: whether execution was successfully or not
 #
 # @usage:
 #      db_execute "$my_con" "$my_query"
 ##
function db_execute() {

    local _con _query

    _con="$1"
    _query="$2"

    # Run the given query using the "established connection"
    echo "$_query" | 
    echo "$( $_con )"

    return "$?"
}

### XXX Functions to implement  ###
# function db_select() {

    # local _con _fields _where _join

    # _con="$1"
    # _fields="$2"

    # if [[ -z "$_fields" ]]; then
    #     _fields="*"
    # fi

    # echo "$_result"
# }

# function db_where() {
# }

# function db_join() {
# }

## END library database ##
