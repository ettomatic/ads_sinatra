require 'rubygems'
require 'sinatra'
require 'torquebox'
require 'sequel'

require 'lib/adsjdbc.jar'
java_import 'com.extendedsystems.jdbc.advantage.ADSDriver'
Java::JavaClass.for_name('com.extendedsystems.jdbc.advantage.ADSDriver')

JDBC_CONN_STRING  = "jdbc:extendedsystems:advantage://127.0.0.1:6262/DATI_ARCO/006214/ARCO;locktype=compatible;tabletype=cdx"

DB = Sequel.connect(JDBC_CONN_STRING)

get '/' do
  "Hello TorqueBox!"
end

#
# it should raise Sequel::DatabaseConnectionError
# instead of NativeException: java.sql.SQLException: No suitable driver 
#
get '/test' do
  q = "SELECT TOP 1 CFORNAFO FROM GBAFORN"
  @data = DB.run(q)
end