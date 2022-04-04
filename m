Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B874F16B3
	for <lists+dmaengine@lfdr.de>; Mon,  4 Apr 2022 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376810AbiDDOFi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Apr 2022 10:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376801AbiDDOFh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Apr 2022 10:05:37 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7ADB7F3;
        Mon,  4 Apr 2022 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649081019; x=1680617019;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bruD2yzg13xcbKVOTCZnA41MnbPSNmOTaTc2Ahx/lY8=;
  b=A1DQKxWthHG0NpLcjOdQtEFBdBf8TnRKvBa8yxGWq68Qt7mUdUYJG0nn
   xwj654ZFwCthAPphGQI/kSAt+jrhFkuN7P/RCioukFRbLBRnzfgtJpl8O
   SjZ3CN8HQrViy4iMFmqJzc+9orSflLlpmTX1vMhQytnLI0O6Evt+0OHl5
   dhVd8TPYchVh4KGNh56sN6IJBhuuTpkdInyHX+g6/W/hrCjcoo/XiDvYX
   5eWCPTkXPdDEC3K7nCm89VaTBv/vjtk60ceRNp03lALdoByGExZtsdrE/
   bHmyW8cYvtLZU74Y7OnSkHUBqQEiPAy4D0NiHFKJZKupUwCARb8vNtGJm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="321215284"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="321215284"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 07:03:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="569396717"
Received: from rhamza-mobl.ger.corp.intel.com ([10.251.211.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 07:03:34 -0700
Date:   Mon, 4 Apr 2022 17:03:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 5/8] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
In-Reply-To: <20220404133904.1296258-6-miquel.raynal@bootlin.com>
Message-ID: <f76c2e68-2a4a-381a-3c40-eb369a08550@linux.intel.com>
References: <20220404133904.1296258-1-miquel.raynal@bootlin.com> <20220404133904.1296258-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 4 Apr 2022, Miquel Raynal wrote:

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
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

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
> +	if (dma_spec->args_count != 6)
> +		return ERR_PTR(-EINVAL);
> +
> +	map = kzalloc(sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);
> +
> +	chan = dma_spec->args[0];
> +	map->req_idx = dma_spec->args[4];
> +	val = dma_spec->args[5];
> +	dma_spec->args_count -= 2;
> +
> +	if (chan >= RZN1_DMAMUX_SPLIT) {
> +		dev_err(&pdev->dev, "Invalid DMA request line: %u\n", chan);
> +		ret = -EINVAL;
> +		goto free_map;
> +	}
> +
> +	if (map->req_idx >= RZN1_DMAMUX_LINES ||
> +	    (map->req_idx % RZN1_DMAMUX_SPLIT) != chan) {
> +		dev_err(&pdev->dev, "Invalid MUX request line: %u\n", map->req_idx);
> +		ret = -EINVAL;
> +		goto free_map;
> +	}
> +
> +	dmac_idx = map->req_idx < RZN1_DMAMUX_SPLIT ? 0 : 1;
> +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", dmac_idx);
> +	if (!dma_spec->np) {
> +		dev_err(&pdev->dev, "Can't get DMA master\n");
> +		ret = -EINVAL;
> +		goto free_map;
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
> +	if (ret)
> +		goto free_mux;

Move this check before the unlock. Then free_mux path doesn't need to do
(re)lock as the mutex is still held. You might also want to consider 
renaming the label e.g. to chan_release_and_unlock.

> +
> +	return map;
> +
> +free_mux:
> +	mutex_lock(&dmamux->lock);
> +	dmamux->used_chans &= ~mask;
> +	mutex_unlock(&dmamux->lock);
> +free_map:
> +	kfree(map);
> +
> +	return ERR_PTR(ret);
> +}


-- 
 i.

