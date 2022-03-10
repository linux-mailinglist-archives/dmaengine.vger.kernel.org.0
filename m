Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658924D50CC
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiCJRqE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 12:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbiCJRqE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 12:46:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F05180D2A;
        Thu, 10 Mar 2022 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646934302; x=1678470302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Hgem/xb7fgEnabZDJWfqC0vFwT+ahTBVHdBBEWMA6Q=;
  b=PzXzYF182SeA3S6798u/dsu0OGjOVd5XzUY8WmAxF6CsVxVnJSsfSYOu
   YKJtCfP9By8HgoN3PevDbE1RgK6rVACn9LUR03HDzRL4+49+q8UFQP65E
   FOfcJ+0W3J8vEEw9FYBL/JjpJR3DkcUNdwVQa8SKsl91fq0Cu5APcWy8n
   ajZw+AqwjHwatqlzhH67aqAuiLgY5O+4N9HRoJGlM2qttixiEeSgvo0r1
   uEH1ptOIQcvZypBIjNqxegeSJSJQq8seCxmTesz17PDCX7eF9dwPhxrU3
   VDgw7hjLr60aNqqE+d2IlSKcoDSE/q3hMS0FJyNenXWdtCdsOP4UrzNTI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341748011"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="341748011"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:45:02 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="781540349"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:44:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nSMpi-00Eqwb-AB;
        Thu, 10 Mar 2022 19:44:14 +0200
Date:   Thu, 10 Mar 2022 19:44:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH v4 5/9] dma: dw: dmamux: Introduce RZN1 DMA router support
Message-ID: <Yio47YVZuHaFvwE8@smile.fi.intel.com>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
 <20220310155755.287294-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310155755.287294-6-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 04:57:51PM +0100, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
> 
> We need two additional information from the 'dmas' property: the channel
> (bit in the dmamux register) that must be accessed and the value of the
> mux for this channel.
> 
> Aside from the driver introduction, as these devices are described as
> subnodes of the system controller, we also need the system controller
> (clock) driver to populate its children manually. Starting from now on,
> one child can be the dmamux.

In all DMA engine related patches the prefix should be "dmaengine:".

...

> +static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> +					struct of_dma *ofdma)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +	struct rzn1_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +	struct rzn1_dmamux_map *map;
> +	unsigned int dmac_idx, chan, val;
> +	u32 mask;
> +	int ret;
> +
> +	map = kzalloc(sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);

> +	if (dma_spec->args_count != 6) {
> +		kfree(map);
> +		return ERR_PTR(-EINVAL);
> +	}

You may move this check above and get one kfree() call less.
Moreover, you may use a goto approach to call kfree() from
a single point of exit.

> +	chan = dma_spec->args[0];
> +	map->req_idx = dma_spec->args[4];
> +	val = dma_spec->args[5];
> +	dma_spec->args_count -= 2;
> +
> +	if (chan >= RZN1_DMAMUX_SPLIT) {
> +		kfree(map);
> +		dev_err(&pdev->dev, "Invalid DMA request line: %u\n", chan);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (map->req_idx >= RZN1_DMAMUX_LINES ||
> +	    (map->req_idx % RZN1_DMAMUX_SPLIT) != chan) {
> +		kfree(map);
> +		dev_err(&pdev->dev, "Invalid MUX request line: %u\n", map->req_idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	dmac_idx = map->req_idx < RZN1_DMAMUX_SPLIT ? 0 : 1;
> +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", dmac_idx);
> +	if (!dma_spec->np) {
> +		kfree(map);
> +		dev_err(&pdev->dev, "Can't get DMA master\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u request %u\n",
> +		map->req_idx, dmac_idx, chan);
> +
> +	mask = BIT(map->req_idx);
> +	mutex_lock(&dmamux->lock);
> +	dmamux->used_chans |= mask;
> +	ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
> +	mutex_unlock(&dmamux->lock);
> +	if (ret) {
> +		rzn1_dmamux_free(&pdev->dev, map);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return map;
> +}

-- 
With Best Regards,
Andy Shevchenko


