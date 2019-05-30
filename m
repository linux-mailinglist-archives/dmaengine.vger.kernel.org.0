Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA02FB5D
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2019 14:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfE3MBl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 May 2019 08:01:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16744 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfE3MBl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 May 2019 08:01:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cefc6230000>; Thu, 30 May 2019 05:01:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 May 2019 05:01:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 May 2019 05:01:39 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 May
 2019 12:01:37 +0000
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Error out if DMA_PREP_INTERRUPT
 flag is unset
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190529214355.15339-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9b0e0d20-6386-a38a-1347-4264d249cb44@nvidia.com>
Date:   Thu, 30 May 2019 13:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529214355.15339-1-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559217699; bh=reDR5M2JTDqXTNW7rZr6EEAnF0APcRZ8+YH4GK7K9dE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BliolhNRG2WTgLrf6H0GFf5HF31eruBgAHOZAX6toRT8oUBUTYu6t2Fn4HDHfFdJL
         LfX4YVRxf9P8LarsHlwQS9BL9vEySKTUE81LAW36e3f7UXT/OFEoLN8tZa5Pkte1VX
         svKBviaEQYzKQ7Q0QhVCnq8raycDlnkbj4OHBgwAFarfVJGU/UJcpulXgboES0XU9G
         Yl0YwdNCoe23LPh20wdwQjwLTfpCOavYH5HQAFo0uZja1cGhBEX944JHQnaR8yl2WS
         esnhAbT8t+EU6qnFfzkMhcNiHJ7DzU8SYuGbRGvAjF9NS7brdhMYGcK+Q2ZX9qs/Pn
         6kYWF83dcrYhg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 29/05/2019 22:43, Dmitry Osipenko wrote:
> Apparently driver was never tested with DMA_PREP_INTERRUPT flag being
> unset since it completely disables interrupt handling instead of skipping
> the callbacks invocations, hence putting channel into unusable state.
> 
> The flag is always set by all of kernel drivers that use APB DMA, so let's
> error out in otherwise case for consistency. It won't be difficult to
> support that case properly if ever will be needed.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index cf462b1abc0b..2c84a660ba36 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -988,8 +988,12 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>  		csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
>  	}
>  
> -	if (flags & DMA_PREP_INTERRUPT)
> +	if (flags & DMA_PREP_INTERRUPT) {
>  		csr |= TEGRA_APBDMA_CSR_IE_EOC;
> +	} else {
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
>  
>  	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
>  
> @@ -1131,8 +1135,12 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
>  		csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
>  	}
>  
> -	if (flags & DMA_PREP_INTERRUPT)
> +	if (flags & DMA_PREP_INTERRUPT) {
>  		csr |= TEGRA_APBDMA_CSR_IE_EOC;
> +	} else {
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
>  
>  	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;

Looks good to me.

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
