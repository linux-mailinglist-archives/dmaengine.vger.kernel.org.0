Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E65991EE
	for <lists+dmaengine@lfdr.de>; Thu, 22 Aug 2019 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfHVLSg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Aug 2019 07:18:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55402 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfHVLSg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Aug 2019 07:18:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7MBIQj2048903;
        Thu, 22 Aug 2019 06:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566472706;
        bh=NS/mVTXTOro/Edy47WaM5g/4GOcUYhf9QMTHcCRtKXc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nJju6YZ26uleYj4OC89gIL4ZYhQ8dePN7AJZOr9Z7H7ROhojxBf4xMJq/kj/redGQ
         2RQIGExMREfaZI8xzWzls0ETbKFchg+0l4En0Ih1hWn+1OQumK4a6b4uN/Yivldu+D
         zNPUZ0FWRvVCUoBPa/GcpFGNLjZpzegICm9Xdrao=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7MBIQjL097076
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Aug 2019 06:18:26 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 22
 Aug 2019 06:18:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 22 Aug 2019 06:18:25 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7MBIMlM072604;
        Thu, 22 Aug 2019 06:18:22 -0500
Subject: Re: [PATCH v2 07/14] dt-bindings: dma: ti: Add document for K3 UDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-8-peter.ujfalusi@ti.com> <20190821175906.GA30618@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <4e55e254-18f6-748f-380f-a7f0a6eeff92@ti.com>
Date:   Thu, 22 Aug 2019 14:18:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821175906.GA30618@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 21/08/2019 20.59, Rob Herring wrote:
> On Tue, Jul 30, 2019 at 12:34:43PM +0300, Peter Ujfalusi wrote:
>> New binding document for
>> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
>>
>> UDMA-P is introduced as part of the K3 architecture and can be found on
>> AM654 and j721e.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../devicetree/bindings/dma/ti/k3-udma.txt    | 170 ++++++++++++++++++
>>  include/dt-bindings/dma/k3-udma.h             |  10 ++
>>  2 files changed, 180 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.txt
>>  create mode 100644 include/dt-bindings/dma/k3-udma.h
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.txt b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
>> new file mode 100644
>> index 000000000000..7f30fe583ade
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
>> @@ -0,0 +1,170 @@
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
> 
> This is the phandle of the client? That's weird. More below.

Not the client, but of the psi-l gasket. PSI-L stands for Packet
Streaming Interface Link.
UDMA can not talk directly to peripherals, it operates within the PSI-L
fabric. If a peripheral needs to be serviced by UDMA it has to have a
PSI-L thread ID.

In PSI-L every source and destination have unique thread ID which is
used by the PSI-L to steer the data flow from source to destination.
The thread is map is broken down to gaskets, for example
PDMA0's thread IDs are 0x4400-0x44ff
SA2UL's threads are between 0x4000-0x40ff
UDMAP0's threads are 0x1000-0x3fff

Gaskets usually group multiple threads, so for example to communicate
with PDMA0's 2nd thread, the thread ID which need to be used for
configuration is 0x4402.

I'll try to give more details later.

> 
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
>> +- pdma,statictr-type:	In case the remote endpoint (PDMAs) requires StaticTR
> 
> Property names are in the form [<vendor>,]prop-name. pdma is not a 
> vendor.

Which one is acceptable replacement ti,pdma,statictr-type, or
ti,pdma-statictr-type?

