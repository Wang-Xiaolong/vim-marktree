syn region MtCbarBlock matchgroup=MtBlockFence start="<<cbar|" end="|>>" contains=@MtLinet,MtCodeComment,@MtCbarMarks
syn cluster MtCbarMarks contains=MtCbarRed,MtCbarGreen,MtCbarBlue,MtCbarMagenta,MtCbarYellow,MtCbarCyan

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

syn region MtCbarTableBlock matchgroup=MtBlockFence start="<<cbar_table|" end="|>>" contains=MtCodeComment,@MtCbarTableCells,MtCbarTableGrid
syn cluster MtCbarTableCells contains=MtCbarRedCell,MtCbarGreenCell,MtCbarBlueCell,MtCbarMagentaCell,MtCbarYellowCell,MtCbarCyanCell
syn match MtCbarTableGrid "|" contained

hi default link MtCbarTableGrid MtSign

syn match MtCbarRedCell "{[^}]\{-}{" contained contains=MtCbarRedSign,MtCbarRedCellGrid
syn match MtCbarRedCellGrid "|" contained
syn match MtCbarGreenCell "\[[^\]]\{-}\[" contained contains=MtCbarGreenSign,MtCbarGreenCellGrid
syn match MtCbarGreenCellGrid "|" contained
syn match MtCbarBlueCell "([^)]\{-}(" contained contains=MtCbarBlueSign,MtCbarBlueCellGrid
syn match MtCbarBlueCellGrid "|" contained
syn match MtCbarMagentaCell "}[^{]\{-}}" contained contains=MtCbarMagentaSign,MtCbarMagentaCellGrid
syn match MtCbarMagentaCellGrid "|" contained
syn match MtCbarYellowCell "\][^\[]\{-}\]" contained contains=MtCbarYellowSign,MtCbarYellowCellGrid
syn match MtCbarYellowCellGrid "|" contained
syn match MtCbarCyanCell ")[^(]\{-})" contained contains=MtCbarCyanSign,MtCbarCyanCellGrid
syn match MtCbarCyanCellGrid "|" contained

hi default link MtCbarRedCell MtCbarRed
hi default link MtCbarGreenCell MtCbarGreen
hi default link MtCbarBlueCell MtCbarBlue
hi default link MtCbarMagentaCell MtCbarMagenta
hi default link MtCbarYellowCell MtCbarYellow
hi default link MtCbarCyanCell MtCbarCyan