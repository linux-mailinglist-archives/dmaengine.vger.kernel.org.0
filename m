Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4B7640F6
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 23:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGZVK4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 17:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGZVKx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 17:10:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD141BE2;
        Wed, 26 Jul 2023 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=GdQIbfATFxwt8LtDtqP230uJEWFrpPIrlWDHw9xXrWA=; b=rAIfnk+5U2VYLw+CBHnDr6b1D/
        6B7I34rWocwCB55qJoKrqOhG9XIOJdaf1/niPN+luHvEAQTf4kCdB5UqRa/3o/FG8Yc2XIXpKAqRl
        Sj1I1Fyf+gMcDFcN4F4Vd5y6BzxIpn1VuEvxIwYZ1abqOboUOkqY0hoPj3YjJFytRXZzt3bnKgd79
        r0Yg632YO5WGwZ5QLszWKqJDoMrWQ2I6tDU+xKUIwUo6Y0rMl8Ku6lVH/OjXIs9zzFGJSx9+dw9Zo
        2T4pvjlr+Q1iWCP6DnPaXf+dmtxTvuxIj2buhLCOa/00hfZH+F8HhQZ2DDb4TYRCLhw28tLBxfnud
        X0DgvZNg==;
Received: from d75-158-34-12.abhsia.telus.net ([75.158.34.12] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qOlmN-00B8uv-PH; Wed, 26 Jul 2023 15:10:45 -0600
Message-ID: <0e4caa6c-d5bd-61e7-2ef6-300973cd2db6@deltatee.com>
Date:   Wed, 26 Jul 2023 15:10:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chengfeng Ye <dg573847474@gmail.com>, vkoul@kernel.org,
        Yunbo Yu <yuyunbo519@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726104827.60382-1-dg573847474@gmail.com>
 <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
 <ecf68b20-0a07-18bb-42a8-e622054b01f8@wanadoo.fr>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <ecf68b20-0a07-18bb-42a8-e622054b01f8@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 75.158.34.12
X-SA-Exim-Rcpt-To: christophe.jaillet@wanadoo.fr, dg573847474@gmail.com, vkoul@kernel.org, yuyunbo519@gmail.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on
 &plxdev->ring_lock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023-07-26 15:00, Christophe JAILLET wrote:
> Le 26/07/2023 à 17:57, Logan Gunthorpe a écrit :
>>
>>
>> On 2023-07-26 04:48, Chengfeng Ye wrote:
>>> As plx_dma_process_desc() is invoked by both tasklet plx_dma_desc_task()
>>> under softirq context and plx_dma_tx_status() callback that executed
>>> under
>>> process context, the lock aquicision of &plxdev->ring_lock inside
>>> plx_dma_process_desc() should disable irq otherwise deadlock could
>>> happen
>>> if the irq preempts the execution of process context code while the lock
>>> is held in process context on the same CPU.
>>>
>>> Possible deadlock scenario:
>>> plx_dma_tx_status()
>>>      -> plx_dma_process_desc()
>>>      -> spin_lock(&plxdev->ring_lock)
>>>          <tasklet softirq>
>>>          -> plx_dma_desc_task()
>>>          -> plx_dma_process_desc()
>>>          -> spin_lock(&plxdev->ring_lock) (deadlock here)
>>>
>>> This flaw was found by an experimental static analysis tool I am
>>> developing
>>> for irq-related deadlock.
>>>
>>> The tentative patch fixes the potential deadlock by
>>> spin_lock_irqsave() in
>>> plx_dma_process_desc() to disable irq while lock is held.
>>>
>>> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
>>
>> Makes sense. Thanks!
>>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>
>> Logan
>>
> 
> Hi,
> 
> as explained in another reply [1], would spin_lock_bh() be enough in
> such a case?

The driver originally used spin_lock_bh(). It was removed by Yunbo Yu in
2022 who said that it was unnecessary to be used with a tasklet:

1d05a0bdb420 ("dmaengine: plx_dma: Move spin_lock_bh() to spin_lock() ")

If spin_lock_bh() is correct (which is what I originally thought when I
wrote the driver, though I'm a bit confused now) then I guess that
Yunbo's change was just incorrect. It sounded sensible at the time, but
it looks like there are two call sites of plx_dma_desc_task(): one in
the tasklet and one not in the tasklet. The one not in the tasklet needs
to use the bh version.

So perhaps we should just revert 1d05a0bdb420?

Logan
