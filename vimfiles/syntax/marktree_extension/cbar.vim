syn region MtExtCbar start="<<cbar|\zs" end="\ze|>>" contained contains=@MtLinet,MtCodeComment,@MtExtCbarElements
syn cluster MtCodeExtension add=MtExtCbar
syn cluster MtExtCbarElements contains=MtCbarRed,MtCbarGreen,MtCbarBlue,MtCbarMagenta,MtCbarYellow,MtCbarCyan

syn match MtCbarRed "{[^}]\{-}{" contained contains=MtCbarRedSign,MtCbarGreen,MtCbarBlue,MtCbarYellow,MtCbarCyan
syn match MtCbarRedSign "[{}]" contained
syn match MtCbarGreen "\[[^\]]\{-}\[" contained contains=MtCbarGreenSign,MtCbarRed,MtCbarBlue,MtCbarMagenta,MtCbarCyan
syn match MtCbarGreenSign "[\[\]]" contained
syn match MtCbarBlue "([^)]\{-}(" contained contains=MtCbarBlueSign,MtCbarRed,MtCbarGreen,MtCbarMagenta,MtCbarYellow
syn match MtCbarBlueSign "[()]" contained
syn match MtCbarMagenta "}[^{]\{-}}" contained contains=MtCbarMagentaSign,MtCbarGreen,MtCbarBlue,MtCbarYellow,MtCbarCyan
syn match MtCbarMagentaSign "[{}]" contained
syn match MtCbarYellow "\][^\[]\{-}\]" contained contains=MtCbarYellowSign,MtCbarRed,MtCbarBlue,MtCbarMagenta,MtCbarCyan
syn match MtCbarYellowSign "[\[\]]" contained
syn match MtCbarCyan ")[^(]\{-})" contained contains=MtCbarCyanSign,MtCbarRed,MtCbarGreen,MtCbarMagenta,MtCbarYellow
syn match MtCbarCyanSign "[()]" contained

hi default link MtExtCbar Normal