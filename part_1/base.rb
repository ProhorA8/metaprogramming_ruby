# базовый класс
class Base
  def initialize(resource)
    load_data_from resource
  end

  def load_data_from(resource)
    raw_data = File.read "./data/#{resource}.json"
    # первый подход
    # обходим хэш
    # Oj.load(raw_data).each do |method, value|
    #   # выполняем присваивание методу
    #   self.send "#{method}=", value
    # end

    Oj.load(raw_data).each do |method, value|
      # заполняем значения переменных образца класса
      # делаем проверку, если метода нет, то и переменную заводить не нужно
      self.instance_variable_set(:"@#{method}", value) if self.methods.include?(method.to_sym)
    end
  end

  class << self
    private

    # вызывается автоматически, когда данный класс был унаследован
    # задаём для подкласса набор методов на которые он должен отвечать
    # приннимает указатель на подкласс
    def inherited(subclass)
      # имя подкласса
      # puts subclass
      # его методы
      attrs = attributes_for subclass
      subclass.class_exec do
        # блок кода который хотим выполнить в контексте этого класса
        # создаём методы ридары которые перечислены в файле methods.json
        attr_reader(*attrs)
      end
      # пишем для того что бы цепочка выше по иерархии работала, не прерывая цепочку наследования
      # класс Base будет наследовать доп. классам у которых в теории может быть свой метод inherited
      super
    end

    # получем массив всех методов на которые класс отвечает
    def attributes_for(klass)
      # кэшируем, считываем все методы, парсим
      @methods ||= Oj.load File.read('./methods.json')
      # находим только те методы которые принадлежат классу, ключ – приводим название класса к нижнему регистру
      @methods[klass.name.downcase]
    end
  end
end
