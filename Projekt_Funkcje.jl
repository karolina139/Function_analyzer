module Func
export parse_formula_input, first_derivative, second_derivative, get_bottom_range_value, get_top_range_value, 
max_function_value, min_function_value, draw_plot, generate_default_table, generate_table

#używane biblioteki
using SymPy, Plots, Latexify, LaTeXStrings
#Plots na silniku pyplot
pyplot()

"""Funkcja konwertująca wpisany wzór na wzór symboliczny"""
function parse_formula_input(expression)   
    return sympify(expression)
end


 """Funkcja obliczająca pierwszą pochodną funkcji"""
function first_derivative(formula)
    formula = parse_formula_input(formula)
    x = symbols("x")
    return string(diff(formula,x))
end


"""Funkcja obliczająca drugą pochodną funkcji"""
function second_derivative(formula)
    formula = parse_formula_input(formula)
    x = symbols("x")
    return string(diff(formula,x,2))
end


"""Funkcja zwracająca dolną wartość zakresu"""
function get_bottom_range_value(range) 
    range_x = split(range,",")
    return parse(Int64, String(range_x[1]))
end


"""Funkcja zwracająca górną wartość zakresu"""
function get_top_range_value(range)  
    range_x = split(range,",")
    return parse(Int64, String(range_x[2]))
end


"""Funkcja obliczająca maksymalną wartość funkcji w danym zakresie"""
function max_function_value(expression, range)
    formula = sympify(expression)
    x = Sym("x")
    delta = 0.01
    derivative = diff(formula,x)
    extremes = []
    for x in solve(derivative)
        if derivative(N(x)-delta)>0 && derivative(N(x)+delta)<0
            append!(extremes, N(formula(x)))
        end
    end

    f_x_bottom = N(round(Float64(formula(get_bottom_range_value(range))), digits=4))
    f_x_top = N(round(Float64(formula(get_top_range_value(range))), digits=4))
    
    if length(extremes) == 0
        return string(round(Float64(max(f_x_bottom,f_x_top)), digits=4))     
    else
        return string(max(f_x_bottom,f_x_top, round(Float64(maximum(extremes)), digits=4)))
    end
end


"""Funkcja obliczająca minimalną wartość funkcji w danym zakresie"""
function min_function_value(expression, range) 
    formula = sympify(expression)
    x = Sym("x")
    delta = 0.01
    derivative = diff(formula,x)
    extremes = []
    for x in solve(derivative)
        if derivative(N(x)-delta)<0 && derivative(N(x)+delta)>0
            append!(extremes, N(formula(x)))
        end
    end

    f_x_bottom = round(Float64(N(formula(get_bottom_range_value(range)))), digits=4)
    f_x_top = round(Float64(N(formula(get_top_range_value(range)))), digits=4)

    if length(extremes) == 0
        return  string(round(Float64(min(f_x_bottom,f_x_top)), digits=4))
    else
        return  string(min(f_x_bottom,f_x_top, round(Float64(minimum(extremes)), digits=4)))
    end
end


"""Funkcja zwracająca listę miejsc zerowych pierwszej pochodnej w podanym zakresie"""
function get_first_extremes(expression)
    formula =  parse_formula_input(expression)
    x = Sym("x")
    derivative = diff(formula,x)
    extremes = []
    append!(extremes, solve(derivative))
    return extremes
end


"""Funkcja zwracająca listę miejsc zerowych drugiej pochodnej w podanym zakresie"""
function get_second_extremes(expression)  
    formula =  parse_formula_input(expression)
    x = Sym("x")
    derivative = diff(formula,x)
    bis = diff(derivative,x)
    extremes = []
    append!(extremes, solve(bis))
    return extremes
end


"""Funkcja zwracająca uporządkowaną listę punktów i zakresów 
w formie latexowych stringów - potrzebne do pierwszego wiersza tabelki"""
function get_ranges(expression, range) 
    points = []
    bottom = get_bottom_range_value(range)
    top = get_top_range_value(range)
    extremes1 = get_first_extremes(expression)
    extremes2 = get_second_extremes(expression)
    push!(points, bottom)
    push!(points, top)
    for e1 in extremes1
        push!(points, e1)
    end
    for e2 in extremes2
        push!(points, e2)
    end
    sorted = sort(points)
    ranges = []
    i=1
    while i<= length(sorted)-1
        j = sorted[i]
        k = sorted[i+1]
        if j !=k
            push!(ranges, latexify("$j"))
            push!(ranges, "("*latexify("$j, $k")*")")
        end
        i=i+1
    end 
    push!(ranges, "$top")
    return ranges
end    


"""Funkcja zwracająca uporządkowaną listę punktów i zakresów, które
są wykorzystywane do obliczania znaku/wartości pochodnej/funkcji"""
function get_ranges_for_count(expression, range)
    points = []
    bottom = get_bottom_range_value(range)
    top = get_top_range_value(range)
    extremes1 = get_first_extremes(expression)
    extremes2 = get_second_extremes(expression)
    push!(points, bottom)
    push!(points, top)
    for e1 in extremes1
        push!(points, e1)
    end
    for e2 in extremes2
        push!(points, e2)
    end
    sorted = sort(points)
    ranges = []
    i=1
    while i<= length(sorted)-1
        j = sorted[i]
        k = sorted[i]+0.0000000000001
        if j !=k
            push!(ranges, j)
            push!(ranges, k)
        end
        i=i+1
    end 
    push!(ranges, top)
    return unique(ranges)
end


