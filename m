Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F06750A9F
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 16:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjGLOQV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjGLOQQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 10:16:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637951BDF;
        Wed, 12 Jul 2023 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689171373; x=1720707373;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Os8ND3nqigTu76dQVguaSEK1X3J11jRaSqtTnbGNiqI=;
  b=Rh4CsPGHXqHyUgpOoJcdlKbZRZX7w+Ir0YseszgrE//K1wNbau3QaWmz
   MFfgV+ErjhofDuWFwLG/K4M5Z5tIzossSXW0QB4NnvXkgTyUPkkoNM10w
   H37wB27OIhEZxCmJAYpo3G9O7s2/EFOL6M39nPfw2L8TOLy5r27bbWSSO
   8MPK9vthRnQlifdXnXTMT4UEA3LUzO1XuZMfN0ErERoUthI3cZobm0kkU
   SXyzNym3HyabcglBcB2xmUuRI4BtmVFIsqCfQJCHi4FE3/3TCeP4VFul+
   y2HN4XirneXXPpYfhuDR1oreYkxv7RRf4zD/y+wSdbAlkjzMASbUUkKAt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="354807596"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="354807596"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 07:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791640967"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="791640967"
Received: from agermosh-mobl1.amr.corp.intel.com ([10.252.43.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 07:16:09 -0700
Date:   Wed, 12 Jul 2023 17:16:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Robert Baldyga <r.baldyga@samsung.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Tresidder <rtresidd@electromag.com.au>,
        stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: Return DMA_PAUSED when transaction is
 paused
In-Reply-To: <ZKUceu9iJuAAeYYT@matsya>
Message-ID: <f99696c-df19-2e6d-d48c-b3f2c3481e22@linux.intel.com>
References: <20230526105434.14959-1-ilpo.jarvinen@linux.intel.com> <ZKUceu9iJuAAeYYT@matsya>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-329618449-1689166921=:1670"
Content-ID: <6466d25e-fcdb-cadb-f4f8-49c884fcba48@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-329618449-1689166921=:1670
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <44d86a3c-f85c-567d-6dd2-de905c6fb7c0@linux.intel.com>

On Wed, 5 Jul 2023, Vinod Koul wrote:

> On 26-05-23, 13:54, Ilpo Järvinen wrote:
> > pl330_pause() does not set anything to indicate paused condition which
> > causes pl330_tx_status() to return DMA_IN_PROGRESS. This breaks 8250
> > DMA flush after the fix in commit 57e9af7831dc ("serial: 8250_dma: Fix
> > DMA Rx rearm race"). The function comment for pl330_pause() claims
> > pause is supported but resume is not which is enough for 8250 DMA flush
> > to work as long as DMA status reports DMA_PAUSED when appropriate.
> > 
> > Add PAUSED state for descriptor and mark BUSY descriptors with PAUSED
> > in pl330_pause(). Return DMA_PAUSED from pl330_tx_status() when the
> > descriptor is PAUSED.
> 
> Have you noticed the comment in the code which reads:
> 
> /*
>  * We don't support DMA_RESUME command because of hardware
>  * limitations, so after pausing the channel we cannot restore
>  * it to active state. We have to terminate channel and setup
>  * DMA transfer again. This pause feature was implemented to
>  * allow safely read residue before channel termination.
>  */

I'm aware of this limitation (and comment) but it's not causing a problem 
here since serial8250_rx_dma_flush() does not need to call resume, it 
requires only supporting pause + reading the state/status.

> So driver just stops when in pause.

It not only stops but keeps claiming it's still not stopped which causes 
the problem in 8250 code because 8250 DMA code assumes DMA side returns 
the correct status.

> Now the commit 57e9af7831dc returns when in progress state, so am not
> sure how returning Paused would help here?

In serial8250_rx_dma_flush() 8250 DMA code does this:
		dmaengine_pause(dma->rxchan);
                __dma_rx_complete(p);
                dmaengine_terminate_async(dma->rxchan);

As you can see, __dma_rx_complete() would not take that return when called 
from serial8250_rx_dma_flush() if correct DMA_* status would be returned.

The return in __dma_rx_complete() is meant for other paths (as shown in 
57e9af7831dc's changelog) but is now currently taken also when called 
from serial8250_rx_dma_flush() because pl330 keeps returning 
DMA_IN_PROGRESS instead of DMA_PAUSED. Thus, I created this fix.

-- 
 i.


> > Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> > Tested-by: Richard Tresidder <rtresidd@electromag.com.au>
> > Fixes: 88987d2c7534 ("dmaengine: pl330: add DMA_PAUSE feature")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/linux-serial/f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au/
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > 
> > $ diff -u <(git grep -l -e '\.device_pause' -e '->device_pause') <(git grep -l DMA_PAUSED)
> > 
> > ...tells there might a few other drivers which do not properly return
> > DMA_PAUSED status despite having a pause function.
> > 
> >  drivers/dma/pl330.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index 0d9257fbdfb0..daad25f2c498 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -403,6 +403,12 @@ enum desc_status {
> >  	 * of a channel can be BUSY at any time.
> >  	 */
> >  	BUSY,
> > +	/*
> > +	 * Pause was called while descriptor was BUSY. Due to hardware
> > +	 * limitations, only termination is possible for descriptors
> > +	 * that have been paused.
> > +	 */
> > +	PAUSED,
> >  	/*
> >  	 * Sitting on the channel work_list but xfer done
> >  	 * by PL330 core
> > @@ -2041,7 +2047,7 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
> >  	list_for_each_entry(desc, &pch->work_list, node) {
> >  
> >  		/* If already submitted */
> > -		if (desc->status == BUSY)
> > +		if (desc->status == BUSY || desc->status == PAUSED)
> >  			continue;
> >  
> >  		ret = pl330_submit_req(pch->thread, desc);
> > @@ -2326,6 +2332,7 @@ static int pl330_pause(struct dma_chan *chan)
> >  {
> >  	struct dma_pl330_chan *pch = to_pchan(chan);
> >  	struct pl330_dmac *pl330 = pch->dmac;
> > +	struct dma_pl330_desc *desc;
> >  	unsigned long flags;
> >  
> >  	pm_runtime_get_sync(pl330->ddma.dev);
> > @@ -2335,6 +2342,10 @@ static int pl330_pause(struct dma_chan *chan)
> >  	_stop(pch->thread);
> >  	spin_unlock(&pl330->lock);
> >  
> > +	list_for_each_entry(desc, &pch->work_list, node) {
> > +		if (desc->status == BUSY)
> > +			desc->status = PAUSED;
> > +	}
> >  	spin_unlock_irqrestore(&pch->lock, flags);
> >  	pm_runtime_mark_last_busy(pl330->ddma.dev);
> >  	pm_runtime_put_autosuspend(pl330->ddma.dev);
> > @@ -2425,7 +2436,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> >  		else if (running && desc == running)
> >  			transferred =
> >  				pl330_get_current_xferred_count(pch, desc);
> > -		else if (desc->status == BUSY)
> > +		else if (desc->status == BUSY || desc->status == PAUSED)
> >  			/*
> >  			 * Busy but not running means either just enqueued,
> >  			 * or finished and not yet marked done
> > @@ -2442,6 +2453,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> >  			case DONE:
> >  				ret = DMA_COMPLETE;
> >  				break;
> > +			case PAUSED:
> > +				ret = DMA_PAUSED;
> > +				break;
> >  			case PREP:
> >  			case BUSY:
> >  				ret = DMA_IN_PROGRESS;
> > -- 
> > 2.30.2
> 
> 
--8323329-329618449-1689166921=:1670--
