Return-Path: <dmaengine+bounces-7122-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B6C4603F
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 11:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F08E7347A0C
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6FF305E24;
	Mon, 10 Nov 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIDQM1ab"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D85302169;
	Mon, 10 Nov 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771404; cv=none; b=jjpm0ZA6mFl/f1ANGBlWK1hz+XSqP5Uy/9+50n9dcsx/Mwh/mwhdwf5g6QXLAF8MVPFUVntNs838yEI1vXPHHZ8OWzX2Q09u6LlFUd9IRVY2y3Q+CeCz2axEHumyGga1P7qfLno5TVMGCpYukmkxmccHRuuxkud1R8HiDKpVIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771404; c=relaxed/simple;
	bh=0PabFxxvA+YhDQ+fCPSHquXNTZEHu6lGzfiulgTlw1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVC4MLQlOQ3JvAnU+SltCxl+5ZtuSRwLbS6pdD5fX3AnfXg5W5A0k2X0DQKmFzasbXe98JzmVbMaRWO/VjA2+Z7SKbyLJ8vf4lf4LwYehD9QngsiGhqedNEKxC/RwPLAugaEb1GSpyJxsXZl0Ugxf90qPD+bspF1452YiFaik9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIDQM1ab; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762771403; x=1794307403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0PabFxxvA+YhDQ+fCPSHquXNTZEHu6lGzfiulgTlw1M=;
  b=KIDQM1abm+GvFwx2bA2b9Bfi/uNcsJoKahn1xUfERnd4D/5gTsoiUddu
   526TxVWjZjRdXmRK9uIICMLt/KJ4aVWk5X8PCeq03GTy9pGdOJ7r7j0rr
   9g/MVRWNsEUiSsqHFR0gjeBVuu5xYQzx9NyMrE6qwzeU+b9Tyt6XBHf8k
   TE7Ia+ky7ZcnXEZyyvGHYKqo3od6yVvKQqQYDxzJznyhlS4zRdqcmxjHN
   ttWErtxZo523+VKBc3ia8IIm2/2Z1c2fbuZLJFp9YkdQ51cPLQ/elKhuf
   ofWm+PKZ/6GBBEduzJuEf00HHBRzwtHtKyAHaYLCBjo+55eZ8DNZskfw9
   w==;
X-CSE-ConnectionGUID: NkXKRtoiSjSdnlv/JZPogg==
X-CSE-MsgGUID: DSq6X33XTDqoA/cXOco1hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="82216433"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82216433"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:43:23 -0800
X-CSE-ConnectionGUID: Sdr+zpq6T3GmanOc8nD6sQ==
X-CSE-MsgGUID: 6HQ9h6gJSxmFuU4+ZL2oMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="189362275"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.235])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:43:21 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vIPMk-00000007R4d-34Wg;
	Mon, 10 Nov 2025 12:43:18 +0200
Date: Mon, 10 Nov 2025 12:43:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Praveen Kumar <kpraveen.lkml@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/3] dmaengine: Use device_match_of_node() helper
Message-ID: <aRHBxiOy5ecYkggI@smile.fi.intel.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
 <20251110085349.3414507-3-andriy.shevchenko@linux.intel.com>
 <aRG8cVly3b7sR9Vw@u67f9ca6e60d851.ant.amazon.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRG8cVly3b7sR9Vw@u67f9ca6e60d851.ant.amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 11:20:33AM +0100, Praveen Kumar wrote:
> On Mon, Nov 10, 2025 at 09:47:44AM +0100, Andy Shevchenko wrote:
> > Instead of open coding, use device_match_of_node() helper.

...

> > -		if (np && device->dev->of_node && np != device->dev->of_node)
> > +		if (np && !device_match_of_node(device->dev, np))
> 
> I see a difference in what device_match_of_node does vs what was
> happening in the previous check. And, we have an unwanted double
> check of np.

Nope.

> int device_match_of_node(struct device *dev, const void *np)
> {
>         return np && dev->of_node == np;
> }
> 
> Instead, I would recommend,
> 
>         if (device->dev->of_node && !device_match_of_node(device->dev, np))
>                 continue;

This will be the wrong check. Think about it, yeah, it's not so trivial check
and hence the change.

-- 
With Best Regards,
Andy Shevchenko



