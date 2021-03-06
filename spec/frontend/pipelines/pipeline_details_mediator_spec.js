import MockAdapter from 'axios-mock-adapter';
import waitForPromises from 'helpers/wait_for_promises';
import axios from '~/lib/utils/axios_utils';
import PipelineMediator from '~/pipelines/pipeline_details_mediator';

describe('PipelineMdediator', () => {
  let mediator;
  let mock;

  beforeEach(() => {
    mock = new MockAdapter(axios);
    mediator = new PipelineMediator({ endpoint: 'foo.json' });
  });

  afterEach(() => {
    mock.restore();
  });

  it('should set defaults', () => {
    expect(mediator.options).toEqual({ endpoint: 'foo.json' });
    expect(mediator.state.isLoading).toEqual(false);
    expect(mediator.store).toBeDefined();
    expect(mediator.service).toBeDefined();
  });

  describe('request and store data', () => {
    it('should store received data', () => {
      mock.onGet('foo.json').reply(200, { id: '121123' });
      mediator.fetchPipeline();

      return waitForPromises().then(() => {
        expect(mediator.store.state.pipeline).toEqual({ id: '121123' });
      });
    });
  });
});
