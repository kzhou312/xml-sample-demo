DBA=$1
DBAPWD=$2
XFILES=$3
XFILESPWD=$4
XDBEXT=$5
XDBEXTPWD=$6
DEMOUSER=$7
DEMOPWD=$8
HOSTNAME=$9
HTTPPORT=${10}
SERVERURL="$HOSTNAME:$HTTPPORT"
INSTALLROOT=`pwd`
rm -rf oracle-xml-sample-demo-*
curl -Lk https://github.com/oracle/xml-sample-demo/zipball/master -o xml-sample-demo.zip
unzip -o xml-sample-demo.zip
cd oracle-xml-sample-demo*
sqlplus $DBA/$DBAPWD @scripts/installXFiles $XFILES $XFILESPWD $HTTPPORT
sqlplus $DBA/$DBAPWD @scripts/installMetadata $XDBEXT $XDBEXTPWD
sh scripts/installXMLRepository.sh $DBA $DBAPWD $XFILES $XFILESPWD $XDBEXT $XDBEXTPWD $DEMOUSER $DEMOPWD $SERVERURL
rm -rf oracle-json-in-db-*
cd $INSTALLROOT
curl -Lk https://github.com/oracle/json-in-db/zipball/master -o json-in-db.zip
unzip -o json-in-db.zip
cd oracle-json-in-db*
sh scripts/installJSONRepository.sh $DBA $DBAPWD $XFILES $XFILESPWD $XDBEXT $XDBEXTPWD $DEMOUSER $DEMOPWD $SERVERURL
