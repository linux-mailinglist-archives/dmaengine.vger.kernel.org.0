Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD64F4F87
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 04:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbiDFAwZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 20:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452300AbiDEPyp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 11:54:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919765DA11;
        Tue,  5 Apr 2022 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649170333; x=1680706333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j43We/NuvgFWbEzhQtKpK2IXQeIEAZ3DIUzlKkfSios=;
  b=jTlBpo9ZT6SqJacT5oR1fLrCnaPgfGk6jVqC62Ow50/3MoG9m+pkBFuU
   eRHQ2wLiAny8t4ETbGTWWKFPitJHkUZOXZJ1ICmvCgQkLuWMFnZc7tRD5
   2EaxEZ8Boec9KEk9ww0tRB4dAdJmdCa+9IR06ZrTmDF0PcuO04H845AZ2
   r6uvZ5qA1TZW36mBM9PhRaSp+dxI+RJNpaByoNpYTcmIRbouXifAvNFuw
   IZeekotsd7dmXnsiCdildrpC33pod68Kj2AHO4D36wBQndLzNXprnCGHG
   8u/bZHrmozfTTejvnDKnAnND8iVex95QGVm0FRs/FFKl9hPoRPQTydFK5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="347207507"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="347207507"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:52:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="524023886"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:51:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nbkWl-00DQ4I-K7;
        Tue, 05 Apr 2022 17:51:27 +0300
Date:   Tue, 5 Apr 2022 17:51:27 +0300
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v7 7/9] dmaengine: dw: Add RZN1 compatible
Message-ID: <YkxXb5moC6/DkRwV@smile.fi.intel.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
 <20220405081911.1349563-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405081911.1349563-8-miquel.raynal@bootlin.com>
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

On Tue, Apr 05, 2022 at 10:19:09AM +0200, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is very close to the original DW DMA IP, a DMA
> router has been introduced to handle the wiring options that have been
> added.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/dma/dw/platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
> index 246118955877..47f2292dba98 100644
> --- a/drivers/dma/dw/platform.c
> +++ b/drivers/dma/dw/platform.c
> @@ -137,6 +137,7 @@ static void dw_shutdown(struct platform_device *pdev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id dw_dma_of_id_table[] = {
>  	{ .compatible = "snps,dma-spear1340", .data = &dw_dma_chip_pdata },
> +	{ .compatible = "renesas,rzn1-dma", .data = &dw_dma_chip_pdata },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


