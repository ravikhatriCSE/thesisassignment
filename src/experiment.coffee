###

Adapted from Fred Callaway's experiment.coffee file

###
# coffeelint: disable=max_line_length, indentation

# Enforce a minimum window size
checkWindowSize = (width, height, display) ->
  console.log 'cws'
  win_width = $(window).width()
  maxHeight = $(window).height()
  if $(window).width() < width or $(window).height() < height
    display.hide()
    $('#window_error').show()
  else
    $('#window_error').hide()
    display.show()

$(window).resize -> checkWindowSize 800, 600, $('#jspsych-target')
$(window).resize()



loadJson = (file) ->
  result = $.ajax
    dataType: 'json'
    url: file
    async: false
  return result.responseJSON

$(window).on 'load', ->
  trials = loadJson "static/json/trials.json"
  initializeExperiment trials

initializeExperiment = (trials) ->
  console.log 'INITIALIZE EXPERIMENT'
  console.log trials

  #  ============================== #
  #  ========= EXPERIMENT ========= #
  #  ============================== #

  welcome =
    type: 'text'
    text: """
    <h1>Mouselab-MDP Demo</h1>

    This is an experiment to test understand human metacognitive learning.
    <p>
    Press <b>space</b> to continue.

    """


  i = 0
  main =
    type: 'mouselab-mdp'
    leftMessage: -> "Round: #{++i}/#{trials.length}"
    timeline: trials

  experiment_timeline = [
    # welcome
    main
  ]


  # ================================================ #
  # ========= START AND END THE EXPERIMENT ========= #
  # ================================================ #


  jsPsych.init
    display_element: $('#jspsych-target')
    timeline: experiment_timeline
    # show_progress_bar: true

    on_finish: ->
      jsPsych.data.displayData()

    on_data_update: (data) ->
      console.log 'data', data

