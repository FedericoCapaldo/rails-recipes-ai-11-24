class Recipe < ApplicationRecord

  def content
    if super.blank?
      set_content
    else
      super
    end
  end



  private

  def set_content
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "Give me a simple recipe for #{name} with the ingredients #{ingredients}. Give me only the text of the recipe, without any of your own answer like 'Here is a simple recipe'."}]
    })
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    update(content: new_content)

    return new_content
  end
end
