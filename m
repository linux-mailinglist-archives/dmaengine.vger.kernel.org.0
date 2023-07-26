Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A87640E3
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 23:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGZVHg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 17:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGZVHf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 17:07:35 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 14:07:34 PDT
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5A1D19BE
        for <dmaengine@vger.kernel.org>; Wed, 26 Jul 2023 14:07:34 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Olc0q7uBxqvVSOlc0q8aLk; Wed, 26 Jul 2023 23:00:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690405202;
        bh=629h+qJRA+9CNbQtHSbGcrSotbeRZcqRnTPLR9Flyv4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k6imsvy7IG7H+QjCuWkkUh3cdKOz6oBJQWfiALgFYOs58EkQF2M0ELT8kN40brueT
         VGXS30CMcTwXZMmpppwjhpayLcJoKE9+LKMThdVxTNnVjtNDs7+0oHZrgnO/8P+7Zm
         aGKyMA0HwQKmtre2kXKpt6RAnN9SDyj7WivB7bsL7w1yrIEjJU1ZH0wLJGHds5PFZx
         wVzC/Mbanb6tT1T8eqMmDxJA8w+p/3Uo570kXzVM65GBQ7wvXtmKZzpSpSeuF7tdqd
         lTiksLzA1GnDD1Fubn7c5+g5iNPdzRvF4s2/LJulOwX56dYIRid7JYZlMOf1HQVekR
         qQZTkvaq8ZHFg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Jul 2023 23:00:02 +0200
X-ME-IP: 86.243.2.178
Message-ID: <ecf68b20-0a07-18bb-42a8-e622054b01f8@wanadoo.fr>
Date:   Wed, 26 Jul 2023 23:00:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on
 &plxdev->ring_lock
Content-Language: fr, en-US
To:     Logan Gunthorpe <logang@deltatee.com>,
        Chengfeng Ye <dg573847474@gmail.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726104827.60382-1-dg573847474@gmail.com>
 <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 26/07/2023 à 17:57, Logan Gunthorpe a écrit :
> 
> 
> On 2023-07-26 04:48, Chengfeng Ye wrote:
>> As plx_dma_process_desc() is invoked by both tasklet plx_dma_desc_task()
>> under softirq context and plx_dma_tx_status() callback that executed under
>> process context, the lock aquicision of &plxdev->ring_lock inside
>> plx_dma_process_desc() should disable irq otherwise deadlock could happen
>> if the irq preempts the execution of process context code while the lock
>> is held in process context on the same CPU.
>>
>> Possible deadlock scenario:
>> plx_dma_tx_status()
>>      -> plx_dma_process_desc()
>>      -> spin_lock(&plxdev->ring_lock)
>>          <tasklet softirq>
>>          -> plx_dma_desc_task()
>>          -> plx_dma_process_desc()
>>          -> spin_lock(&plxdev->ring_lock) (deadlock here)
>>
>> This flaw was found by an experimental static analysis tool I am developing
>> for irq-related deadlock.
>>
>> The tentative patch fixes the potential deadlock by spin_lock_irqsave() in
>> plx_dma_process_desc() to disable irq while lock is held.
>>
>> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> 
> Makes sense. Thanks!
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Logan
> 

Hi,

as explained in another reply [1], would spin_lock_bh() be enough in 
such a case?

CJ

[1]: 
https://lore.kernel.org/all/5125e39b-0faf-63fc-0c51-982b2a567e21@wanadoo.fr/
