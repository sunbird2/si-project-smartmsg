package com.m.excel;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.util.ApachePOI36;

public class ExcelPaser extends ApachePOI36 {

	public List<HashMap<String, String>> getExcelData(String path,
			String fileName) throws Exception {

		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> hm = null;

		String[][] rslt = super.Read(path + fileName);
		int maxCol = super.getmaxCountColumn();

		int rowCount = rslt.length;
		for (int i = 0; i < rowCount; i++) {

			hm = new HashMap<String, String>();
			hm.put("/", Integer.toString(i + 1));
			for (int j = 0; j < maxCol; j++) {

				hm.put(this.getColumn(j + 1),
						(j >= rslt[i].length) ? "" : rslt[i][j]);
			}

			al.add(hm);
		}

		return al;
	}

	private String getColumn(int index) {

		int base = (int) (char) 'A';
		int div = (int) (char) 'Z' - base + 1;
		StringBuffer buf = new StringBuffer();

		if ((index - 1) >= 0) {
			if (index - 1 >= div) {

				buf.append(new Character((char) (base
						+ (int) ((index - 1) / div) - 1)).toString());
				buf.append(new Character(
						(char) (base + (int) ((index - 1) % div))).toString());
			} else {
				buf.append(new Character((char) (base + index - 1)).toString());
			}
		}

		return buf.toString();
	}

}
