Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6F567DE6
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiGFFhJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGFFhI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2221832;
        Tue,  5 Jul 2022 22:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D920E61CAB;
        Wed,  6 Jul 2022 05:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAC9C3411C;
        Wed,  6 Jul 2022 05:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657085827;
        bh=W+R4R0iQJdL3kEg76byrlTJL0N4G8JVknNgmrsZ/mHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZswyHIg2akxVQy6O2ZiOIZJJyCRgK20jSgNrBaNY6jcZjHrtPk2d8khNEDQKe+An8
         jhOOsdOslbBMRuzeXDnNkJOb90byMOPPowf45SKF/e3tBBhyfFkTn/bW9zvazWpEwa
         uIUa7hglq33oJWPY35B9VqJuET6i2o+0rBpPcbj0OiQrT287dcYBHkC7IQQ1tRfxxa
         v7gaWt9GR75/A+ZG4H0AbFN9KrFXyfo4I/qK47Xdlv/XHL0Fx9CNUiFeFiU95sTzE3
         fMM22/IT1NWCT5j8OtlGHG5u6vOX9Kc3VxMUY6+B/+SILX2ntdTLM8YO69YyQW/R4L
         AB0qe9rAxRbkA==
Date:   Wed, 6 Jul 2022 11:07:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     olivierdautricourt@gmail.com, sr@denx.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] dmaengine: altera: Fix kernel-doc
Message-ID: <YsUff/8iadvI0R4N@matsya>
References: <20220525093313.52749-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525093313.52749-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-05-22, 17:33, Jiapeng Chong wrote:
> Fix the following W=1 kernel warnings:
> 
> drivers/dma/altera-msgdma.c:927: warning: expecting prototype for
> msgdma_dma_remove(). Prototype was for msgdma_remove() instead.

Commit title should describe the change and not the effect, pls revise

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/dma/altera-msgdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 6f56dfd375e3..bdaac5d62a04 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -918,7 +918,7 @@ static int msgdma_probe(struct platform_device *pdev)
>  }
>  
>  /**
> - * msgdma_dma_remove - Driver remove function
> + * msgdma_remove() - Driver remove function
>   * @pdev: Pointer to the platform_device structure
>   *
>   * Return: Always '0'
> -- 
> 2.20.1.7.g153144c

-- 
~Vinod
