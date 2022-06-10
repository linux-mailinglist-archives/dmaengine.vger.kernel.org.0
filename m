Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF15465F5
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbiFJLqX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 07:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiFJLqW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 07:46:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD38A42A09;
        Fri, 10 Jun 2022 04:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63EE2B834C4;
        Fri, 10 Jun 2022 11:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6415FC34114;
        Fri, 10 Jun 2022 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654861579;
        bh=7EK7ta1CkGJt773OIwydlghYrh/L9WFuMuPQS/2Y14s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsOjQGai86yOkS6mIA51g/YFuQDFIaHXM2D7o6CPg0DnsX50uCLTtOfVsQWhAdZK3
         CcAZkOiNngSEiC/fsCTvXAqOrsRgD5rxxfp/COhW1SpwjPtjAxtkFig8TSGGD0fw+7
         SIgDAQuAe/ckZmXiL643RpeEf1xzUfYZOa7Nww8s5oWns3BJfKSPUqOtHHu5FsKJYI
         ova3/B/gC3hG2dXl90zTBFaXQ872eB2Bgo9+ow0+0eRmC1gHr2h4reFY12nQ6Jsq4U
         EgW1XtnGGyBFo+jAwcJ267jQPKz89E0+1KJsQWea3oQEJAZikCGrst2BsjdDApmjZ0
         r29NwKppHnhYw==
Date:   Fri, 10 Jun 2022 17:16:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] dmaengine: apple-admac: Fix compile warning
Message-ID: <YqMvBhoMRuLcO0lN@matsya>
References: <20220609184301.8242-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609184301.8242-1-povik+lin@cutebit.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-06-22, 20:43, Martin Povišer wrote:
> Fix a warning of bad format specifier:

Patch title should describe the change and not the effect..
> 
>   drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
>   drivers/dma/apple-admac.c:209:26: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'long unsigned int' [-Wformat=]
>       209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
> 
> Follow-up to the recent ADMAC series, feel free to squash:
> https://lore.kernel.org/asahi/20220531213615.7822-1-povik+lin@cutebit.org/T/#t
> 
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
> 2.33.0

-- 
~Vinod
