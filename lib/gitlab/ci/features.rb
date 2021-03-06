# frozen_string_literal: true

module Gitlab
  module Ci
    ##
    # Ci::Features is a class that aggregates all CI/CD feature flags in one place.
    #
    module Features
      def self.artifacts_exclude_enabled?
        ::Feature.enabled?(:ci_artifacts_exclude, default_enabled: true)
      end

      def self.job_heartbeats_runner?(project)
        ::Feature.enabled?(:ci_job_heartbeats_runner, project, default_enabled: true)
      end

      def self.instance_variables_ui_enabled?
        ::Feature.enabled?(:ci_instance_variables_ui, default_enabled: true)
      end

      def self.pipeline_latest?
        ::Feature.enabled?(:ci_pipeline_latest, default_enabled: true)
      end

      def self.pipeline_status_omit_commit_sha_in_cache_key?(project)
        Feature.enabled?(:ci_pipeline_status_omit_commit_sha_in_cache_key, project, default_enabled: true)
      end

      # Remove in https://gitlab.com/gitlab-org/gitlab/-/issues/224199
      def self.store_pipeline_messages?(project)
        ::Feature.enabled?(:ci_store_pipeline_messages, project, default_enabled: true)
      end

      def self.raise_job_rules_without_workflow_rules_warning?
        ::Feature.enabled?(:ci_raise_job_rules_without_workflow_rules_warning, default_enabled: true)
      end

      def self.bulk_insert_on_create?(project)
        ::Feature.enabled?(:ci_bulk_insert_on_create, project, default_enabled: true)
      end

      # NOTE: The feature flag `disallow_to_create_merge_request_pipelines_in_target_project`
      # is a safe switch to disable the feature for a parituclar project when something went wrong,
      # therefore it's not supposed to be enabled by default.
      def self.disallow_to_create_merge_request_pipelines_in_target_project?(target_project)
        ::Feature.enabled?(:ci_disallow_to_create_merge_request_pipelines_in_target_project, target_project)
      end

      def self.lint_creates_pipeline_with_dry_run?(project)
        ::Feature.enabled?(:ci_lint_creates_pipeline_with_dry_run, project, default_enabled: true)
      end

      def self.project_transactionless_destroy?(project)
        Feature.enabled?(:project_transactionless_destroy, project, default_enabled: false)
      end

      def self.coverage_report_view?(project)
        ::Feature.enabled?(:coverage_report_view, project, default_enabled: true)
      end

      def self.child_of_child_pipeline_enabled?(project)
        ::Feature.enabled?(:ci_child_of_child_pipeline, project, default_enabled: true)
      end

      def self.trace_overwrite?
        ::Feature.enabled?(:ci_trace_overwrite, type: :ops, default_enabled: false)
      end

      def self.accept_trace?(project)
        ::Feature.enabled?(:ci_enable_live_trace, project) &&
          ::Feature.enabled?(:ci_accept_trace, project, type: :ops, default_enabled: false)
      end

      def self.new_artifact_file_reader_enabled?(project)
        ::Feature.enabled?(:ci_new_artifact_file_reader, project, default_enabled: true)
      end
    end
  end
end
