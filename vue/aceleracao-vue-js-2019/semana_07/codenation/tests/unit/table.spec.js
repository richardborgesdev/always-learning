import { shallowMount } from '@vue/test-utils'
import Table from '@/components/Table.vue'

describe('Table.vue', () => {
  it('renders columns when passed', () => {
    const columns = ["Coluna 1"];
    const wrapper = shallowMount(Table, {
      propsData: {
        columns,
      }
    });
    console.log(wrapper.html());

    expect(wrapper.find('thead > tr > th').text()).toBe('Coluna 1');
  });
  it('renders rows when passed', () => {
    const rows = [["Linha 1"]];
    const wrapper = shallowMount(Table, {
      propsData: {
        rows,
      }
    });
    console.log(wrapper.html());

    expect(wrapper.find('tbody > tr > td').text()).toBe('Linha 1');
  });
})
