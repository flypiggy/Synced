import { runPage } from '../common/tool';
import layout from './layout';
import guest from './guest';
import partner from './partner';

const admin = () => {
  layout();
  runPage('admin-guests-index', guest);
  runPage('admin-partners-index', partner);
};

export default admin;
