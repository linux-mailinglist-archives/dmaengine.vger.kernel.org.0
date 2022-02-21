Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC84BDC7A
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381314AbiBUQyQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 11:54:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiBUQyP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 11:54:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4913122534;
        Mon, 21 Feb 2022 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645462432; x=1676998432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jFAKX07sax2uMuZwpnIsQeZvNSQX6LJPr86+iOLPjR4=;
  b=ZCJ/1rlP/8Z/iiIBndgFo90PRraxskZEkTXvUuVY34Fnin+P6FOYfWzK
   vKdAUIbP1VBDf9aZ6wjVC+7/uJ2LZYgBCSV21fe/j998iwGLeE7InxWfX
   rBuskH3Oaclkc+8sGUiCOdIG1nVtjNrMJaLbtrl1IVIYdU0V1EEaFQGkQ
   zA7aMqur2eubkJ/a04mwMpvczwtuMx/Z0yHYag7d1y2WEZNIDo1EYWuWc
   0lyO5CSKZcCyqrRs2Dr+hAoTBjdr7RE/wBvvtdCn0GEandSp4GsOgDgWC
   JAe4XYr8fpDDBHaRVvbFXokEyPatzF7R+piViFyXBO0Dg2C+lXX3FYPZF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314803674"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="314803674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 08:53:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="706312552"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 08:53:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMBvj-006rFh-Ly;
        Mon, 21 Feb 2022 18:52:55 +0200
Date:   Mon, 21 Feb 2022 18:52:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: Re: [PATCH 5/8] dma: dw: Avoid partial transfers
Message-ID: <YhPDZ4yb50sMdVgV@smile.fi.intel.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
 <20220218181226.431098-6-miquel.raynal@bootlin.com>
 <YhIcyyBp53LnMbjU@smile.fi.intel.com>
 <TYYPR01MB7086F412B035A09AED2037A9F53A9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYYPR01MB7086F412B035A09AED2037A9F53A9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
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

On Mon, Feb 21, 2022 at 08:14:47AM +0000, Phil Edworthy wrote:
> Hi Andy,
> 
> I wrote the patch a few years ago, but didn't get the time to upstream it.
> 
> I am not aware of a HW integration bug on the RZ/N1 device but can't rule it
> out. I am struggling to see what kind of HW issue this could be as, iirc,
> word accesses work fine when the size of the transfer is a multiple of the
> MEM width.
> 
> I found the issue when testing DMA with the UART transferring different amounts of data.

Can you tell more about the setup and test cases?

Also, which version of the DW DMAC IP is being used in this SoC?

...

> > > +		if (sconfig->dst_addr_width && sconfig->dst_addr_width <
> > data_width)
> > > +			data_width = sconfig->dst_addr_width;
> > 
> > But here no check that you do it for explicitly peripheral to memory, so
> > this
> > will affect memory to peripheral transfers as well.
> No, this should be ok as this change is within:
> 	case DMA_DEV_TO_MEM:

Ah, it's better. But still unclear to me why we need this.

P.S. Please avoid top-postings.

> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: 20 February 2022 10:50
> > On Fri, Feb 18, 2022 at 07:12:23PM +0100, Miquel Raynal wrote:

> > > Pausing a partial transfer only causes data to be written to mem that is
> > > a multiple of the memory width setting.
> > >
> > > However, when a DMA client driver finishes DMA early, e.g. due to UART
> > > char timeout interrupt, all data read from the DEV must be written to
> > MEM.
> > >
> > > Therefore, allow the slave to limit the memory width to ensure all data
> > > read from the DEV is written to MEM when DMA is paused.
> > 
> > Is this a fix?
> > What happens to the data if you don't do this?
> > As far as I understood the Synopsys DesignWare specification the DMA
> > controller
> > is capable of flushing FIFO in that case on byte-by-byte basis. Do you
> > have an
> > HW integration bug?
> > 
> > TL;DR: tell us more about this.
> > 
> > ...
> > 
> > > +		if (sconfig->dst_addr_width && sconfig->dst_addr_width <
> > data_width)
> > > +			data_width = sconfig->dst_addr_width;
> > 
> > But here no check that you do it for explicitly peripheral to memory, so
> > this
> > will affect memory to peripheral transfers as well.

-- 
With Best Regards,
Andy Shevchenko


