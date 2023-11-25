import _ from 'lodash';

export default class AuditUtils {

  static auditUniqueCountById (typeName: string, items: Array<any>, itemsById: Record<string, any>, expectedCount: number): void {
    if (items.length !== _.size(itemsById)) {
      for (const [id, duplicateItems] of Object.entries(_.groupBy(items, 'id') as Record<string, Array<any>>)) {
        if (duplicateItems.length > 1) {
          console.log(` [ERROR] non-unique ${typeName} id: ${id}`);
        }
      }
      throw `found non-unique ${typeName} id's`;
    }

    if (items.length < expectedCount) {
      console.log(` [ERROR] found ${items.length} unique ${typeName}, expected at least ${expectedCount}`)
      throw `missing expected ${typeName} id's`;
    }
    else if (items.length > expectedCount) {
      console.log(` [WARN] found ${items.length} unique ${typeName}, expected ${expectedCount}; consider updating expected`)
    }
    else {
      console.log(` [OK] found ${items.length} unique ${typeName} (expected ${expectedCount})`);
    }
  }

  static auditIsValid (typeName: string, items: Array<any>): void {
    const validItems = [];
    const invalidItems = [];
    for (const item of items) {
      if (item.isValid()) {
        validItems.push(item);
      }
      else {
        invalidItems.push(item);
      }
    }

    if (validItems.length < items.length || invalidItems.length > 0) {
      for (const item of invalidItems) {
        console.log(` [ERROR] ${typeName} is not valid: ${item.id}`);
      }
      throw `found ${invalidItems.length} invalid ${typeName} records`;
    }
    else {
      console.log(` [OK] found ${validItems.length} valid ${typeName} records`);
    }
  }
}
