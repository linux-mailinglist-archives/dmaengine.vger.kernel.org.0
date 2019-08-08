Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C1486303
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfHHNWw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 09:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfHHNWw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 09:22:52 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980D12171F;
        Thu,  8 Aug 2019 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565270572;
        bh=gRtTbqNQGMilfVLZgzVIN2dGKouuTcp6PKE2RGisMZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfuZkLufkWM94Ez0D0cbwNQHrIlzQRthIovDrrS22TQNSXx90SmYMQPaougEPvAZs
         FBNvUm6i4QzjYxkbxH8VZM483i4Treskd4OiNBrPWnXu/yLeESS+GlXy2Izt4fe2GY
         q5m4EPWA38HRMBXNmcdoZDHknDQ74mRKzF4qRegk=
Date:   Thu, 8 Aug 2019 18:51:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: mv_xor: Fix a possible null-pointer dereference in
 mv_xor_prep_dma_xor()
Message-ID: <20190808132140.GZ12733@vkoul-mobl.Dlink>
References: <20190727093027.11781-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727093027.11781-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-07-19, 17:30, Jia-Ju Bai wrote:
> In mv_xor_prep_dma_xor(), there is an if statement on line 577 to check
> whether sw_desc is NULL:
>     if (sw_desc)
> 
> When sw_desc is NULL, it is used on line 594:
>     dev_dbg(..., sw_desc, &sw_desc->async_tx);
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, sw_desc is checked before being used.
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/dma/mv_xor.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 0ac8e7b34e12..08c0b2a9eb32 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -589,9 +589,11 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
>  		}
>  	}
>  
> -	dev_dbg(mv_chan_to_devp(mv_chan),
> -		"%s sw_desc %p async_tx %p \n",
> -		__func__, sw_desc, &sw_desc->async_tx);
> +	if (sw_desc) {
> +		dev_dbg(mv_chan_to_devp(mv_chan),
> +			"%s sw_desc %p async_tx %p \n",
> +			__func__, sw_desc, &sw_desc->async_tx);
> +	}

why not move this into the preceeding if condition?

>  	return sw_desc ? &sw_desc->async_tx : NULL;
>  }
>  
> -- 
> 2.17.0

-- 
~Vinod