> 
>> +			configuration:
>> +			- PSIL_STATIC_TR_XY (1): XY type of StaticTR
>> +			For endpoints without StaticTR the property is not
>> +			needed or to be set PSIL_STATIC_TR_NONE (0).
>> +- pdma,enable-acc32:	Force 32 bit access on peripheral port. Only valid for
>> +			XY type StaticTR, not supported on am654.
>> +			Must be enabled for threads servicing McASP with AFIFO
>> +			bypass mode.
>> +- pdma,enable-burst:	Enable burst access on peripheral port. Only valid for
>> +			XY type StaticTR, not supported on am654.
>> +- ti,channel-tpl:	Channel Throughput level:
>> +			0 / or not present - normal channel
>> +			1 - High Throughput channel
>> +			2 - Ultra High Throughput channel (j721e only)
>> +- ti,needs-epib:	If the endpoint require EPIB to be present in the
>> +			descriptor.
>> +- ti,psd-size:		Size of the Protocol Specific Data section of the
>> +			descriptor.
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
>> +		compatible = "ti,am654-navss-main-udmap";
>> +		reg =	<0x0 0x31150000 0x0 0x100>,
>> +			<0x0 0x34000000 0x0 0x100000>,
>> +			<0x0 0x35000000 0x0 0x100000>;
>> +		reg-names = "gcfg", "rchanrt", "tchanrt";
>> +		#dma-cells = <3>;
>> +
>> +		ti,ringacc = <&ringacc>;
>> +		ti,psil-base = <0x1000>;
>> +
>> +		interrupt-parent = <&main_udmass_inta>;
>> +
>> +		ti,sci = <&dmsc>;
>> +		ti,sci-dev-id = <188>;
>> +
>> +		ti,sci-rm-range-tchan = <0x6 0x1>, /* TX_HCHAN */
>> +					<0x6 0x2>; /* TX_CHAN */
>> +		ti,sci-rm-range-rchan = <0x6 0x4>, /* RX_HCHAN */
>> +					<0x6 0x5>; /* RX_CHAN */
>> +		ti,sci-rm-range-rflow = <0x6 0x6>; /* GP RFLOW */
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
>> +			pdma,statictr-type = <PSIL_STATIC_TR_XY>;
>> +			pdma,enable-acc32;
>> +			pdma,enable-burst;
>> +		};
>> +	};
>> +};
>> +
>> +mcasp0: mcasp@02B00000 {
> 
> I don't really follow what psilss and mcasp are...

McASP is a peripheral which does not have PSI-L interface, it is legacy
IP. It is serviced by PDMA which is on one side is a PSI-L peripheral,
on the other side it is communicating with McASP.

Each thread in the PDMA is dedicated to service a given legacy
peripheral and within a PDMA block we could have mixed type of
channels/threads servicing different legacy peripherals.

In essence the PDMA channel is a purpose built small DMA to service a
single peripheral and the channels are grouped together to for a PDMA
gasket.

The PDMA itself can only be programmed via the UDMA channel's remote
peer register area, it is like an extension of the UDMA to legacy
peripherals.

Native PSI-L peripherals like SA2UL, CPSW or ICSSG does not have PDMA as
they are built for PSI-L, thus they don't have any static TR registers
or things which is needed in PDMAs to be able to service lefacy
peripherals.

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
> 'thread offset' is 1?

Yes. SA2UL uses one tx thread (paired with one UDMA tx channel): 0x4000
and it has two RX threads (each paired to separate UDMA rx channel):
0x4000 and 0x4001

In protocol level PSI-L the thread IDs are defined as:
0x0000 - 0x7fff Source PSI-L threads
0x8000 - 0xffff Destination threads

The documentation defines the source ID only and the destination ID is
derived by src_id + 0x8000 or src_id | 0x8000

and the PSI-L thread configuration is symmetric among them, so the
settings for 0x4000 applies to 0x4000|0x8000 as well, this is why I
opted to add the direction parameter instead of spelling out the
configuration for src and dst threads.

> 
>> +	dma-names = "tx", "rx1", "rx2";
>> +...
>> +	psil-config0 {
> 
> Are these nodes 1-1 with the 'dmas' entries? I think these flags should 
> all be DMA cells. They are all configuration of DMA channels, right?

These are unique for the given PSI-L thread. Depending on the remote
(remote to UDMA) thread the parameters can be different and the valid
set of parameters as well.

> Though I'm not sure about how that would work for the previous example.

Like native native PSI-L peripherals does not have for example static TR
support as they don't need, so anything which is needed for static TR
does not apply to them.

If I would put all the possible thread parameters in one line then I
would easily go beyond 15 entries and we still have not supported
features on the threads. Adding them would break the bindings as I would
need to expand the parameter list and it would be really hard to decode
and understand what the given dmas line is actually describing.

> 
>> +		ti,needs-epib;
>> +		ti,psd-size = <64>;
>> +	};
>> +
>> +	psil-config1 {
>> +		ti,needs-epib;
>> +		ti,psd-size = <64>;
>> +	};
>> +
>> +	psil-config2 {
>> +		ti,needs-epib;
>> +		ti,psd-size = <64>;
>> +	};
>> +};
>> diff --git a/include/dt-bindings/dma/k3-udma.h b/include/dt-bindings/dma/k3-udma.h
>> new file mode 100644
>> index 000000000000..f5c8f5d50491
>> --- /dev/null
>> +++ b/include/dt-bindings/dma/k3-udma.h
>> @@ -0,0 +1,10 @@
>> +#ifndef __DT_TI_UDMA_H
>> +#define __DT_TI_UDMA_H
>> +
>> +#define UDMA_DIR_TX		0
>> +#define UDMA_DIR_RX		1
>> +
>> +#define PSIL_STATIC_TR_NONE	0
>> +#define PSIL_STATIC_TR_XY	1
>> +
>> +#endif /* __DT_TI_UDMA_H */
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
