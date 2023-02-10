Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD7691833
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 06:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBJF41 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 00:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjBJF4X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 00:56:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE676F20C
        for <dmaengine@vger.kernel.org>; Thu,  9 Feb 2023 21:56:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A88E61CB7
        for <dmaengine@vger.kernel.org>; Fri, 10 Feb 2023 05:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597D0C433D2;
        Fri, 10 Feb 2023 05:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676008563;
        bh=w/s7swZsCI4cAbs/7EAKhtoA7ox4qNU4i99/6vXe49I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6e2Y60mjZySk7pxOE+MmlyRER84zSBSFj9qzVKrlgES43mFXZgThChWNaWWv3qY4
         UvKYQsIz5QcIy7refRkUSCP33eWzvLu04z4JVuGpNkIjFaknDGsxJ3KztuNbko5Zvn
         Qx0DeWZ3tfh612LSQl2lwnHgrKryRhCIeVGuedEp9UUrz9PybzNrABdhYzSFcgp5IV
         FmRXDE4w6OqRqRdV2FmiQn8f0OLi50IP12w3roFcZxJYAvs+Srr9I+gp6+byejCqLd
         TPk0OeC8GCs1zKXsDWFF7F9JX621k82FUhz/FLvvXx8YImr5sflCHB4ftJVWB3fI9a
         JOXfcdhPRui5Q==
Date:   Fri, 10 Feb 2023 11:25:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Eric Pilmore <epilmore@gigaio.com>
Cc:     "Mehta, Sanju" <Sanju.Mehta@amd.com>, dmaengine@vger.kernel.org
Subject: Re: [RESEND PATCH] dmaengine: ptdma: check for null desc before
 calling pt_cmd_callback
Message-ID: <Y+Xcbip4dO4qSP4H@matsya>
References: <CAOQPn8tpjo5Jwz8jGi0JfTQd-hF+VS7N90T=GJpjG3wj5x8UHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQPn8tpjo5Jwz8jGi0JfTQd-hF+VS7N90T=GJpjG3wj5x8UHw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-02-23, 21:37, Eric Pilmore wrote:
> From: Eric Pilmore <epilmore@gigaio.com>
> 
> Resolves a panic that can occur on AMD systems, typically during host
> shutdown, after the PTDMA driver had been exercised. The issue was
> the pt_issue_pending() function is mistakenly assuming that there will
> be at least one descriptor in the Submitted queue when the function
> is called. However, it is possible that both the Submitted and Issued
> queues could be empty, which could result in pt_cmd_callback() being
> mistakenly called with a NULL pointer.
> Ref: Bugzilla Bug 216856.
> 
> Fixes: 6fa7e0e836e2 ("dmaengine: ptdma: fix concurrency issue with
> multiple dma transfer")

This should not be split two two lines!

> Signed-off-by: Eric Pilmore <epilmore@gigaio.com>
> ---
>  drivers/dma/ptdma/ptdma-dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c
> b/drivers/dma/ptdma/ptdma-dmaengine.c
> index cc22d162ce25..1aa65e5de0f3 100644
> --- a/drivers/dma/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
> @@ -254,7 +254,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>         spin_unlock_irqrestore(&chan->vc.lock, flags);
> 
>         /* If there was nothing active, start processing */
> -       if (engine_is_idle)
> +       if (engine_is_idle && desc)

Please run checkpatch before sending patches

WARNING: please, no spaces at the start of a line
#40: FILE: drivers/dma/ptdma/ptdma-dmaengine.c:257:
+       if (engine_is_idle && desc)$

WARNING: suspect code indent for conditional statements (7, 15)
#40: FILE: drivers/dma/ptdma/ptdma-dmaengine.c:257:
+       if (engine_is_idle && desc)
                pt_cmd_callback(desc, 0);

>                 pt_cmd_callback(desc, 0);
>  }
> 
> --
> 2.38.1

-- 
~Vinod
