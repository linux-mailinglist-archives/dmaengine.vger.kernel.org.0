Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4944D88
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 22:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFMUdX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 16:33:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42444 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfFMUdX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jun 2019 16:33:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5DKX9mU095248;
        Thu, 13 Jun 2019 15:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560457989;
        bh=Iw66ZlMG9g4IKHXricwFmXq3+LquUzDHIWFykeidiDU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fMe8BuJPRnWf59pXtSPpXfH1rrGsEQFEuhYqEI6j8x9PtLxDwvrF+03GmkkBhRKzq
         UKLqYX8TZ/xO726R6wAJymbubg4NOj3KWikf6wfcR9hS9VPCa8qlEO9E7OJG0EPgsT
         tLyB5Tc3cVsP7kfvIG/gtc/+qHjOGTFpPAKriSnU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5DKX9lv093210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jun 2019 15:33:09 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 13
 Jun 2019 15:33:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 13 Jun 2019 15:33:09 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5DKX5AS026254;
        Thu, 13 Jun 2019 15:33:06 -0500
Subject: Re: [PATCH 09/16] dt-bindings: dma: ti: Add document for K3 UDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
 <20190506123456.6777-10-peter.ujfalusi@ti.com> <20190613181626.GA7039@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e0d6a264-96b5-31a6-e70b-3b1c2d863988@ti.com>
Date:   Thu, 13 Jun 2019 23:33:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613181626.GA7039@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rob,

On 13/06/2019 21.16, Rob Herring wrote:
>> +Remote PSI-L endpoint
>> +
>> +Required properties:
>> +--------------------
>> +- ti,psil-base:		PSI-L thread ID base of the endpoint
>> +
>> +Within the PSI-L endpoint node thread configuration subnodes must present with:
>> +ti,psil-configX naming convention, where X is the thread ID offset.
> 
> Don't use vendor prefixes on node names.

OK.

>> +
>> +Configuration node Required properties:
>> +--------------------
>> +- linux,udma-mode:	Channel mode, can be:
>> +			- UDMA_PKT_MODE: for Packet mode channels (peripherals)
>> +			- UDMA_TR_MODE: for Third-Party mode
> 
> This is hardly a common linux thing. What determines the value here.

Unfortunately it is.
Each channel can be configured to Packet or TR mode. For some
peripherals it is true that they only support packet mode, these are the
newer PSI-L native peripherals.
For these channels a udma-mode property would be correct.

But we have legacy peripherals as well and they are serviced by PDMA
(which is a native peripheral designed to talk to the given legacy IP).
We can use either packet or TR mode in UDMAP to talk to PDMAs, it is in
most cases clear what to use, but for example for audio (McASP) channels
Linux is using TR channel because we need cyclic DMA while for example
RTOS is using Packet mode as it fits their needs better.

Here I need to prefix the udma-mode with linux as the mode is used by
Linux, but other OS might opt to use different channel mode.

The reason why this needs to be in the DT is that when the channel is
requested we need to configure the mode and it can not be swapped
runtime easily between Packet and TR mode.

>> +
>> +Configuration node Optional properties:
>> +--------------------
>> +- statictr-type:	In case the remote endpoint requires StaticTR
>> +			configuration:
>> +			- PSIL_STATIC_TR_XY: XY type of StaticTR
>> +			- PSIL_STATIC_TR_MCAN: MCAN type of StaticTR
>> +- ti,channel-tpl:	Channel Throughput level:
>> +			0 / or not present - normal channel
>> +			1 - High Throughput channel
>> +- ti,needs-epib:	If the endpoint require EPIB to be present in the
>> +			descriptor.
>> +- ti,psd-size:		Size of the Protocol Specific Data section of the
>> +			descriptor.
> 
> You've got a lot of properties and child nodes here, but not in the 
> example. Please make the example more complete.

Sure, I'll extend the example with other peripheral which uses more
properties.

> 
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
>> +	main_udmap: udmap@31150000 {
> 
> dma-controller@...

OK

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
>> +pdma0: pdma@2a41000 {
>> +	compatible = "ti,am654-pdma";
>> +	reg = <0x0 0x02A41000 0x0 0x400>;
>> +	reg-names = "eccaggr_cfg";
>> +
>> +	ti,psil-base = <0x4400>;
>> +
>> +	/* ti,psil-config0-2 */
>> +	UDMA_PDMA_TR_XY(0);
> 
> What is this? Don't abuse defines with stuff like this. Generally only 
> defines of single values should be used.

The reason I have used define to build the psil-config sections is that
we have some PDMAs with 22 threads and it makes the DT explode when
writing out all of the thread configurations.

Within one PDMA we can have a mix of different modes, so I can not say
that all of the threads in the PDMA is the same.

> 
>> +	UDMA_PDMA_TR_XY(1);
>> +	UDMA_PDMA_TR_XY(2);
>> +};
>> +
>> +mcasp0: mcasp@02B00000 {
>> +...
>> +	/* tx: pdma0-0, rx: pdma0-0 */
>> +	dmas = <&main_udmap &pdma0 0 UDMA_DIR_TX>,
>> +	       <&main_udmap &pdma0 0 UDMA_DIR_RX>;
>> +	dma-names = "tx", "rx";
>> +...
>> +};
>> -- 

Thanks,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
