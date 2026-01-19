Return-Path: <dmaengine+bounces-8365-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 410ABD3A099
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 08:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6C1730022EF
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BBA335BCD;
	Mon, 19 Jan 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Chb+FyO3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA13321A7;
	Mon, 19 Jan 2026 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809128; cv=none; b=k+DlH/XpHqpgI9pzwtvTmGM9Dt2WDuxLDJupdJjChz3Ihr3olbKjP7XJ6HVau9VeJ6ixwHQf+pD4NHCZJmWphaOINI3BS8rYzPQ5anNpPHxLsPvSmqd5SqGdg5mDEVZTYjns5NjQ6jXr+yxOgfRuItm73C6GshdLtvyoi5Lwqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809128; c=relaxed/simple;
	bh=rkTaXwH7xuhgMepfGmG1wSXpE5Has1Gj11gQmXLi3Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUlWtuRaMttbryoMXqojrHkONz0zANh+YfuUHZpfoODuiArg+qSAK+cdal4xe5/OMTQm/FwONwr3EFo+1GlXxqYpzVZWlj+d5WMa+Xfp1hYxFpFRKhybdLPXubCIcfCZWq0rXUgg+12VDkragBEEsAJHDGdFDISrpaQYCRndyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Chb+FyO3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768809127; x=1800345127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rkTaXwH7xuhgMepfGmG1wSXpE5Has1Gj11gQmXLi3Cc=;
  b=Chb+FyO3ss5icpP9K5nUvxcGpIlMkBawUOmp9CiD7HLgDoi9rytr5bah
   5W1IuGIHywEEesDB57ffh49QwSltlfJTxZiEi1+b3lSsJuQ8rFbcX5rPG
   Jm2g/pr8LySDoDvpEwmKh3uWWO+gUeX/fMXZWEzRPAGDmnB6cKu3wQXIV
   Ul2ibZ6kyPnGsqbKQp9XWFDYVaD0HrJCe+w2d7mMYl9QMkL8IRc/egoAv
   J5nvorACa1j94PD690kSFVNFlVslau3B3KTizDrRt9BIPw/agTBDYofWq
   4T43FxRqBVrwJCWURZOhEvXQ9ZgTPa7vwH4dWgf9cRmXEo4X4k0JIXXRU
   Q==;
X-CSE-ConnectionGUID: RmCeuw1tQyiFuyf1+5wBeQ==
X-CSE-MsgGUID: Yo1eeR4/SkOv1XkhdRb5jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="70064037"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="70064037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:52:07 -0800
X-CSE-ConnectionGUID: SJ4Qayj7RQSGpdN9/0RzRA==
X-CSE-MsgGUID: nP4iOZSmRj+oCopOyVHzjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="236487246"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:52:05 -0800
Date: Mon, 19 Jan 2026 09:52:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 0/3] dmaengine: A little cleanup and refactoring
Message-ID: <aW3io4O9bGmJw6A2@smile.fi.intel.com>
References: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
 <aWVYK6zywigycNCT@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWVYK6zywigycNCT@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 03:23:07PM -0500, Frank Li wrote:
> On Fri, Jan 09, 2026 at 06:35:40PM +0100, Andy Shevchenko wrote:
> > This just a set of small almost ad-hoc cleanups and refactoring.
> > Nothing special and nothing that changes behaviour.
> >
> > Changelog v3:
> > - fixed checkpatch warning (mixed tabs and spaces) (Vinod)
> >
> > v2: 20251110085349.3414507-1-andriy.shevchenko@linux.intel.com

> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Thank you! Vinod, since we seems will have an -rc8 this cycle, can this series
be applied now?

-- 
With Best Regards,
Andy Shevchenko



