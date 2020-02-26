Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB9170059
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 14:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgBZNoz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 08:44:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:4853 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgBZNoz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 26 Feb 2020 08:44:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 05:44:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="226720260"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 26 Feb 2020 05:44:52 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j6wze-004wMs-ST; Wed, 26 Feb 2020 15:44:54 +0200
Date:   Wed, 26 Feb 2020 15:44:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 3/4] dmaengine: Drop redundant 'else' keyword
Message-ID: <20200226134454.GP10400@smile.fi.intel.com>
References: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
 <20200226101842.29426-3-andriy.shevchenko@linux.intel.com>
 <55eafd8a-d36b-5de3-ad55-ab73d9d56146@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55eafd8a-d36b-5de3-ad55-ab73d9d56146@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 26, 2020 at 02:37:27PM +0200, Peter Ujfalusi wrote:
> On 2/26/20 12:18 PM, Andy Shevchenko wrote:
> > It's obvious that 'else' keyword is redundant in the code like
> > 
> > 	if (foo)
> > 		return bar;
> > 	else if (baz)
> > 		...
> > 
> > Drop it for good.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/dmaengine.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index ae56a91c2a05..1bb5477ef7ec 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -1230,9 +1230,9 @@ static inline int dma_maxpq(struct dma_device *dma, enum dma_ctrl_flags flags)
> >  {
> >  	if (dma_dev_has_pq_continue(dma) || !dmaf_continue(flags))
> >  		return dma_dev_to_maxpq(dma);
> > -	else if (dmaf_p_disabled_continue(flags))
> > +	if (dmaf_p_disabled_continue(flags))
> 
> I would add blank line in between the - new - if cases for better
> readability.

Thank you for review and comment.

Here I have opposite opinion, but let Vinod and Dan, as maintainers, to decide.
I'll be not against it if it's preferred way.

> >  		return dma_dev_to_maxpq(dma) - 1;
> > -	else if (dmaf_continue(flags))
> > +	if (dmaf_continue(flags))
> >  		return dma_dev_to_maxpq(dma) - 3;
> >  	BUG();
> >  }
> > @@ -1243,7 +1243,7 @@ static inline size_t dmaengine_get_icg(bool inc, bool sgl, size_t icg,
> >  	if (inc) {
> >  		if (dir_icg)
> >  			return dir_icg;
> > -		else if (sgl)
> > +		if (sgl)
> >  			return icg;
> >  	}
> >  
> > 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
With Best Regards,
Andy Shevchenko


