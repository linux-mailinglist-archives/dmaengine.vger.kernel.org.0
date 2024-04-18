Return-Path: <dmaengine+bounces-1903-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A078AA477
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 23:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63081F2159E
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 21:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6A19069F;
	Thu, 18 Apr 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPl5kAtR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B4165FD6;
	Thu, 18 Apr 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474047; cv=none; b=E93PKmbGR5YK9lL0/PaFSWxGhPGe1oMOw4In4m9kPwcYhSXWIO8OAhv9n7s2YnijcJnRkhg2oCS+oJLHHc2A/mhiBqOvuG4v8l7ZMbWlk0+9teaXxe2EhXEZoJkvNmHZO7XlaZulHKM6zcOiSA/Oele56ZwkVMnkxBOWMXHZvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474047; c=relaxed/simple;
	bh=8FcS+d3XqPALYlKipast1fx6gvgoQgjVL9Fu3VpDnLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPtLob/FQ03bJZDd9MdTIIDhke3NtPJnGjcf25Qzx6HRAhwEXrV8ERrctcG7NHEyvaJf1SAbVntHnS8sZSnZLS2haQxDb9RkeWjxFQYik6mUGxcoZ2H2hbzXlkKvSQLI83reGjFVk+CDzAeHLq8+C+A3ylYzpT0wbmDIzZj4A/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPl5kAtR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713474047; x=1745010047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8FcS+d3XqPALYlKipast1fx6gvgoQgjVL9Fu3VpDnLA=;
  b=RPl5kAtRpAcuAbJqxzwsGcjpeTg5pIsamhEGIso2xUzLBC3IFzJOFxPg
   +RVLJw52f9JCmihI6AUVb3uGV0hvWeYeHeWaTncnVlxmPvbErYfuS1twr
   j2E51xmB2tiHb+a8EmlHvp53EucAQ5hwft8B4RXbRaBAaH6rN7Fkbuvoy
   JRVcwdVWyN2QJRQ7Y7in/RhnEKI28mBvaeDtyHSgmnl/MVYnl7aubV3IB
   PLVDWV3MEZHgayCS9/diDMS7aCpXw/v0EB6eAXB3pZNVrWPC9+OHEDvh0
   n9viuEey5War5H1HuGm52tezYzr+d2KWMRcqdukJhFMtZuSsG40Wt0OmN
   g==;
X-CSE-ConnectionGUID: MN+mgiDQQU+mV+yJGkcy2g==
X-CSE-MsgGUID: IsJfKF/9Rfu7vaorLvNsFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8887569"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8887569"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 14:00:46 -0700
X-CSE-ConnectionGUID: nELOdJapRMKou4dSOlVNNw==
X-CSE-MsgGUID: PG/RLJrHQxqtfy0ZX+NVSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27879557"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 14:00:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxYs4-00000000Uaz-1KZK;
	Fri, 19 Apr 2024 00:00:40 +0300
Date: Fri, 19 Apr 2024 00:00:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw: Simplify prepare CTL_LO methods
Message-ID: <ZiGJ-DspJq5R6Dym@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-4-fancer.lancer@gmail.com>
 <Zh7LyszPd2sNfWRm@smile.fi.intel.com>
 <lzcgxh7trwoksd4bx2fsybellbngvpwhgq2a76ou2iufemockp@3dca4bfox2ps>
 <ZiEIRluj-50FMIgp@smile.fi.intel.com>
 <xfa7evanbrvdxdoq6473wpymvqogezspwkdoawu2dr6mnyxiwq@zx2schip66wj>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xfa7evanbrvdxdoq6473wpymvqogezspwkdoawu2dr6mnyxiwq@zx2schip66wj>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 10:00:02PM +0300, Serge Semin wrote:
> On Thu, Apr 18, 2024 at 02:47:18PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 17, 2024 at 11:11:46PM +0300, Serge Semin wrote:
> > > On Tue, Apr 16, 2024 at 10:04:42PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Apr 16, 2024 at 07:28:57PM +0300, Serge Semin wrote:

...

> > > > > +	if (dwc->direction == DMA_MEM_TO_DEV) {
> > > > > +		sms = dwc->dws.m_master;
> > > > > +		smsize = 0;
> > > > > +		dms = dwc->dws.p_master;
> > > > > +		dmsize = sconfig->dst_maxburst;
> > > 
> > > > I would group it differently, i.e.
> > > > 
> > > > 		sms = dwc->dws.m_master;
> > > > 		dms = dwc->dws.p_master;
> > > > 		smsize = 0;
> > > > 		dmsize = sconfig->dst_maxburst;
> > > 
> > > Could you please clarify, why? From my point of view it was better to
> > > group the source master ID and the source master burst size inits
> > > together.
> 
> > Sure. The point here is that when you look at the DMA channel configuration
> > usually you operate with the semantically tied fields for source and
> > destination. At least this is my experience, I always check both sides
> > of the transfer for the same field, e.g., master setting, hence I want to
> > have them coupled.
> 
> Ok. I see. Thanks for clarification. I normally do that in another
> order: group the functionally related fields together - all
> source-related configs first, then all destination-related configs.
> Honestly I don't have strong opinion about this part, it's just my
> personal preference. Am I right to think that from your experience in
> kernel it's normally done in the order you described?

In this driver I believe I have followed that one, yes.

> > > > > +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> > > > > +		sms = dwc->dws.p_master;
> > > > > +		smsize = sconfig->src_maxburst;
> > > > > +		dms = dwc->dws.m_master;
> > > > > +		dmsize = 0;
> > > > > +	} else /* DMA_MEM_TO_MEM */ {
> > > > > +		sms = dwc->dws.m_master;
> > > > > +		smsize = 0;
> > > > > +		dms = dwc->dws.m_master;
> > > > > +		dmsize = 0;
> > > > > +	}
> > > > 
> > > > Ditto for two above cases.

-- 
With Best Regards,
Andy Shevchenko



