Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254EB5085EB
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349339AbiDTKc7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiDTKc6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA5C3F885;
        Wed, 20 Apr 2022 03:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8F86B81E8D;
        Wed, 20 Apr 2022 10:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE298C385A0;
        Wed, 20 Apr 2022 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650450609;
        bh=kEDDxF17hrgH58OVXjuIFepbkYbLgvtx7CEHRjDCwCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuN7WrdOgPrnpmS28LNzTXFdP0/6JFpbRoUr8/TS88N1o8Cdkyx4z17A2P6Y6NyAN
         5mZ6/kGu36j0rAd+C7uf3DXMWLq6LYjta+6Mz8wX7AhgC+8qwq/yOgI36IFJdvOxGK
         fgiox1MxAGqv2hcK4BuHaeXsS05hug5qZJm/sCD+ZQr2B/4vyDQRTgDEw89ckih+sX
         asjureABj9XGif273HwHcxBenmh2LvafbGcBD6yf2Gf5gBmbSE1Ttb5b7UmC2996YX
         aIXXfFeH4Bi6M9/3FIUVsPQb7OUe2glfii1bl/dbBfg7X1YkdyCt/aI0O+J6OpFGON
         ksxKZ1CFX4e9g==
Date:   Wed, 20 Apr 2022 16:00:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yunbo Yu <yuyunbo519@gmail.com>
Cc:     logang@deltatee.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: plx_dma: Move spin_lock_bh() to spin_lock()
Message-ID: <Yl/grDCcX0/SRusw@matsya>
References: <20220418142021.1241558-1-yuyunbo519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418142021.1241558-1-yuyunbo519@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-04-22, 22:20, Yunbo Yu wrote:
> It is unnecessary to call spin_lock_bh() for you are already in a tasklet.

call spin_lock_bh() if you are already in a ..


With that fixed, applied. Thanks
> 
> Signed-off-by: Yunbo Yu <yuyunbo519@gmail.com>
> ---
>  drivers/dma/plx_dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 1ffcb5ca9788..12725fa1655f 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -137,7 +137,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
>  	struct plx_dma_desc *desc;
>  	u32 flags;
>  
> -	spin_lock_bh(&plxdev->ring_lock);
> +	spin_lock(&plxdev->ring_lock);
>  
>  	while (plxdev->tail != plxdev->head) {
>  		desc = plx_dma_get_desc(plxdev, plxdev->tail);
> @@ -165,7 +165,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
>  		plxdev->tail++;
>  	}
>  
> -	spin_unlock_bh(&plxdev->ring_lock);
> +	spin_unlock(&plxdev->ring_lock);
>  }
>  
>  static void plx_dma_abort_desc(struct plx_dma_dev *plxdev)
> -- 
> 2.25.1

-- 
~Vinod
