# frozen_string_literal: true

class Mrsk < Formula
  desc "Deploy web apps anywhere"
  homepage "https://mrsk.dev"
  url "https://github.com/mrsked/mrsk/archive/refs/tags/v0.8.4.tar.gz"
  sha256 "28e260de56c72bab3622a983dc13fbe22c4c6574583e20db0dbcd15905282385"
  license "MIT"

  depends_on "docker"

  def install
    # Parse version from lib/mrsk/version.rb
    version = `grep -m1 -o 'VERSION = ".*"' lib/mrsk/version.rb`.gsub(/[^0-9+\.]/, "")

    # Full url to image including tag
    # image_tag = "ghcr.io/mrsked/mrsk:v#{version}"
    image_tag = "ghcr.io/mrsked/mrsk:latest"

    # Pull docker image
    system "docker", "pull", image_tag

    (bin/"mrsk").write <<~EOS
      #!/bin/sh

      MRSK_IMAGE="#{image_tag}"

      # Set the '-it' flag if the OS is macOS or Linux
      if [ "$(uname)" = "Darwin" ] || [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
        DOCKER_FLAGS='-it'
      else
        DOCKER_FLAGS=''
      fi

      # Execute the 'docker run' command with the specified flags and arguments
      # Set the '--volume' flag to mount the current directory and the Docker socket
      docker run "$DOCKER_FLAGS" -v "$PWD:/workdir" -v "/var/run/docker.sock:/var/run/docker.sock:rw" "$MRSK_IMAGE" "$@"
    EOS
  end

  # Provide instructions for how to use the 'mrsk' CLI tool
  def caveats
    <<~EOS
      The 'mrsk' command-line tool is used to deploy web apps to any server or platform.

      To install 'mrsk', run the following command:

        $ brew tap mrsked/tap
        $ brew install mrsk

      Once installed, you can create a configuration file using the 'mrsk init' command:

        $ mrsk init

      This will create a new configuration file at the specified path with some default settings.

      You can then use the 'mrsk deploy' command to deploy your app:

        $ mrsk deploy

      For more information, visit the 'mrsk' repository at https://github.com/mrsked/mrsk.
    EOS
  end

  # Test that the 'mrsk version' command returns a version number
  test do
    version_output = shell_output("#{bin}/mrsk version")
    assert_match(/\d+\.\d+\.\d+/, version_output)
  end
end
