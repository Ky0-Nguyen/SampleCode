/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */
import React, {useState, useEffect, memo} from 'react';
import {
  View,
  Text,
  Image,
  FlatList,
  StyleSheet,
  ActivityIndicator,
} from 'react-native';
import generateFakeUsers, {IUser} from './generateFakeUsers';
const RenderUser = memo(({item}: {item: IUser}) => (
  <View style={styles.userContainer}>
    <Image source={{uri: item.avatar}} style={styles.avatar} />
    <Text style={styles.name}>{item.name}</Text>
    <Text style={styles.email}>{item.email}</Text>
  </View>
));

const App = () => {
  const [users, setUsers] = useState<IUser[]>([]);

  useEffect(() => {
    const fakeUsers = generateFakeUsers(100); // Generate 100 fake users
    setUsers(fakeUsers);
  }, []);

  const renderUser = ({item}: {item: IUser}) => <RenderUser item={item} />;

  return users.length === 0 ? (
    <ActivityIndicator size="large" color="#0000ff" />
  ) : (
    <FlatList
      data={users}
      keyExtractor={item => item.id}
      renderItem={renderUser}
      contentContainerStyle={styles.list}
      removeClippedSubviews={true}
      maxToRenderPerBatch={10}
    />
  );
};

const styles = StyleSheet.create({
  list: {
    padding: 16,
  },
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

export default App;
