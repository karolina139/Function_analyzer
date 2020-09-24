#używana biblioteka i import modułu
using Gtk
using .Func

#Zmienna z aktualną ściężką, w której znajduje się użytkownik, potrzebna do wykonania dalszych funkcji
path = pwd()

#połączenie z plikiem opisującym wygląd aplikacji
style_file = joinpath(dirname(Base.source_path()), "style.css")
provider = GtkCssProviderLeaf(filename = style_file)

#inicjalizacja głównego okna
win = GtkWindow("Analizator funkcji 2000")
set_gtk_property!(win, :name, "win")
screen = Gtk.GAccessor.style_context(win)
push!(screen, GtkStyleProvider(provider), 600)

#inicjalizacja metody rozmieszczania obiektów - siatki
grid = GtkGrid()

######
#OBIEKTY 
######

####
#Napis "wzór funkcji i pole entry do wpisania wzoru
space = GtkLabel("")
set_gtk_property!(space, :name, "space")
screen = Gtk.GAccessor.style_context(space)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:8,1] = space

formula_label = GtkLabel("Wzór funkcji:")
set_gtk_property!(formula_label, :name, "formula_label")
screen = Gtk.GAccessor.style_context(formula_label)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:8,2] = formula_label

space1 = GtkLabel("")
set_gtk_property!(space1, :name, "space")
screen = Gtk.GAccessor.style_context(space1)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:8,3] = space1

formula_input = GtkEntry()
set_gtk_property!(formula_input, :name, "formula_input")
screen = Gtk.GAccessor.style_context(formula_input)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:8,4] = formula_input


#####
#Guziki kalkulatorowe, do budowania wzoru funkcji
space2 = GtkLabel("")
set_gtk_property!(space2, :name, "space")
screen = Gtk.GAccessor.style_context(space2)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:8, 5] = space2

b1 = GtkButton("x")
set_gtk_property!(b1, :name, "button")
screen = Gtk.GAccessor.style_context(b1)
push!(screen, GtkStyleProvider(provider), 600)
grid[1,6] = b1

b2 = GtkButton("^")
set_gtk_property!(b2, :name, "button")
screen = Gtk.GAccessor.style_context(b2)
push!(screen, GtkStyleProvider(provider), 600)
grid[2,6] = b2

b3 = GtkButton("√")
set_gtk_property!(b3, :name, "button")
screen = Gtk.GAccessor.style_context(b3)
push!(screen, GtkStyleProvider(provider), 600)
grid[3,6] = b3

b4 = GtkButton("ln")
set_gtk_property!(b4, :name, "button")
screen = Gtk.GAccessor.style_context(b4)
push!(screen, GtkStyleProvider(provider), 600)
grid[4,6] = b4

b5 = GtkButton("7")
set_gtk_property!(b5, :name, "button")
screen = Gtk.GAccessor.style_context(b5)
push!(screen, GtkStyleProvider(provider), 600)
grid[5,6] = b5

b6 = GtkButton("8")
set_gtk_property!(b6, :name, "button")
screen = Gtk.GAccessor.style_context(b6)
push!(screen, GtkStyleProvider(provider), 600)
grid[6,6] = b6

b7 = GtkButton("9")
set_gtk_property!(b7, :name, "button")
screen = Gtk.GAccessor.style_context(b7)
push!(screen, GtkStyleProvider(provider), 600)
grid[7,6] = b7

b8 = GtkButton("/")
set_gtk_property!(b8, :name, "button")
screen = Gtk.GAccessor.style_context(b8)
push!(screen, GtkStyleProvider(provider), 600)
grid[8,6] = b8


b9 = GtkButton("(")
set_gtk_property!(b9, :name, "button")
screen = Gtk.GAccessor.style_context(b9)
push!(screen, GtkStyleProvider(provider), 600)
grid[1,7] = b9

b10 = GtkButton(")")
set_gtk_property!(b10, :name, "button")
screen = Gtk.GAccessor.style_context(b10)
push!(screen, GtkStyleProvider(provider), 600)
grid[2,7] = b10

b11 = GtkButton("π")
set_gtk_property!(b11, :name, "button")
screen = Gtk.GAccessor.style_context(b11)
push!(screen, GtkStyleProvider(provider), 600)
grid[3,7] = b11

