Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D6581368
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiGZMvI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiGZMvI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 08:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE17C1D321
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 05:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A83261537
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 12:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5640FC341D0;
        Tue, 26 Jul 2022 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658839866;
        bh=Ul2GNXixVAT6+wHU6Mi2l36gA68YAmxH+ivA5yyjiqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eR8kwhu4SGu22jujmwHiJHq92BpBfP+rfBDYjaq0abXz4hPHnzylX188XHE7tFhRX
         mXHDN3w1JVvFiF/b6JkxuSzLSLo/PQNZh23bQ3i+uxoG8xK2+qnXXRTsLX6QC8XFv/
         /X5GbL6N+uZpSIP387snuTdpKbkyA8z9k3ir2npYWBz5e1h7UWZA2f/EkC7xRlecqL
         ZvAyhwcrfm2vi7oi/U6ySC4oavZYW75yb1xbKuTdemCEzvJPaO1R2XdrvKM2a2I6rs
         WEax7Ll+UXkFyxUlzJTrwgwdr7gfFKG39MFfjqSsKCs2YgKBrO7FVVJlqP9J2y7Xbw
         n7xKNr7fWHEaA==
Date:   Tue, 26 Jul 2022 18:21:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dmaengine: sprd: Cleanup in .remove() after
 pm_runtime_get_sync() failed
Message-ID: <Yt/jNiMwWK+PgAD1@matsya>
References: <20220721204054.323602-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220721204054.323602-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-07-22, 22:40, Uwe Kleine-König wrote:
> It's not allowed to quit remove early without cleaning up completely.
> Otherwise this results in resource leaks that probably yield graver
> problems later. Here for example some tasklets might survive the lifetime
> of the sprd-dma device and access sdev which is freed after .remove()
> returns.
> 
> As none of the device freeing requires an active device, just ignore the
> return value of pm_runtime_get_sync().

Applied, thanks

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/dma/sprd-dma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 2138b80435ab..474d3ba8ec9f 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1237,11 +1237,8 @@ static int sprd_dma_remove(struct platform_device *pdev)
>  {
>  	struct sprd_dma_dev *sdev = platform_get_drvdata(pdev);
>  	struct sprd_dma_chn *c, *cn;
> -	int ret;
>  
> -	ret = pm_runtime_get_sync(&pdev->dev);
> -	if (ret < 0)
> -		return ret;
> +	pm_runtime_get_sync(&pdev->dev);
>  
>  	/* explicitly free the irq */
>  	if (sdev->irq > 0)
> 
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> -- 
> 2.36.1

-- 
~Vinod
