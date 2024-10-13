import {faker} from '@faker-js/faker';

const generateFakeUsers = (count = 10) => {
  return Array.from({length: count}).map(() => ({
    id: faker.string.uuid(),
    name: faker.name.fullName(),
    email: faker.internet.email(),
    avatar: faker.image.avatar(),
  }));
};

export interface IUser {
  id: string;
  name: string;
  email: string;
  avatar: string;
}

export {generateFakeUsers};
