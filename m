Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256DCD7DC1
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbfJOR3u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 13:29:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52392 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbfJOR3u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Oct 2019 13:29:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9FHTXFQ085986;
        Tue, 15 Oct 2019 12:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571160573;
        bh=KrgWh3TYfGhwD7OfEBPyzWk6XjSnfwlDaFgeUWGRq+4=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=L1gtts7qAYQjzYbF+sV9wfqa36DIJryMOvxkH5mko3FySUga9Qv0Ryz9RwRoaqamS
         H9ZKjoBMctkL1BsrCqknon/FODW30FoI6MktcLlD77XWoZwCjgM0G8/RTcnMektaHw
         gxwd0TSqbVxFCU9w4vc9/HCRI1Ym8atG/0w0fKpU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9FHTX9g073402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Oct 2019 12:29:33 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 15
 Oct 2019 12:29:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 15 Oct 2019 12:29:26 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9FHTTnV090514;
        Tue, 15 Oct 2019 12:29:29 -0500
Subject: Re: [PATCH v3 07/14] dt-bindings: dma: ti: Add document for K3 UDMA
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     <nm@ti.com>, <devicetree@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <t-kristo@ti.com>, <tony@atomide.com>, <vkoul@kernel.org>,
        <ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
        <dan.j.williams@intel.com>, <linux-arm-kernel@lists.infradead.org>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-8-peter.ujfalusi@ti.com> <20191010175232.GA24556@bogus>
 <ef07299b-eb43-d582-adb8-46f46681f9a5@ti.com>
Message-ID: <d53f3bd7-d331-33c8-5232-c8f3cc9ac708@ti.com>
Date:   Tue, 15 Oct 2019 20:30:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ef07299b-eb43-d582-adb8-46f46681f9a5@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rob,

On 10/11/19 10:30 AM, Peter Ujfalusi wrote:
> 
> I have already moved the TR vs Packet mode channel selection, which does
> make sense as it was Linux's choice to use TR for certain cases.
> 
> If I move these to code then we need to have big tables
> struct psil_config am654_psil[32767] = {};
> struct psil_config j721e_psil[32767] = {};

After thinking about this a bit more, I think we can move all the PSI-L
endpoint configuration to the kernel as not all the 32767 threads are
actually in use. Sure it is going to be some amount of static data in
the kernel, but it is an acceptable compromise.

The DMA binding can look like this:

dmas = <&main_udmap 0xc400>,
       <&main_udmap 0x4400>;
dma-names = "tx", "rx";

or
dmas = <&main_udmap 0x4400 UDMA_DIR_TX>,
       <&main_udmap 0x4400 UDMA_DIR_RX>;
dma-names = "tx", "rx";

If I keep the direction.
0xc400 is destination ID, which is 0x4400 | 0x8000 as per PSI-L
specification.
In the TRM only the source threads can be found as a map (thread IDs <
0x7fff), but the binding document can cover this.

This way we don't need another dtsi file and I can create the map in the
kernel.

This will hide some details of the HW from DT, but since the PSI-L
thread configuration is static in hardware I believe it is acceptable.

However we still have uncovered features in the binding or in code, like
a case when the RX does not have access to the DMA channel, only flows.
Not sure if I should reserve the direction parameter as an indication to
this or find other way.
Basically we communicate on the given PSI-L thread without having a DMA
channel as other core is owning the channel.

What do you think?

> 
> and for each new family member a new one.
> 
> Also, if we want add DMA support for a new peripheral we would need to
> modify the kernel and the DT in sync (well, kernel first, than DT).
> 
>> Or do some combination of the above. 
> 
> What about this:
> create a new dtsi file per SoC (k3-am654-psil.dtsi, k3-k721e-psil.dtsi)
> for the PSI-L threads and inside something like this:
> 
> psil-threads: psil-threads {
> 	...
> 	/* SA2UL: 0x4000 - 0x4003 */
> 	ti,psil-config-4000 {
> 		linux,udma-mode = <UDMA_PKT_MODE>;
> 		ti,needs-epib;
> 		ti,psd-size = <64>;
> 		ti,notdpkt;
> 	};
> 
> 	ti,psil-config-4001 {
> 		linux,udma-mode = <UDMA_PKT_MODE>;
> 		ti,needs-epib;
> 		ti,psd-size = <64>;
> 		ti,notdpkt;
> 	};
> 
> 	ti,psil-config-4002 {
> 		linux,udma-mode = <UDMA_PKT_MODE>;
> 		ti,needs-epib;
> 		ti,psd-size = <64>;
> 		ti,notdpkt;
> 	};
> 
> 	...
> 	/* PDMA6 (PDMA_MCASP_G0): 0x4400 - 0x4402 */
> 	thread-4400 {
> 		ti,pdma-statictr-type = <PDMA_STATIC_TR_XY>;
> 		ti,pdma-enable-acc32;
> 		ti,pdma-enable-burst;
> 	};
> 
> 	thread-4401 {
> 		ti,pdma-statictr-type = <PDMA_STATIC_TR_XY>;
> 		ti,pdma-enable-acc32;
> 		ti,pdma-enable-burst;
> 	};
> 
> 	thread-4402 {
> 		ti,pdma-statictr-type = <PDMA_STATIC_TR_XY>;
> 		ti,pdma-enable-acc32;
> 		ti,pdma-enable-burst;
> 	};
> 
> 	...
> };
> 
> Then the binding would look like this for sa2ul:
> 
> /* tx: crypto_pnp-1, rx: crypto_pnp-1 */
> dmas = <&main_udmap 0x4000 UDMA_DIR_TX>,
>        <&main_udmap 0x4000 UDMA_DIR_RX>,
>        <&main_udmap 0x4001 UDMA_DIR_RX>;
> dma-names = "tx", "rx1", "rx2";
> 
> for McASP:
> dmas = <&main_udmap 0x4400 UDMA_DIR_TX>,
>        <&main_udmap 0x4400 UDMA_DIR_RX>;
> dma-names = "tx", "rx";
> 
> Then either we can have phandle in the udmap nodes to the psil-threads,
> or just find it from the root when needed.
> 
>> Sorry I don't have specific suggestions, but I just see lots of properties 
>> and complexity, and I don't really understand the h/w here. Putting the 
>> complexity in what is an ABI is generally not a good plan.
> 
> The complexity is coming from the hardware itself. If I can not describe
> the hardware than it is not going to be easy for the software to figure
> out what it is dealing with.
> 
>> And I don't 
>> have the bandwidth to study and understand the complexities of your h/w 
>> (and everyone elses), so just more explanations are not likely to really 
>> help.
> 
> Sure, I understand.
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
