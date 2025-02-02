module ForemanMaintain::PackageManager
  class Dnf < Yum
    def clean_cache(assumeyes: false)
      dnf_action('clean', 'all', :assumeyes => assumeyes)
      super
    end

    def version_locking_supported?
      true
    end

    private

    def dnf_action(action, packages, with_status: false, assumeyes: false)
      packages = [packages].flatten(1)
      yum_options = []
      yum_options << '-y' if assumeyes
      if with_status
        sys.execute_with_status("dnf #{yum_options.join(' ')} #{action} #{packages.join(' ')}",
                                :interactive => !assumeyes)
      else
        sys.execute!("dnf #{yum_options.join(' ')} #{action} #{packages.join(' ')}",
                     :interactive => !assumeyes)

      end
    end
  end
end
