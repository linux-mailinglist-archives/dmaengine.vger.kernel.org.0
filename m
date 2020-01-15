Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCB213BCA3
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 10:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgAOJoT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 04:44:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54078 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgAOJoS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 04:44:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00F9hunI123963;
        Wed, 15 Jan 2020 03:43:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579081436;
        bh=I1GbB9LPbUbIMdwYtUqwmved9scdWddLN73TisHwbc8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pR0xeT9JuRIQ161rA/RXCC7rCxdgEQFO6BBN87pGN9iJY6fhVLiQ2Cg2pQvNgYBTW
         vISvIVgt0OWNGpI++9Cu9qycZMARXF9HrLqGcnL3DYS2DYBTQGMYo/LHHnTzlMuPi7
         fgvT3kK+IAGAnclmPFE+6bkaQSPurbAzf53EkyEY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00F9hu7e089171
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jan 2020 03:43:56 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 15
 Jan 2020 03:43:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 15 Jan 2020 03:43:55 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00F9hpEC035930;
        Wed, 15 Jan 2020 03:43:51 -0600
Subject: Re: [PATCH v8 02/18] soc: ti: k3: add navss ringacc driver
To:     <santosh.shilimkar@oracle.com>, Sekhar Nori <nsekhar@ti.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
 <20191223110458.30766-3-peter.ujfalusi@ti.com>
 <6d70686b-a94e-18d1-7b33-ff9df7176089@ti.com>
 <900c2f21-22bf-47f9-5c3c-0a3d95a5d645@oracle.com>
 <ea6a87ae-b978-a786-27eb-db99483a82d9@ti.com>
 <f0230e88-bd9b-cd6d-433d-06d507cafcbd@ti.com>
 <9177657a-71c7-7bd0-a981-3ef1f736d4dc@oracle.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2c933a6c-37c6-3ef6-7c37-ae36e8c49bf7@ti.com>
Date:   Wed, 15 Jan 2020 11:44:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9177657a-71c7-7bd0-a981-3ef1f736d4dc@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 14/01/2020 20.06, santosh.shilimkar@oracle.com wrote:
>>>>> Can you please giver your Acked-by for the ringacc patches if they are
>>>>> still OK from your point of view as you had offered to take them
>>>>> before
>>>>> I got comments from Lokesh.
>>>>>
>>>> Sure. But you really need to split the series so that dma engine and
>>>> soc driver patches can be applied independently.
>>>
>>> The ringacc is a build and runtime dependency for the DMA. I have hoped
>>> that all of them can go via DMAengine (hence asking for your ACK on the
>>> drivers/soc/ti/ patches) for 5.6.
>>>
>>>> Can you please do that?
>>>
>>> This late in the merge window that would really mean that I will miss
>>> another release for the KS3 DMA...
>>> I can live with that if you can pick the ringacc for 5.6 and if Vinod
>>> takes the DMAengine core changes as well.
>>>
>>> That would leave only the DMA drivers for 5.7 and we can also queue up
>>> changes for 5.7 which depends on the DMAengine API (ASoC changes, UART,
>>> sa2ul, etc).
>>>
>>> If they go independently and nothing makes it to 5.6 then 5.8 is the
>>> realistic target for the DMA support for the KS3 family of devices...
>>
>> Thats too many kernel versions to get this important piece in.
>>
>> Santosh, if you do not have anything else queued up that clashes with
>> this, can the whole series be picked up by Vinod with your ack on the
>> drivers/soc/ti/ pieces?
>>
> I would prefer driver patches to go via driver tree.

Not sure what you mean by 'driver patches'...
The series to enable DMA support on TI's K3 platform consists:
Patch 1-2: Ring Accelerator _driver_ (drivers/soc/ti/)
Patch 3-6: DMAengine core patches to add new features needed for k3-udma
Patch 7-11: DMA _driver_ patches for K3 (drivers/dma/ti/)

Patch 10 depends on the ringacc and the DMAengine core patches
Patch 11 depends on patch 10

I kept it as a single series in hope that they will go via one subsystem
tree to avoid build dependency issues and will have a good amount of
time in linux-next for testing.

>> Vinod could also perhaps setup an immutable branch based on v5.5-rc1
>> with just the drivers/soc/ti parts applied so you can merge that branch
>> in case you end up having to send up anything that conflicts.
>>
> As suggested on other email to Peter, these DMA engine related patches
> should be queued up since they don't have any dependency. Based on
> the status of that patchset, will take care of pulling in the driver
> patches either for this merge window or early part of next merge window.

OK, I'll send the two patch for ringacc as a separate series.

Vinod: Would it be possible for you to pick up the DMAengine core
patches (patch 3-6)?
The UDMA driver patches have hard dependency on DMAengine core and
ringacc, not sure how they are going to go in...

> Regards,
> Santosh

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
