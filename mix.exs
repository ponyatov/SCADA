defmodule Scada.MixProject do
    use Mix.Project
    
    def project do
        [
            app: :scada,
            version: "0.0.1",
            elixir: "~> 1.11",
            elixirc_paths: ["src"],
            start_permanent: Mix.env() == :prod,
            deps: deps()
        ]
    end
    
    def application do
        [
            extra_applications: [:logger]
        ]
    end
    
    defp deps do
        [
            # \ <section:deps>
            {:cowboy, "~> 2.8"},
            {:ecto, "~> 3.5"},
            {:json, "~> 1.3"},
            {:earmark, "~> 1.4"},
            {:tortoise, "~> 0.9.5"},
            {:bamboo, "~> 1.6"},
            #{:mqtt, "~> 0.3.3"},
            #{:modbus, "~> 0.3.7"},
            {:exsync, "~> 0.2.4", only: :dev},
            # / <section:deps>
        ]
    end
    
end
