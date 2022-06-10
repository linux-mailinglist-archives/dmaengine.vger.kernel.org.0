Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2985465F7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiFJLrJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiFJLrJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 07:47:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271AA7938A
        for <dmaengine@vger.kernel.org>; Fri, 10 Jun 2022 04:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC225B83438
        for <dmaengine@vger.kernel.org>; Fri, 10 Jun 2022 11:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B7AC34114;
        Fri, 10 Jun 2022 11:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654861625;
        bh=8ZvD41YHm/Gb/yGz96jS9pDl8fWKTfvHLvvqvsmVUSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FinvaabFVUvtNXoM77c2jIgQuelHrYgfQ5v2w+36zB/x2Zwsc6k47/IYAVeilYorh
         AUBLWigFD/weRlRTKGEnmQF8yKmnYaHj7sosHMNsQhaGPOAdT3XWk2XbzaDk3erDLx
         oJS+TPT/I2q30dGvzZXhU7ed5iBOhZG/xT+IFvTjp4jiJOkbxYhzD1wcgd/KpzSBGZ
         KaH0JJWkjKetZAa6W3xS1OcsfKrv9PMa0GoTvOkBwK3hVZXBKER7JM4TWtMVK2pcPw
         r5JGn8po+34XTqKGeIx2wG1cJmRxNmixgUQJHrNZKvpFsz4kL1lY+yWjht0K7Qz3zB
         sAwKnIx6Ex6dg==
Date:   Fri, 10 Jun 2022 17:17:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] dmaengine: apple-admac: Fix print format
Message-ID: <YqMvNdmolngiUNmm@matsya>
References: <20220610043117.39337-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610043117.39337-1-vkoul@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-06-22, 10:01, Vinod Koul wrote:
> We get a warning (treated as error now)
> drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
> drivers/dma/apple-admac.c:209:26: error: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'long unsigned int' [-Werror=format=]
>   209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
> 
> Use %lx for priniting the flag

I have picked this one
> 
> Fixes: b127315d9a78 ("dmaengine: apple-admac: Add Apple ADMAC driver")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

added bot as report too

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/apple-admac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
> index 2425069c186d..c502f8c3aca7 100644
> --- a/drivers/dma/apple-admac.c
> +++ b/drivers/dma/apple-admac.c
> @@ -206,7 +206,7 @@ static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
>  	/* If happens means we have buggy code */
>  	WARN_ON_ONCE(addr + tx->period_len > tx->buf_end);
>  
> -	dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
> +	dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%lx\n",
>  		channo, &addr, tx->period_len, FLAG_DESC_NOTIFY);
>  
>  	writel_relaxed(addr,             ad->base + REG_DESC_WRITE(channo));
> -- 
> 2.34.3

-- 
~Vinod
