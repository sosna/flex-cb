// Copyright (C) 2008 European Central Bank. All rights reserved.
//
// Redistribution and use in source and binary forms,
// with or without modification, are permitted
// provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
// Neither the name of the European Central Bank
// nor the names of its contributors may be used to endorse or promote products
// derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
// THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
package org.sdmx.stores.xml.v2.structure.collection
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import org.sdmx.model.v2.structure.code.Code;
	import org.sdmx.model.v2.base.Annotation;

	/**
	 * @private
	 */
	public class CodeExtractorTest extends TestCase {
		
		public function CodeExtractorTest(methodName:String=null) {
			super(methodName);
		}
		
		public static function suite():TestSuite {
			return new TestSuite(CodeExtractorTest);
		}
		
		public function testCodeExtractionFull():void {
			var xml:XML = 
				<Code value="A" urn="urn:sdmx:org.sdmx.infomodel.codelist.CodeList=ECB:CL_COLLECTION.Code=A" xmlns="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/structure" xmlns:common="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/common">
					<Description>Average of observations through period</Description>
					<Description xml:lang="fr">Average of observations through period (in French)</Description>
					<Annotations>
						<common:Annotation xmlns="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/common">
							<AnnotationTitle>Test Annotation</AnnotationTitle>
							<AnnotationType>Text</AnnotationType>
							<AnnotationURL>http://www.ecb.int/</AnnotationURL>
							<AnnotationText xml:lang="en">Test EN</AnnotationText>
							<AnnotationText xml:lang="fr">Test FR</AnnotationText>
						</common:Annotation>
					</Annotations>
				</Code>	
			var extractor:CodeExtractor = new CodeExtractor();
			var item:Code = extractor.extract(xml) as Code;
			assertNotNull("The item cannot be null", item);
			assertEquals("The IDs should be equal", "A", item.id);
			assertEquals("The URNs should be equal", "urn:sdmx:org.sdmx.infomodel.codelist.CodeList=ECB:CL_COLLECTION.Code=A", item.urn);
			assertNotNull("The description cannot be null", item.description);
			assertEquals("There should be 2 localised strings in the description collection", 2, item.description.localisedStrings.length);
			assertEquals("The descriptions for EN should be equal", "Average of observations through period", item.description.localisedStrings.getDescriptionByLocale("en"));
			assertEquals("The descriptions for FR should be equal", "Average of observations through period (in French)", item.description.localisedStrings.getDescriptionByLocale("fr"));			
			/*assertEquals("There should be 1 annotation", 1, item.annotations.length);
			var annotation:Annotation = item.annotations.getItemAt(0) as Annotation;
			assertEquals("The types should be equal", "Text", annotation.type);
			assertEquals("The titles should be equal", "Test Annotation", annotation.title);
			assertEquals("The URLs should be equal", "http://www.ecb.int/", annotation.url);
			assertEquals("There should be 2 localised strings in this annotation", 2, annotation.text.localisedStrings.length);
			assertEquals("The EN text should be equal", "Test EN", annotation.text.localisedStrings.getDescriptionByLocale("en"));
			assertEquals("The FR text should be equal", "Test FR", annotation.text.localisedStrings.getDescriptionByLocale("fr"));*/	
		}
		
		public function testEmptyDescription():void {
			var xml:XML = 
				<Code value="A" urn="urn:sdmx:org.sdmx.infomodel.codelist.CodeList=ECB:CL_COLLECTION.Code=A" xmlns="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/structure" xmlns:common="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/common">
					<Annotations>
						<common:Annotation xmlns="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/common">
							<AnnotationTitle>Test Annotation</AnnotationTitle>
							<AnnotationType>Text</AnnotationType>
							<AnnotationURL>http://www.ecb.int/</AnnotationURL>
							<AnnotationText xml:lang="en">Test EN</AnnotationText>
							<AnnotationText xml:lang="fr">Test FR</AnnotationText>
						</common:Annotation>
					</Annotations>
				</Code>	
			var extractor:CodeExtractor = new CodeExtractor();
			try {
				extractor.extract(xml);
				fail("Description is mandatory!");
			} catch (error:SyntaxError) {}	
		}
	}
}