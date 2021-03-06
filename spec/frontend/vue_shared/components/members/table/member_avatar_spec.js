import { shallowMount } from '@vue/test-utils';
import { MEMBER_TYPES } from '~/vue_shared/components/members/constants';
import { member as memberMock, group, invite, accessRequest } from '../mock_data';
import MemberAvatar from '~/vue_shared/components/members/table/member_avatar.vue';
import UserAvatar from '~/vue_shared/components/members/avatars/user_avatar.vue';
import GroupAvatar from '~/vue_shared/components/members/avatars/group_avatar.vue';
import InviteAvatar from '~/vue_shared/components/members/avatars/invite_avatar.vue';

describe('MemberList', () => {
  let wrapper;

  const createComponent = propsData => {
    wrapper = shallowMount(MemberAvatar, {
      propsData,
    });
  };

  afterEach(() => {
    wrapper.destroy();
  });

  test.each`
    memberType                    | member           | expectedComponent | expectedComponentName
    ${MEMBER_TYPES.user}          | ${memberMock}    | ${UserAvatar}     | ${'UserAvatar'}
    ${MEMBER_TYPES.group}         | ${group}         | ${GroupAvatar}    | ${'GroupAvatar'}
    ${MEMBER_TYPES.invite}        | ${invite}        | ${InviteAvatar}   | ${'InviteAvatar'}
    ${MEMBER_TYPES.accessRequest} | ${accessRequest} | ${UserAvatar}     | ${'UserAvatar'}
  `(
    'renders $expectedComponentName when `memberType` is $memberType',
    ({ memberType, member, expectedComponent }) => {
      createComponent({ memberType, member });

      expect(wrapper.find(expectedComponent).exists()).toBe(true);
    },
  );
});
