Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE76575AC
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiL1LMB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiL1LL7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:11:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5562FB66;
        Wed, 28 Dec 2022 03:11:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E69E0B81633;
        Wed, 28 Dec 2022 11:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB4BC433D2;
        Wed, 28 Dec 2022 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672225915;
        bh=2NN9aOnhE0g5CPXUvtIdD6kBa8yBbezuVcM869SJkok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSjg8W1HNmTIpEIFfujXpWBj6i5pumTE1y+o6U1FUf+zHekrPia7cAUrd4u4CYfp2
         CZka3Kndf2zwdi3BGwJOoTW2eyG7xVc+ryolNZYs4FL6FBMLnboOXPHpGiX6dDzj4q
         av/XLQmmMM10hwtW6yt42PoJnHbQpnczjx0HTvaksBBQkrg5TaV7tqNMULIdwhP15L
         4WsHvlgkxQ6L8ICIMgfQILorwIkSyxNaqD7Y6vl3cWJxuBBVEaGYyiNtgs4KLlXddB
         r2AGxsNRT1ReHiWrkvRIa/94bsvKdDLyo51AhksOCFjUytiV6tT2XY2ob/tf/doOPg
         axE+kX/trQ5Uw==
Date:   Wed, 28 Dec 2022 16:41:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: HISI_DMA should depend on ARCH_HISI
Message-ID: <Y6wkd93CvGW/iOQR@matsya>
References: <363a1816d36cd3cf604d88ec90f97c75f604de64.1669044190.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363a1816d36cd3cf604d88ec90f97c75f604de64.1669044190.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-11-22, 16:23, Geert Uytterhoeven wrote:
> The HiSilicon DMA Engine is only present on HiSilicon SoCs.  Hence add a
> dependency on ARCH_HISI, to prevent asking the user about this driver
> when configuring a kernel without HiSilicon SoC support.
> 
> Fixes: e9f08b65250d73ab ("dmaengine: hisilicon: Add Kunpeng DMA engine support")

My script warns of bad tag, so I looked up.. this one uses 16 chars of
SHA1... checkpatch also complains: Please use correct Fixes: style
'Fixes: <12 chars of sha1>...

I guess lots of parts assume that it shall be _exactly_ 12!

I have applied it ..

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index b9d54f20812f794b..67323afe9fcad137 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -245,7 +245,7 @@ config FSL_RAID
>  
>  config HISI_DMA
>  	tristate "HiSilicon DMA Engine support"
> -	depends on ARM64 || COMPILE_TEST
> +	depends on ARCH_HISI || COMPILE_TEST
>  	depends on PCI_MSI
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
> -- 
> 2.25.1

-- 
~Vinod
