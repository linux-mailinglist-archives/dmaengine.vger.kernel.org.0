Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9977D713323
	for <lists+dmaengine@lfdr.de>; Sat, 27 May 2023 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjE0HoG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 May 2023 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjE0Hnz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 May 2023 03:43:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A709E4F
        for <dmaengine@vger.kernel.org>; Sat, 27 May 2023 00:43:51 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2oabqe6Y9wiD92oabqxMKz; Sat, 27 May 2023 09:43:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685173430;
        bh=uyWOW8D3AJ7mCDV73zgAucJmFUmSlFpt34Ibvt6so7E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IyYZWLsKeM7pci4vGAotaHENz1XD92Y+YzWdHMd5zMr2yMgsopzM71wMcgKP8YPa8
         W0uZlB9NOJ4W6ZoERcALcmwnDOWhwTNtyMIU1HCdxhnaBy1AGBTug1qfkEuUa21Jl0
         9wIVN3y4IBL2ZmCNXQQZ9UXyH4SCj+um104csw8OMX1MNi2rUV88ccfohrzVMFoS2S
         8g+Pn3S3yHAwTLANQ/a48bDVHmAQczSgwNz+hhuhSotYD6ktyXsEU97xnVMD0/HJPV
         9pf5JwbDVRGjEwmD1n2lsP4rOCXh0BgBVjW6tBqJ1QLEeJob5YTk0C+lDEb2hDAz+E
         mz1hH2EYNBUIQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 May 2023 09:43:50 +0200
X-ME-IP: 86.243.2.178
Message-ID: <963bad8f-11d7-ce02-ad01-d925a4ac8771@wanadoo.fr>
Date:   Sat, 27 May 2023 09:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] When 'mcf_edma' is allocated, some space is allocated for
 a flexible array at the end of the struct. 'chans' item are allocated, that
 is to say 'pdata->dma_channels'.
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <f55d9154b7c600828f6fad3ea5fa791a5f17b9a4.1685172449.git.christophe.jaillet@wanadoo.fr>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <f55d9154b7c600828f6fad3ea5fa791a5f17b9a4.1685172449.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 27/05/2023 à 09:32, Christophe JAILLET a écrit :
> Then, this number of item is stored in 'mcf_edma->n_chans'.
> 
> A few lines later, if 'mcf_edma->n_chans' is 0, then a default value of 64
> is set.
> 
> This ends to no space allocated by devm_kzalloc() because chans was 0, but
> 64 items are read and/or written in some not allocated memory.
> 
> Change the logic to define a default value before allocating the memory.
> 
> Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> If I'm correct, then:
> 
>     - the default value is hard-coded as 64. There is also a
>          #define EDMA_CHANNELS 64
>       which maybe could be used, or renamed as EDMA_DEFAULT_CHANNELS
> 
>     - mcf_edma_err_handler() looks bogus, because it considers that
>       mcf_edma->chans has EDMA_CHANNELS items.
>       I guess that something related to mcf_edma->n_chans is what is
>       expected, but how should this be done?
> 
> Maybe, the EDMA_CHANNELS value should be used all the time?
> Maybe, the number of chans should be limited to EDMA_CHANNELS?
> Maybe, the number of chans should be at least EDMA_CHANNELS?
> 
> Maybe, maybe, maybe, but me, I don't know :(
> 
> All I know is that this patch compiles :)
> and that it can gives Dan an idea for smatch for checking access to un-allocated
> memory related to flexible array :)
> ---
>   drivers/dma/mcf-edma.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 

NAK, subject line missing.

A better V2 has been sent.

