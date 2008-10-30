// ECB/SIS Public License, version 1.0, document reference SIS/2001/116
//
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
package org.sdmx.stores.xml.v2.structure
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import org.sdmx.event.SDMXDataEvent;
	import org.sdmx.model.v2.structure.code.CodeLists;
	import org.sdmx.model.v2.structure.code.CodeList;
	import org.sdmx.model.v2.structure.concept.Concepts;
	import org.sdmx.model.v2.structure.concept.Concept;
	import org.sdmx.model.v2.structure.keyfamily.KeyFamilies;
	import org.sdmx.model.v2.structure.keyfamily.KeyFamily;

	/**
	 * @private
	 */
	public class StructureReaderTest extends TestCase
	{
		private var _testXML:XML = 
<Structure 
	xmlns="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/message" 
	xmlns:message="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/message" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/message SDMXMessage.xsd http://www.SDMX.org/resources/SDMXML/schemas/v2_0/structure SDMXStructure.xsd">
	<Header>
		<ID>IREF000506</ID>
		<Test>false</Test>
		<Name xml:lang="en">ECB structural definitions</Name>
		<Prepared>2006-10-25T14:26:00</Prepared>
		<Sender id="4F0"/>
	</Header>
	<message:CodeLists xmlns="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/structure">
		<CodeList agencyID="ECB" id="CL_COLLECTION">
			<Name xml:lang="en">Collection indicator code list</Name>
			<Code value="A">
				<Description xml:lang="EN">Average of observations through period</Description>
			</Code>
			<Code value="B">
				<Description xml:lang="en">Beginning of period</Description>
			</Code>
			<Code value="E">
				<Description xml:lang="en">End of period</Description>
			</Code>
			<Code value="H">
				<Description xml:lang="en">Highest in period</Description>
			</Code>
			<Code value="L">
				<Description xml:lang="en">Lowest in period</Description>
			</Code>
			<Code value="M">
				<Description xml:lang="en">Middle of period</Description>
			</Code>
			<Code value="S">
				<Description xml:lang="en">Summed through period</Description>
			</Code>
			<Code value="U">
				<Description xml:lang="en">Unknown</Description>
			</Code>
			<Code value="V">
				<Description xml:lang="en">Other</Description>
			</Code>
			<Code value="Y">
				<Description xml:lang="en">Annualised summed</Description>
			</Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_CURRENCY">
			<Name xml:lang="en">Currency code list</Name>
			<Code value="ALL">
				<Description xml:lang="en">Albanian lek</Description>
			</Code>
			<Code value="ARS">
				<Description xml:lang="en">Argentine peso</Description>
			</Code>
			<Code value="ATS">
				<Description xml:lang="en">Austrian schilling</Description>
			</Code>
			<Code value="AUD">
				<Description xml:lang="en">Australian dollar</Description>
			</Code>
			<Code value="BAM">
				<Description xml:lang="en">Bosnia-Hezergovinian convertible mark</Description>
			</Code>
			<Code value="BEF">
				<Description xml:lang="en">Belgian franc</Description>
			</Code>
			<Code value="BEL">
				<Description xml:lang="en">Belgian franc (financial)</Description>
			</Code>
			<Code value="BGN">
				<Description xml:lang="en">Bulgarian lev</Description>
			</Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_DECIMALS">
			<Name xml:lang="en">Decimals codelist</Name>
			<Code value="0">
				<Description xml:lang="en">Zero</Description>
			</Code>
			<Code value="1">
				<Description xml:lang="en">One</Description>
			</Code>
			<Code value="2">
				<Description xml:lang="en">Two</Description>
			</Code>
			<Code value="3">
				<Description xml:lang="en">Three</Description>
			</Code>
			<Code value="4">
				<Description xml:lang="en">Four</Description>
			</Code>
			<Code value="5">
				<Description xml:lang="en">Five</Description>
			</Code>
			<Code value="6">
				<Description xml:lang="en">Six</Description>
			</Code>
			<Code value="7">
				<Description xml:lang="en">Seven</Description>
			</Code>
			<Code value="8">
				<Description xml:lang="en">Eight</Description>
			</Code>
			<Code value="9">
				<Description xml:lang="en">Nine</Description>
			</Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_EXR_SUFFIX">
			<Name xml:lang="en">Exch. rate series variation code list</Name>
			<Code value="A">
				<Description xml:lang="en">Average or standardised measure for given frequency</Description>
			</Code>
			<Code value="E">
				<Description xml:lang="en">End-of-period</Description>
			</Code>
			<Code value="P">
				<Description>Growth rate to previous period</Description>
            </Code>
            <Code value="R">
                <Description>Annual rate of change</Description>
            </Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_EXR_TYPE">
			<Name xml:lang="en">Exchange rate type code list</Name>
			<Code value="BRC0">
				<Description xml:lang="en">Real bilateral exchange rate, CPI deflated</Description>
			</Code>
			<Code value="CR00">
				<Description xml:lang="en">Central rate</Description>
			</Code>
			<Code value="EN00">
				<Description xml:lang="en">Nominal effective exch. rate</Description>
			</Code>
			<Code value="ERC0">
				<Description xml:lang="en">Real effective exch. rate CPI deflated</Description>
			</Code>
			<Code value="ERC1">
				<Description xml:lang="en">Real effective exch. rate retail prices deflated</Description>
			</Code>
			<Code value="ERD0">
				<Description xml:lang="en">Real effective exch. rate GDP deflators deflated</Description>
			</Code>
			<Code value="ERM0">
				<Description xml:lang="en">Real effective exch. rate import unit values deflated</Description>
			</Code>
			<Code value="ERP0">
				<Description xml:lang="en">Real effective exch. rate producer prices deflated</Description>
			</Code>
			<Code value="ERU0">
				<Description xml:lang="en">Real effective exch. rate ULC manufacturing deflated</Description>
			</Code>
			<Code value="ERU1">
				<Description xml:lang="en">Real effective exch. rate ULC total economy deflated</Description>
			</Code>
			<Code value="ERW0">
				<Description xml:lang="en">Real effective exch. rate wholesale prices deflated</Description>
			</Code>
			<Code value="ERX0">
				<Description xml:lang="en">Real effective exch. rate export unit values deflated</Description>
			</Code>
			<Code value="SP00">
				<Description xml:lang="en">Spot</Description>
			</Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_FREQ">
			<Name xml:lang="en">Frequency code list</Name>
			<Code value="A">
				<Description xml:lang="en">Annual</Description>
			</Code>
			<Code value="B">
				<Description xml:lang="en">Business</Description>
			</Code>
			<Code value="D">
				<Description xml:lang="en">Daily</Description>
			</Code>
			<Code value="E">
				<Description xml:lang="en">Event (not supported)</Description>
			</Code>
			<Code value="H">
				<Description xml:lang="en">Half-yearly</Description>
			</Code>
			<Code value="M">
				<Description xml:lang="en">Monthly</Description>
			</Code>
			<Code value="Q">
				<Description xml:lang="en">Quarterly</Description>
			</Code>
			<Code value="W">
				<Description xml:lang="en">Weekly</Description>
			</Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_OBS_CONF">
			<Name xml:lang="en">Observation confidentiality code list</Name>
			<Code value="C">
				<Description xml:lang="en">Confidential statistical information</Description>
			</Code>
			<Code value="D">
				<Description xml:lang="en">Secondary confidentiality set by the sender, not for publication</Description>
			</Code>
			<Code value="F">
				<Description xml:lang="en">Free (free for publication)</Description>
			</Code>
			<Code value="N">
				<Description xml:lang="en">Not for publication, restricted for internal use only</Description>
			</Code>
			<Code value="R">
				<Description xml:lang="en">Discontinued from 13 October 2006</Description>
			</Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_OBS_STATUS">
			<Name xml:lang="en">Observation status code list</Name>
			<Code value="A">
				<Description xml:lang="en">Normal value</Description>
			</Code>
			<Code value="B">
				<Description xml:lang="en">Break</Description>
			</Code>
			<Code value="E">
				<Description xml:lang="en">Estimated value</Description>
			</Code>
			<Code value="F">
				<Description xml:lang="en">Forecast value</Description>
			</Code>
			<Code value="H">
				<Description xml:lang="en">Missing value; holiday or weekend</Description>
			</Code>
			<Code value="L">
				<Description xml:lang="en">Missing value; data exist but were not collected</Description>
			</Code>
			<Code value="M">
				<Description xml:lang="en">Missing value; data cannot exist</Description>
			</Code>
			<Code value="P">
				<Description xml:lang="en">Provisional value</Description>
			</Code>
			<Code value="Q">
				<Description xml:lang="en">Missing value; suppressed</Description>
			</Code>
			<Code value="S">
				<Description xml:lang="en">Strike</Description>
			</Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_UNIT">
			<Name xml:lang="en">Unit code list</Name>
			<Code value="ARS">
				<Description xml:lang="en">Argentine peso</Description>
			</Code>
			<Code value="ATS">
				<Description xml:lang="en">Austrian schilling</Description>
			</Code>
			<Code value="AUD">
				<Description xml:lang="en">Australian dollar</Description>
			</Code>
			<Code value="BEF">
				<Description xml:lang="en">Belgian franc</Description>
			</Code>
			<Code value="BEL">
				<Description xml:lang="en">Belgian franc (financial)</Description>
			</Code>
			<Code value="BGN">
				<Description xml:lang="en">Bulgarian lev</Description>
			</Code>
			<Code value="BRL">
				<Description xml:lang="en">Brazilian real</Description>
			</Code>
			<Code value="CAD">
				<Description xml:lang="en">Canadian dollar</Description>
			</Code>
			<Code value="CHF">
				<Description xml:lang="en">Swiss franc</Description>
			</Code>
			<Code value="ZAR">
				<Description xml:lang="en">South African rand</Description>
			</Code>
		</CodeList>
		<CodeList agencyID="ECB" id="CL_UNIT_MULT">
			<Name xml:lang="en">Unit multiplier code list</Name>
			<Code value="0">
				<Description xml:lang="en">Units</Description>
			</Code>
			<Code value="1">
				<Description xml:lang="en">Tens</Description>
			</Code>
			<Code value="2">
				<Description xml:lang="en">Hundreds</Description>
			</Code>
			<Code value="3">
				<Description xml:lang="en">Thousands</Description>
			</Code>
			<Code value="4">
				<Description xml:lang="en">Tens of thousands</Description>
			</Code>
			<Code value="6">
				<Description xml:lang="en">Millions</Description>
			</Code>
			<Code value="9">
				<Description xml:lang="en">Billions</Description>
			</Code>
		</CodeList>
	</message:CodeLists>
	<message:Concepts xmlns="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/structure">
		<Concept agencyID="ECB" id="COLLECTION">
			<Name xml:lang="en">Collection indicator</Name>
		</Concept>
		<Concept agencyID="ECB" id="CURRENCY">
			<Name xml:lang="en">Currency</Name>
		</Concept>
		<Concept agencyID="ECB" id="CURRENCY_DENOM">
			<Name xml:lang="en">Currency denominator</Name>
		</Concept>
		<Concept agencyID="ECB" id="DECIMALS">
			<Name xml:lang="en">Decimals</Name>
		</Concept>
		<Concept agencyID="ECB" id="EXR_SUFFIX">
			<Name xml:lang="en">Series variation - EXR context</Name>
		</Concept>
		<Concept agencyID="ECB" id="EXR_TYPE">
			<Name xml:lang="en">Exchange rate type</Name>
		</Concept>
		<Concept agencyID="ECB" id="FREQ">
			<Name xml:lang="en">Frequency</Name>
		</Concept>
		<Concept agencyID="ECB" id="OBS_CONF">
			<Name xml:lang="en">Observation confidentiality</Name>
		</Concept>
		<Concept agencyID="ECB" id="OBS_STATUS">
			<Name xml:lang="en">Observation status</Name>
		</Concept>
		<Concept agencyID="ECB" id="OBS_VALUE">
			<Name xml:lang="en">Observation value</Name>
		</Concept>
		<Concept agencyID="ECB" id="TIME_FORMAT">
			<Name xml:lang="en">Time format code</Name>
		</Concept>
		<Concept agencyID="ECB" id="TIME_PERIOD">
			<Name xml:lang="en">Time period or range</Name>
		</Concept>
		<Concept agencyID="ECB" id="TITLE_COMPL">
			<Name xml:lang="en">Title complement</Name>
		</Concept>
		<Concept agencyID="ECB" id="UNIT">
			<Name xml:lang="en">Unit</Name>
		</Concept>
		<Concept agencyID="ECB" id="UNIT_MULT">
			<Name xml:lang="en">Unit multiplier</Name>
		</Concept>
	</message:Concepts>
	<message:KeyFamilies xmlns="http://www.SDMX.org/resources/SDMXML/schemas/v2_0/structure">
		<KeyFamily agencyID="ECB" id="ECB_EXR1" uri="http://stats.ecb.europa.eu/stats/dtf_test/ecb_exr1.xml">
			<Name xml:lang="en">Exchange Rates</Name>
			<Components>
				<Dimension conceptRef="FREQ" codelist="CL_FREQ" isFrequencyDimension="true"/>
				<Dimension conceptRef="CURRENCY" codelist="CL_CURRENCY"/>
				<Dimension conceptRef="CURRENCY_DENOM" codelist="CL_CURRENCY"/>
				<Dimension conceptRef="EXR_TYPE" codelist="CL_EXR_TYPE"/>
				<Dimension conceptRef="EXR_SUFFIX" codelist="CL_EXR_SUFFIX"/>
				<TimeDimension conceptRef="TIME_PERIOD"/>
				<Group id="Group">
					<DimensionRef>CURRENCY</DimensionRef>
					<DimensionRef>CURRENCY_DENOM</DimensionRef>
					<DimensionRef>EXR_TYPE</DimensionRef>
					<DimensionRef>EXR_SUFFIX</DimensionRef>
				</Group>
				<PrimaryMeasure conceptRef="OBS_VALUE"/>
				<Attribute conceptRef="TIME_FORMAT" attachmentLevel="Series" assignmentStatus="Mandatory" isTimeFormat="true">
					<TextFormat textType="String" maxLength="3"/>
				</Attribute>
				<Attribute conceptRef="OBS_STATUS" attachmentLevel="Observation" codelist="CL_OBS_STATUS" assignmentStatus="Mandatory"/>
				<Attribute conceptRef="OBS_CONF" attachmentLevel="Observation" codelist="CL_OBS_CONF" assignmentStatus="Conditional"/>
				<Attribute conceptRef="COLLECTION" attachmentLevel="Series" codelist="CL_COLLECTION" assignmentStatus="Mandatory"/>
				<Attribute conceptRef="DECIMALS" attachmentLevel="Group" codelist="CL_DECIMALS" assignmentStatus="Mandatory">
					<AttachmentGroup>Group</AttachmentGroup>
				</Attribute>
				<Attribute conceptRef="TITLE_COMPL" attachmentLevel="Group" assignmentStatus="Mandatory">
					<TextFormat textType="String" maxLength="1050"/>
					<AttachmentGroup>Group</AttachmentGroup>
				</Attribute>
				<Attribute conceptRef="UNIT" attachmentLevel="Group" codelist="CL_UNIT" assignmentStatus="Mandatory">
					<AttachmentGroup>Group</AttachmentGroup>
				</Attribute>
				<Attribute conceptRef="UNIT_MULT" attachmentLevel="Group" codelist="CL_UNIT_MULT" assignmentStatus="Mandatory">
					<AttachmentGroup>Group</AttachmentGroup>
				</Attribute>
			</Components>
		</KeyFamily>
	</message:KeyFamilies>
</Structure>
		
		public function StructureReaderTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite
		{
			return new TestSuite(StructureReaderTest);
		}
		
		public function testExtractCodeLists():void
		{
			var reader:StructureReader = new StructureReader();
			reader.dispatchKeyFamilies = true;
			reader.addEventListener(StructureReader.CODE_LISTS_EVENT, 
				addAsync(handleCodeLists, 3000));
			reader.read(_testXML);
		}
		
		public function testExtractConcepts():void
		{
			var reader:StructureReader = new StructureReader();
			reader.dispatchKeyFamilies = true;
			reader.addEventListener(StructureReader.CONCEPTS_EVENT, 
				addAsync(handleConcepts, 3000));
			reader.read(_testXML);
		}
		
		public function testExtractKeyFamily():void
		{
			var reader:StructureReader = new StructureReader();
			reader.dispatchKeyFamilies = true;
			reader.addEventListener(StructureReader.KEY_FAMILIES_EVENT,
				addAsync(handleKeyFamilies, 3000));
			reader.read(_testXML);
		}
		
		private function handleCodeLists(event:SDMXDataEvent):void
		{
			assertTrue("There should be some code lists in the event", 
				event.data is CodeLists);
			var codeLists:CodeLists = event.data as CodeLists;
			assertEquals("There must be 10 code lists", 10, codeLists.length);
			var codeList1:CodeList = codeLists.getItemAt(0) as CodeList;
			assertEquals("The 1st code list should be CL_COLLECTION", 
				"CL_COLLECTION", codeList1.id);
			assertEquals("There should be 10 codes in the code list", 10,
				codeList1.codes.length);
			var codeList2:CodeList = codeLists.getItemAt(9) as CodeList;	
			assertEquals("The 1st code list should be CL_UNIT_MULT", 
				"CL_UNIT_MULT", codeList2.id);
			assertEquals("There should be 7 codes in the code list", 7,
				codeList2.codes.length);
		}
		
		private function handleConcepts(event:SDMXDataEvent):void
		{
			var concepts:Concepts = event.data as Concepts;
			assertEquals("There must be 15 concepts", 15, concepts.length);
			var concept1:Concept = concepts.getItemAt(0) as Concept;
			assertEquals("The 1st concept should be 'COLLECTION'", 
				"COLLECTION", concept1.id);
			var concept2:Concept = concepts.getItemAt(14) as Concept;
			assertEquals("The last concept should be 'UNIT_MULT'", 
				"UNIT_MULT", concept2.id);			
		}
		
		private function handleKeyFamilies(event:SDMXDataEvent):void
		{
			var keyFamily:KeyFamily = (event.data as KeyFamilies).getItemAt(0) 
				as KeyFamily;
			assertEquals("Key family is ECB_EXR1", "ECB_EXR1", keyFamily.id);
			assertEquals("There should be 6 dimensions in the KF", 6, 
				keyFamily.keyDescriptor.length);
			assertEquals("There should be 1 measure", 1, 
				keyFamily.measureDescriptor.length);	
			assertEquals("There should be 1 group", 1, 
				keyFamily.groupDescriptors.length);
			assertEquals("There should be 8 attributes", 8, 
				keyFamily.attributeDescriptor.length);	
		}
	}
}