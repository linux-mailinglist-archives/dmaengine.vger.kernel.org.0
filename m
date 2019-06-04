Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E493464C
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfFDMKl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 08:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfFDMKl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Jun 2019 08:10:41 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328D124A02;
        Tue,  4 Jun 2019 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559650240;
        bh=bx10crper5s5AYw/kBlidhtOiBbuZXbSa+8Uxao2YZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afx9V+aIVbqwBiSR3kTsnxskJZ0D90hjgaW18j81v/vZ4eO0q+t2nn+PZULSBPNY8
         uG54BzSzpIvaKaQLY2ld2MzeMbjT4O+JwmcVfJW56c3YEZVkuvsczGGlkG+BwVFgKO
         7YimuA7USP+Hp1SruKbCgzO8FFSIY0WZD+je0MrE=
Date:   Tue, 4 Jun 2019 17:37:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V3 2/2] dmaengine: fsl-qdma: Add improvement
Message-ID: <20190604120733.GV15118@vkoul-mobl>
References: <20190522032103.13713-1-peng.ma@nxp.com>
 <20190522032103.13713-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522032103.13713-2-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-05-19, 03:21, Peng Ma wrote:
> When an error occurs we should clean the error register then to return

The patch title is supposed to tell us about the change. "Add
improvement: is a very generic term!

I have change title to "Continue to clear register on error" and applied

> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V3:
> 	- no changed.
> 
>  drivers/dma/fsl-qdma.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index da8fdf5..8e341c0 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -703,10 +703,8 @@ static irqreturn_t fsl_qdma_error_handler(int irq, void *dev_id)
>  
>  	intr = qdma_readl(fsl_qdma, status + FSL_QDMA_DEDR);
>  
> -	if (intr) {
> +	if (intr)
>  		dev_err(fsl_qdma->dma_dev.dev, "DMA transaction error!\n");
> -		return IRQ_NONE;
> -	}
>  
>  	qdma_writel(fsl_qdma, FSL_QDMA_DEDR_CLEAR, status + FSL_QDMA_DEDR);
>  	return IRQ_HANDLED;
> -- 
> 1.7.1

-- 
~Vinod
