Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58264563819
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiGAQj1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiGAQj1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 12:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8821E28E0A;
        Fri,  1 Jul 2022 09:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23130625B8;
        Fri,  1 Jul 2022 16:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80F4C3411E;
        Fri,  1 Jul 2022 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693565;
        bh=5dv6pNQwTsKSW23B5WZKeacfI6JiNPybRZTNk2LY2Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpTDUp8aSk+6UdxNAIN6FXp6zlWYIPap4hpx9m2aPGdU6nHvElsLj+vCRqCRQS9rn
         ooMeZp5wkbzD+l4fkDbxjlGJCpA2xC75aS2+o0ddhBunGwGNVaE9Z2/VBawpKvECKA
         XKmwfqKwKfeDcvW+q02HEtrb3C4pqKHBuakgnp0nnYf9qEQgI9qkitJHayZvXofbnn
         9yidD6T4zx5c0ZJB+F+HelRdNuz7ogMsNYaoS7c76NWH1bul7L9Hv2i2N933X4dolm
         2NfilV5YogqZRtuCdxBOYYF8673e9y39rJudx7OZjCIo/5NCPvzID7leAkWEbDmdnX
         rTqkj6u4csg2g==
Date:   Fri, 1 Jul 2022 22:09:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: remove redundant assignment to
 pointer last_sg
Message-ID: <Yr8jObY3T/9tsQfh@matsya>
References: <20220614184759.164379-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614184759.164379-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-06-22, 19:47, Colin Ian King wrote:
> The pointer last_sg is being assigned a value at the start of a loop
> however it is never read and is being re-assigned later on in both
> brances of an if-statement. The assignment is redundant and can be
> removed.

Applied, thanks

> 
> Cleans up clang scan-build warning:
> drivers/dma/fsl-edma-common.c:563:3: warning: Value stored to 'last_sg'
> is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/dma/fsl-edma-common.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 3ae05d1446a5..a06a1575a2a5 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -559,9 +559,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  	}
>  
>  	for_each_sg(sgl, sg, sg_len, i) {
> -		/* get next sg's physical address */
> -		last_sg = fsl_desc->tcd[(i + 1) % sg_len].ptcd;
> -
>  		if (direction == DMA_MEM_TO_DEV) {
>  			src_addr = sg_dma_address(sg);
>  			dst_addr = fsl_chan->dma_dev_addr;
> -- 
> 2.35.3

-- 
~Vinod
