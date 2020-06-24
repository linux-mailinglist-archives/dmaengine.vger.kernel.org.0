Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E459D206DF5
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbgFXHlq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388375AbgFXHlp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:41:45 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 436732073E;
        Wed, 24 Jun 2020 07:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592984505;
        bh=rFvb/C1vB4fTHTydMAiUGBkFrnes0labacSjWz6B2Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFWOwSx2QuRAnC+dU59V66k7oE7mFQ9SqeTpJOszccIJVV1nfUcRw+2Vxen2N2mof
         5BrcG59EnL6JgPy+zVEumdQk0LwApIvQD6TcojckfQUxq/7IBhO0sC9uOh1w6PRGYF
         blHJ+y/CxitjKLKVq6UZn9ojTTYgOaD6J3lYFXXQ=
Date:   Wed, 24 Jun 2020 13:11:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: pl330: Make sure the debug is idle before
 doing DMAGO
Message-ID: <20200624074141.GQ2324254@vkoul-mobl>
References: <1591234598-78919-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591234598-78919-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-06-20, 09:36, Sugar Zhang wrote:
> According to the datasheet of pl330:
> 
> Example 2-1 Using DMAGO with the debug instruction registers
> 
> 1. Create a program for the DMA channel
> 2. Store the program in a region of system memory
> 3. Poll the DBGSTATUS Register to ensure that the debug is idle
> 4. Write to the DBGINST0 Register
> 5. Write to the DBGINST1 Register
> 6. Write zero to the DBGCMD Register
> 
> so, we should make sure the debug is idle before step 4/5/6, not
> only step 6. if not, there maybe a risk that fail to write DBGINST0/1.

Applied, thanks

> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  drivers/dma/pl330.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 88b884c..6a158ee 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -885,6 +885,12 @@ static inline void _execute_DBGINSN(struct pl330_thread *thrd,
>  	void __iomem *regs = thrd->dmac->base;
>  	u32 val;
>  
> +	/* If timed out due to halted state-machine */
> +	if (_until_dmac_idle(thrd)) {
> +		dev_err(thrd->dmac->ddma.dev, "DMAC halted!\n");
> +		return;
> +	}
> +
>  	val = (insn[0] << 16) | (insn[1] << 24);
>  	if (!as_manager) {
>  		val |= (1 << 0);
> @@ -895,12 +901,6 @@ static inline void _execute_DBGINSN(struct pl330_thread *thrd,
>  	val = le32_to_cpu(*((__le32 *)&insn[2]));
>  	writel(val, regs + DBGINST1);
>  
> -	/* If timed out due to halted state-machine */
> -	if (_until_dmac_idle(thrd)) {
> -		dev_err(thrd->dmac->ddma.dev, "DMAC halted!\n");
> -		return;
> -	}
> -
>  	/* Get going */
>  	writel(0, regs + DBGCMD);
>  }
> -- 
> 2.7.4
> 
> 

-- 
~Vinod
