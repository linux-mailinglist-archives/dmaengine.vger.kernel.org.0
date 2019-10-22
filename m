Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FD9E034F
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 13:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfJVLqZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 07:46:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34966 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbfJVLqZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Oct 2019 07:46:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MBk78K081386;
        Tue, 22 Oct 2019 06:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571744767;
        bh=D8Xr36FkHE114oLNdhxs8VF7GbCwyndapIYX2707LgU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gZbLaC6QZ+CqLi7kfRJOAAKHSHqz7JqJcfixVJagdPBqB8/yM/ig1qGVaSdgGQFC7
         ZucfhMxwgH52ce1n/sXJXjdYlmSzY9+pFUo1NTxxIOiccoVIXiVuyEqWZVfN3Iclge
         4BuMMXC+wsAPGudnwMjoGGgDtjcBN2uGGiPQZKiQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MBjahZ023272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 06:45:36 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 06:45:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 06:45:26 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9MBj2NU038532;
        Tue, 22 Oct 2019 06:45:03 -0500
Subject: Re: [PATCH v3 07/14] dt-bindings: dma: ti: Add document for K3 UDMA
To:     Rob Herring <robh@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Keerthy <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vinod <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-8-peter.ujfalusi@ti.com> <20191010175232.GA24556@bogus>
 <ef07299b-eb43-d582-adb8-46f46681f9a5@ti.com>
 <d53f3bd7-d331-33c8-5232-c8f3cc9ac708@ti.com>
 <CAL_JsqKWVLMa=AJ+SNHjMRFpCk6cM=UPBgmmHVonOQ03a_zxXQ@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a844b84c-8dc7-6562-1f66-e4d625fa42e6@ti.com>
Date:   Tue, 22 Oct 2019 14:46:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKWVLMa=AJ+SNHjMRFpCk6cM=UPBgmmHVonOQ03a_zxXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 17/10/2019 17.03, Rob Herring wrote:
> On Tue, Oct 15, 2019 at 12:29 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>
>> Rob,
>>
>> On 10/11/19 10:30 AM, Peter Ujfalusi wrote:
>>>
>>> I have already moved the TR vs Packet mode channel selection, which does
>>> make sense as it was Linux's choice to use TR for certain cases.
>>>
>>> If I move these to code then we need to have big tables
>>> struct psil_config am654_psil[32767] = {};
>>> struct psil_config j721e_psil[32767] = {};
>>
>> After thinking about this a bit more, I think we can move all the PSI-L
>> endpoint configuration to the kernel as not all the 32767 threads are
>> actually in use. Sure it is going to be some amount of static data in
>> the kernel, but it is an acceptable compromise.
>>
>> The DMA binding can look like this:
>>
>> dmas = <&main_udmap 0xc400>,
>>        <&main_udmap 0x4400>;
>> dma-names = "tx", "rx";
>>
>> or
>> dmas = <&main_udmap 0x4400 UDMA_DIR_TX>,
>>        <&main_udmap 0x4400 UDMA_DIR_RX>;
>> dma-names = "tx", "rx";
>>
>> If I keep the direction.
>> 0xc400 is destination ID, which is 0x4400 | 0x8000 as per PSI-L
>> specification.
>> In the TRM only the source threads can be found as a map (thread IDs <
>> 0x7fff), but the binding document can cover this.
>>
>> This way we don't need another dtsi file and I can create the map in the
>> kernel.
>>
>> This will hide some details of the HW from DT, but since the PSI-L
>> thread configuration is static in hardware I believe it is acceptable.
>>
>> However we still have uncovered features in the binding or in code, like
>> a case when the RX does not have access to the DMA channel, only flows.
>> Not sure if I should reserve the direction parameter as an indication to
>> this or find other way.
>> Basically we communicate on the given PSI-L thread without having a DMA
>> channel as other core is owning the channel.
>>
>> What do you think?
> 
> Seems like a reasonable solution

OK, I'll go ahead and implement the PSI-L thread representation to the
kernel.

> though I don't really follow the last issue.

In this DMA for RX (DEV_TO_MEM) we need the source thread paired to
UDMAP receive channel to get data flowing.
The arriving packets within PSI-L are directed by flowID to a specific
receive flow configuration which describe the ring from where UDMAP
should pick up the descriptor and to where the completed one should be
placed for the SW.

There are cases when Linux for example does not have access to the
receive channel at all, it is handled by another core, but certain
receive flow(s) are given to Linux so they can receive packets.
In this case we do RX DMA without actual DMA channel.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
