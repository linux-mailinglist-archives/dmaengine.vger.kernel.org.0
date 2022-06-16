Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099D654E24A
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 15:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiFPNpB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377137AbiFPNpA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 09:45:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB2D2D1E0;
        Thu, 16 Jun 2022 06:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBA8CB82288;
        Thu, 16 Jun 2022 13:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46393C34114;
        Thu, 16 Jun 2022 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655387095;
        bh=oU44dZP+HgtSihUBjOfeusehgtG+6mtRqoSPwF9dv1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRt6em7TjtgRkVf1zVSHyvL7E0gmQsvDu9l2Aalx9A396PguTD50CswU9pBm9GtUG
         dHAImetJgpeqHb+1u6BGMRco3NV+a6bUo2MZJEPGJz/Ed9PI1Ilipm9QBT79CPPBuH
         doCBBjnlxlOQmZX5SM9sKz2Nai692wYP+oZVuNgN6HFsilBfZMZ3IgfA/j6hZ2ROSY
         FzpsupQ5jaXUGh3WrhT+qMPXEJtVLmPV/AOPQgIG3L+YLZx40+O4VbJN3/9E7GlEuE
         pcDJgFNSH2nC4CAhfYh14GiknqQY1VKGgx4cSi7dq/z62ag7FZCvQp8D/G3/OCnOhu
         VrF10LzJez5Kg==
Date:   Thu, 16 Jun 2022 06:44:54 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: apple-admac: Fix build on
 32-bit/non-LPAE platforms
Message-ID: <Yqsz1tqmy4Mt8oOE@matsya>
References: <20220614074915.1443629-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220614074915.1443629-1-geert@linux-m68k.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Geert,

On 14-06-22, 09:49, Geert Uytterhoeven wrote:
> If CONFIG_PHYS_ADDR_T_64BIT is not set:
> 
>     drivers/dma/apple-admac.c: In function ‘admac_cyclic_write_one_desc’:
>     drivers/dma/apple-admac.c:213:22: error: right shift count >= width of type [-Werror=shift-count-overflow]
>       213 |  writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
>           |                      ^~
> 
> Fix this by using the {low,upp}er_32_bits() helper macros to obtain the
> address parts.

This changelog is good, but patch title needs update. We should never
reflect the effect of change, but describe the change in patch...

Maybe "dmaengine: apple-admac: use {lower|upper}_32_bits() for
extracting address" would be a better patch title...

Thanks

> 
> Reported-by: noreply@ellerman.id.au
> Fixes: b127315d9a78c011 ("dmaengine: apple-admac: Add Apple ADMAC driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/dma/apple-admac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
> index c502f8c3aca79be1..d1f74a3aa999d773 100644
> --- a/drivers/dma/apple-admac.c
> +++ b/drivers/dma/apple-admac.c
> @@ -209,10 +209,10 @@ static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
>  	dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%lx\n",
>  		channo, &addr, tx->period_len, FLAG_DESC_NOTIFY);
>  
> -	writel_relaxed(addr,             ad->base + REG_DESC_WRITE(channo));
> -	writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
> -	writel_relaxed(tx->period_len,   ad->base + REG_DESC_WRITE(channo));
> -	writel_relaxed(FLAG_DESC_NOTIFY, ad->base + REG_DESC_WRITE(channo));
> +	writel_relaxed(lower_32_bits(addr), ad->base + REG_DESC_WRITE(channo));
> +	writel_relaxed(upper_32_bits(addr), ad->base + REG_DESC_WRITE(channo));
> +	writel_relaxed(tx->period_len,      ad->base + REG_DESC_WRITE(channo));
> +	writel_relaxed(FLAG_DESC_NOTIFY,    ad->base + REG_DESC_WRITE(channo));
>  
>  	tx->submitted_pos += tx->period_len;
>  	tx->submitted_pos %= 2 * tx->buf_len;
> -- 
> 2.25.1

-- 
~Vinod