"""Funkcja licząca wartość funkcji dla danego x"""
function count_value_of_formula(expression, value)
    formula = parse_formula_input(expression)
    x = Sym("x")
    return subs(formula, x, value)
end


"""Funkcja tworząca folder do przechowywania plików z obrazem wykresów i tabelek"""
function make_directory()
    if isdir("Plots") == false
        mkdir("Plots")
    end
end


"""Funkcja tworząca i zapisująca domyślny, pusty wykres"""
function draw_default_plot()
    make_directory()
    path = pwd()

    plot(xlims=(-10,10), ylims=(-10,10), background_color_outside="#ffffe6")
    savefig(path*"\\Plots\\Default_plot.png")
end


"""Funkcja tworząca i zapisująca wykres funkcji"""
function draw_plot(expression, range)
    path = pwd()

    if occursin("tan", expression) || occursin("cot", expression)
        #ustawiony zakres ylims dla ładniejszego wykresu
        xs = LinRange(get_bottom_range_value(range), get_top_range_value(range), 1000)
        ys = parse_formula_input(expression)      
        plot(xs, ys, label = latexify("$expression"), ylim = (-10, 10), color = "#b34700", background_color_outside = "#ffffe6", legend = :topright, legendfontsize = 13)
        savefig(path * "\\Plots\\Plot.png")
    else
        xs = LinRange(get_bottom_range_value(range), get_top_range_value(range), 1000)
        ys = parse_formula_input(expression)
        plot(xs, ys, label = latexify("$expression"), color = "#b34700", background_color_outside = "#ffffe6", legend = :topright, legendfontsize = 13)
        savefig(path * "\\Plots\\Plot.png")
    end
end


"""Funkcja tworząca i zapisująca domyślną, pustą tabelkę"""
function generate_default_table()
    path = pwd()

    plot(xlims=(0,11), ylims=(0,7), framestyle=:none, background_color_outside="#ffffe6")
    plot!([0,0],[0,7], color=:black, label=false)
    plot!([1,1],[0,7], color=:black, label=false)
    plot!([0,11],[0,0], color=:black, label=false)
    plot!([0,11],[7,7], color=:black, label=false)
    plot!([0,11],[6,6], color=:black, label=false)

    for x in 3:2:11
        plot!([x,x],[0,7], color=:black, label=false)
    end
    
    for y in 2:2:4
        plot!([0,11],[y,y], color=:black, label=false)
    end
    
    for x in 2:2:10, y in 1:2:5
        annotate!(x,y, "-")
    end

    annotate!(0.5, 5, latexify("f(x)"))
    annotate!(0.5, 3, latexify("f'(x)"))
    annotate!(0.5, 1, latexify("f''(x)"))    

    annotate!(2, 6.5, "-10")
    annotate!(4, 6.5, "(-10,0)")
    annotate!(6, 6.5, "0")
    annotate!(8, 6.5, "(0,10)")
    annotate!(10, 6.5, "10")

    savefig(path*"\\Plots\\Default_table.png")
end


"""Funkcja tworząca i zapisująca tabelkę z analizą przebiegu zmienności funkcji"""
function generate_table(expression, range)
    path = pwd()

    formula = parse_formula_input(expression)
    ranges = get_ranges(formula, range)
    ranges_for_count = get_ranges_for_count(formula, range)

    plot(xlims=(0,length(ranges)*2+1), ylims=(0,7), framestyle=:none, background_color_outside="#ffffe6")
    plot!([0,0],[0,7], color=:black, label=false)
    plot!([1,1],[0,7], color=:black, label=false)
    plot!([0,length(ranges)*2+1],[0,0], color=:black, label=false)
    plot!([0,length(ranges)*2+1],[7,7], color=:black, label=false)
    plot!([0,length(ranges)*2+1],[6,6], color=:black, label=false)

    for y in 2:2:4
        plot!([0,length(ranges)*2+1],[y,y], color=:black, label=false)
    end

    for i in 1:length(ranges)
        plot!([1+i*2, 1+i*2],[0,7], color=:black, label=false)
    end
    
    annotate!(0.5, 5, latexify("f(x)"), 8)
    annotate!(0.5, 3, latexify("f'(x)"), 8)
    annotate!(0.5, 1, latexify("f''(x)"), 8)

    for (i,r) in enumerate(ranges)
        annotate!(2*i, 6.5, "$r", 8)
    end

    for (i,c) in enumerate(ranges_for_count)
        if count_value_of_formula(diff(formula), c) == 0
            annotate!(2*i, 3, "0", 10)
            value = count_value_of_formula(formula, c)
            annotate!(2*i, 5, latexify("$value"), 8)
        end
        if count_value_of_formula(diff(formula), c) < 0 
            annotate!(2*i, 3, "-", 10)
            annotate!(2*i, 5, L"\searrow", 12)
        end
        if count_value_of_formula(diff(formula), c) > 0
            annotate!(2*i, 3, "+", 10)
            annotate!(2*i, 5, L"\nearrow", 12)
        end
        if count_value_of_formula(diff(diff(formula)), c) == 0
            annotate!(2*i, 1, "0", 10)
            annotate!(2*i, 4.5, "p.p.", 8)
        end
        if count_value_of_formula(diff(diff(formula)), c) < 0
            annotate!(2*i, 1, "-", 10)
            annotate!(2*i, 4.5, "wklęsła", 8)
        end
        if count_value_of_formula(diff(diff(formula)), c) > 0
            annotate!(2*i, 1, "+", 10)
            annotate!(2*i, 4.5, "wypukła", 8)
        end
    end

    savefig(path*"\\Plots\\Table.png")
end


end


