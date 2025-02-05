const function2latex = Dict{Symbol, String}(
    ## Greek alphabet
    :alpha => "\\alpha",
    :beta => "\\beta",
    :gamma => "\\gamma",
    :delta => "\\delta",
    :epsilon => "\\epsilon",
    :zeta => "\\zeta",
    :eta => "\\eta",
    :theta => "\\theta",
    :iota => "\\iota",
    :kappa => "\\kappa",
    :lambda => "\\lambda",
    :mu => "\\mu",
    :nu => "\\nu",
    :xi => "\\xi",
    :pi => "\\pi",
    :rho => "\\rho",
    :sigma => "\\sigma",
    :tau => "\\tau",
    :upsilon => "\\upsilon",
    :phi => "\\phi",
    :chi => "\\chi",
    :psi => "\\psi",
    :omega => "\\omega",
    :Gamma => "\\Gamma",
    :Delta => "\\Delta",
    :Theta => "\\Theta",
    :Lambda => "\\Lambda",
    :Xi => "\\Xi",
    :Pi => "\\Pi",
    :Sigma => "\\Sigma",
    :Upsilon => "\\Upsilon",
    :Phi => "\\Phi",
    :Psi => "\\Psi",
    :Omega => "\\Omega",
    ## Trinogometry
	:sin =>   "\\mathrm{sen}",
    :cos =>   "\\mathrm{cos}",
    :tan =>   "\\mathrm{tg}",
	:sind =>  "\\mathrm{sen}",
    :cosd =>  "\\mathrm{cos}",
    :tand =>  "\\mathrm{tg}",
    :cot =>   "\\mathrm{cotg}",
    :sec =>   "\\mathrm{sec}",
    :csc =>   "\\mathrm{cos\\,sec}",
	:sinh =>  "\\mathrm{senh}",
    :cosh =>  "\\mathrm{cosh}",
    :tanh =>  "\\mathrm{tanh}",
    :coth =>  "\\mathrm{coth}",
	:asin =>  "\\mathrm{arc\\,sen}",
    :acos =>  "\\mathrm{arc\\,cos}",
    :atan =>  "\\mathrm{arc\\,tg}",
    :atan2 => "\\mathrm{atan2}",
    :asinh => "\\mathrm{arcsinh}",
    :sinc =>  "\\mathrm{senc}",
    :acosh => "\\mathrm{arc\\,cosh}",
    :cosc =>  "\\mathrm{cosc}",
    :atanh => "\\mathrm{arc\\,tanh}",
    :acot =>  "\\mathrm{arc\\,cot}",
    :acoth => "\\mathrm{arc\\,coth}",
    :asec =>  "\\mathrm{arc\\,sec}",
    :sech =>  "\\mathrm{sech}",
    :asech => "\\mathrm{arc\\,sech}",
    :acsc =>  "\\mathrm{arc\\,csc}",
    :csch =>  "\\mathrm{csch}",
    :acsch => "\\mathrm{arc\\,csch}",
    ## Misc
	:log =>   "\\mathrm{ln}",
    :log10 => "\\log_{10}",
    :log2 =>   "\\log_{2}",
    :gamma => "\\Gamma", # The Gamma function
    )

const trigonometric_functions = [
    :sin,
    :cos,
    :tan,
	:sind,
	:cosd,
	:tand,
    :cot,
    :sec,
    :csc,
    :sinh,
    :cosh,
    :tanh,
    :coth,
    :asin,
    :acos,
    :atan,
    :atan2,
    :asinh,
    :sinc,
    :acosh,
    :cosc,
    :atanh,
    :acot,
    :acoth,
    :asec,
    :sech,
    :asech,
    :acsc,
    :csch,
    :acsch,
    ]

const trigonometric_functions_degrees = [
	:sind,
	:cosd,
	:tand,
	]
