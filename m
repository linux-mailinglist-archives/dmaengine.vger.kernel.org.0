Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9493625177B
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgHYLYv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHYLYk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:24:40 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D2E20715;
        Tue, 25 Aug 2020 11:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598354679;
        bh=M3p0x9HTexyXG3y5wtcZskuuZYZ2oidM4aabQAVz3xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZh0xC0b8X09A8dT0ltfBidxeXkJkRe/uji2Tj8v/s2tkDe8qNiV9RLZQSAKx3yU1
         yzhQMZXTO+VJFReo++Wt1I/UsaWuGgF0FHj00yNwRdYf5uA0pzmxmbUL7FP1fgQKeu
         KjEQsComLcl8dmfQABg2xxd5W9quYrDzm07wD7+Y=
Date:   Tue, 25 Aug 2020 16:54:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, dan.j.williams@intel.com, ardeleanalex@gmail.com
Subject: Re: [PATCH 2/5] dmaengine: axi-dmac: move clock enable earlier
Message-ID: <20200825112435.GO2639@vkoul-mobl>
References: <20200819071633.76494-1-alexandru.ardelean@analog.com>
 <20200819071633.76494-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819071633.76494-2-alexandru.ardelean@analog.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-20, 10:16, Alexandru Ardelean wrote:
> The clock may also be required to read registers from the IP core (if it is
> provided and the driver needs to control it).
> So, move it earlier in the probe.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 088c79137398..07665c60c21b 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -850,6 +850,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(dmac->clk))
>  		return PTR_ERR(dmac->clk);
>  
> +	ret = clk_prepare_enable(dmac->clk);
> +	if (ret < 0)
> +		return ret;
> +
>  	INIT_LIST_HEAD(&dmac->chan.active_descs);

Change is fine, but then you need to jump to err_clk_disable in few
place below this and not return error

>  
>  	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
> @@ -892,10 +896,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	dmac->chan.vchan.desc_free = axi_dmac_desc_free;
>  	vchan_init(&dmac->chan.vchan, dma_dev);
>  
> -	ret = clk_prepare_enable(dmac->clk);
> -	if (ret < 0)
> -		return ret;
> -
>  	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
>  
>  	ret = axi_dmac_detect_caps(dmac, version);
> -- 
> 2.17.1

-- 
~Vinod