b12 = GtkButton("exp")
set_gtk_property!(b12, :name, "button")
screen = Gtk.GAccessor.style_context(b12)
push!(screen, GtkStyleProvider(provider), 600)
grid[4,7] = b12

b13 = GtkButton("4")
set_gtk_property!(b13, :name, "button")
screen = Gtk.GAccessor.style_context(b13)
push!(screen, GtkStyleProvider(provider), 600)
grid[5,7] = b13

b14 = GtkButton("5")
set_gtk_property!(b14, :name, "button")
screen = Gtk.GAccessor.style_context(b14)
push!(screen, GtkStyleProvider(provider), 600)
grid[6,7] = b14

b15 = GtkButton("6")
set_gtk_property!(b15, :name, "button")
screen = Gtk.GAccessor.style_context(b15)
push!(screen, GtkStyleProvider(provider), 600)
grid[7,7] = b15

b16 = GtkButton("*")
set_gtk_property!(b16, :name, "button")
screen = Gtk.GAccessor.style_context(b16)
push!(screen, GtkStyleProvider(provider), 600)
grid[8,7] = b16


b17 = GtkButton("sin")
set_gtk_property!(b17, :name, "button")
screen = Gtk.GAccessor.style_context(b17)
push!(screen, GtkStyleProvider(provider), 600)
grid[1,8] = b17

b18 = GtkButton("cos")
set_gtk_property!(b18, :name, "button")
screen = Gtk.GAccessor.style_context(b18)
push!(screen, GtkStyleProvider(provider), 600)
grid[2,8] = b18

b19 = GtkButton("tg")
set_gtk_property!(b19, :name, "button")
screen = Gtk.GAccessor.style_context(b19)
push!(screen, GtkStyleProvider(provider), 600)
grid[3,8] = b19

b20 = GtkButton("ctg")
set_gtk_property!(b20, :name, "button")
screen = Gtk.GAccessor.style_context(b20)
push!(screen, GtkStyleProvider(provider), 600)
grid[4,8] = b20

b21 = GtkButton("1")
set_gtk_property!(b21, :name, "button")
screen = Gtk.GAccessor.style_context(b21)
push!(screen, GtkStyleProvider(provider), 600)
grid[5,8] = b21

b22 = GtkButton("2")
set_gtk_property!(b22, :name, "button")
screen = Gtk.GAccessor.style_context(b22)
push!(screen, GtkStyleProvider(provider), 600)
grid[6,8] = b22

b23 = GtkButton("3")
set_gtk_property!(b23, :name, "button")
screen = Gtk.GAccessor.style_context(b23)
push!(screen, GtkStyleProvider(provider), 600)
grid[7,8] = b23

b24 = GtkButton("-")
set_gtk_property!(b24, :name, "button")
screen = Gtk.GAccessor.style_context(b24)
push!(screen, GtkStyleProvider(provider), 600)
grid[8,8] = b24


b25 = GtkButton("arcsin")
set_gtk_property!(b25, :name, "button")
screen = Gtk.GAccessor.style_context(b25)
push!(screen, GtkStyleProvider(provider), 600)
grid[1,9] = b25

b26 = GtkButton("arccos")
set_gtk_property!(b26, :name, "button")
screen = Gtk.GAccessor.style_context(b26)
push!(screen, GtkStyleProvider(provider), 600)
grid[2,9] = b26

b27 = GtkButton("arctg")
set_gtk_property!(b27, :name, "button")
screen = Gtk.GAccessor.style_context(b27)
push!(screen, GtkStyleProvider(provider), 600)
grid[3,9] = b27

b28 = GtkButton("arcctg")
set_gtk_property!(b28, :name, "button")
screen = Gtk.GAccessor.style_context(b28)
push!(screen, GtkStyleProvider(provider), 600)
grid[4,9] = b28

b29 = GtkButton("0")
set_gtk_property!(b29, :name, "button")
screen = Gtk.GAccessor.style_context(b29)
push!(screen, GtkStyleProvider(provider), 600)
grid[5,9] = b29

b30 = GtkButton(".")
set_gtk_property!(b30, :name, "button")
screen = Gtk.GAccessor.style_context(b30)
push!(screen, GtkStyleProvider(provider), 600)
grid[6,9] = b30

