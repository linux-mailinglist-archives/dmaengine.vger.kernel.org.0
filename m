Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C435085F0
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiDTKdn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351834AbiDTKdm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:33:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA503F885;
        Wed, 20 Apr 2022 03:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DAAAB81E8D;
        Wed, 20 Apr 2022 10:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D3C385A1;
        Wed, 20 Apr 2022 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650450654;
        bh=3hsA9FdNCm/ir4JpBGaglXUVYAiq1AFFt+T3cgSWS6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG05t+vL/kAmVNYRYtQXVGzFLv/YahEg3VtFGl95mjORL/WWP/V2G5ce+1T8mEc9+
         l1hsqicRaXaLE17+qhRkdklPIcsBVNcTYU1Wn+nF6zUuLVxr7PWSPIxKesUK1X5mbW
         S5l2ChrHPND4PFfQFuoZYpRroeHXvr8LmxwYy3xzFuR7rMJ3PkYARIXAIKSCi4kVVN
         msdnCKjaczV2Y0okUSNL3m33S/YkYk1QWG2dbPShxngPbV13kc2u7j5dkS/Ke4xQyW
         LgKndX/LXCRGj4Fil2Zuki5Z51+hm4tnuwB//s+J0y572GNPzq+wSTqIhahlnKVf5a
         OF6VH8Q5OMCIQ==
Date:   Wed, 20 Apr 2022 16:00:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yunbo Yu <yuyunbo519@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mv_xor_v2: move spin_lock_bh to spin_lock
Message-ID: <Yl/g2uuBrvHXDxZ9@matsya>
References: <20220418141940.1241482-1-yuyunbo519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418141940.1241482-1-yuyunbo519@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-04-22, 22:19, Yunbo Yu wrote:
> It is unnecessary to call spin_lock_bh() for that you are already in a

if you are

> taselet.

tasklet

> 
> Signed-off-by: Yunbo Yu <yuyunbo519@gmail.com>
> ---
>  drivers/dma/mv_xor_v2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
> index 9c8b4084ba2f..f10b29034da1 100644
> --- a/drivers/dma/mv_xor_v2.c
> +++ b/drivers/dma/mv_xor_v2.c
> @@ -591,14 +591,14 @@ static void mv_xor_v2_tasklet(struct tasklet_struct *t)
>  		dma_run_dependencies(&next_pending_sw_desc->async_tx);
>  
>  		/* Lock the channel */
> -		spin_lock_bh(&xor_dev->lock);
> +		spin_lock(&xor_dev->lock);
>  
>  		/* add the SW descriptor to the free descriptors list */
>  		list_add(&next_pending_sw_desc->free_list,
>  			 &xor_dev->free_sw_desc);
>  
>  		/* Release the channel */
> -		spin_unlock_bh(&xor_dev->lock);
> +		spin_unlock(&xor_dev->lock);
>  
>  		/* increment the next descriptor */
>  		pending_ptr++;
> -- 
> 2.25.1

-- 
~Vinod
