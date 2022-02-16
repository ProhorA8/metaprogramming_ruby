require 'oj'

class Base
  class << self
    private

    # вызывается автоматически, когда данный класс был унаследован
    # задаём для подкласса набор методов на которые он должен отвечать
    def inherited(subclass)
      # имя класса
      puts subclass
      # его методы
      puts attributes_for subclass
    end

    # получем массив всех методов на которые класс отвечает
    def attributes_for(klass)
      # кэшируем
      @methods ||= Oj.load File.read('./methods.json')
      # обращаемся к объекту с методами и находим методы, ключ – приводим название класса к нижнему регистру
      @methods[klass.name.downcase]
    end
  end
end
