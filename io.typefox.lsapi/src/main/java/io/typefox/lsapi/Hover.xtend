/*******************************************************************************
 * Copyright (c) 2016 TypeFox GmbH (http://www.typefox.io) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package io.typefox.lsapi

import io.typefox.lsapi.annotations.LanguageServerAPI
import java.util.List
import javax.annotation.Nullable

/**
 * The result of a hover request.
 */
@LanguageServerAPI
interface Hover {
	
	/**
	 * The hover's content
	 */
	def List<? extends MarkedString> getContents()
	
	/**
	 * An optional range
	 */
	@Nullable
	def Range getRange()
	
}