import { runPage } from '../common/tool';
import layout from './layout';
import guest from './guest';
import partner from './partner';
import event from './event';

const admin = () => {
  layout();
  runPage('admin-guests-index', guest);
  runPage('admin-partners-index', partner);
  runPage(['admin-events-edit', 'admin-events-index', 'admin-events-new', 'admin-events-guests-index'], event);
};

export default admin;