b31 = GtkButton(",")
set_gtk_property!(b31, :name, "button")
screen = Gtk.GAccessor.style_context(b31)
push!(screen, GtkStyleProvider(provider), 600)
grid[7,9] = b31

b32 = GtkButton("+")
set_gtk_property!(b32, :name, "button")
screen = Gtk.GAccessor.style_context(b32)
push!(screen, GtkStyleProvider(provider), 600)
grid[8,9] = b32


####
#Pola z tekstem i pola entry do wpisania zakresów dla jakich ma zostać wykonana czynność
space2 = GtkLabel("")
set_gtk_property!(space2, :name, "space")
screen = Gtk.GAccessor.style_context(space2)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,10] = space2

space3 = GtkLabel("")
grid[3:8,10] = space3

#Zakres do narysowania wykresu
range_for_plot_label = GtkLabel("Rysuj dla zakresu:")
set_gtk_property!(range_for_plot_label, :name, "label")
screen = Gtk.GAccessor.style_context(range_for_plot_label)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,11] = range_for_plot_label

range_for_plot_input = GtkEntry()
set_gtk_property!(range_for_plot_input, :text,"-10,10")
grid[3:4,11] = range_for_plot_input

#Zakres dla analizy funkcji
range_for_count_label = GtkLabel("Badaj dla zakresu:")
set_gtk_property!(range_for_count_label, :name, "label")
screen = Gtk.GAccessor.style_context(range_for_count_label)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,12] = range_for_count_label

range_for_count_input = GtkEntry()
set_gtk_property!(range_for_count_input, :text,"-10,10")
grid[3:4,12] = range_for_count_input


####
#Pola tekstowe i pola, w których pokazują się wyniki wykonanych czynności
space4 = GtkLabel("")
set_gtk_property!(space4, :name, "space")
screen = Gtk.GAccessor.style_context(space4)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,13:14] = space4

space5 = GtkLabel("")
grid[3:8,13:14] = space5

#Pierwsza pochodna funkcji
first_derivative_text = GtkLabel("Pierwsza pochodna:")
set_gtk_property!(first_derivative_text, :name, "label")
screen = Gtk.GAccessor.style_context(first_derivative_text)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,15] = first_derivative_text

first_derivative_output = GtkLabel("")
set_gtk_property!(first_derivative_output, :name, "output")
screen = Gtk.GAccessor.style_context(first_derivative_output)
push!(screen, GtkStyleProvider(provider), 600)
grid[3:4,15] = first_derivative_output

#Druga pochodna funkcji
second_derivative_text = GtkLabel("Druga pochodna:")
set_gtk_property!(second_derivative_text, :name, "label")
screen = Gtk.GAccessor.style_context(second_derivative_text)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,16] = second_derivative_text

second_derivative_output = GtkLabel("")
set_gtk_property!(second_derivative_output, :name, "output")
screen = Gtk.GAccessor.style_context(second_derivative_output)
push!(screen, GtkStyleProvider(provider), 600)
grid[3:4,16] = second_derivative_output

#Wartość maksymalna
maximum_value_text = GtkLabel("Wartość maksymalna:")
set_gtk_property!(maximum_value_text, :name, "label")
screen = Gtk.GAccessor.style_context(maximum_value_text)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,17] = maximum_value_text

maximum_value_output = GtkLabel("")
set_gtk_property!(maximum_value_output , :name, "output")
screen = Gtk.GAccessor.style_context(maximum_value_output)
push!(screen, GtkStyleProvider(provider), 600)
grid[3:4,17] = maximum_value_output

#Wartość minimalna
minimum_value_text = GtkLabel("Wartość minimalna:")
set_gtk_property!(minimum_value_text, :name, "label")
screen = Gtk.GAccessor.style_context(minimum_value_text)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,18] = minimum_value_text

minimum_value_output = GtkLabel("")
set_gtk_property!(minimum_value_output , :name, "output")
screen = Gtk.GAccessor.style_context(minimum_value_output)
push!(screen, GtkStyleProvider(provider), 600)
grid[3:4,18] = minimum_value_output


####
#Guziki do obsługi programu
space6 = GtkLabel("")
set_gtk_property!(space6 , :name, "space")
screen = Gtk.GAccessor.style_context(space6)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,19] = space6

space7 = GtkLabel("")
grid[3:8,19] = space7

