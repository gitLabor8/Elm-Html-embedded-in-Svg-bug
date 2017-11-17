module Main exposing (..)

{--

    Displays two html textarea's: one normal and one embedded in svgText
    The one embedded in svg will not display properly

--}

import Html exposing (..)
import Html.Attributes exposing (height, width)
import Html.Events exposing (on, onClick, onInput)
import Svg exposing (svg)
import Svg.Attributes exposing (viewBox)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = init, view = view, update = update }


type alias Model =
    { htmlText : String
    , svgText : String
    }


init : Model
init =
    { htmlText = "Type here"
    , svgText = "Type here"
    }


type Msg
    = ChangeHtmlText String
    | ChangeSvgText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeHtmlText newText ->
            { model | htmlText = newText }

        ChangeSvgText newText ->
            { model | svgText = newText }


view : Model -> Html Msg
view model =
    div []
        (List.intersperse
            (br [] [])
            [ text "Normal html textarea"
            , htmlTextarea model
            , text "Html textarea embedded in svg"
            , svgTextarea model
            , text "End of example"
            ]
        )


htmlTextarea : Model -> Html Msg
htmlTextarea model =
    textarea [ onInput ChangeHtmlText ] []


svgTextarea : Model -> Html Msg
svgTextarea model =
    let
        textspace =
            textarea [ onInput ChangeSvgText ] []

        ( w, h ) =
            ( 200, 200 )
    in
    svg
        [ width w
        , height h
        , viewBox <| "0 0 " ++ toString w ++ " " ++ toString h
        ]
        [ textspace ]
