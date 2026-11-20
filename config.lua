
Config = {}
Config.NUIReadyTime = 50 * 1000 -- 50 seconds
Config.WheelPosition = "right" -- left, right and center
Config.ShowCharacter = true -- If True, it will show the character with a camera animation.
Config.CanOpenInCar = false -- If True, you can open the menu while in a vehicle.

Config.UseAnimation = true -- If you set True, no further action will be taken until the animation ends. If False, the animation will not wait for the end of the animation, it will be done directly
Config.CamFov = 30.0 -- Camera Field of View
Config.CameraOffsets = { x = 0.25, y = -0.1, z = 0.5, zRot = 0.2 }

Config.UseKeyMapping = {
    -- If you make it True, it will use a key you specify. After this key is registered to the player once, it will not change in the player even if you change it from Config. The new key will be valid for the other player who enters the server for the first time
    ["use"] = true,
    ["key"] = "M",
}
Config.Keys = {
    -- If KeyMapping is switched on, you will not use it here
    -- Do not touch here if KeyMapping is switched on!
    ["open"] = 244, -- https://docs.fivem.net/docs/game-references/controls/
    ["close"] = "M" -- https://www.toptal.com/developers/keycode
}


Config.Drawables = {
    ["ear"] = {
        ["command"] = "ear",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 2,
            ["type"] = "prop"
        },
        ["animation"] = {
            ["dict"] = nil,
            ["name"] = nil,
            ["dress"] = {
                ["dict"] = "mp_cp_stolen_tut",
                ["name"] = "b_think",
                ["time"] = 900,
                ["movement"] = 51,
            },
            ["undress"] = {
                ["dict"] = "mp_cp_stolen_tut",
                ["name"] = "b_think",
                ["time"] = 900,
                ["movement"] = 51,
            },
        }
    },
    ["neck"] = {
        ["command"] = "neck",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 7,
            ["type"] = "component"
        },
        ["animation"] = {
            ["dict"] = "clothingtie",
            ["name"] = "try_tie_positive_a",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 2.1 * 1000,
            ["movement"] = 51,
        }
    },
    ["watch"] = {
        ["command"] = "watch",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 6,
            ["type"] = "prop"
        },
        ["animation"] = {
            ["dict"] = nil,
            ["name"] = nil,
            ["dress"] = {
                ["dict"] = "nmt_3_rcm-10",
                ["name"] = "cs_nigel_dual-10",
                ["time"] = 1.2 * 1000,
                ["movement"] = 51,
            },
            ["undress"] = {
                ["dict"] = "nmt_3_rcm-10",
                ["name"] = "cs_nigel_dual-10",
                ["time"] = 1.2 * 1000,
                ["movement"] = 51,
            },
        }
    },
    ["bracelet"] = {
        ["command"] = "bracelet",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 7,
            ["type"] = "prop"
        },
        ["animation"] = {
            ["dict"] = nil,
            ["name"] = nil,
            ["dress"] = {
                ["dict"] = "nmt_3_rcm-10",
                ["name"] = "cs_nigel_dual-10",
                ["time"] = 1.2 * 1000,
                ["movement"] = 51,
            },
            ["undress"] = {
                ["dict"] = "nmt_3_rcm-10",
                ["name"] = "cs_nigel_dual-10",
                ["time"] = 1.2 * 1000,
                ["movement"] = 51,
            },
        }
    },
    ["vest"] = {
        ["command"] = "vest",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 9,
            ["type"] = "component",
        },
        ["animation"] = {
            ["dict"] = "clothingtie",
            ["name"] = "try_tie_negative_a",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 1.2 * 1000,
            ["movement"] = 51,
        }
    },
    ["torso"] = {
        ["command"] = "torso",
        ["drawable"] = {
            ["male"] = {
                ["default"] = 15,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 11,
            ["type"] = "component",
        },
        ["animation"] = {
            ["dict"] = "clothingtie",
            ["name"] = "try_tie_negative_a",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 1.5 * 1000,
            ["movement"] = 51,
        },
        ["extras"] = {
            ["male"] = {
                {["type"] = "component", ["componentid"] = 3, ["default"] = 15, ["texture"] = 0}, -- Arms ( Gloves )
                {["type"] = "component", ["componentid"] = 8, ["default"] = 15, ["texture"] = 0}, -- Undershirt ( t-shirt)
            },
            ["female"] = {
                {["type"] = "component", ["componentid"] = 3, ["default"] = 15, ["texture"] = 0}, -- Arms ( Gloves )
                {["type"] = "component", ["componentid"] = 8, ["default"] = 15, ["texture"] = 0} -- Undershirt ( t-shirt)
            }
        }
    },
    ["pants"] = {
        ["command"] = "pants",
        ["drawable"] = {
            ["male"] = {
                ["default"] = 21,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 4,
            ["type"] = "component",
        },
        ["animation"] = {
            ["dict"] = "re@construction",
            ["name"] = "out_of_breath",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 1.3 * 1000,
            ["movement"] = 51,
        }
    },
    ["gloves"] = {
        ["command"] = "gloves",
        ["drawable"] = {
            ["male"] = {
                ["default"] = 15,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 3,
            ["type"] = "component",
        },
        ["animation"] = {
            ["dict"] = "nmt_3_rcm-10",
            ["name"] = "cs_nigel_dual-10",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 1.2 * 1000,
            ["movement"] = 51,
        }
    },
    ["hat"] = {
        ["command"] = "hat",
        ["drawable"] = {
            ["male"] = {
                ["default"] = 0,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 0,
            ["type"] = "prop",
        },
        ["animation"] = {
            ["dict"] = nil,
            ["name"] = nil,
            ["dress"] = {
                ["dict"] = "mp_masks@standard_car@ds@",
                ["name"] = "put_on_mask",
                ["time"] = 600,
                ["movement"] = 51,
            },
            ["undress"] = {
                ["dict"] = "missheist_agency2ahelmet",
                ["name"] = "take_off_helmet_stand",
                ["time"] = 1.2 * 1000,
                ["movement"] = 51,
            },
        }
    },
    ["shoes"] = {
        ["command"] = "shoes",
        ["drawable"] = {
            ["male"] = {
                ["default"] = 34,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 6,
            ["type"] = "component",
        },
        ["animation"] = {
            ["dict"] = "random@domestic",
            ["name"] = "pickup_low",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 1.2 * 1000,
            ["movement"] = 0,
        }
    },
    ["mask"] = {
        ["command"] = "mask",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 1,
            ["type"] = "component",
        },
        ["animation"] = {
            ["dict"] = "mp_masks@standard_car@ds@",
            ["name"] = "put_on_mask",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 800,
            ["movement"] = 51,
        }
    },
    ["hair"] = {
        ["command"] = "hair",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 2,
            ["type"] = "component",
        },
        ["animation"] = {
            ["dict"] = "clothingtie",
            ["name"] = "check_out_a",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 2 * 1000,
            ["movement"] = 51,
        }
    },
    ["bag"] = {
        ["command"] = "bag",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 5,
            ["type"] = "component",
        },
        ["animation"] = {
            ["dict"] = "anim@heists@ornate_bank@grab_cash",
            ["name"] = "intro",
            ["dress"] = nil,
            ["undress"] = nil,
            ["time"] = 1.6 * 1000,
            ["movement"] = 51,
        }
    },
    ["glasses"] = {
        ["command"] = "glasses",
        ["drawable"] = {
            ["male"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["female"] = {
                ["default"] = -1,
                ["texture"] = 0,
            },
            ["componentid"] = 1,
            ["type"] = "prop",
        },
        ["animation"] = {
            ["dict"] = nil,
            ["name"] = nil,
            ["dress"] = {
                ["dict"] = "clothingspecs",
                ["name"] = "put_on",
                ["time"] = 5.3 * 1000,
                ["movement"] = 51,
            },
            ["undress"] = {
                ["dict"] = "clothingspecs",
                ["name"] = "take_off",
                ["time"] = 2 * 1000,
                ["movement"] = 51,
            },
        }
    },
}
