require 'rails_helper'

describe Course do
  
  let(:course){ described_class.new }
  
  before do
    allow(DateTime).to receive(:now).and_return(DateTime.new(2001,2,13))
  end
  
  context '#validate_then_save' do
    it 'returns false if the name is empty' do
      result = course.validate_then_save(name: '', description: 'description', start: '2001-02-14', end: '2001-02-15')
      expect(result).to be_falsey
      expect(course.errors).to include('Course cannot be posted without a name')
    end
    it 'returns false if the start_date is empty' do
      result = course.validate_then_save(name: 'testname', description: 'description', start: '', end: '2001-02-15')
      expect(result).to be_falsey
      expect(course.errors).to include('Course needs a start date')
    end
    it 'returns false if the end_date is empty' do
      result = course.validate_then_save(name: 'testname', description: 'description', start: '2001-02-14', end: '')
      expect(result).to be_falsey
      expect(course.errors).to include('Course needs an end date')
    end
    it 'returns false if the start date is in the past' do
      result = course.validate_then_save(name: 'testname', description: 'description', start: '2001-02-11', end: '2001-02-15')
      expect(result).to be_falsey
      expect(course.errors).to include('Course must start in the future')
    end
    it 'returns false if the start date is after the end date' do
      result = course.validate_then_save(name: 'testname', description: 'description', start: '2001-02-15', end: '2001-02-14')
      expect(result).to be_falsey
      expect(course.errors).to include('Course must end after it starts!')
    end
    it 'saves the course if the params are valid and returns a truthy object' do
      result = course.validate_then_save(name: 'testname', description: 'description', start: '2001-02-14', end: '2001-02-15')
      expect(result).not_to be_falsey
      expect(Course.all.count).to eq 1
    end
    
  end
  
end