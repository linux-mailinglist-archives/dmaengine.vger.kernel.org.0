Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29CA4F4F8A
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 04:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbiDFAwc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 20:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452287AbiDEPyo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 11:54:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1665EDDF;
        Tue,  5 Apr 2022 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649170294; x=1680706294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hDIKbcuCqOOCzkaHLmnwvCV3OzXa2wmONhiVcVDqU1g=;
  b=GkhhBhXEnbE/WF8Ms66FIEaOEuuQ+XEaQxoF2nvqJfZ2/nOsp8RlP2ow
   gkbDN0OsFc0f3+uqt7Oa0c1Ril0N9WjtyV2O2HF44T7xZN28UE5QlgxNV
   9S1tmrBrzVG1j9uTw1MXqHUkrfsdDOv8jBQAYiL+hVWCSFI6zTT4rgEcM
   VjDOCJTcJ+pmVwIKQ6kEfEk1sQjLUoLP5O9MJ36sI/0EUUUXMujsunpz1
   NWblqw91yb4c6GXgINEtwgQWv4eP6AD2RTzSpOb/mcZuugoj+gWh077+O
   9yJFeNnJkBCRcXjAjhP09o5b9bvMHMRe0UbeuUR4/xz03zXNzt3OcoGI0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260756109"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260756109"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:51:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="641638017"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:51:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nbkWH-00DQ3V-OF;
        Tue, 05 Apr 2022 17:50:57 +0300
Date:   Tue, 5 Apr 2022 17:50:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v7 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <YkxXUdMA75b8keSd@smile.fi.intel.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
 <20220405081911.1349563-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405081911.1349563-6-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 05, 2022 at 10:19:07AM +0200, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
> 
> We need two additional information from the 'dmas' property: the channel
> (bit in the dmamux register) that must be accessed and the value of the
> mux for this channel.

...

>  dw_dmac-y			:= platform.o
>  dw_dmac-$(CONFIG_OF)		+= of.o

> +obj-$(CONFIG_RZN1_DMAMUX)	+= rzn1-dmamux.o

I would move it down in the file to distinguish more generic drivers
from specific quirks.

>  obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
>  dw_dmac_pci-y			:= pci.o

...

> +#define RZN1_DMAMUX_SPLIT 16

I would name it more explicitly:

#define RZN1_DMAMUX_SPLIT_1_0	 16

...

> +	dmac_idx = map->req_idx < RZN1_DMAMUX_SPLIT ? 0 : 1;

...and hence use positive conditional:

	dmac_idx = map->req_idx >= RZN1_DMAMUX_SPLIT_1_0 ? 1 : 0;

With above addressed
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


