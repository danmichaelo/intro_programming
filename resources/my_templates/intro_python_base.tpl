{%- extends 'basic.tpl' -%}
{% from 'mathjax.tpl' import mathjax %}


{%- block header -%}
  {% include "resources/my_templates/intro_python_header.html" %}
{%- endblock header -%}


{% block in_prompt %}
  {# Blank; we're removing the input prompt. #}
{% endblock %}

{# Need a unique identifier for each output cell, to toggle individual cells' visbility.
    Make an empty list, and add to the list each time an output block is rendered.
    Use the length of the list as the unique identifier.
    #}
{% set cell_count=[] %}

{% block output %} {# outputs works, but hidden by output #}
  <div class='text-right'>
    <button id='show_output_{{ cell_count|length }}' class='btn btn-success btn-xs show_output' target='{{ cell_count|length }}'>show output</button>
    <button id='hide_output_{{ cell_count|length }}' class='btn btn-success btn-xs hide_output' target='{{ cell_count|length }}'>hide output</button>
  </div>
  {{ super() }}
  {% set _ = cell_count.append(1) %}
{% endblock output %}

{# Will these blocks (output, stream_stdout) always match 1:1?
    If there's a stream_stdout block, it's inside an output block,
    so we should be able to use the cell_count, maybe -1 to match value before increment?
   Can't use indentation in this next block, because output uses <pre> tag, which will
    keep the whitespace from template indentation.
    #}
{% block stream_stdout %}
{% for line in super().split('\n') %}
{% if '<div class="output_subarea output_stream output_stdout output_text">' in line %}
<div id="output_stdout_{{ cell_count|length }}" class="output_subarea output_stream output_stdout output_text">
{%- else -%}
{{ line }}
{%- endif -%}
{% endfor %}
{% endblock stream_stdout %}


{% block body %}
  <body>
   {% include "resources/my_templates/navbar.html" %}
      <div class="container" id="notebook-container">
        <div class='text-right'>
          <button id='show_output_all' class='btn btn-success btn-xs show_output_all'>Show all output</button>
          <button id='hide_output_all' class='btn btn-success btn-xs hide_output_all'>Hide all output</button>
        </div>

        {{ super() }}

      </div>
  </body>
{%- endblock body %}

{% block footer %}
  {% include "resources/my_templates/include_jquery.html" %}
  </html>
{% endblock footer %}