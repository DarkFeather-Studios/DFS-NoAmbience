Config = {}

Config.dfs_noambience = {
    BannedCarModels = {
        { modelname = "RHINO"      , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "HYDRA"      , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "POLICEB"    , BannedFromSpawning = false,  RemoveUntouched = true   },
        { modelname = "LAZER"      , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "POLMAV"     , BannedFromSpawning = false,  RemoveUntouched = false  },
        { modelname = "FROGGER"    , BannedFromSpawning = false,  RemoveUntouched = false  },
        { modelname = "BLIMP"      , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "BLIMP2"     , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "BLIMP3"     , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "CARGOBOB"   , BannedFromSpawning = false,  RemoveUntouched = false  },
        { modelname = "BUZZARD"    , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "SAVAGE"     , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "HUNTER"     , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "VALKYRIE"   , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "AKULA"      , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "JET"        , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "LUXOR"      , BannedFromSpawning = false,  RemoveUntouched = false  },
      --{ modelname = "NUMBUS"     , BannedFromSpawning = false,  RemoveUntouched = false  }, not a vehicle. Nimbus? That's Gabe's personal jet.
        { modelname = "STRIKEFORCE", BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "TITAN"      , BannedFromSpawning = true ,  RemoveUntouched = true   },
        { modelname = "AMBULANCE"  , BannedFromSpawning = false,  RemoveUntouched = false  }
    },

    PopulationMultiplierBase = 0.75,

    DefaultClassBoosts = {
        [0]  =  {   className = "compact"       ,   torque = 1.0  ,  initialDriveForce =   0.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [1]  =  {   className = "sedan"         ,   torque = 1.1  ,  initialDriveForce =  10.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [2]  =  {   className = "suv"           ,   torque = 1.8  ,  initialDriveForce =   5.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [3]  =  {   className = "coupe"         ,   torque = 1.2  ,  initialDriveForce =   7.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [4]  =  {   className = "muscle"        ,   torque = 1.8  ,  initialDriveForce =   8.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [5]  =  {   className = "sports classic",   torque = 1.8  ,  initialDriveForce =   7.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [6]  =  {   className = "sports"        ,   torque = 1.4  ,  initialDriveForce =   8.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [7]  =  {   className = "super"         ,   torque = 3.0  ,  initialDriveForce =  25.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 2.5, fClutchChangeRateScaleDownShift = 2.5, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [8]  =  {   className = "motorcycle"    ,   torque = 4.0  ,  initialDriveForce =   5.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [9]  =  {   className = "offroad"       ,   torque = 1.8  ,  initialDriveForce =   5.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [10] =  {   className = "industrial"    ,   torque = 1.4  ,  initialDriveForce =   5.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [11] =  {   className = "utility"       ,   torque = 1.5  ,  initialDriveForce =   5.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [12] =  {   className = "van"           ,   torque = 1.5  ,  initialDriveForce =   5.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [13] =  {   className = "cycles"        ,   torque = 1.0  ,  initialDriveForce =   0.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [14] =  {   className = "boat"          ,   torque = 3.0  ,  initialDriveForce =  80.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [15] =  {   className = "helis"         ,   torque = 20.0 ,  initialDriveForce = 200.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [16] =  {   className = "plane"         ,   torque = 6.0  ,  initialDriveForce = 200.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [17] =  {   className = "service"       ,   torque = 1.8  ,  initialDriveForce =  10.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [18] =  {   className = "emergency"     ,   torque = 1.0  ,  initialDriveForce =   0.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [19] =  {   className = "military"      ,   torque = 1.0  ,  initialDriveForce =   0.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [20] =  {   className = "commercial"    ,   torque = 3.0  ,  initialDriveForce =   0.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0},
        [21] =  {   className = "train"         ,   torque = 1.0  ,  initialDriveForce =   0.0  ,  fDriveInertia = 0.0, fClutchChangeRateScaleUpShift = 0.0, fClutchChangeRateScaleDownShift = 0.0, fInitialDriveMaxFlatVel = 0.0, fBrakeForce = 0.0, fHandBrakeForce = 0.0, fTractionCurveMax = 0.0, fTractionCurveLateral = 0.0, fTractionCurveMin = 0.0}
    },

    DefaultModelBoosts      = {
        ["NIL"]             =   { torque =      0.0 ,   initialDriveForce =      0.00  , fDriveInertia =      0.0, fClutchChangeRateScaleUpShift =     0.0, fClutchChangeRateScaleDownShift =      0.0, fInitialDriveMaxFlatVel =   0.0, fBrakeForce =    0.0, fHandBrakeForce =     0.0, fTractionCurveMax =    0.0, fTractionCurveLateral =    0.0, fTractionCurveMin =    0.0 },
            }

}