Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74C3790B1
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 16:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhEJO1c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 10:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237353AbhEJOYu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 10:24:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6154C610F8;
        Mon, 10 May 2021 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620656625;
        bh=kEP6aLlNuK4Dajr76Bpt6HISC9bo3qqNa90Xw9uHtoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUW+atv1hpr4r/pWfHHTxwrayD2unlBNNP8VlGbzhfqps3a/b5zLJvHpXi0Hkgrr3
         /As3U1KQQ5zmMHKmiXDurRrT4LoRNbdh/8D3ADLuopFS1CBUoLKnLCI7qZmZkhmNPt
         G6O4BDyduyWVl3RySPV3ijYCI0zEo2tQ3xKIHkCAPDW29wKTLQlM2R/2vZzvN39M+N
         YJCywM1aFvzA8Ex1rvOWGOyUwo/A5Hf2jkCijWqCxskFK3Qr3QS77TRx2fut2WZQD4
         0sTCbMhvU1haihnTIWhoGrLpRshsIeWEJIcMJAQiJp7hKsSzgT+x4ALY4c2oVNp1ki
         D6QGSdap2araQ==
Date:   Mon, 10 May 2021 19:53:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: fsl-qdma: check dma_set_mask return value
Message-ID: <YJlB7XutrKJ0vq6n@vkoul-mobl.Dlink>
References: <1619427549-20498-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619427549-20498-1-git-send-email-yibin.gong@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-04-21, 16:59, Robin Gong wrote:
> For fix below warning reported by static code analysis tool like Coverity
> from Synopsys:
> 
> 'CID 12285639 (#1 of 2): Unchecked return value (CHECKED_RETURN)'

This should be:
Addresses-Coverity-ID: 12285639 ("Unchecked return value")

I have fixed that up and applied
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/fsl-qdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index ed2ab46..045ead4 100644
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
