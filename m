Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3A145959C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 20:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhKVTdx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 14:33:53 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:59797 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhKVTdu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Nov 2021 14:33:50 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pF1UmhF3gRLGppF1UmZGpk; Mon, 22 Nov 2021 20:30:41 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 22 Nov 2021 20:30:41 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] dmaengine: dw-edma: Fix (and simplify) the probe broken
 since ecb8c88bd31c
To:     Vinod Koul <vkoul@kernel.org>
Cc:     gustavo.pimentel@synopsys.com, wangqing@vivo.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <935fbb40ae930c5fe87482a41dcb73abf2257973.1636492127.git.christophe.jaillet@wanadoo.fr>
 <YZs/OeBJDMc4A4EC@matsya>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <2cbd5202-6b0d-b5b3-62a0-8ade7bf0d199@wanadoo.fr>
Date:   Mon, 22 Nov 2021 20:30:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZs/OeBJDMc4A4EC@matsya>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 22/11/2021 à 07:56, Vinod Koul a écrit :
> On 09-11-21, 22:09, Christophe JAILLET wrote:
>> The commit in the Fixes: tag has changed the logic of the code and now it
>> is likely that the probe will return an early success (0), even if not
>> completely executed.
>>
>> This should lead to a crash or similar issue later on when the code
>> accesses to some never allocated resources.
>>
>> Change the '!err' into a 'err' when checking if
>> 'dma_set_mask_and_coherent()' has failed or not.
>>
>> While at it, simplify the code and remove the "can't success code" related
>> to 32 DMA mask.
>> As stated in [1], 'dma_set_mask_and_coherent(DMA_BIT_MASK(64))' can't fail
>> if 'dev->dma_mask' is non-NULL. And if it is NULL, it would fail for the
>> same reason when tried with DMA_BIT_MASK(32).
> 
> The patch title should describe the changes in the patch and not the
> outcome! So I have taken the liberty to update this to:
> dmaengine: dw-edma: Fix return value check for dma_set_mask_and_coherent()
> 

Hi,

In fact, this 'bad' patch title was a way for me to express my 
frustration to someone who 'stole' someone else work:
    - without letting him know about it
    - without fixing his broken patch by himself when informed
    - without taking into account others comments (Andy Shevchenko about 
64 DMA mask)

So, thanks for fixing it (and thanks to Wang Qing for pushing in the 
right direction, even if a better communication would have been 
appreciated :) )


If you could just confirmed the 64 DMA mask cleanup, it would be great 
for me. I trust the one who stated that such code could be simplified 
and I've tried to audit code to confirm it by myself.
However, this pattern looks quite common in the kernel, so I'm still 
unsure about it :( !

CJ
