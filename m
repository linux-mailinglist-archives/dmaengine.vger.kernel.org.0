Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4204D50E9
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbiCJRv7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 12:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiCJRv7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 12:51:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E012F144;
        Thu, 10 Mar 2022 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646934658; x=1678470658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oK7blUt0TFCk1NJ5HyN0lfCWqR9i06S7tHBY6OymPcs=;
  b=PC6xLAGOoUM/V5TdGwY+JhWtto/4FQ5oYzTRF6B3oCrEYivaQDubKAEC
   KJfSHFV964I8eSeIzY/g3bKRnkoLD0xY8kTYGKfXQxvlYZUEeUpMRct34
   cqCv/8/D2e5ayO8wRcc9c/JPymSiWRAqsVzXqF7UJtwb2adT05GODwotk
   sY0MRoiQNQZBnCWRyYJ1WuLKan/XxGUiLOXNwqzxo01O6ngHuDm2KPdLY
   niWx+f8utec/wRxjqbp6Eu+AmfbWlE4NwnUAeniSsRkMKMbdb4T0ttHe1
   q48G+Pay2XblZ73tG4JwNSRdeJ9ufsRLSdZ64gJTQpJOQu6bbmgFsWEku
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341749142"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="341749142"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:50:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="644538148"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:50:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nSMvR-00Er5F-GG;
        Thu, 10 Mar 2022 19:50:09 +0200
Date:   Thu, 10 Mar 2022 19:50:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH v4 7/9] dma: dw: Avoid partial transfers
Message-ID: <Yio6UWYIDZWXx2Ux@smile.fi.intel.com>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
 <20220310155755.287294-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310155755.287294-8-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

+Cc: Ilpo who is currently doing adjoining stuff.

Ilpo, this one affects Intel Bay Trail and Cherry Trail platforms.
Not sure if it's in scope of your interest right now, but it might
be useful to see how DMA <--> 8250 UART functioning.

On Thu, Mar 10, 2022 at 04:57:53PM +0100, Miquel Raynal wrote:
> As investigated by Phil Edworthy <phil.edworthy@renesas.com> on RZN1 a

Email can be dropped as you put it below, just (full) name is enough.

I'm wondering if Phil or anybody else who possess the hardware can
test / tested this.

> while ago, pausing a partial transfer only causes data to be written to
> memory that is a multiple of the memory width setting. Such a situation
> can happen eg. because of a char timeout interrupt on a UART. In this
> case, the current ->terminate_all() implementation does not always flush
> the remaining data as it should.
> 
> In order to workaround this, a solutions is to resume and then pause
> again the transfer before termination. The resume call in practice
> actually flushes the remaining data.

Perhaps Fixes tag?

> Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/dma/dw/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 7ab83fe601ed..2f6183177ba5 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -862,6 +862,10 @@ static int dwc_terminate_all(struct dma_chan *chan)
>  
>  	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
>  
> +	/* Ensure the last byte(s) are drained before disabling the channel */
> +	if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
> +		dwc_chan_resume(dwc, true);
> +
>  	dwc_chan_pause(dwc, true);
>  
>  	dwc_chan_disable(dw, dwc);
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


