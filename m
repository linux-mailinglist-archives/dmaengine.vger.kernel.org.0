Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900CD4F9475
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiDHLvp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiDHLvl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 07:51:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608824314E;
        Fri,  8 Apr 2022 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649418578; x=1680954578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0h8qDCJbgj5JnaE7KMtlcmvlSc/sxYVlAQJlYRyN6Pc=;
  b=Ebx/NYa5WPIGkNjSfw1IiTUQJdLHqfkvamxi3NWypBhVje3Jh92i/u4H
   +KhK2Te2dtoO1kr30Wj9AMUP1t0cE9uMeJmug/3a5qDkiV829eKJPDwgB
   WfkCcLoloys9IGDpwHD8Lw4vYcYucF17KfGqzaKpGfCZoinyvBB269uUu
   Px5Y1Hjpx/ON85HJeYIScfjda3v6OMf8HIrHSCeKEkkUhXZ017ETHt/86
   3tDfDdEnYLjJYG2lid0G2bwAx70FNqiqds0fTxNav9Lyw2R5yFgBecjTc
   t/1hBegqHlfjb5GoVx51cjAFiOVXKwIOkNLxuEmAVHk8WKv/BwnhTSWAp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260408763"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="260408763"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:49:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="524750342"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:49:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncn3m-000H0a-HS;
        Fri, 08 Apr 2022 14:45:50 +0300
Date:   Fri, 8 Apr 2022 14:45:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Magnus Damm <magnus.damm@gmail.com>,
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
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <YlAgbh2AFevBktxd@smile.fi.intel.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
 <20220406161856.1669069-6-miquel.raynal@bootlin.com>
 <6fbeebe2-9693-f91-78bd-451480f7a6dd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fbeebe2-9693-f91-78bd-451480f7a6dd@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 08, 2022 at 12:55:47PM +0300, Ilpo Järvinen wrote:
> On Wed, 6 Apr 2022, Miquel Raynal wrote:
> 
> > The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> > dmamux register located in the system control area which can take up to
> > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > two different peripherals.
> > 
> > We need two additional information from the 'dmas' property: the channel
> > (bit in the dmamux register) that must be accessed and the value of the
> > mux for this channel.

> > +	mask = BIT(map->req_idx);
> > +	mutex_lock(&dmamux->lock);
> > +	dmamux->used_chans |= mask;
> > +	ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
> > +	if (ret)
> > +		goto release_chan_and_unlock;
> > +
> > +	mutex_unlock(&dmamux->lock);
> > +
> > +	return map;
> > +
> > +release_chan_and_unlock:
> > +	dmamux->used_chans &= ~mask;
> 
> Now that I check this again, I'm not sure why dmamux->used_chans |= mask; 
> couldn't be done after r9a06g032_sysctrl_set_dmamux() call so this 
> rollback of it wouldn't be necessary.

I would still need the mutex unlock which I believe is down path there under
some other label. Hence you are proposing something like

	mask = BIT(map->req_idx);

	mutex_lock(&dmamux->lock);
	ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
	if (ret)
		goto err_unlock; // or whatever label is

	dmamux->used_chans |= mask;
	mutex_unlock(&dmamux->lock);

	return map;

Is that correct? If so, I don't see impediments either.

> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko


