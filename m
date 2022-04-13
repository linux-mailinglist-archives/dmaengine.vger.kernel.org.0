Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E051F4FF50A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiDMKrf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 06:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiDMKr2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 06:47:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28032076;
        Wed, 13 Apr 2022 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649846707; x=1681382707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEfjdwY23aKsvFoAZXPuaR84pVXUkXydcu5CIrt9EcU=;
  b=kNjI9kFmGs/RGczAg8RN1VHANg0whIUqtLDVy+POUeknLWdXUfAlCRRR
   yX46L8vyvCoGTTa2I1FHP1SHiIuss48sYYFrV1gsbrP1+HSzMKs7VrHpH
   YvABZ42Cby9+BDqPvSpCqwd0ecYV4W4RuKKAG4GdnI7rtzL4YA8O9iWZY
   mLSbKscaBRbCJtE8JZY0K6MKvkEgVkC/GBKSItGJgzSpwBB4fDvGOVoWT
   PVhNXvjBGSIKY+SUJaqx5pCNKXwuaEYylAELzyzfhj856tC5xQHCulH11
   szyY4gOfmd1CRNQmA4dVZySSJzzJO9Ya4HGiQ/YdEtT571b7qg1It6Aqk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262386193"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="262386193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:45:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="700201266"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:45:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neaR9-001nON-Fb;
        Wed, 13 Apr 2022 13:41:23 +0300
Date:   Wed, 13 Apr 2022 13:41:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v10 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <Ylao068kNANViy4B@smile.fi.intel.com>
References: <20220412193936.63355-1-miquel.raynal@bootlin.com>
 <20220412193936.63355-6-miquel.raynal@bootlin.com>
 <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
 <20220413100026.73e11004@xps13>
 <CAMuHMdU3pEX3oGoHQ71cm7m0DpguJOqpOTq4_kfAxD98XN325A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3pEX3oGoHQ71cm7m0DpguJOqpOTq4_kfAxD98XN325A@mail.gmail.com>
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

On Wed, Apr 13, 2022 at 10:05:43AM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 13, 2022 at 10:00 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:

...

>     DECLARE_BITMAP(used_chans, 2 * RZN1_DMAMUX_MAX_LINES);

Yep, this one.

-- 
With Best Regards,
Andy Shevchenko


