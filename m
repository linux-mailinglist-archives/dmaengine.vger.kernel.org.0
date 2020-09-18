Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56E26FC6A
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRMY5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 08:24:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:55411 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRMY5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 08:24:57 -0400
IronPort-SDR: +Em5LBh7D+Ae3TkVqFnjFKRCspsw6mzjK2Bv0+VCTlB+n2UzgvwbuzRqOyRGA2dkP/oJnPvR3O
 J4Z+egc3mYzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244758112"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="244758112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 05:24:56 -0700
IronPort-SDR: Su8fdFmcA3/oHfW7dwfrBVBZ5nPDpHh2UfBATeDBd5RZdgyftr9w2pkedjNDSbwRoeTSm7Zxfy
 /wLgwMkP6GbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="336787905"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2020 05:24:53 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kJFNN-00HZtB-Sl; Fri, 18 Sep 2020 15:20:29 +0300
Date:   Fri, 18 Sep 2020 15:20:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v6 2/2] Add Intel LGM soc DMA support.
Message-ID: <20200918122029.GX3956970@smile.fi.intel.com>
References: <cover.1599605765.git.mallikarjunax.reddy@linux.intel.com>
 <748370a51af0ab768e542f1537d1aa3aeefebe8a.1599605765.git.mallikarjunax.reddy@linux.intel.com>
 <20200909111424.GQ1891694@smile.fi.intel.com>
 <36a42016-3260-3933-bbf9-9203c4124115@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36a42016-3260-3933-bbf9-9203c4124115@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 18, 2020 at 11:42:54AM +0800, Reddy, MallikarjunaX wrote:
> On 9/9/2020 7:14 PM, Andy Shevchenko wrote:
> > On Wed, Sep 09, 2020 at 07:07:34AM +0800, Amireddy Mallikarjuna reddy wrote:

...

> > > +	help
> > > +	  Enable support for intel Lightning Mountain SOC DMA controllers.
> > > +	  These controllers provide DMA capabilities for a variety of on-chip
> > > +	  devices such as SSC, HSNAND and GSWIP.
> > And how module will be called?
>  are you expecting to include 'default y' ?

I'm expecting to see something like "if you choose M the module will be called
bla-foo-bar." Look at the existing examples in the kernel.

...

> > > +ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
> > > +{
> > > +	u32 old_val, new_val;
> > > +
> > > +	old_val = readl(d->base +  ofs);
> > > +	new_val = (old_val & ~mask) | (val & mask);
> > With bitfield.h you will have this as u32_replace_bits().
> -  new_val = (old_val & ~mask) | (val & mask);
> + new_val = old_val;
> + u32_replace_bits(new_val, val, mask);
> 
> I think in this function we cant use this because of compilation issues
> thrown by bitfield.h . Expecting 2nd and 3rd arguments as constant numbers
> not as type variables.
> 
> ex:
> 	u32_replace_bits(val, 0, IPA_REG_ENDP_ROUTER_HASH_MSK_ALL);

How comes these are constants? In the above you have a function which does
r-m-w approach to the register. It should be something like

	old = read();
	new = u32_replace_bits(old, ...);
	write(new);

> ./include/linux/bitfield.h:131:3: error: call to '__field_overflow' declared
> with attribute error: value doesn't fit into mask
>    __field_overflow();     \
>    ^~~~~~~~~~~~~~~~~~
> 
> ./include/linux/bitfield.h:119:3: error: call to '__bad_mask' declared with
> attribute error: bad bitfield mask
>    __bad_mask();
>    ^~~~~~~~~~~~

So, even with constants u32_replace_bits() must work. Maybe you didn't get how?

> > > +	if (new_val != old_val)
> > > +		writel(new_val, d->base + ofs);
> > > +}

...

> > > +	/* High 4 bits */
> > Why only 4?
> this is higher 4 bits of 36 bit addressing..

Make it clear in the comment.

...

> > > +device_initcall(intel_ldma_init);
> > Each _initcall() in general should be explained.
> ok. is it fine?
> 
> /* Perform this driver as device_initcall to make sure initialization
> happens
>  * before its dma clients of some are platform specific. make sure to
> provice
>  * registered dma channels and dma capabilities to client before their
>  * initialization.
>  */

/*
 * Just follow proper multi-line comment style.
 * And use dma -> DMA.
 */

-- 
With Best Regards,
Andy Shevchenko


