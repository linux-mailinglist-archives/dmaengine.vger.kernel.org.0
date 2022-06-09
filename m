Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B712154516A
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiFIP6m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiFIP6l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 11:58:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0F1D2ACE
        for <dmaengine@vger.kernel.org>; Thu,  9 Jun 2022 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654790319; x=1686326319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifloQWQIUtgR6y8wf3XHxnRW7kDeb+ewI/WTlXUwdek=;
  b=DaG2AAOxPB77kkvHuJx5Lhy/3pE+g4fJZ69rNTrYFgxZl8Qhe+u18OXx
   GdvdxWyXY+DZx8F8jIZOuLNP53GOyRxuWgzMEPiuonNNsW51IGODGUHQv
   AXdAbvMM5NG2c8MVLnHKy5461lVDjaCqDz7qqWi9B8TCEgyInjCVajU8s
   hX08tg/J+l0t4xEMC31yhxrGv3aYELCpglbS8/pZUNjP1nEJEbfzZZgZK
   myxXG5hastRDmB95+Io4pfsth60lSeWBzBn7t91bUpQ/xW3KeeYcbMjE0
   T/ug+ahYun84KhfRDUHvXjCTsbvc1AKkAaEyWSl18YgrpYvPRNrKyCk+Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257154281"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257154281"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:58:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="671376360"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:58:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzKXz-000Y0g-Vu;
        Thu, 09 Jun 2022 18:58:11 +0300
Date:   Thu, 9 Jun 2022 18:58:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v3 1/2] dmaengine: dw: dmamux: Export the module device
 table
Message-ID: <YqIYk4jP4zwikt4P@smile.fi.intel.com>
References: <20220609141455.300879-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609141455.300879-1-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 09, 2022 at 04:14:54PM +0200, Miquel Raynal wrote:
> This is a tristate driver that can be built as a module, as a result,
> the OF match table should be exported with MODULE_DEVICE_TABLE().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes in v3:
> * Added a Fixes tag.
> 
> Changes in v2:
> * New patch.
> 
>  drivers/dma/dw/rzn1-dmamux.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
> index 11d254e450b0..0ce4fb58185e 100644
> --- a/drivers/dma/dw/rzn1-dmamux.c
> +++ b/drivers/dma/dw/rzn1-dmamux.c
> @@ -140,6 +140,7 @@ static const struct of_device_id rzn1_dmamux_match[] = {
>  	{ .compatible = "renesas,rzn1-dmamux" },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, rzn1_dmamux_match);
>  
>  static struct platform_driver rzn1_dmamux_driver = {
>  	.driver = {
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


