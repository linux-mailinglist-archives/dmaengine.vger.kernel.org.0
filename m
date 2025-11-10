Return-Path: <dmaengine+bounces-7129-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06026C47905
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9B018874F4
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5F25A2AE;
	Mon, 10 Nov 2025 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbOW3SK3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7911D416C;
	Mon, 10 Nov 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788828; cv=none; b=HbIUavC2w4Yk1yNMo8ec8FLp/szJWHP30UjfDy9XCik6n5ztR+ubC8vW9mBTxFbDVCytFpcRZ2hN1SOC/Ps5Z0tLBXB0sv3Tjp8ocep08D+dKQF61NhQVKQrb69AtTu56MKWMbMELtKa/7clu5VZtVyMtwc8rOOXbDIO0qsgtIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788828; c=relaxed/simple;
	bh=+rymyB2H1GCpplFZN98ExnpzW0O9nCkV8E0c0HQjmWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuJcQbQ1lHRtr0l1FxPEniXCdPrvXmugWm3KQAfZFoJRcmkRKGeV8YgPwN3MJJuCoCZbOY/LyA5Co5bDzQkQWgiVPWIZrNlTlecQ9/cDhrxmnDgJ2VK6rHc3yzcc68RMijDs65Arjzf1vFA+icxzaNcyJeQnr+co6YdcML7nG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbOW3SK3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762788826; x=1794324826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+rymyB2H1GCpplFZN98ExnpzW0O9nCkV8E0c0HQjmWE=;
  b=UbOW3SK3fZRqEhqvS0xR8aj0rQFNGsXYJNhWFvrHN37ppp9EXmAfzI5m
   y6VMyXcKEDObbAMQ/56auh9nQk4pY5CMGFBIv/YfYSjM/nDaewc0fBlgR
   tAUtrJMGpvQKO2LisIHdUAbi3KamcWHYe4fnReASai1QMfzNsf2ekMlOV
   J8LvC/at8btzoS2YD29iPDrazsT1QlJl+qp/VcmaIsSdeQ6E4rZlg/Q/L
   r0u/tkfeuPfZ1OkrRdtrouOCJevfLqWMldpldtDOUbYofNh8HOU03Flxr
   vcpy1kch5KWbJMmd+Oj9LpwEliX4/V2Hf7q6lgIaxNuq8GyqZYvPK9xPT
   A==;
X-CSE-ConnectionGUID: cADGsg1wSXqZSRXQBd8VmA==
X-CSE-MsgGUID: +Yg0UMphRsmL9Pdq9yuVlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82237648"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="82237648"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 07:33:38 -0800
X-CSE-ConnectionGUID: IwSUOry/SDKpLQ2tpxmPnA==
X-CSE-MsgGUID: fQundh82RRibb0QT8W8jhQ==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.235])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 07:33:33 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vITtZ-00000007V6M-2rxB;
	Mon, 10 Nov 2025 17:33:29 +0200
Date: Mon, 10 Nov 2025 17:33:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/13] scatterlist: introduce sg_nents_for_dma() helper
Message-ID: <aRIFyR0maAfZF7MN@smile.fi.intel.com>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
 <20251110103805.3562136-2-andriy.shevchenko@linux.intel.com>
 <waid6zxayuxacb6sntlxwgyjia3w25sfz2tzxxzb4tkqgmx63o@ndpztxeh6o32>
 <jea2owcqtjeomlbwkfopt3ujsnakn4p3xeyqhh7s4kowf7k7dr@deyg5pky5udo>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jea2owcqtjeomlbwkfopt3ujsnakn4p3xeyqhh7s4kowf7k7dr@deyg5pky5udo>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 09:21:18AM -0600, Bjorn Andersson wrote:
> On Mon, Nov 10, 2025 at 09:05:26AM -0600, Bjorn Andersson wrote:
> > On Mon, Nov 10, 2025 at 11:23:28AM +0100, Andy Shevchenko wrote:

...

> > >  int sg_nents(struct scatterlist *sg);
> > >  int sg_nents_for_len(struct scatterlist *sg, u64 len);
> > > +int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len);


^^^

> > > +int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len)
> 
> All but two clients store the value in an unsigned int. Changing the
> return type to unsigned int also signals that the function is just
> returning a count (no errors).

The type is chosen for the consistency with the existing APIs.
So, I prefer consistency in this case, if we need to change type, we need to do
that for all above APIs I believe. And this is out of the scope here.

Personally I was also puzzled of the choice as *nents members are all unsigned
int in the scatterlist.h.

...

> > We need an EXPORT_SYMBOL() here.

Good catch! I'll add it in next version.

> > With that, this looks good to me.
> > 
> > Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



