# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    # gxweb = 'https://dev_interview.qagoodx.co.za'
    policy.default_src :none
    policy.script_src :http, :https, 'unsafe-inline' #, gxweb
    policy.style_src :http, :https, 'unsafe-inline'
    policy.img_src :http, :https, :data
    policy.font_src :http, :https
    policy.connect_src :http, :https
    policy.media_src :http, :https
    policy.object_src :none
    policy.child_src :none
    policy.frame_src :none
    # policy.connect_src :self, '*'
    # policy.script_src :self, gxweb
    # policy.default_src :self, :https
    # policy.font_src    :self, :https, :data
    # policy.img_src     :self, :https, :data
    # policy.object_src  :none
    # policy.script_src  :self, :https
    # policy.style_src   :self, :https
  end

  # Generate session nonces for permitted importmap, inline scripts, and inline styles.
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w(script-src style-src)

  # Report violations without enforcing the policy.
  # config.content_security_policy_report_only = true
end
