Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD38844363E
	for <lists+dmaengine@lfdr.de>; Tue,  2 Nov 2021 20:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhKBTIf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Nov 2021 15:08:35 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:64884 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhKBTIc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Nov 2021 15:08:32 -0400
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id hz6XmmvCi3ptZhz6XmuddF; Tue, 02 Nov 2021 20:05:54 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 02 Nov 2021 20:05:54 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH V2] dma: dw-edma-pcie: switch from 'pci_' to 'dma_' API
To:     Qing Wang <wangqing@vivo.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
References: <1632800660-108761-1-git-send-email-wangqing@vivo.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <e30467d0-55e0-156c-4eba-2838c22fe030@wanadoo.fr>
Date:   Tue, 2 Nov 2021 20:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632800660-108761-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,


Le 28/09/2021 à 05:44, Qing Wang a écrit :
> From: Wang Qing <wangqing@vivo.com>
> 
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
> 
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
> 
> While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
> updated to a much less verbose 'dma_set_mask_and_coherent()'.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>   drivers/dma/dw-edma/dw-edma-pcie.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 44f6e09..198f6cd
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -186,27 +186,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>   	pci_set_master(pdev);
>   
>   	/* DMA configuration */
> -	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>   	if (!err) {
if err = 0, so if no error...

> -		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -		if (err) {
> -			pci_err(pdev, "consistent DMA mask 64 set failed\n");
> -			return err;
> -		}
> +		pci_err(pdev, "DMA mask 64 set failed\n");
> +		return err;
... we log an error, return success but don't perform the last steps of 
the probe.

>   	} else {
>   		pci_err(pdev, "DMA mask 64 set failed\n");
>   
> -		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>   		if (err) {
>   			pci_err(pdev, "DMA mask 32 set failed\n");
>   			return err;
>   		}
> -
> -		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> -		if (err) {
> -			pci_err(pdev, "consistent DMA mask 32 set failed\n");
> -			return err;
> -		}
>   	}
>   
>   	/* Data structure allocation */
> 

This patch is broken and should be reworked.

It has been applied in ecb8c88bd31c.

CJ
