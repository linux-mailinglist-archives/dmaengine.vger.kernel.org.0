Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A00E237B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391357AbfJWTzr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 15:55:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48896 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390336AbfJWTzq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 15:55:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NJtBnx074255;
        Wed, 23 Oct 2019 14:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571860511;
        bh=de5S54xAtPYP9Lxrsi0FJ/ADWfqMQdaDJmT0NY/9mgA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V8Wn4UG2UyEZlbG/YuL6MF8N441+sbezab4qUKa6IL13ptVpSLUN3d/D1RG+KPXWX
         gMpAfNZ13Yu5OrsGwVDff1QYb+PO1xA0yyEtsWhzZ4hhXapEm/9LHwJpe5QauVAHt0
         mtDO2p2DtB8M/X9qkGAWavoMP54z0pSB8/614iew=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NJtBq4080638;
        Wed, 23 Oct 2019 14:55:11 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 14:55:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 14:55:00 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NJt4X7043211;
        Wed, 23 Oct 2019 14:55:04 -0500
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when
 idle
To:     Tony Lindgren <tony@atomide.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <dmaengine@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <giulio.benetti@benettiengineering.com>,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
References: <20191023153138.23442-1-tony@atomide.com>
 <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
 <20191023171628.GO5610@atomide.com>
 <5deab8a9-5796-5367-213e-90c5961b8498@ti.com>
 <20191023191859.GQ5610@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7d578fe1-2d60-4a6e-48b0-73d66c39f783@ti.com>
Date:   Wed, 23 Oct 2019 22:55:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023191859.GQ5610@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tony,

On 10/23/19 10:18 PM, Tony Lindgren wrote:
>> the autosuspend_delay is set 100 ms, so if you put a udelay(101) between
>> prep_sg and issue_pending in the usb driver this trickery will be for
>> nothing, right?
>> If the usb driver is preempted for longer than 100ms between the two
>> calls, same issue.
>> Not sure, but if for some reason the transfer would take longer than
>> 100ms than pm_runtime will bring down the dma, no?
> 
> No, the dma will happen just fine no matter what the delay is.
> 
> Part of the problem here is the musb driver. It friggin
> continues before checking the completion of a dma transfer!

nice. Well I assume it is from an era when pm_runtime did not even
existed and assumes that things are always available and react without
delay.

> Fixing that currently is not trivial.

I had the pleasure to lurk in for the tusb6010_omap and I fully agree.

>>> But yeah, some dmaengine API that can sleep to tell
>>> a request is about to come would simplify things.
>>
>> any of the prep callbacks kind of indicates that a client is preparing a
>> transfer so in a perfect world it is going to want to execute it..
>>
>>> I don't think we have anything like that available
>>> right now?
>>
>> Well, it would have the same issues. If the time between
>> dmaengine_be_warned_i_m_going_to_call_issue_pending_soon and
>> issue_pending is more than the autosuspend_delay then it is not going to
>> help.
> 
> We'd have to allow dma consumer driver call pm_runtime_get_sync()
> on the dma device. Something similar maybe to what we have
> for phy_pm_runtime_get_sync(). Or just get the device handle for
> dma so the consumer can call pm_runtime_get_sync() on it.

How much a pm_runtime_get_sync(dmadev) is different when it is issued by
the client driver compared to when the dma driver issues it for it's own
device?

>> On the other hand: if the usb driver assumes that the dma transfer is
>> already finished when issue_pending returned and carry on with
>> subsequent request, that is also a problematic assumption. One can only
>> consider a transfer to be done if the completion callback is called or
>> you have polled for the completion and it tells you the same.
>> This is problematic if you are in atomic context as the DMA completion
>> interrupt might not come while you are there.
> 
> Yeah the musb driver has a history of 14 years of issues.
> I guess the logic there has been, it's usb, it can disconnect
> at any time..
> 
>> imho, this fix is working by lucky constellation of the stars ;)
>> Or we can assume that there will never be more than 100ms delay between
>> prepare_sg and issue_pending...
> 
> Not true. The cpp41 dma is doing the right thing and is not
> affected by the PM runtime autosuspend delay.

Yes, what the cppi41 does is (was) correct. If the rpm's work is not
executed between the runtime_get and when the is_suspended flag is
checked in issue_pending, then the resume callback will start the
transfer. That's kind of fine(ish). If cppi41 would be used for audio
then it would not be as the DMA must start when we tell it to start.

> Otherwise USB
> hard drives would not work, they can take seconds to spin up :)

Hrm, true.

> The missing part here seems to be the fact that musb continues
> before the dma completion is done.

But I still fail to see the difference between the events before this
patch and with the case when there is a 100ms delay between prep_sg and
issue_pending.

Before this patch:

prep_sg()
issue_pending() <- runtime_get() /  put_autosuspend()
		   _not_ starting transfer
runtime_resume() <- starts the transfer

With this patch and than 100ms delay between prep_sg and issue_pending:

prep_sg() <- runtime_get() /  put_autosuspend()
runtime_resume() <- not starting transfer
issue_pending() <- runtime_get() /  put_autosuspend()
		   starts the transfer

With this patch, but more than 100ms delay in between:

prep_sg() <- runtime_get() /  put_autosuspend()
runtime_resume() <- not starting transfer
> 100ms delay
runtime_suspend()
issue_pending() <- runtime_get() /  put_autosuspend()
		   _not_ starting transfer
runtime_resume() <- starts the transfer

pm_runtime_get_sync() in issue_pending would be the solution to avoid
delayed execution, but the usb driver should not assume that DMA is
completed as soon as issue_pending returned.

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
