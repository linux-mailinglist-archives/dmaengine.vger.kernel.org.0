Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4859D4F9254
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 11:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiDHJ6I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiDHJ6H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 05:58:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A581D59CA;
        Fri,  8 Apr 2022 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649411760; x=1680947760;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VFW5ooso+q6hlaQnz7e4gtHdL3Ba8aSrKhhWGKZ5rUQ=;
  b=k4cEr2LOiHEG/NGGiHN9gS31kq/aD/edsFdayOMNLL82J421wDnfAD9I
   92YNF+DNUgTYmzwKPpxI5vmmoOiniCuYAoOyqhrWdtoSefklJWtkdLAxY
   Dh6hfbm3PAhqH9WLOok+fWLtpU+91MwV2qlL4Pz0TgFNCfx2xakR/To/F
   QJfCYxx6EoLVdLT2GD5tWDD/HVgQYMDfjURPN4BeA10SxG9c+Ep9cb8fF
   wAPCjGzs7/9z/q4/VMY38DWcYqer4f5J13gewnJyiz30ObJSXEfjXfH5c
   EP3GIZKnmrZFQVNiEKxMXKciEp1YImKeaVyttpXfxuzbTmzS6z3lnQnnt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260391197"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="260391197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 02:56:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="571433908"
Received: from aecajiao-mobl.amr.corp.intel.com ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 02:55:54 -0700
Date:   Fri, 8 Apr 2022 12:55:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
In-Reply-To: <20220406161856.1669069-6-miquel.raynal@bootlin.com>
Message-ID: <6fbeebe2-9693-f91-78bd-451480f7a6dd@linux.intel.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com> <20220406161856.1669069-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1766008063-1649411759=:1643"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1766008063-1649411759=:1643
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 6 Apr 2022, Miquel Raynal wrote:

> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
> 
> We need two additional information from the 'dmas' property: the channel
> (bit in the dmamux register) that must be accessed and the value of the
> mux for this channel.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
> +	if (chan >= RZN1_DMAMUX_MAX_LINES) {
> +		dev_err(&pdev->dev, "Invalid DMA request line: %u\n", chan);
> +		ret = -EINVAL;
> +		goto free_map;
> +	}
> +
> +	if (map->req_idx >= RZN1_DMAMUX_LINES ||
> +	    (map->req_idx % RZN1_DMAMUX_MAX_LINES) != chan) {
> +		dev_err(&pdev->dev, "Invalid MUX request line: %u\n", map->req_idx);
> +		ret = -EINVAL;
> +		goto free_map;
> +	}
> +
> +	dmac_idx = map->req_idx >= RZN1_DMAMUX_MAX_LINES ? 1 : 0;
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
> +	if (ret)
> +		goto release_chan_and_unlock;
> +
> +	mutex_unlock(&dmamux->lock);
> +
> +	return map;
> +
> +release_chan_and_unlock:
> +	dmamux->used_chans &= ~mask;

Now that I check this again, I'm not sure why dmamux->used_chans |= mask; 
couldn't be done after r9a06g032_sysctrl_set_dmamux() call so this 
rollback of it wouldn't be necessary.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>



-- 
 i.

--8323329-1766008063-1649411759=:1643--
