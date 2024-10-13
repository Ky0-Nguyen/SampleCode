/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */
import React, {useState, useEffect} from 'react';
import {FlatList, StyleSheet, ActivityIndicator} from 'react-native';

import ItemUser from './src/components/ItemUser';
import {generateFakeUsers, IUser} from './src/utils';

/**
 * The main App component that renders a list of users.
 * It fetches users data on mount and renders a loading indicator if data is not available.
 */
const App = () => {
  // State to hold the list of users
  const [users, setUsers] = useState<IUser[]>([]);

  // Effect to fetch users data on component mount
  useEffect(() => {
    // Fetching 1000 fake users
    const fakeUsers = generateFakeUsers(1000);
    // Updating the state with the fetched users
    setUsers(fakeUsers);
  }, []);

  // Function to render a single user item
  const renderUser = ({item}: {item: IUser}) => <ItemUser user={item} />;

  // Conditional rendering based on the availability of users data
  return users.length === 0 ? (
    // Rendering a loading indicator if users data is not available
    <ActivityIndicator size="large" color="#0000ff" />
  ) : (
    // Rendering the FlatList with users data
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

// Styles for the FlatList content container
const styles = StyleSheet.create({
  list: {
    padding: 16,
  },
});

// Exporting the App component
export default App;
