Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCA736A858
	for <lists+dmaengine@lfdr.de>; Sun, 25 Apr 2021 18:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhDYQUA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 25 Apr 2021 12:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhDYQUA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 25 Apr 2021 12:20:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A23B611C2;
        Sun, 25 Apr 2021 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619367560;
        bh=NdxtA/vfvZEFjh39RCdHx63hCF6404jblqDobJhrNaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CX6fsNTZPqv8Sk1Tp9YuP7gZ+6SxPPNS/trExSABFfBRM4FCM6MAm7be3oo8qiw9I
         z4kRitNG5v3ztXtRftR9kpTL6/a1HC4DOaIIw1g9yw+VQc3CxPgUppBC2CTQE004XM
         k8EJeRRX/blSrnUof+UQH8wNnXuQpfRdJpDzm3CcTFX25T2x9tWAIjjyKtBRb8kuP6
         wy4MTwBn7D2xC7lJQDmjeEFu9AIFAoDfdZgWKcFi9hjSq2U4Y+d6fkOJHcvB7se3OZ
         OM+5262GI5MtyKfU/2BDw1e9Rpg78Obl4tOaw9nIQBhU6e060HVoI86YOtu8o1Bgso
         fAylxgvNpMtBQ==
Date:   Sun, 25 Apr 2021 21:49:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: fsl-qdma: check dma_set_mask return value
Message-ID: <YIWWg6fJFjMgb65m@vkoul-mobl.Dlink>
References: <1619170187-5552-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619170187-5552-1-git-send-email-yibin.gong@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-21, 17:29, Robin Gong wrote:
> For fix warning reported by static code analysis tool like Coverity from
> Synopsys.

Please mention which warning, also Coverity id
Do see other patches which add coverity ids

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/fsl-qdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index ed2ab46..86c02b6 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -1235,7 +1235,11 @@ static int fsl_qdma_probe(struct platform_device *pdev)
>  	fsl_qdma->dma_dev.device_synchronize = fsl_qdma_synchronize;
>  	fsl_qdma->dma_dev.device_terminate_all = fsl_qdma_terminate_all;
>  
> -	dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
> +	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
> +	if (ret) {
> +		dev_err(&pdev->dev, "dma_set_mask failure.\n");
> +		return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, fsl_qdma);
>  
> -- 
> 2.7.4

-- 
~Vinod
