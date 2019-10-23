Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5878E2599
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 23:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407620AbfJWVne (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 17:43:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35164 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407605AbfJWVne (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 17:43:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NLh9gT110286;
        Wed, 23 Oct 2019 16:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571866989;
        bh=wacVFqbLmEtd3w9mIHoYYehpYuH1fnxcUqzWhcaMdRQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F7tZtUvB+TjhBk+k3FmN/7Dnt4VMc5BmH8GAEIBkWC5H60RAAorquyP8PLKcQSFts
         6ROC0xOPHqZLlWeqGUkjrQHUk3U0NvsjvLa9P8gynihq76d1UtI8H6RdLazRH82EM5
         57inwwBlnBOXYNA98RCR2LmqNj9iAyYhD88+fMeo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NLh92Q088756
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 16:43:09 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 16:42:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 16:42:58 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NLh372125420;
        Wed, 23 Oct 2019 16:43:03 -0500
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when
 idle
To:     Tony Lindgren <tony@atomide.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
 <c3f0ae57-bc74-bab9-c8f9-b4ca751d657e@ti.com>
 <20191023212734.GT5610@atomide.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <78bf336e-8078-df79-2e3e-42c6cf8a3ae8@ti.com>
Date:   Thu, 24 Oct 2019 00:43:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023212734.GT5610@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 24/10/2019 00:27, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [191023 20:56]:
>> On 23/10/2019 23:18, Tony Lindgren wrote:
>>> And no, adding pm_runtime_get_sync() to issue_pending is not
>>> a solution. There may be clocks and regulators that need to
>>> be powered up, and we don't want to use pm_runtime_irq_safe()
>>> because of the permanent use count on the parent.
>>
>> 5 cents.
>>
>> I think the right thing might be to get rid of pm_runtime_xxx()
>> in cppi41_dma_issue_pending(). So overall approach will be:
>>
>> - new job -> cppi41_dma_prep_slave_sg() -> pm_runtime_get()
>> - issue_pending: fill backlog if suspended or run_queue if active (pm_runtime_active())
>> - job done: dmaengine_desc_get_callback_invoke() ->
>>
>> 	dmaengine_desc_get_callback_invoke();
>> 	pm_runtime_mark_last_busy(cdd->ddev.dev);
>> 	pm_runtime_put_autosuspend(cdd->ddev.dev);
>>    in all places.
>>
>> It even might allow to get rid of cdd->lock.
> 
> Well I don't think cppi41_dma_prep_slave_sg() is necessarily
> paired with anything currently.

It should - dma cmpletion callbacks have to be called somewhere.


  This can potentially leading
> to pm_runtime_get() called multiple times?

That's the idea - increase pm_counter as many times as jobs submitted.

> 
> So I think we'd also need cppi41_dma_cleanup_slave_sg()
> or similar, and require they get called in a paired manner.
> 
> It might be better to add seprate PM runtime specific
> functions that dma consumers can optionally call.

not sure here. It seems just over designed very old stuff ;)

-- 
Best regards,
grygorii
