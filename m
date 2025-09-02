Return-Path: <dmaengine+bounces-6319-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B3B3FACA
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEA0165EEF
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564492EA178;
	Tue,  2 Sep 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/TgDWmd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2127FD40;
	Tue,  2 Sep 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805871; cv=none; b=drqYE4z0j50F6C+7SmSnNOhUgx0mm6rkmmV6hxgdchMs0VdUS4ssC7GJL0SyWkSjwaLFQXXvSnPLT0WXJp5lJGvsz2QHn5rj2S5uM/PL3t3NALuOPixICW0njamqALYsewkMrZtRuKlGJmRrpMilex0nOLFJLk7T4laujvUotpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805871; c=relaxed/simple;
	bh=ym2GUDMI1A6ZDzs1md6RCldVcx51pxHlCzxhoY6wx4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq/zorr9jeKXc8nYo3S53RZAnOLLoK1OsBJswuPVwd3MW/RQTsp/AvU9RFIitzK83stx9pQnWNZwJg8wmTLckmlYpV4EvMXJOg39ukXCt/nd/jQ5BXsIRHQffklHZlGIU7dQVGgKpoTnMsPZgn/pB+oFnXCNrnDsr/hC+S7oUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/TgDWmd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756805870; x=1788341870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ym2GUDMI1A6ZDzs1md6RCldVcx51pxHlCzxhoY6wx4Q=;
  b=c/TgDWmdEmAlscXM+t634EA/VfIB8FEETcAKOIGgcYYsHuLMEmh3ATm3
   MNI+FTFqH/8J5ffutdBAGe/3IG2cIM56r6ODugAzFmNp61dmUtfu0hx4o
   4e8OE6/YVv4SOBmm32MOVk7obl8S03yohy/0DqHai3KurVAglxdBG6JMo
   sbhGJ5Tymv0U+wx3D/+CLHqad7X75TI2pxTGqh5A2xvtvu5lT3qvkAOdx
   xLbkdFa4Ekc5o4iTHay5gj5caBJcJvmj2n/U1MpU+oaKGnjdzvGBxcYe2
   mNiI7K/FCz2d1Uhb2hW5B8AZ6uJrf8x/JoVJuglpZsZN5H2KgD0bUtNrA
   g==;
X-CSE-ConnectionGUID: X9zdn3EnRnKSCIEdBChi1w==
X-CSE-MsgGUID: w9E8VErrTJq93HEbTdUxDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76670673"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="76670673"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 02:37:48 -0700
X-CSE-ConnectionGUID: THkyuwnKSMmje3KTeCq1Ww==
X-CSE-MsgGUID: WZ4knoL8SLySkxrYn60rlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171110882"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 02:37:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1utNSQ-0000000Ael3-1hQR;
	Tue, 02 Sep 2025 12:37:42 +0300
Date: Tue, 2 Sep 2025 12:37:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw: dmamux: Fix device reference leak in
 rzn1_dmamux_route_allocate
Message-ID: <aLa65t3j1tmyEMnp@smile.fi.intel.com>
References: <20250902090358.2423285-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902090358.2423285-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 05:03:58PM +0800, Miaoqian Lin wrote:
> The reference taken by of_find_device_by_node()
> must be released when not needed anymore.
> Add missing put_device() call to fix device reference leaks.

How is this being found? Do you have a stacktrace or kmemleak reports?

-- 
With Best Regards,
Andy Shevchenko



