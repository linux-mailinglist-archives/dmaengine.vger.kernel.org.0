Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85270ACC94
	for <lists+dmaengine@lfdr.de>; Sun,  8 Sep 2019 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfIHMNm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Sep 2019 08:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfIHMNm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 8 Sep 2019 08:13:42 -0400
Received: from localhost (unknown [122.182.221.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7997218AC;
        Sun,  8 Sep 2019 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944821;
        bh=Hw3q1ag0I8CbUon0M+dF8zfRHhWR8pPixExolxzfN4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vnz+wlEPnfhzYmcMiY0M0iFU/ND4by/c+ETjEbVH94MIbRMJxEjlf/RlibWPTTYvv
         mxp2ma8QPh1DTLUPmDPLnC4Fy/c0LBVqM9zkRrlR+OhDaCx8ihym5PeQ44ogsTPlZ+
         w6lpJqw70sy1ApNDt8mO+oAmcs100jE9EHazoj9w=
Date:   Sun, 8 Sep 2019 17:42:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC 2/3] dmaengine: of_dma: Function to look up the DMA domain
 of a client
Message-ID: <20190908121233.GM2672@vkoul-mobl>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906141816.24095-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-09-19, 17:18, Peter Ujfalusi wrote:
> Find the DMA domain controller of the client device by iterating up in
> device tree looking for the closest 'dma-domain-controller' property.
> 
> If the client's node is not provided then check the DT root for the
> controller.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/of-dma.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_dma.h |  7 +++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index c2d779daa4b5..04b5795cd76b 100644
> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c
> @@ -18,6 +18,48 @@
>  static LIST_HEAD(of_dma_list);
>  static DEFINE_MUTEX(of_dma_lock);
>  
> +/**
> + * of_find_dma_domain - Get the domain DMA controller
> + * @np:		device node of the client device
> + *
> + * Look up the DMA controller of the domain the client device is part of.
> + * Finds the dma-domain controller the client device belongs to. It is used when
> + * requesting non slave channels (like channel for memcpy) to make sure that the
> + * channel can be request from a DMA controller which can service the given
> + * domain best.
> + *
> + * Returns the device_node pointer of the DMA controller or succes or NULL on
> + * error.
> + */
> +struct device_node *of_find_dma_domain(struct device_node *np)
> +{
> +	struct device_node *dma_domain = NULL;
> +	phandle dma_phandle;
> +
> +	/*
> +	 * If no device_node is provided look at the root level for system
> +	 * default DMA controller for modules.
> +	 */
> +	if (!np)
> +		np = of_root;
> +
> +	if (!np || !of_node_get(np))
> +		return NULL;
> +
> +	do {
> +		if (of_property_read_u32(np, "dma-domain-controller",
> +					 &dma_phandle))
> +			np = of_get_next_parent(np);

lets have braces around if as well please

> +		else {
> +			dma_domain = of_find_node_by_phandle(dma_phandle);
> +			of_node_put(np);
> +		}
> +	} while (!dma_domain && np);
> +
> +	return dma_domain;
> +}
> +EXPORT_SYMBOL_GPL(of_find_dma_domain);
> +
>  /**
>   * of_dma_find_controller - Get a DMA controller in DT DMA helpers list
>   * @dma_spec:	pointer to DMA specifier as found in the device tree
> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
> index fd706cdf255c..6eab0a8d3335 100644
> --- a/include/linux/of_dma.h
> +++ b/include/linux/of_dma.h
> @@ -32,6 +32,8 @@ struct of_dma_filter_info {
>  };
>  
>  #ifdef CONFIG_DMA_OF
> +extern struct device_node *of_find_dma_domain(struct device_node *np);
> +
>  extern int of_dma_controller_register(struct device_node *np,
>  		struct dma_chan *(*of_dma_xlate)
>  		(struct of_phandle_args *, struct of_dma *),
> @@ -52,6 +54,11 @@ extern struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec
>  		struct of_dma *ofdma);
>  
>  #else
> +static inline struct device_node *of_find_dma_domain(struct device_node *np)
> +{
> +	return NULL;
> +}
> +
>  static inline int of_dma_controller_register(struct device_node *np,
>  		struct dma_chan *(*of_dma_xlate)
>  		(struct of_phandle_args *, struct of_dma *),
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
