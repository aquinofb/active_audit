module TestActiveAudit
  extend ActiveAudit::Rules::Base

  attributes :nome, :idade
  required_attributes :nome
  # add_hook :before_save, :meu_metodo, if: :teste

  # when_the :name, change_to: "produtao", do: :ta_fazendo, if: :teste

  def meu_metodo
    puts "*"*100
    puts "*"*100
    puts "meu meu_metodo"
    puts "*"*100
    puts "*"*100
  end

  def teste
    true
  end

  def ta_fazendo
    puts "-="*100
    puts "-="*100
    puts "ta fazneod"
    puts "-="*100
    puts "-="*100
  end
end
