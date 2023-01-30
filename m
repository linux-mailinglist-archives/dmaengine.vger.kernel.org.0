Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63B680B2E
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 11:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjA3Kqe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjA3Kqb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 05:46:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6113303CA;
        Mon, 30 Jan 2023 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675075590; x=1706611590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TeDQ+XRbcpt1cTnSgCWfbh9yMP+nctrrh9gmlG7F6uc=;
  b=C1G5tB9sDs+dv3tH7DKsCk7KecQuoMH/tReGPXLHXikYOjciWWsqEvs3
   e+eCmqs7bQghJpSgNADSFtroN+z5lIEngvqs9YtSQdqaKeO5FJYoydT6c
   x+/7Hts2UyXE6LbdLggyuwOB+BOqcmZYZM2HurWyaXlCGOl5jfgrsr/xi
   ctzZNGNnJ5yPQwO5aGwBFnrofTsOOeJjwCa/jxxrLo1EFucjMCYp9p9XS
   QHzboIZgcX4WEDZHpuhDWqP/5vY1HAQS6TFF3tU57Z6Zt6AjrNnIULFOA
   OQPlKiXArRQjY4OFVdDimXVeHRX77zIOJ3SsrtxcSo6dJsOKbKRFWJv1n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="354843130"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="354843130"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 02:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="732655458"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="732655458"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2023 02:46:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMRgA-00HJ3c-2o;
        Mon, 30 Jan 2023 12:46:26 +0200
Date:   Mon, 30 Jan 2023 12:46:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Do not dereference NULL structure
Message-ID: <Y9egAuMYM+JyBZ3O@smile.fi.intel.com>
References: <20230127223623.never.507-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127223623.never.507-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 27, 2023 at 02:36:27PM -0800, Kees Cook wrote:
> If "vdesc" is NULL, it cannot be used with vd_to_axi_desc(). Leave
> "bytes" unchanged at 0. Seen under GCC 13 with -Warray-bounds:
> 
> ../drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'dma_chan_tx_status':
> ../drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:329:46: warning: array subscript 0 is outside array bounds of 'struct
> virt_dma_desc[46116860184273879]' [-Warray-bounds=]
>   329 |                 bytes = vd_to_axi_desc(vdesc)->length;
>       |                                              ^~
> 
> Fixes: 8e55444da65c ("dmaengine: dw-axi-dmac: Support burst residue granularity")
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 08af483331fd..4169e1d7d5ca 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -325,8 +325,6 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
>  		len = vd_to_axi_desc(vdesc)->hw_desc[0].len;
>  		completed_length = completed_blocks * len;
>  		bytes = length - completed_length;
> -	} else {
> -		bytes = vd_to_axi_desc(vdesc)->length;
>  	}
>  
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);

If you want to fix it properly, the code should be modified like

	status = dma_cookie_status(dchan, cookie, txstate);
	if (status == DMA_COMPLETE || !txstate) {
		if (txstate)
			goto out;
		return status;
	}

	...

out:
	dma_set_residue(txstate, bytes);

	return status;

to be in accordance with the Documentation.

**OR**

the Documentation should be fixed to tell that if status is DMA_COMPLETE,
residue is undefined and assumed to be 0.

Vinod?

-- 
With Best Regards,
Andy Shevchenko


