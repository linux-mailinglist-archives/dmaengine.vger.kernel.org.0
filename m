Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8812B545172
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 17:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiFIP7P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiFIP7O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 11:59:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8D1EA87E
        for <dmaengine@vger.kernel.org>; Thu,  9 Jun 2022 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654790352; x=1686326352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Ta0Mb+lhR2SZvITBApJW2yMsnoPPqFduVONCIqnMN4=;
  b=giWGRdNlskV99aJop3c95RzpFXNeakN4bGl33nv3p221oV2rg5Z8wYrs
   wETfV97VX0SfbzSPcGC3LYzEdeWoWoYyz68VqOeOWeDrW1WHGf99f8fr5
   tgJZ6G89tz4gj8vP6QaPWhUgUGawoHtv5yImggUuiujOFH4zBuYnhORWl
   +lEFMvua5vVNch3D+RmKBzUtwDuckDEhRDIhUr63A7k0UszpISWIWkHBa
   3wcUTGGov2s9ZbtJZ37arq3U43xE0GiC8AgpaDgwIRR76O5uj8mc74kxz
   +T4d0qjWhlkG/Z6Jusmm3HNRVpUcVT7Q+cyYOD9oknIM3yEtKn7kv3vB5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="274851298"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="274851298"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:59:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="724495396"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:59:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzKYs-000Y0n-8w;
        Thu, 09 Jun 2022 18:59:06 +0300
Date:   Thu, 9 Jun 2022 18:59:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        ilpo.jarvinen@linux.intel.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/2] dmaengine: dw: dmamux: Fix build without CONFIG_OF
Message-ID: <YqIYyrf0S5p+YmMY@smile.fi.intel.com>
References: <20220609141455.300879-1-miquel.raynal@bootlin.com>
 <20220609141455.300879-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609141455.300879-2-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 09, 2022 at 04:14:55PM +0200, Miquel Raynal wrote:
> When built without OF support, of_match_node() expands to NULL, which
> produces the following output:
> >> drivers/dma/dw/rzn1-dmamux.c:105:34: warning: unused variable 'rzn1_dmac_match' [-Wunused-const-variable]
>    static const struct of_device_id rzn1_dmac_match[] = {
> 
> One way to silence the warning is to enclose the structure definition
> with an #ifdef CONFIG_OF/#endif block.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes in v3:
> * Did not extend the change to the second match table as requested by Andy.
> * Added a Fixes tag.
> 
> Changes in v2:
> * Used the #ifdef solution rather than the __maybe_unused keyword.
> 
>  drivers/dma/dw/rzn1-dmamux.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
> index 0ce4fb58185e..f9912c3dd4d7 100644
> --- a/drivers/dma/dw/rzn1-dmamux.c
> +++ b/drivers/dma/dw/rzn1-dmamux.c
> @@ -102,10 +102,12 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>  	return ERR_PTR(ret);
>  }
>  
> +#ifdef CONFIG_OF
>  static const struct of_device_id rzn1_dmac_match[] = {
>  	{ .compatible = "renesas,rzn1-dma" },
>  	{}
>  };
> +#endif
>  
>  static int rzn1_dmamux_probe(struct platform_device *pdev)
>  {
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


