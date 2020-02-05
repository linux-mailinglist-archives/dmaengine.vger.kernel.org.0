Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F35152763
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 09:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgBEIKa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Feb 2020 03:10:30 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32858 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgBEIKa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Feb 2020 03:10:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0158APDC071899;
        Wed, 5 Feb 2020 02:10:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580890225;
        bh=b+qiEeC1rtft9IYzgd/F11sSSM+sJCMDAMLRewswKHc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kw0Sqs4i/i3pm3j/y6IWzWqkEvHOf0slYu7rew9t4n5/orO9pWC1ydloq3a60rQFg
         PoKAvBpRYeq2U2DMTh7eI0jq1bAFJExZByMaR4ippNeSuOAA5+LZ6i/sy8z1xC2iwD
         5/LVhQmL6ybBGt0GsKu6m6BVLa8PcYx1Cw8Dy68s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0158AOhf098349
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Feb 2020 02:10:25 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 02:10:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 02:10:24 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0158AM6j000628;
        Wed, 5 Feb 2020 02:10:22 -0600
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
To:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <20200204062118.GS2841@vkoul-mobl>
 <CAHp75VeRemcJkMMB7D2==Y-A4We=s1ntojZoPRdVS8vs+dB_Ew@mail.gmail.com>
 <20200205044352.GC2618@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <13dcf3d9-06ca-d793-525d-12f6d7cd27c1@ti.com>
Date:   Wed, 5 Feb 2020 10:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205044352.GC2618@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,

On 05/02/2020 6.43, Vinod Koul wrote:
> On 04-02-20, 13:21, Andy Shevchenko wrote:
>> On Tue, Feb 4, 2020 at 8:21 AM Vinod Koul <vkoul@kernel.org> wrote:
>>>
>>> On 03-02-20, 12:37, Andy Shevchenko wrote:
>>>> On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>>>
>>>>> dma_request_slave_channel_reason() no longer have user in mainline, it
>>>>> can be removed.
>>>>>
>>>>> Advise users of dma_request_slave_channel() and
>>>>> dma_request_slave_channel_compat() to move to dma_request_slave_chan()
>>>>
>>>> How? There are legacy ARM boards you have to care / remove before.
>>>> DMAengine subsystem makes a p*s off decisions without taking care of
>>>> (I'm talking now about dma release callback, for example) end users.
>>>
>>> Can you elaborate issue you are seeing with dma_release callback?
>>
>>
>> [    7.980381] intel-lpss 0000:00:1e.3: WARN: Device release is not
>> defined so it is not safe to unbind this driver while in use
> 
> Yes that is expected but is not valid in your case.

In which case it is valid?

> Anyway this will be turned off before the release.

Looking at the commit which added it and I still don't get the point.
If any of the channel is in use then we should not allow the DMA driver
to go away at all.
Imho there should be a function to check if we can proceed with the
.remove of the driver and fail it if any of the channels are in use.

Hrm, base/dd.c __device_release_driver() does not check the .remove's
return value, so it can not fail.

What is expected if the .remove returns with OK but we still have
channels in use?

After the remove all sorts of things got yanked which might makes the
still in use channels cause issues down the road.

I'm curious why it is a good thing to remotely try to support unbind
when the driver is in use.
It is like one wants to support ext4 removal even when your rootfs is ext4.

I think krefing the DMA driver for channel request/release is just fine,
if user wants to break the system we should not assist...

>> It's not limited to that driver, but actually all I'm maintaining.
>>
>> Users are not happy!
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
