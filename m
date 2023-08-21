Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3293C78234D
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjHUFsf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 01:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjHUFse (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 01:48:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4AA8
        for <dmaengine@vger.kernel.org>; Sun, 20 Aug 2023 22:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EE97629F2
        for <dmaengine@vger.kernel.org>; Mon, 21 Aug 2023 05:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E973EC433C9;
        Mon, 21 Aug 2023 05:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692596912;
        bh=L9M/iN/63EmEmcGFtQpDKNoSqXHBaYIN9Kt5YNZqQoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZF5PGpsI+rn8wgP1sLgvUvOATi49jgZLFX7yK3Vb0o+l6eZJDkXLDYi8RwEDNH2bv
         yqfjFVYH/AwRveZxPqZJpq2nwm30JMuNVVuxmen7+ixdQjoJJdFAqm8KmVYCuhlYBf
         XF+lUyu416WDG+zvxUORcj8bYcY5ZA+FzKTekCpz1ocwg/2uHN9pNRarI/hAjBYbTb
         sN4C0jXO8rREpqquLHUjVd8XeWb75UXMknCZAhiTLcWq6Z+HQCqd+tpEhaJlnoyWtq
         Pb1TfOLTDH9ihjzvEn0QXc0GFSxyQFm6VhRjqX78n/JnECkPyhmC8lly6/YZUFMGuM
         MnVav31agUFAA==
Date:   Mon, 21 Aug 2023 11:18:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     liwei391@huawei.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH -next 2/2] dmaengine: mcf-edma: use struct_size() helper
Message-ID: <ZOL6qokJlH/W5RNo@matsya>
References: <20230816020355.3002617-1-liaoyu15@huawei.com>
 <20230816020355.3002617-2-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816020355.3002617-2-liaoyu15@huawei.com>
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

Duplicate to 923b13838892 ("dmaengine: mcf-edma: Use struct_size()")

> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/dma/mcf-edma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
> index 9413fad08a60..444b5c1bd7dc 100644
> --- a/drivers/dma/mcf-edma.c
> +++ b/drivers/dma/mcf-edma.c
> @@ -180,7 +180,6 @@ static int mcf_edma_probe(struct platform_device *pdev)
>  {
>  	struct mcf_edma_platform_data *pdata;
>  	struct fsl_edma_engine *mcf_edma;
> -	struct fsl_edma_chan *mcf_chan;
>  	struct edma_regs *regs;
>  	int ret, i, len, chans;
>  
> @@ -197,7 +196,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
>  		chans = pdata->dma_channels;
>  	}
>  
> -	len = sizeof(*mcf_edma) + sizeof(*mcf_chan) * chans;
> +	len = struct_size(mcf_edma, chans, chans);
>  	mcf_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
>  	if (!mcf_edma)
>  		return -ENOMEM;
> -- 
> 2.25.1

-- 
~Vinod
