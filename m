Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73D4BCE10
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 11:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiBTK5W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 05:57:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiBTK5V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 05:57:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39065340C2;
        Sun, 20 Feb 2022 02:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645354620; x=1676890620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yPqPywbDC7Awr4bHvSEXFevB7s9D3RWFfXlO+8m6W44=;
  b=grmpciZvqwbTEiQGP9hdwHFo0pb8S43722IJNdUUlq3fSPWP8My02gxc
   7iizn46btKlUrVSwuKG2Llu0Dy3e6xfBMKhKsYukOe3Y26vRO09mKERDY
   dQoMSsvmQIHidDUAMXH9qdtZInh/Wk9y8/nVzfnjIQgW2Cx86vyJzDOt5
   GmQJlQ2Rgr8dt6/0fFC3kvbOchDY4Qc35wpMok+TQP2+apJAylFzX8Xjr
   jWfARkYVaIONnZWDy84mzpNzYW/W6o6mWhvsE2zmWtUj3PP78WFzEY/wt
   HsjnMWA2GgRKjgJu8is8RwWejhEvuVkVA9XNnJmTn/VPYm++Uvl3b1hh3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="275951791"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="275951791"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 02:56:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="531490390"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 02:56:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nLjsp-006UYn-51;
        Sun, 20 Feb 2022 12:56:03 +0200
Date:   Sun, 20 Feb 2022 12:56:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: Re: [PATCH 4/8] dma: dmamux: Introduce RZN1 DMA router support
Message-ID: <YhIeQlwmt/yCc8Uu@smile.fi.intel.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
 <20220218181226.431098-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218181226.431098-5-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Feb 18, 2022 at 07:12:22PM +0100, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
> 
> We need two additional information from the 'dmas' property: the channel
> (bit in the dmamux register) that must be accessed and the value of the
> mux for this channel.

...

> +dw_dmac-y			:= platform.o dmamux.o

We do not need this on other platforms, please make sure we have no dangling
code on, e.g., x86.

...

> +	/* The of_node_put() will be done in the core for the node */
> +	master = map->req_idx < dmamux->dmac_requests ? 0 : 1;

The opposite conditional will be better, no?`

...

> +	dmamux->used_chans |= BIT(map->req_idx);
> +	ret = r9a06g032_syscon_set_dmamux(BIT(map->req_idx),
> +					  val ? BIT(map->req_idx) : 0);


Cleaner to do

	u32 mask = BIT(...);
	...

	dmamux->used_chans |= mask;
	ret = r9a06g032_syscon_set_dmamux(mask, val ? mask : 0);

...

> +static const struct of_device_id rzn1_dmac_match[] __maybe_unused = {
> +	{ .compatible = "renesas,rzn1-dma", },
> +	{},

No comma for terminator entry.

> +};

...

> +	if (!node)
> +		return -ENODEV;

Dup check, why not to simply try for phandle first?

...

> +	if (of_property_read_u32(dmac_node, "dma-requests",
> +				 &dmamux->dmac_requests)) {

One line?

> +		dev_err(&pdev->dev, "Missing DMAC requests information\n");
> +		of_node_put(dmac_node);
> +		return -EINVAL;

First put node, then simply use dev_err_probe().

> +	}

...

> +static const struct of_device_id rzn1_dmamux_match[] = {
> +	{ .compatible = "renesas,rzn1-dmamux", },
> +	{},

No comma.

> +};

-- 
With Best Regards,
Andy Shevchenko


