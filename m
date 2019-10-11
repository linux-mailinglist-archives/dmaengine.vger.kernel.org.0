Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5DD3A07
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2019 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfJKHaX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Oct 2019 03:30:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57852 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHaX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Oct 2019 03:30:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9B7U6El078191;
        Fri, 11 Oct 2019 02:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570779006;
        bh=znP/gGaBX/Jb6dmBMtFvZoxZ7cFvHE83wvW8fbuudow=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=o7tSAAui6UC0pkVc4uInf8vM9gVTu+vb8QWiVmMYMpYylB6cISO5aPObEtEsl9Sll
         PbxMmd9NmQ+TrAzzefTRd3JJSBnewoW9WitjzSQ6rJcQdtDJuOHGQWeaEgvi9wYA3D
         oZx05cWwgF6vdaSPTuJa0HOyIQrZ2UGgGshIiqEQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9B7U6Q3112318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Oct 2019 02:30:06 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 11
 Oct 2019 02:30:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 11 Oct 2019 02:30:01 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9B7U1qI053518;
        Fri, 11 Oct 2019 02:30:02 -0500
Subject: Re: [PATCH v3 07/14] dt-bindings: dma: ti: Add document for K3 UDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-8-peter.ujfalusi@ti.com> <20191010175232.GA24556@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ef07299b-eb43-d582-adb8-46f46681f9a5@ti.com>
Date:   Fri, 11 Oct 2019 10:30:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010175232.GA24556@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rob,

