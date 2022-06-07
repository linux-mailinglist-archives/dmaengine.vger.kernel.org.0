Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6286154182A
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jun 2022 23:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359009AbiFGVJd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jun 2022 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379049AbiFGVIn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jun 2022 17:08:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150E421329C
        for <dmaengine@vger.kernel.org>; Tue,  7 Jun 2022 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654627860; x=1686163860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+IFA82BTf1vg/c1CM750oB0li57yhexf+/6W61dEKqs=;
  b=FDwxk2lZq8guSnoyw0ov4POd5KIaFfjO9XmUGKiLnplykzxHjjybYLLY
   It3yO9M+M7KlJN14iCwjUTpDLyFCnhCJ1U6fcVR0jOE+W79KNC8l60It0
   giQQOl5NVAIbe1pVAKiVcJeR6UVKSK24XTMDAqAQ9V31F5aMe34AglAo8
   6x8VC90Q4ifE4tAZ3oQuwapSwl8n1UPBUBGfdQkvbn9UpWd+A+GhlDaip
   44zUHNJdAACXvbI5ZPdOa8MfC6pv0PgdK4VDoX9hU0kYjMWiT6GnToaK4
   ShMpk5W9OdAI25DQ/iCUPz9HrBTniPbhMGbHhd951vTdqi+UyK+Bpm0D1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274272039"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="274272039"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 11:50:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="670122995"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 11:50:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyeHV-000Vxe-52;
        Tue, 07 Jun 2022 21:50:21 +0300
Date:   Tue, 7 Jun 2022 21:50:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] dmaengine: dw: dmamux: Fix build without CONFIG_OF
Message-ID: <Yp+d7PFFUBFKXwDm@smile.fi.intel.com>
References: <20220607152215.46731-1-miquel.raynal@bootlin.com>
 <20220607152215.46731-2-miquel.raynal@bootlin.com>
 <Yp99r87N7uyQYvwz@smile.fi.intel.com>
 <20220607191759.7e3a2fcc@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607191759.7e3a2fcc@xps-13>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 07, 2022 at 07:17:59PM +0200, Miquel Raynal wrote:
> andriy.shevchenko@linux.intel.com wrote on Tue, 7 Jun 2022 19:32:47
> +0300:
> > On Tue, Jun 07, 2022 at 05:22:15PM +0200, Miquel Raynal wrote:

...

> > No, what I asked is the opposite.
> 
> I don't get what you want. Can you please explain what you mean by
> "simply drop CONFIG_OF"?

The below code changes shouldn't be present in this patch, that's all.

...

> > > +#ifdef CONFIG_OF
> > >  static const struct of_device_id rzn1_dmamux_match[] = {
> > >  	{ .compatible = "renesas,rzn1-dmamux" },
> > >  	{}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, rzn1_dmamux_match);
> > > +#endif
> > >  
> > >  static struct platform_driver rzn1_dmamux_driver = {
> > >  	.driver = {
> > >  		.name = "renesas,rzn1-dmamux",
> > > -		.of_match_table = rzn1_dmamux_match,
> > > +		.of_match_table = of_match_ptr(rzn1_dmamux_match),
> > >  	},
> > >  	.probe	= rzn1_dmamux_probe,
> > >  };  

-- 
With Best Regards,
Andy Shevchenko


