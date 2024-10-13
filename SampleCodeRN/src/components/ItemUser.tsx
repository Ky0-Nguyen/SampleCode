import React, {memo} from 'react';
import {StyleSheet, Text, View} from 'react-native';
import FastImage from 'react-native-fast-image';
import {IUser} from '../utils';

type Props = {
  user: IUser;
};

const ItemUser = (props: Props) => {
  const {user} = props;
  return (
    <View style={styles.userContainer}>
      <FastImage source={{uri: user.avatar}} style={styles.avatar} />
      <Text style={styles.name}>{user.name}</Text>
      <Text style={styles.email}>{user.email}</Text>
    </View>
  );
};

export default memo(ItemUser);

const styles = StyleSheet.create({
  userContainer: {
    marginTop: 16,
    alignItems: 'center',
    marginBottom: 16,
  },
  avatar: {
    width: '100%',
    height: 200,
    borderRadius: 25,
    marginRight: 16,
  },
  name: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  email: {
    fontSize: 14,
    color: 'gray',
  },
});
