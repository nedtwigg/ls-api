/*******************************************************************************
 * Copyright (c) 2016 TypeFox GmbH (http://www.typefox.io) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package io.typefox.lsapi.test

import io.typefox.lsapi.CompletionItemKind
import io.typefox.lsapi.builders.CompletionListBuilder
import io.typefox.lsapi.builders.DocumentRangeFormattingParamsBuilder
import io.typefox.lsapi.builders.IBuilder
import io.typefox.lsapi.builders.WorkspaceEditBuilder
import org.junit.Assert
import org.junit.Test

import static extension io.typefox.lsapi.test.LineEndings.*

class BuilderTest {
	
	private def void assertBuilds(IBuilder<?> builder, String expected) {
		Assert.assertEquals(expected.trim, builder.build.toString.toSystemLineEndings)
	}
	
	@Test
	def void testCompletionList() {
		new CompletionListBuilder[
			item[
				label('foo')
				textEdit[
					range[
						start[
							line(3)
							character(12)
						]
						end[
							line(4)
							character(8)
						]
					]
					newText('qwertz')
				]
			]
			item[
				label('bar')
				kind(CompletionItemKind.Class)
				detail('Very foo and also very bar.')
			]
		].assertBuilds('''
			CompletionListImpl [
			  incomplete = false
			  items = ArrayList (
			    CompletionItemImpl [
			      label = "foo"
			      kind = null
			      detail = null
			      documentation = null
			      sortText = null
			      filterText = null
			      insertText = null
			      textEdit = TextEditImpl [
			        range = RangeImpl [
			          start = PositionImpl [
			            line = 3
			            character = 12
			          ]
			          end = PositionImpl [
			            line = 4
			            character = 8
			          ]
			        ]
			        newText = "qwertz"
			      ]
			      data = null
			    ],
			    CompletionItemImpl [
			      label = "bar"
			      kind = Class
			      detail = "Very foo and also very bar."
			      documentation = null
			      sortText = null
			      filterText = null
			      insertText = null
			      textEdit = null
			      data = null
			    ]
			  )
			]
		''')
	}
	
	@Test
	def void testDocumentRangeFormattingParams() {
		new DocumentRangeFormattingParamsBuilder[
			range[
				start[
					line(3)
					character(12)
				]
				end[
					line(4)
					character(8)
				]
			]
			textDocument[
				uri('http://foo.example.com/')
			]
			options[
				tabSize(4)
				insertSpaces(true)
				property('foo', '123')
				property('bar', '_/^\\_')
			]
		].assertBuilds('''
			DocumentRangeFormattingParamsImpl [
			  range = RangeImpl [
			    start = PositionImpl [
			      line = 3
			      character = 12
			    ]
			    end = PositionImpl [
			      line = 4
			      character = 8
			    ]
			  ]
			  textDocument = TextDocumentIdentifierImpl [
			    uri = "http://foo.example.com/"
			  ]
			  options = FormattingOptionsImpl [
			    tabSize = 4
			    insertSpaces = true
			    properties = {foo=123, bar=_/^\_}
			  ]
			]
		''')
	}
	
	@Test
	def void tetsWorkspaceEdit() {
		new WorkspaceEditBuilder[
			change('foo') [
				range[
					start[
						line(3)
						character(12)
					]
					end[
						line(4)
						character(8)
					]
				]
				newText('superfoo')
			]
			change('bar') [
				range[
					start[
						line(7)
						character(1)
					]
					end[
						line(7)
						character(2)
					]
				]
				newText('superBar')
			]
			change('foo') [
				newText('another change')
			]
			change('foo') [
				newText('yet another change')
			]
		].assertBuilds('''
			WorkspaceEditImpl [
			  changes = {foo=[TextEditImpl [
			    range = RangeImpl [
			      start = PositionImpl [
			        line = 3
			        character = 12
			      ]
			      end = PositionImpl [
			        line = 4
			        character = 8
			      ]
			    ]
			    newText = "superfoo"
			  ], TextEditImpl [
			    range = null
			    newText = "another change"
			  ], TextEditImpl [
			    range = null
			    newText = "yet another change"
			  ]], bar=[TextEditImpl [
			    range = RangeImpl [
			      start = PositionImpl [
			        line = 7
			        character = 1
			      ]
			      end = PositionImpl [
			        line = 7
			        character = 2
			      ]
			    ]
			    newText = "superBar"
			  ]]}
			]
		''')
	}
	
}