On 10/10/2019 20.52, Rob Herring wrote:
> On Tue, Oct 01, 2019 at 09:16:57AM +0300, Peter Ujfalusi wrote:
>> New binding document for
>> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
>>
>> UDMA-P is introduced as part of the K3 architecture and can be found in
>> AM654 and j721e.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../devicetree/bindings/dma/ti/k3-udma.txt    | 185 ++++++++++++++++++
>>  include/dt-bindings/dma/k3-udma.h             |  10 +
>>  2 files changed, 195 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.txt
>>  create mode 100644 include/dt-bindings/dma/k3-udma.h
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.txt b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
>> new file mode 100644
>> index 000000000000..3a8816ec9ce0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
>> @@ -0,0 +1,185 @@
>> +* Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)
>> +
>> +The UDMA-P is intended to perform similar (but significantly upgraded) functions
>> +as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
>> +supports the transmission and reception of various packet types. The UDMA-P is
>> +architected to facilitate the segmentation and reassembly of SoC DMA data
>> +structure compliant packets to/from smaller data blocks that are natively
>> +compatible with the specific requirements of each connected peripheral. Multiple
>> +Tx and Rx channels are provided within the DMA which allow multiple segmentation
>> +or reassembly operations to be ongoing. The DMA controller maintains state
>> +information for each of the channels which allows packet segmentation and
>> +reassembly operations to be time division multiplexed between channels in order
>> +to share the underlying DMA hardware. An external DMA scheduler is used to
>> +control the ordering and rate at which this multiplexing occurs for Transmit
>> +operations. The ordering and rate of Receive operations is indirectly controlled
>> +by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.
>> +
>> +The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
>> +channels. Channels in the UDMA-P can be configured to be either Packet-Based or
>> +Third-Party channels on a channel by channel basis.
>> +
>> +All transfers within NAVSS is done between PSI-L source and destination threads.
>> +The peripherals serviced by UDMA can be PSI-L native (sa2ul, cpsw, etc) or
>> +legacy, non PSI-L native peripherals. In the later case a special, small PDMA is
>> +tasked to act as a bridge between the PSI-L fabric and the legacy peripheral.
>> +
>> +PDMAs can be configured via UDMAP peer registers to match with the configuration
>> +of the legacy peripheral.
>> +
>> +Required properties:
>> +--------------------
>> +- compatible:		Should be
>> +			"ti,am654-navss-main-udmap" for am654 main NAVSS UDMAP
>> +			"ti,am654-navss-mcu-udmap" for am654 mcu NAVSS UDMAP
>> +			"ti,j721e-navss-main-udmap" for j721e main NAVSS UDMAP
>> +			"ti,j721e-navss-mcu-udmap" for j721e mcu NAVSS UDMAP
>> +- #dma-cells:		Should be set to <3>.
>> +			- The first parameter is a phandle to the remote PSI-L
>> +			  endpoint
>> +			- The second parameter is the thread offset within the
>> +			  remote thread ID range
>> +			- The third parameter is the channel direction.
>> +- reg:			Memory map of UDMAP
>> +- reg-names:		"gcfg", "rchanrt", "tchanrt"
>> +- msi-parent:		phandle for "ti,sci-inta" interrupt controller
>> +- ti,ringacc:		phandle for the ring accelerator node
>> +- ti,psil-base:		PSI-L thread ID base of the UDMAP channels
>> +- ti,sci:		phandle on TI-SCI compatible System controller node
>> +- ti,sci-dev-id:	TI-SCI device id
>> +- ti,sci-rm-range-tchan: UDMA tchan resource list in pairs of type and subtype
>> +- ti,sci-rm-range-rchan: UDMA rchan resource list in pairs of type and subtype
>> +- ti,sci-rm-range-rflow: UDMA rflow resource list in pairs of type and subtype
>> +
>> +For PSI-L thread management the parent NAVSS node must have:
>> +- ti,sci:		phandle on TI-SCI compatible System controller node
>> +- ti,sci-dev-id:	TI-SCI device id of the NAVSS instance
>> +
>> +Remote PSI-L endpoint
>> +
>> +Required properties:
>> +--------------------
>> +- ti,psil-base:		PSI-L thread ID base of the endpoint
>> +
>> +Within the PSI-L endpoint node thread configuration subnodes must present with:
>> +psil-configX naming convention, where X is the thread ID offset.
>> +
>> +Configuration node Optional properties:
>> +--------------------
>> +- ti,pdma-statictr-type:In case the remote endpoint (PDMAs) requires StaticTR
>> +			configuration:
>> +			- PSIL_STATIC_TR_XY (1): XY type of StaticTR
>> +			For endpoints without StaticTR the property is not
>> +			needed or to be set PSIL_STATIC_TR_NONE (0).
>> +- ti,pdma-enable-acc32:	Force 32 bit access on peripheral port. Only valid for
>> +			XY type StaticTR, not supported on am654.
>> +			Must be enabled for threads servicing McASP with AFIFO
>> +			bypass mode.
>> +- ti,pdma-enable-burst:	Enable burst access on peripheral port. Only valid for
>> +			XY type StaticTR, not supported on am654.
>> +- ti,channel-tpl:	Channel Throughput level:
>> +			0 / or not present - normal channel
>> +			1 - High Throughput channel
>> +			2 - Ultra High Throughput channel (j721e only)
>> +- ti,needs-epib:	If the endpoint require EPIB to be present in the
>> +			descriptor.
>> +- ti,psd-size:		Size of the Protocol Specific Data section of the
>> +			descriptor.
>> +- ti,notdpkt:		The Teardown Completion Message on the thread must be
>> +			suppressed.
>> +
>> +Example:
>> +
>> +main_navss: main_navss {
>> +	compatible = "simple-bus";
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	dma-coherent;
>> +	dma-ranges;
>> +	ranges;
>> +
>> +	ti,sci = <&dmsc>;
>> +	ti,sci-dev-id = <118>;
>> +
>> +	main_udmap: dma-controller@31150000 {
>> +		compatible = "ti,j721e-navss-main-udmap";
>> +		reg =	<0x0 0x31150000 0x0 0x100>,
>> +			<0x0 0x34000000 0x0 0x100000>,
>> +			<0x0 0x35000000 0x0 0x100000>;
>> +		reg-names = "gcfg", "rchanrt", "tchanrt";
>> +		#dma-cells = <3>;
>> +
>> +		ti,ringacc = <&main_ringacc>;
>> +		ti,psil-base = <0x1000>;
>> +
>> +		interrupt-parent = <&main_udmass_inta>;
>> +
>> +		ti,sci = <&dmsc>;
>> +		ti,sci-dev-id = <212>;
>> +
>> +		ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
>> +					<0x0f>, /* TX_HCHAN */
>> +					<0x10>; /* TX_UHCHAN */
>> +		ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
>> +					<0x0b>, /* RX_HCHAN */
>> +					<0x0c>; /* RX_UHCHAN */
>> +		ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
>> +	};
>> +};
>> +
>> +psilss@340c000 {
>> +	/* PSILSS1 AASRC */
>> +	compatible = "ti,j721e-psilss";
>> +	reg = <0x0 0x0340c000 0x0 0x1000>;
>> +	reg-names = "config";
>> +
>> +	pdma_main_mcasp_g0: pdma_main_mcasp_g0 {
>> +		/* PDMA6 (PDMA_MCASP_G0) */
>> +		ti,psil-base = <0x4400>;
>> +
>> +		/* psil-config0 */
>> +		psil-config0 {
>> +			ti,pdma-statictr-type = <PDMA_STATIC_TR_XY>;
>> +			ti,pdma-enable-acc32;
>> +			ti,pdma-enable-burst;
>> +		};
>> +	};
>> +};
>> +
>> +mcasp0: mcasp@02B00000 {
>> +...
>> +	/* tx: PDMA_MAIN_MCASP_G0-0, rx: PDMA_MAIN_MCASP_G0-0 */
>> +	dmas = <&main_udmap &pdma_main_mcasp_g0 0 UDMA_DIR_TX>,
>> +	       <&main_udmap &pdma_main_mcasp_g0 0 UDMA_DIR_RX>;
>> +	dma-names = "tx", "rx";
>> +...
>> +};
>> +
>> +crypto: crypto@4E00000 {
>> +	compatible = "ti,sa2ul-crypto";
>> +...
>> +
>> +	/* tx: crypto_pnp-1, rx: crypto_pnp-1 */
>> +	dmas = <&main_udmap &crypto 0 UDMA_DIR_TX>,
>> +	       <&main_udmap &crypto 0 UDMA_DIR_RX>,
>> +	       <&main_udmap &crypto 1 UDMA_DIR_RX>;
> 
> I asked before if the first cell is the client and you said no.

Correct, it is not the client. It is the node of the PSI-L gasket which
in case of native PSI-L peripherals happens to be the same node as the
client's
In K3 DMA architecture the data is moved along PSI-L threads. The
threads are formed when two PSI-L (source and destination) thread ID is
paired.
Since sa2ul is native PSI-L peripheral, the first cell (the phandle to
the PSI-L remove gasket from UDMAP point of view) is pointing to itself.

McASP on the other hand is not native PSI-L, it needs a PDMA to be
serviced (PDMA is a native PSI-L peripheral), so the first cell for
McASP is a phandle to the PDMA gasket which is tasked to service it.

> But this 
> shows it clearly is. Or '...' omits a lot more than just some node 
> properties and 'dmas' is not a property in 'crypto' node.

I only omitted properties like clocks, power, regs. As I said the first
call is a phandle to the PSI-L gasket for the peripheral which happens
to be the same in this case as it is a native PSI-L peripheral.

> Having the consumer phandle here looks like a hack to me and I can't 
> think of ever seeing such a case before.

We never had a DMA architecture like what we have here either. The DMA
gives extreme flexibility on how peripherals are configured, parameterized.
The UDMAP replaces the generic system DMA (EDMA/sDMA) and the packet
based networking DMAs as a single entity.
All channels are capable to act on behalf of a completely different DMA
and the only thing which dictates the channel configuration is the
properties of the remote endpoint.

This is on hardware level. On top of this flexibility almost every task
can be implemented in at least two different, but valid ways. Cyclic DMA
for audio for example can be implemented in four ways and all of them
would work just fine.

> I don't think we want to start now. 

Hrm, we have a hardware which gives flexibility to hw designers to have
different features and parameters per PSI-L remote thread IDs. Most of
the networking peripherals are using 16 bytes of Protocol Specific data,
sa2ul uses 64 bytes for the same. For legacy peripherals (via PDMAs) PS
data is not used.
And there are other features for the DMA per threads that somehow needs
to be described and might apply or not apply at all to a given thread.

> First, it's redundant. The code parsing 'dmas' already knows what node 
> it is in. I guess this is lost in Linux when the args are passed to 
> main_udmap's translate function, but that's Linux's problem and not a DT 
> problem. I haven't looked at the code, but I'm guessing you want crypto 
> phandle to go read these psil-config nodes.

It is not redundant. McASP for example is not a PSI-L native peripheral,
so it can not have PSI-L configuration nodes. The binding needs to point
to the PSI-L gasket's node, for McASP is is a PDMA, for sa2ul it is itself.

> Second, If we ever rev the FDT format to have type information 
> maintained, we could find each phandle and not have to parse #*-cells to 
> walk these properties.
> 
> 
>> +	dma-names = "tx", "rx1", "rx2";
>> +...
>> +	psil-config0 {
>> +		ti,needs-epib;
>> +		ti,psd-size = <64>;
>> +		ti,notdpkt;
>> +	};
> 
> I still don't like this either. Your choices are:
> 
> Put into dma cells. Yes, that's not easily expanded as you said, but 
> your bindings shouldn't really be expanding either.

This is not going to work with the flexibility and the wide range of
endpoint parameters, configuration we need for the channel.

> Don't put into DT. Not everything has to go into DT. What changes per 
> board/customer? Limit DT data to that. What data is fixed based on the 
> client or SoC? That can reside in the drivers. There's less value in 
> that data being in DT unless it is standard like interrupts, clocks, 
> etc. Maybe the DMA api needs some way for clients to provide the 
> provider with additional configuration information.

I have already moved the TR vs Packet mode channel selection, which does
make sense as it was Linux's choice to use TR for certain cases.

If I move these to code then we need to have big tables
struct psil_config am654_psil[32767] = {};
struct psil_config j721e_psil[32767] = {};

and for each new family member a new one.

Also, if we want add DMA support for a new peripheral we would need to
modify the kernel and the DT in sync (well, kernel first, than DT).

> Or do some combination of the above. 

What about this:
create a new dtsi file per SoC (k3-am654-psil.dtsi, k3-k721e-psil.dtsi)
for the PSI-L threads and inside something like this:

psil-threads: psil-threads {
	...
	/* SA2UL: 0x4000 - 0x4003 */
	ti,psil-config-4000 {
		linux,udma-mode = <UDMA_PKT_MODE>;
		ti,needs-epib;
		ti,psd-size = <64>;
		ti,notdpkt;
	};

	ti,psil-config-4001 {
		linux,udma-mode = <UDMA_PKT_MODE>;
		ti,needs-epib;
		ti,psd-size = <64>;
		ti,notdpkt;
	};

	ti,psil-config-4002 {
		linux,udma-mode = <UDMA_PKT_MODE>;
		ti,needs-epib;
		ti,psd-size = <64>;
		ti,notdpkt;
	};

	...
	/* PDMA6 (PDMA_MCASP_G0): 0x4400 - 0x4402 */
	thread-4400 {
		ti,pdma-statictr-type = <PDMA_STATIC_TR_XY>;
		ti,pdma-enable-acc32;
		ti,pdma-enable-burst;
	};

	thread-4401 {
		ti,pdma-statictr-type = <PDMA_STATIC_TR_XY>;
		ti,pdma-enable-acc32;
		ti,pdma-enable-burst;
	};

	thread-4402 {
		ti,pdma-statictr-type = <PDMA_STATIC_TR_XY>;
		ti,pdma-enable-acc32;
		ti,pdma-enable-burst;
	};

	...
};

Then the binding would look like this for sa2ul:

/* tx: crypto_pnp-1, rx: crypto_pnp-1 */
dmas = <&main_udmap 0x4000 UDMA_DIR_TX>,
       <&main_udmap 0x4000 UDMA_DIR_RX>,
       <&main_udmap 0x4001 UDMA_DIR_RX>;
dma-names = "tx", "rx1", "rx2";

for McASP:
dmas = <&main_udmap 0x4400 UDMA_DIR_TX>,
       <&main_udmap 0x4400 UDMA_DIR_RX>;
dma-names = "tx", "rx";

Then either we can have phandle in the udmap nodes to the psil-threads,
or just find it from the root when needed.

> Sorry I don't have specific suggestions, but I just see lots of properties 
> and complexity, and I don't really understand the h/w here. Putting the 
> complexity in what is an ABI is generally not a good plan.

The complexity is coming from the hardware itself. If I can not describe
the hardware than it is not going to be easy for the software to figure
out what it is dealing with.

> And I don't 
> have the bandwidth to study and understand the complexities of your h/w 
> (and everyone elses), so just more explanations are not likely to really 
> help.

Sure, I understand.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