#Uruchomienie programu
count_button = GtkButton("Badaj")
set_gtk_property!(count_button, :name, "button2")
screen = Gtk.GAccessor.style_context(count_button)
push!(screen, GtkStyleProvider(provider), 600)
grid[1:2,20] = count_button

#Wyczyszczenie wyników
clear_button = GtkButton("Wyczyść")
set_gtk_property!(clear_button, :name, "button2")
screen = Gtk.GAccessor.style_context(clear_button)
push!(screen, GtkStyleProvider(provider), 600)
grid[3:5,20] = clear_button

#Wyjście z programu
exit_button = GtkButton("Wyjdź")
set_gtk_property!(exit_button , :name, "button2")
screen = Gtk.GAccessor.style_context(exit_button)
push!(screen, GtkStyleProvider(provider), 600)
grid[6:8,20] = exit_button


#####
#Pole z domyślnym, pustym wykresem
Func.draw_default_plot()
plot_image = GtkImage(path*"\\Plots\\Default_plot.png")
grid[9,1:10] = plot_image


######
#Pole z domyślną, pustą tabelką
Func.generate_default_table()
table_image = GtkImage(path*"\\Plots\\Default_table.png")
grid[9,11:20] = table_image



######
#Obsługa przycisków kalkulatorowych
GAccessor.text(formula_input,"")
text = ""
is_equal = 0

function button_clicked_callback(widget)
    if widget == b1
        global text = text * "x"
        GAccessor.text(formula_input, text)

    elseif widget == b2

        global text = text * "^"
        GAccessor.text(formula_input, text)

    elseif widget == b3
        global text = text * "sqrt"
        GAccessor.text(formula_input, text)

    elseif widget == b4

        global text = text * "ln"
        GAccessor.text(formula_input, text)

    elseif widget == b5

        global text = text * "7"
        GAccessor.text(formula_input, text)

    elseif widget == b6
        global text = text * "8"
        GAccessor.text(formula_input, text)

    elseif widget == b7
        global text = text * "9"
        GAccessor.text(formula_input, text)

    elseif widget == b8
        global text = text * "/"
        GAccessor.text(formula_input, text)

    elseif widget == b9
        global text = text * "("
        GAccessor.text(formula_input, text)

    elseif widget == b10
        global text = text * ")"
        GAccessor.text(formula_input, text)

    elseif widget == b11
        global text = text * "pi"
        GAccessor.text(formula_input, text)

    elseif widget == b12
        global text = text * "exp"
        GAccessor.text(formula_input, text)

    elseif widget == b13
        global text = text * "4"
        GAccessor.text(formula_input, text)

    elseif widget == b14
        global text = text * "5"
        GAccessor.text(formula_input, text)

    elseif widget == b15
        global text = text * "6"
        GAccessor.text(formula_input, text)

    elseif widget == b16
        global text = text * "*"
        GAccessor.text(formula_input, text)

    elseif widget == b17
        global text = text * "sin"
        GAccessor.text(formula_input, text)

    elseif widget == b18
        global text = text * "cos"
        GAccessor.text(formula_input, text)

    elseif widget == b19
        global text = text * "tan"
        GAccessor.text(formula_input, text)

    elseif widget == b20
        global text = text * "cot"
        GAccessor.text(formula_input, text)

    elseif widget == b21
        global text = text * "1"
        GAccessor.text(formula_input, text)


    elseif widget == b22
        global text = text * "2"
        GAccessor.text(formula_input, text)

    elseif widget == b23
        global text = text * "3"
        GAccessor.text(formula_input, text)

    elseif widget == b24
        global text = text * "-"
        GAccessor.text(formula_input, text)

    elseif widget == b25
        global text = text * "asin"
        GAccessor.text(formula_input, text)

    elseif widget == b26

        global text = text * "acos"
        GAccessor.text(formula_input, text)

    elseif widget == b27
        global text = text * "atan"
        GAccessor.text(formula_input, text)

    elseif widget == b28
        global text = text * "acot"
        GAccessor.text(formula_input, text)

    elseif widget == b29
        global text = text * "0"
        GAccessor.text(formula_input, text)

    elseif widget == b30
        global text = text * "."
        GAccessor.text(formula_input, text)

    elseif widget == b31
        global text = text * ","
        GAccessor.text(formula_input, text)

    elseif widget == b32
        global text = text * "+"
        GAccessor.text(formula_input, text)

    end
