Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A0F6575B8
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiL1LQc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1LQ3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:16:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F3C5F;
        Wed, 28 Dec 2022 03:16:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EB84CE1273;
        Wed, 28 Dec 2022 11:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D691DC433EF;
        Wed, 28 Dec 2022 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672226185;
        bh=VNwuy44KWmvFMmOeYqiE+2eXFkmQ2aZl6ileRi7/Z64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jrt49MtPW6FiGtUoT6cTzQl02L+mLSyb60od5HcbcmjVHolblEwTYD4dtFJg7E8j4
         sY/7gl4SB6WaqYAoyZiBj79xC4PO6Q9BERqpZ7qTC556tFAkmoPam5gjqyDjIstloF
         NF4XOc0zLRoAURpYRoLwOMhAsc1mvlZTypKxloA0RLLZSCNP/qHism8/b8dYzkVlL6
         1LBSwVn4B+vUMHgqDBY0osKFCTL0CpqOj2nWIQtcvZ/HEgXtXa3VqBPzLi1I68G3bW
         YhAxuDUrmk4/VCXe2LPU5k2AoUkvgWMv/leJMUU2pRQJuDMCFAovxsKsTSAfPHORcZ
         GBgic2iEAYvDg==
Date:   Wed, 28 Dec 2022 16:46:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nicolas Frayer <nfrayer@baylibre.com>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        glaroque@baylibre.com
Subject: Re: [PATCH v3] dmaengine: ti: k3-udma: Deferring probe when
 soc_device_match() returns NULL
Message-ID: <Y6wlhfdDdm+XAsuH@matsya>
References: <20221117184406.292416-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117184406.292416-1-nfrayer@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-11-22, 19:44, Nicolas Frayer wrote:
> When the k3 socinfo driver is built as a module, there is a possibility
> that it will probe after the k3 udma driver and the later returns -ENODEV.
> By deferring the k3 udma probe we allow the k3 socinfo to probe and
> register the soc_device_attribute structure needed by the k3 udma driver.
> Removed the dev_err() message as well as it's deferring and not failing.

lgtm, but need rebase as I already picked commit 3f58e10615f3 dmaengine: ti:
k3-udma: Add support for BCDMA CSI RX

> 
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> ---
> v1->v2:
> Extracted this patch from the following series:
> https://lore.kernel.org/all/20221108181144.433087-1-nfrayer@baylibre.com/
> 
> v2->v3:
> Removed the dev_err() message
> 
>  drivers/dma/ti/k3-udma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index ce8b80bb34d7..ca1512eb9910 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5271,10 +5271,10 @@ static int udma_probe(struct platform_device *pdev)
>  	ud->match_data = match->data;
>  
>  	soc = soc_device_match(k3_soc_devices);
> -	if (!soc) {
> -		dev_err(dev, "No compatible SoC found\n");
> -		return -ENODEV;
> -	}
> +
> +	if (!soc)
> +		return -EPROBE_DEFER;
> +
>  	ud->soc_data = soc->data;
>  
>  	ret = udma_get_mmrs(pdev, ud);
> -- 
> 2.25.1

-- 
~Vinod
