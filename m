Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0DB621028
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 13:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiKHMSv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 07:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiKHMSu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 07:18:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BC2DFA4;
        Tue,  8 Nov 2022 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667909929; x=1699445929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+6VvK9ha+KX6/9CqNxcOWvA6lggCRnEoSwH1MbiLuN8=;
  b=dbiC09xreq8AwleDPgR0MXk6Ixx4E4YxyxRp39xIY5F+VU/3Idege/t9
   rAAQkO99qBosMLlvguplT7iIy587O8LoQk3UaSEyw5tGtrfDTn6UKyt9W
   6pfFw9XiAnbkW6rg09F1KkW9RB1DWIsYFiJKhnUCS5bHL8U0qiN+E87rF
   q85AxZRGkeSPKM809GGAP8alJwk708bdpTdZ8Zl1KXBrAl8pT/kUBGEOl
   cS7heWHtc5Mhfp57kLrcANXjWd7HCHUBSkdgJ76hcmm71wPoSJwUBHKzP
   JAQZmmqhi1Eh8Z4cbJf877B2lSds21BEoXsD7RdPHb7+c2L5ap6+GkW5j
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="311834500"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="311834500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="667568306"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="667568306"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2022 04:18:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osNYz-0097h3-1a;
        Tue, 08 Nov 2022 14:18:45 +0200
Date:   Tue, 8 Nov 2022 14:18:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tudor.Ambarus@microchip.com
Cc:     vkoul@kernel.org, Nicolas.Ferre@microchip.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com
Subject: Re: [PATCH v1 1/2] at_hdmac: check and return DMA_PAUSED status when
 suitable
Message-ID: <Y2pJJb6KwwcAMZw8@smile.fi.intel.com>
References: <20221108074938.48853-1-andriy.shevchenko@linux.intel.com>
 <d3d93452-70e6-72e5-b28e-1b259d1e489c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d93452-70e6-72e5-b28e-1b259d1e489c@microchip.com>
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

On Tue, Nov 08, 2022 at 11:50:19AM +0000, Tudor.Ambarus@microchip.com wrote:
> On 11/8/22 09:49, Andy Shevchenko wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > device_tx_status() may return DMA_PAUSED status when driver supports it.
> 
> Yeah, but you haven't described the why. And that's because dma_cookie_status()
> currently considers just DMA_COMPLETE and DMA_IN_PROGRESS for the status of the
> cookie, so the controller drivers are forced to query the DMA_PAUSED state
> themselves.

At last without this change it's inconvenient and requires a lot of additional
(unneeded) code to be written by the caller. Moreover, it's racy. If you query
status twice in a raw, it may be well changed (for example from PAUSED to
IN_PROGRESS or COMPETE).

I will add a word summarizing this.

> Also, I noticed that Vinod prefers that you use the full paragraph in the commit
> message, and not a continuation of the patch title, so you may want to reword
> the commit message.

Yes, I will fix that.

...

> > +       if (!txstate) {
> > +               if (test_bit(ATC_IS_PAUSED, &atchan->status))
> 
> there's a helper function that you can use instead: atc_chan_is_paused()

Will use it.

> > +                       return DMA_PAUSED;
> > +               return DMA_ERROR;
> 
> return dma_status please

Will squash the patch.

> > +       }

...

> > +       if (test_bit(ATC_IS_PAUSED, &atchan->status))
> 
> The status may change after spin_unlock_irqrestore(). Should the residue
> be in sync with the dma status? If yes, you should check the status while
> holding the lock.

You should tell me actually. Because I'm a bit puzzled why we need a spin lock
_and_ atomic bit operations together.

> > +               dma_status = DMA_PAUSED;

...

Thank you for the review.

-- 
With Best Regards,
Andy Shevchenko


