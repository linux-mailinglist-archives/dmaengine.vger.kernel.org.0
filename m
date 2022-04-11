Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB94FBE4D
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbiDKOH0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346983AbiDKOHW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 10:07:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E1233344;
        Mon, 11 Apr 2022 07:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A2F3B81120;
        Mon, 11 Apr 2022 14:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E2EC385A3;
        Mon, 11 Apr 2022 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649685903;
        bh=+XpI86P0PrVXp+Ymcaty6n+WgsUSCnA/kTGjqA5RlnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aF0fknmhr+5+irtIp2HMQm6GPIieF3rwwe8c6mgWsfvqJPYrLQlDG/OnBqGxqTd2D
         k1EAZXN0PHXAcpzj0FucAVpxobgMWTbbN4+EeVdaniE4q3wa3ZRWs9lfb3L+388UyK
         XGIeBmXDlEQSXekCIJcxYXzgZmDFVgEGOB9Jowyq+a1ig9Q4MyC6088SJtDAHXxRav
         3kfWdytkeJGsKC4A4NOd5yeaGS7QRb+zO6Gt1b6o4NGtq39O0oy0iimRWX2x1Y9iCU
         AzrgEZ+rQ9YQffOx5NrBFVCSmMHQWfiyPPeGbgMuoeEQLYdKwjHZ1mryADzgt2n7wU
         g+vVHiVtmC0QA==
Date:   Mon, 11 Apr 2022 19:34:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl08x: remove unneeded variable: "retval".
 Return "NULL"
Message-ID: <YlQ1i3DFqoFFFszO@matsya>
References: <1647512562-18246-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647512562-18246-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-03-22, 18:22, Haowen Bai wrote:
> Unneeded variable: "retval". Return "NULL" , so we have to make code clear.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/dma/amba-pl08x.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index a24882b..c70552a 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -1538,9 +1538,7 @@ static void pl08x_free_chan_resources(struct dma_chan *chan)
>  static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
>  		struct dma_chan *chan, unsigned long flags)
>  {
> -	struct dma_async_tx_descriptor *retval = NULL;
> -
> -	return retval;
> +	return NULL;

better way, drop the function?

>  }
>  
>  /*
> -- 
> 2.7.4

-- 
~Vinod
