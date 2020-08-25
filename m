Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDEF25177F
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHYLZX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbgHYLZV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:25:21 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 224732075B;
        Tue, 25 Aug 2020 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598354721;
        bh=ddQB2CTZx6e755kz/OZHNFbEB2IUK2yHj/0OYJmg+Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dksMgW1cPTKSHSSoky6BMBqulBBF4IH/7mW6rhuJC9jTkbacZEKdAkHYwx19hbugR
         9QwBoR3q9KCcMpQ8bha+e0Gn8UIlsL6tpgc6gBhF7so5ML9anF0XNjGEaMiMzmo+ub
         ttOkqxPQPXEbgNiOO33LjQ0GM+P1o9vB+VP3Kt6o=
Date:   Tue, 25 Aug 2020 16:55:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, dan.j.williams@intel.com, ardeleanalex@gmail.com
Subject: Re: [PATCH 3/5] dmaengine: axi-dmac: wrap entire dt parse in a
 function
Message-ID: <20200825112517.GP2639@vkoul-mobl>
References: <20200819071633.76494-1-alexandru.ardelean@analog.com>
 <20200819071633.76494-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819071633.76494-3-alexandru.ardelean@analog.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-20, 10:16, Alexandru Ardelean wrote:
> All these attributes will be read from registers in newer core versions, so
> just wrap the logic into a function.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 39 ++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 07665c60c21b..473c4a159c89 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -774,6 +774,28 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
>  	return 0;
>  }
>  
> +static int axi_dmac_parse_dt(struct device *dev, struct axi_dmac *dmac)
> +{
> +	struct device_node *of_channels, *of_chan;
> +	int ret;
> +
> +	of_channels = of_get_child_by_name(dev->of_node, "adi,channels");
> +	if (of_channels == NULL)
> +		return -ENODEV;
> +
> +	for_each_child_of_node(of_channels, of_chan) {
> +		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
> +		if (ret) {
> +			of_node_put(of_chan);
> +			of_node_put(of_channels);
> +			return -EINVAL;
> +		}
> +	}
> +	of_node_put(of_channels);
> +
> +	return 0;
> +}
> +
>  static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
>  {
>  	struct axi_dmac_chan *chan = &dmac->chan;
> @@ -823,7 +845,6 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
>  
>  static int axi_dmac_probe(struct platform_device *pdev)
>  {
> -	struct device_node *of_channels, *of_chan;
>  	struct dma_device *dma_dev;
>  	struct axi_dmac *dmac;
>  	struct resource *res;
> @@ -856,19 +877,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  
>  	INIT_LIST_HEAD(&dmac->chan.active_descs);
>  
> -	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
> -	if (of_channels == NULL)
> -		return -ENODEV;
> -
> -	for_each_child_of_node(of_channels, of_chan) {
> -		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
> -		if (ret) {
> -			of_node_put(of_chan);
> -			of_node_put(of_channels);
> -			return -EINVAL;
> -		}
> -	}
> -	of_node_put(of_channels);
> +	ret = axi_dmac_parse_dt(&pdev->dev, dmac);
> +	if (ret < 0)

this need to jump to err_clk_disable

> +		return ret;
>  
>  	pdev->dev.dma_parms = &dmac->dma_parms;
>  	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
> -- 
> 2.17.1

-- 
~Vinod