end



id1 = signal_connect(button_clicked_callback, b1, "clicked")
id2 = signal_connect(button_clicked_callback, b2, "clicked")
id3 = signal_connect(button_clicked_callback, b3, "clicked")
id4 = signal_connect(button_clicked_callback, b4, "clicked")
id5 = signal_connect(button_clicked_callback, b5, "clicked")
id6 = signal_connect(button_clicked_callback, b6, "clicked")
id7 = signal_connect(button_clicked_callback, b7, "clicked")
id8 = signal_connect(button_clicked_callback, b8, "clicked")
id9 = signal_connect(button_clicked_callback, b9, "clicked")
id10 = signal_connect(button_clicked_callback, b10, "clicked")
id11 = signal_connect(button_clicked_callback, b11, "clicked")
id12 = signal_connect(button_clicked_callback, b12, "clicked")
id13 = signal_connect(button_clicked_callback, b13, "clicked")
id14 = signal_connect(button_clicked_callback, b14, "clicked")
id15 = signal_connect(button_clicked_callback, b15, "clicked")
id16 = signal_connect(button_clicked_callback, b16, "clicked")
id17 = signal_connect(button_clicked_callback, b17, "clicked")
id18 = signal_connect(button_clicked_callback, b18, "clicked")
id19 = signal_connect(button_clicked_callback, b19, "clicked")
id20 = signal_connect(button_clicked_callback, b20, "clicked")
id21 = signal_connect(button_clicked_callback, b21, "clicked")
id22 = signal_connect(button_clicked_callback, b22, "clicked")
id23 = signal_connect(button_clicked_callback, b23, "clicked")
id24 = signal_connect(button_clicked_callback, b24, "clicked")
id25 = signal_connect(button_clicked_callback, b25, "clicked")
id26 = signal_connect(button_clicked_callback, b26, "clicked")
id27 = signal_connect(button_clicked_callback, b27, "clicked")
id28 = signal_connect(button_clicked_callback, b28, "clicked")
id29 = signal_connect(button_clicked_callback, b29, "clicked")
id30 = signal_connect(button_clicked_callback, b30, "clicked")
id31 = signal_connect(button_clicked_callback, b31, "clicked")
id32 = signal_connect(button_clicked_callback, b32, "clicked")


#####
#Dodanie funkcjonalności do głównego przycisku, uruchamiającego program
id_count_button = signal_connect(count_button, "button-press-event") do widget,event
    try
        GAccessor.text(first_derivative_output, Func.first_derivative(text))
        GAccessor.text(second_derivative_output, Func.second_derivative(text))
        GAccessor.text(maximum_value_output, Func.max_function_value(text, get_gtk_property(range_for_count_input, :text, String)))
        GAccessor.text(minimum_value_output, Func.min_function_value(text, get_gtk_property(range_for_count_input, :text, String)))
        Func.draw_plot(text, get_gtk_property(range_for_plot_input, :text, String))
        plot = path*"\\Plots\\Plot.png"
        set_gtk_property!(plot_image, :file, plot)
        Func.generate_table(text, get_gtk_property(range_for_count_input, :text, String))
        table = path*"\\Plots\\Table.png"
        set_gtk_property!(table_image, :file, table)
    catch 
        info_dialog("Sprawdź poprawność przedziałów.")
    end
end

####
#Obsługa przycisku do czyszczenia
id_clear_button = signal_connect(clear_button, "button-press-event") do widget,event
    GAccessor.text(first_derivative_output,"")
    GAccessor.text(second_derivative_output, "")
    GAccessor.text(maximum_value_output,"")
    GAccessor.text(minimum_value_output,"")
    global text = ""
    GAccessor.text(formula_input,text)
    default_plot = path*"\\Plots\\Default_plot.png"
    set_gtk_property!(plot_image, :file, default_plot)
    default_table = path*"\\Plots\\Default_table.png"
    set_gtk_property!(table_image, :file, default_table)
end

####
#obsługa przycisku do wyjścia
signal_connect(exit_button, :clicked) do widget
    ask_dialog("Czy na pewno chcesz wyjść?", "Nie", "Tak") && Gtk.destroy(win)
end


#####
#uruchomienie
push!(win, grid)
showall(win)
