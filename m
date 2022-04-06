Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD4A4F6320
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 17:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiDFPao (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 11:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiDFPa0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 11:30:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802F6CCD14;
        Wed,  6 Apr 2022 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649249380; x=1680785380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYoVpyb3l2wM7Z7eVoU8dR1W5tEkmTa6mGYnlgO8Gh4=;
  b=DHR/thF4iFN+EWlQ1KW+wQZO7eNGtUpMEzZ46RqmLo51/B9+i1MnCPKx
   k0+3pH78xlBz3e6IgpzVMF8nqyfKjF3Z9DRw06PHAWZUtqkg65PdQThXF
   6b6A1SPSFA1XJZieaqeUKe+koX4tyxC5ilUUprHNuLvDq4VT/O8U4xxNH
   f2xQgtuKFtA6unaPJycIbEMC3NorvPNBxdvsAg0Zy+H89oqWC/PiXRc0Z
   ClIlNwnv4sPshR6LxIe3LorlFKK14E6Arkr1Hra/j6gPd3xnSPYmHhP53
   KGfpfWjsYviIa/94sTeowPrMyW39tv96sQZDUUcv2tDStvgy3go+sMEYy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347478440"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="347478440"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 05:48:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="588356315"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 05:48:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc544-000Dyb-V4;
        Wed, 06 Apr 2022 15:47:12 +0300
Date:   Wed, 6 Apr 2022 15:47:12 +0300
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
Message-ID: <Yk2L0MAMjMnWB2sU@smile.fi.intel.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
 <20220405081911.1349563-6-miquel.raynal@bootlin.com>
 <YkxXUdMA75b8keSd@smile.fi.intel.com>
 <20220406094908.48ecc4bb@xps13>
 <Yk1WWaJ9IJsU5HXV@smile.fi.intel.com>
 <20220406141346.5caf746c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406141346.5caf746c@xps13>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 06, 2022 at 02:13:46PM +0200, Miquel Raynal wrote:
> andriy.shevchenko@linux.intel.com wrote on Wed, 6 Apr 2022 11:59:05
> +0300:
> > On Wed, Apr 06, 2022 at 09:49:08AM +0200, Miquel Raynal wrote:
> > > andriy.shevchenko@linux.intel.com wrote on Tue, 5 Apr 2022 17:50:57
> > > +0300:  
> > > > On Tue, Apr 05, 2022 at 10:19:07AM +0200, Miquel Raynal wrote:  

...

> > > > > +#define RZN1_DMAMUX_SPLIT 16  
> > > >
> > > > I would name it more explicitly:
> > > > 
> > > > #define RZN1_DMAMUX_SPLIT_1_0	 16  
> > > 
> > > I am sorry but I don't understand this suffix, which probably means
> > > that it is not as clear as we wish. Do you mind if I stick to
> > > RZN1_DMAMUX_SPLIT?  
> > 
> > The suffix to show that this is the value between part 0 (indexed by 0) and
> > part 1 (indexed by 1) as far as I can see they are different by size. Since
> > they are not equal, the original name without suffix is confusing (I would
> > expect indexing up to 4 in such case).
> 
> They are equivalent in size (0-15/16-31), or aren't we talking about the
> same thing?

Hmm... I have misread something then. To clarify that the portions are equal
perhaps we can name it MAX_LINES or so instead of SPLIT?

-- 
With Best Regards,
Andy Shevchenko


