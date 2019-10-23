Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5EE24D1
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 22:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404100AbfJWU4A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 16:56:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53920 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390466AbfJWU4A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 16:56:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NKtZ2a094913;
        Wed, 23 Oct 2019 15:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571864135;
        bh=MQTTyMjZXhjZnzwnc+GWMyroBk1W8/yLleURMf76qAk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xCTmUSicJiXP3Odt/mfxyUMmh2uaO4B0vwFE/Gwggx9WoCp9alSkasJIyoZ9PTGmT
         Xr1S5sxfZxX7wfPsEqwgv2D1mR7bWJo8m0gN3kv7+hjd+vmwVzHlB4dwXQlQ3hXUdk
         xZZesgXG6rJJI8ZbpDc6/2E+NXW98F0asgVpJxIg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NKtZkL091790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 15:55:35 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 15:55:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 15:55:25 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NKtRTs077420;
        Wed, 23 Oct 2019 15:55:28 -0500
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when
 idle
To:     Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
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
 <7d578fe1-2d60-4a6e-48b0-73d66c39f783@ti.com>
 <20191023201829.GR5610@atomide.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <c3f0ae57-bc74-bab9-c8f9-b4ca751d657e@ti.com>
Date:   Wed, 23 Oct 2019 23:55:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023201829.GR5610@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 23/10/2019 23:18, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [191023 19:55]:
>> On 10/23/19 10:18 PM, Tony Lindgren wrote:
>>> We'd have to allow dma consumer driver call pm_runtime_get_sync()
>>> on the dma device. Something similar maybe to what we have
>>> for phy_pm_runtime_get_sync(). Or just get the device handle for
>>> dma so the consumer can call pm_runtime_get_sync() on it.
>>
>> How much a pm_runtime_get_sync(dmadev) is different when it is issued by
>> the client driver compared to when the dma driver issues it for it's own
>> device?
> 
> Well the consumer device could call pm_runtime_get_sync(dmadev)
> when the USB cable is connected for example, and then call
> pm_runtime_pu(dmadev) when let's say the USB cable is disconnected.
> 
> Without using pm_runtime_irq_safe() we currently don't have a
> clear path for doing this where the pm_runtime_get_sync(dmadev)
> may sleep.
> 
>> But I still fail to see the difference between the events before this
>> patch and with the case when there is a 100ms delay between prep_sg and
>> issue_pending.
>>
>> Before this patch:
>>
>> prep_sg()
>> issue_pending() <- runtime_get() /  put_autosuspend()
>> 		   _not_ starting transfer
>> runtime_resume() <- starts the transfer
>>
>> With this patch and than 100ms delay between prep_sg and issue_pending:
>>
>> prep_sg() <- runtime_get() /  put_autosuspend()
>> runtime_resume() <- not starting transfer
>> issue_pending() <- runtime_get() /  put_autosuspend()
>> 		   starts the transfer
>>
>> With this patch, but more than 100ms delay in between:
>>
>> prep_sg() <- runtime_get() /  put_autosuspend()
>> runtime_resume() <- not starting transfer
>>> 100ms delay
>> runtime_suspend()
>> issue_pending() <- runtime_get() /  put_autosuspend()
>> 		   _not_ starting transfer
>> runtime_resume() <- starts the transfer
>>
>> pm_runtime_get_sync() in issue_pending would be the solution to avoid
>> delayed execution, but the usb driver should not assume that DMA is
>> completed as soon as issue_pending returned.
> 
> Oh I see. Yes the consumer driver would need to check for
> the completed dma transfer in all cases. The delay issues
> should not currently happen in the musb_ep_program() problem
> case as it gets called from IRQ context.
> 
> And no, adding pm_runtime_get_sync() to issue_pending is not
> a solution. There may be clocks and regulators that need to
> be powered up, and we don't want to use pm_runtime_irq_safe()
> because of the permanent use count on the parent.

5 cents.

I think the right thing might be to get rid of pm_runtime_xxx()
in cppi41_dma_issue_pending(). So overall approach will be:

- new job -> cppi41_dma_prep_slave_sg() -> pm_runtime_get()
- issue_pending: fill backlog if suspended or run_queue if active (pm_runtime_active())
- job done: dmaengine_desc_get_callback_invoke() ->

	dmaengine_desc_get_callback_invoke();
	pm_runtime_mark_last_busy(cdd->ddev.dev);
	pm_runtime_put_autosuspend(cdd->ddev.dev);
   in all places.

It even might allow to get rid of cdd->lock.


-- 
Best regards,
grygorii
