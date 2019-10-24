Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847C3E2C82
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2019 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438389AbfJXIva (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Oct 2019 04:51:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46838 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbfJXIva (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Oct 2019 04:51:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9O8p7Pp085877;
        Thu, 24 Oct 2019 03:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571907067;
        bh=54djgH10KG/rVSnq5F8we0LmCw2lCjZh+du4GsdmEvs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QtrCVhPHsEj2wOocfkyA9jH2Qkcpyed05iPaxpH9sfQGNXJaooFfi5NN0O9EqX2uQ
         CATjIV6nA3+ZYd4L41pvYSv5wtVyVIPty8whwwhky9oOHwY4bMxsuNeBHxhyWO8tVf
         PyKeNrhT9tgNA1Lhcb+RjjSBvbOxcGwy7EpY3kBM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9O8p7T6006768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Oct 2019 03:51:07 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 24
 Oct 2019 03:50:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 24 Oct 2019 03:50:55 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9O8p1kH035606;
        Thu, 24 Oct 2019 03:51:01 -0500
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
 <7d578fe1-2d60-4a6e-48b0-73d66c39f783@ti.com>
 <20191023201829.GR5610@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <4bcd75d8-b7c5-5006-d80f-c5bda0cdf011@ti.com>
Date:   Thu, 24 Oct 2019 11:52:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023201829.GR5610@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 23/10/2019 23.18, Tony Lindgren wrote:
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

And the USB cable connect/disconnect is handled in interrupt -> you need
to call pm_runtime_get_sync(dmadev) from interrupt context and need to
mark the dmadev to pm_runtime_irq_safe()

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

the cppi41 driver solely relies on irq to check is the transfer is
completed (based on the cookie status).
So yeah, musb have no other choice than trust that the transfer is done
in a timely manner.

> And no, adding pm_runtime_get_sync() to issue_pending is not
> a solution. There may be clocks and regulators that need to
> be powered up, and we don't want to use pm_runtime_irq_safe()
> because of the permanent use count on the parent.

I think the only way to handle this is to keep the DMA enabled as long
as the USB cable is connected.
Either to introduce dma_pm_runtime_get_sync(struct dma_chan *c) and
dma_pm_runtime_put(struct dma_chan *c) or some better name.

It's use would be optional, but for USB you would call them for cable
connect the get_sync (from a work) and put it on disconnect.

The driver internally would not need to be changed, I think this patch
could be removed as well.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
