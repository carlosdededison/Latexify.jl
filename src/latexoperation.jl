"""
    latexoperation(ex::Expr, prevOp::AbstractArray)

Translate a simple operation given by `ex` to LaTeX maths syntax.
This uses the information about the previous operations to decide if
a parenthesis is needed.

"""
function latexoperation(ex::Expr, prevOp::AbstractArray; cdot=true, kwargs...)
    op = ex.args[1]
    convertSubscript!(ex)
    args = map(i -> i isa Number ? latexraw(i; kwargs...) : i, ex.args)

    if op in [:/, :./]
        return "\\frac{$(args[2])}{$(args[3])}"

    elseif op in [:*, :.*]
        str=""
        for i in 2:length(args)
            arg = args[i]
            prevOp[i] in [:+, :-, :±]  && (arg = "\\left( $arg \\right)")
            str = string(str, arg)
            i != length(args) && (str *= cdot ? " \\cdot " : " ")
        end
        return str

    elseif op in [:+, :.+]
        str = join(args[2:end], " + ")
        str = replace(str, "+  -"=>"-")
        str = replace(str, "+ -"=>"-")
        return str

    elseif op in [:±, :.±]
        return "$(args[2]) \\pm $(args[3])"

    elseif op in [:-, :.-]
        if length(args) == 2
            if prevOp[2] == :none && string(args[2])[1] == '-'
                return " + " * string(args[2])[2:end]
            elseif prevOp[2] == :none && string(args[2])[1] == '+'
                return " - " * string(args[2])[2:end]
            elseif prevOp[2] in [:+, :-, :±]
                return " - \\left( $(args[2]) \\right)"
            end
            return " - $(args[2])"
        end
        prevOp[3] in [:+, :-, :±] &&  (args[3] = "\\left( $(args[3]) \\right)")

        if prevOp[3] == :none && string(args[3])[1] == '-'
            return "$(args[2]) + " * string(args[3])[2:end]
        end
        return "$(args[2]) - $(args[3])"

    elseif op in [:^, :.^]
        #isa(args[2], String) && (args[2]="($(args[2]))")
        if prevOp[2] in trigonometric_functions
            str = get(function2latex, prevOp[2], "\\$(prevOp[2])")
            return replace(args[2], str => "$(str)^{$(args[3])}")
        end
        prevOp[2] != :none  && (args[2]="\\left( $(args[2]) \\right)")
        return "$(args[2])^{$(args[3])}"
    elseif ex.head == :(=) && length(args) == 2
        return "$(args[1]) = $(args[2])"
    end

    if ex.head == :.
        ex.head = :call
        # op = string(op, ".") ## Signifies broadcasting.
    end

    string(op)[1] == '.' && (op = Symbol(string(op)[2:end]))

    # infix_operators = [:<, :>, Symbol("=="), :<=, :>=, :!=]
    comparison_operators = Dict(
        :< => "\\lt",
        :.< => "\\lt",
        :> => "\\gt",
        :.> => "\\gt",
        Symbol("==") => "=",
        Symbol(".==") => "=",
        :<= => "\\leq",
        :.<= => "\\leq",
        :>= => "\\geq",
        :.>= => "\\geq",
        :!= => "\\neq",
        :.!= => "\\neq",
        )

    if op in keys(comparison_operators) && length(args) == 3
        str = "$(args[2]) $(comparison_operators[op]) $(args[3])"
        str = "\\left( $str \\right)"
        return str
    end

    ### Check for chained comparison operators
    if ex.head == :comparison && Symbol.(args[2:2:end]) ⊆ keys(comparison_operators)
        str = join([isodd(i) ? "$var" : comparison_operators[var] for (i, var) in enumerate(Symbol.(args))], " ")
        str = "\\left( $str \\right)"
        return str
    end

    if op in keys(function2latex)
        return "$(function2latex[op])\\left( $(join(args[2:end], ", ")) \\right)"
    end

    op == :sqrt && return "\\$op{$(args[2])}"
    op == :abs && return "\\left\\|$(args[2])\\right\\|"
    op == :exp && return "e^{$(args[2])}"


    if ex.head == :ref
        argstring = join(args[2:end], ", ")
		return "{$op}_{$argstring}"
    end

    if ex.head == :call
        return "\\mathrm{$op}\\left( $(join(args[2:end], ", ")) \\right)"
    end

    if ex.head == :tuple
        # return "\\left(" * join(ex.args, ", ") * "\\right)"
        return join(ex.args, ", ")
    end

    ex.head == Symbol("'") && return "$(args[1])'"
    ## if we have reached this far without a return, then error.
    error("Latexify.jl's latexoperation does not know what to do with one of the
                operators in your expression ($op).")
    return ""
end

latexoperation(sym::Symbol, prevOp::AbstractArray; kwargs...) = "$sym"


function convertSubscript!(ex::Expr)
    for i in 1:length(ex.args)
        arg = ex.args[i]
        if arg isa Symbol
            ex.args[i] = convertSubscript(arg)
        end
    end
    return nothing
end

function convertSubscript(str::String)
    if occursin("_", str)
        subscriptList = split(str, "_")
        subscript = join(subscriptList[2:end], "\\_")
        result = "$(subscriptList[1])_{$subscript}"
    else
        result = str
    end
    return result
end

convertSubscript(sym::Symbol) = convertSubscript(string(sym))
