import React, { useEffect } from 'react';
import { StyleSheet, View, Text } from 'react-native';
//https://www.npmjs.com/package/react-native-odoo
import Odoo from '../../assets/lib/Odoups/Odoups'


function Test() {

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
