Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8D4F5E82
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiDFMt5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiDFMsp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 08:48:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3CA4C7A60;
        Wed,  6 Apr 2022 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649235652; x=1680771652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tiv7QeQYk320EhgdYnj6Dr5WjXotDr2L+dj6zBG8/OA=;
  b=AwBc0QehmGLYTG4n4ZZKtNRzwPyTE1glYCET7IAEvZRyI/D9jH1FLkRo
   88r6fOJ/GF/pta2CDLEWlhYuAxJSpBuHVJs0MDGTARuYYgqKfS824h1SO
   +QOq/Sh+upQkGGs373iMmEm1sfmvs8xEh2h263QcCjJJ07vwNfklT0Kcu
   D/hcQVXNgyIbwDudiF9g1SOtSyw9tgEAcqwMF6qi5o8eU7HeM0qOpMfj/
   jnvD1fRanQySpZjt2mtNZixCayZJ7F0ez0CjRVXHbawVQb2H/ayA9s3+C
   n0WxNW6xTXnVSUf8h95Ni2fyG0molSg2fV1KhhSSWo7ZcO0lhTqKKu7jS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="241577635"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="241577635"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:00:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="524384610"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:00:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc1VJ-000BKC-GP;
        Wed, 06 Apr 2022 11:59:05 +0300
Date:   Wed, 6 Apr 2022 11:59:05 +0300
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
Message-ID: <Yk1WWaJ9IJsU5HXV@smile.fi.intel.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
 <20220405081911.1349563-6-miquel.raynal@bootlin.com>
 <YkxXUdMA75b8keSd@smile.fi.intel.com>
 <20220406094908.48ecc4bb@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406094908.48ecc4bb@xps13>
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

On Wed, Apr 06, 2022 at 09:49:08AM +0200, Miquel Raynal wrote:
> andriy.shevchenko@linux.intel.com wrote on Tue, 5 Apr 2022 17:50:57
> +0300:
> > On Tue, Apr 05, 2022 at 10:19:07AM +0200, Miquel Raynal wrote:

...

> > > +#define RZN1_DMAMUX_SPLIT 16
> >
> > I would name it more explicitly:
> > 
> > #define RZN1_DMAMUX_SPLIT_1_0	 16
> 
> I am sorry but I don't understand this suffix, which probably means
> that it is not as clear as we wish. Do you mind if I stick to
> RZN1_DMAMUX_SPLIT?

The suffix to show that this is the value between part 0 (indexed by 0) and
part 1 (indexed by 1) as far as I can see they are different by size. Since
they are not equal, the original name without suffix is confusing (I would
expect indexing up to 4 in such case).

-- 
With Best Regards,
Andy Shevchenko


