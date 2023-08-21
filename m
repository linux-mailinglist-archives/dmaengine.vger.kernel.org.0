Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE778234C
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 07:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjHUFsC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 01:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHUFsB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 01:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB7A7
        for <dmaengine@vger.kernel.org>; Sun, 20 Aug 2023 22:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAFB61558
        for <dmaengine@vger.kernel.org>; Mon, 21 Aug 2023 05:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FD2C433C8;
        Mon, 21 Aug 2023 05:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692596879;
        bh=FiDWPqPkrUvjIW/v6AfAR36jrAn1fppBbb5qffYcS1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk6cC52ebAUTo7msHpaXpnSQZGtdzk/W8IzOw8/WIlqnaJwzD6PA0sV+BbadMaLxz
         2wj5JCV30m6eUWuGXiEKRbFXJX+mWZUN8ZRnUztxA4j5f7FTLj83xqYrfDeCPeRyeN
         GTUR82LUF2QoZj58xL+n3kQyyzTsdY8u45ABs44URYWIMxVsHCwtyJx2M0LobDhSXm
         zWZMj/Z/6wQZi6vfkpR7pAeK9lSLQFb8u3vVE3lhTKgIVKvxElX9VQR4d+LFhbh3Dr
         XTqZLSm8xDutPBzWox/JaHOU7inLuwvP/GfRdF+IoHAcf6tzW/eWOaCr2M3h9Ax296
         4G1atdCj5iu0g==
Date:   Mon, 21 Aug 2023 11:17:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     liwei391@huawei.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH -next 1/2] dmaengine: fsl-edma: use struct_size() helper
Message-ID: <ZOL6ior65updLbea@matsya>
References: <20230816020355.3002617-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816020355.3002617-1-liaoyu15@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-08-23, 10:03, Yu Liao wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/dma/fsl-edma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
> index e40769666e39..caca3566ba82 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -270,7 +270,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct fsl_edma_engine *fsl_edma;
>  	const struct fsl_edma_drvdata *drvdata = NULL;
> -	struct fsl_edma_chan *fsl_chan;
>  	struct edma_regs *regs;
>  	int len, chans;
>  	int ret, i;
> @@ -288,7 +287,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	len = sizeof(*fsl_edma) + sizeof(*fsl_chan) * chans;
> +	len = struct_size(fsl_edma, chans, chans);
>  	fsl_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);

Drop len and use struct_size() here...

>  	if (!fsl_edma)
>  		return -ENOMEM;
> -- 
> 2.25.1

-- 
~Vinod
