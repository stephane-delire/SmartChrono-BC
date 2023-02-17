import React, { useEffect } from 'react';
import { StyleSheet, View, Text } from 'react-native';
//https://www.npmjs.com/package/react-native-odoo
import Odoo from '../../assets/lib/Odoups/Odoups'


function Test() {

const odoo = new Odoo({
  host: "https://demo.burniaux.com",
  port: 8069,
  database: 'demo',
  username: 'sdelire',
  password: 'QkkF2-TfbQ'
})

odoo.connect(function(err) {
  if (err) {return console.log(err);}
})

  return (
    <View style={styles.container}>
      <Text>Check the console for the list of table names.</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default Test;
