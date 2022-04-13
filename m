Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50B4FF506
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 12:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiDMKqh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiDMKqh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 06:46:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BCDD79;
        Wed, 13 Apr 2022 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649846656; x=1681382656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x9E2RFAN71HpM67BWa4dSYQic81dchrB24zFdE659L8=;
  b=ZKpLH0n3qM1fis2yxaRGg6vQZj7NpFxkptRkqaUZnrVSTNmMCwUaUZHl
   ghgJERnDp3yLV332FMyQdC47D4qlsXRGDptQk/ShDouatLGRFGlWrtp49
   DM/MC2Occ632C9X7CdYUULg5B5lcI0J3BJhHw8vvw/2kMN7X2T41F53sz
   qpI5XEnUgItERIZkkpBCmNEPJDHhuPUhwa8gpZY3xuJEHiMJVvdx0YZ5M
   z//ObHNGpy0XPiXj3EroRbao4kND/ELBbgJU3rHnBH2KJKkkH/z+YKsbr
   xhi96+t+Ny6+KJXiYJlvsFFAPoMlxM8vfLjnMQE0TCPlUlsGrcRiB6ttk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="325539005"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="325539005"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:44:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="645121759"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:44:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neaQF-001nNb-At;
        Wed, 13 Apr 2022 13:40:27 +0300
Date:   Wed, 13 Apr 2022 13:40:27 +0300
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
Message-ID: <Ylaom9pRMm0C0Nsz@smile.fi.intel.com>
References: <20220412193936.63355-1-miquel.raynal@bootlin.com>
 <20220412193936.63355-6-miquel.raynal@bootlin.com>
 <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
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

On Wed, Apr 13, 2022 at 09:53:09AM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 12, 2022 at 9:39 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:

...

> You might as well declare it in rzn1_dmamux_data as:
> 
>     unsigned long used_chans[BITS_TO_LONGS(2 * RZN1_DMAMUX_MAX_LINES)];

But better to use proper macro instead of open coding this...

-- 
With Best Regards,
Andy Shevchenko


