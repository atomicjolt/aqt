import React from 'react';
import { shallow } from 'enzyme';
import Modal from './modal';

describe('lti install key modal', () => {

  let result;
  let props;
  let closed;
  let saved;
  const name = 'the application';

  beforeEach(() => {
    saved = false;
    closed = false;
    props = {
      isOpen: true,
      closeModal: () => { closed = true; },
      save: () => { saved = true; },
      ltiInstallKey: {
        id: 2,
        clientId: 'lti-key',
        iss: 'iss',
        jwksUrl: 'jwksUrl',
        tokenUrl: 'tokenUrl',
        oidcUrl: 'oidcUrl',
        created_at: 'created_at',
      },
      application: {
        id: 1,
        name
      }
    };
    result = shallow(<Modal {...props} />);
  });

  it('handles the save function', () => {
    expect(saved).toBeFalsy();
    result.instance().save();
    expect(saved).toBeTruthy();
  });

  it('handles the close function', () => {
    expect(closed).toBeFalsy();
    result.instance().closeModal();
    expect(closed).toBeTruthy();
  });
});
