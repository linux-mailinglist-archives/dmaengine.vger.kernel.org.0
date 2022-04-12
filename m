Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23614FDFAA
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 14:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiDLMKq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354453AbiDLMKM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 08:10:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1556D85D;
        Tue, 12 Apr 2022 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649761816; x=1681297816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KGI/EtCZbnvSnVEi574n0MqqYRuI/6vDtiDNlZgI524=;
  b=dSKbk16yngdiocXlK9kKvCcCxRK4mggqObej1iiKYRFC6YoveJrmSdJm
   Akj9WyBwetErDWWJwk/Llvsi0tJFn247YGyY6p9zUDBb0fkhi4AnxITbL
   u4Pnqpq6rIV/Uk8FJq8oyHPB3FDSVHJjbE6SLV/bk/tdJUBr3uXanNQrF
   HkTGm5k3eNn6lINtgTzlxIoxG0y6WhPZYizUvr2dP+80nRHy+YpbCgRT8
   TosQO94dY3as4BOXAvUeEFZE19kbRNGWRodCAoVyEs/jDvSfKwJBEfwAr
   6GD+4yoT2L6WLZw2P35lt7h8YMzrFwy6e2Ih5tH4lS28huRJ9zu1Lrks/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322792982"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="322792982"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:10:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="655063491"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:10:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neELv-001Ybc-9Z;
        Tue, 12 Apr 2022 14:06:31 +0300
Date:   Tue, 12 Apr 2022 14:06:30 +0300
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
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <YlVdNpuYdgzo7Vgi@smile.fi.intel.com>
References: <20220412102138.45975-1-miquel.raynal@bootlin.com>
 <20220412102138.45975-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412102138.45975-6-miquel.raynal@bootlin.com>
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

On Tue, Apr 12, 2022 at 12:21:34PM +0200, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
> 
> We need two additional information from the 'dmas' property: the channel
> (bit in the dmamux register) that must be accessed and the value of the
> mux for this channel.

...

Some headers are absent, e.g.: types.h, bitops.h.

> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/slab.h>

...

> +	mutex_lock(&dmamux->lock);
> +	clear_bit(BIT(map->req_idx), dmamux->used_chans);

Why do you need atomic bit operation here _and_ mutex?

> +	mutex_unlock(&dmamux->lock);

Ditto for the rest similar cases.

-- 
With Best Regards,
Andy Shevchenko


