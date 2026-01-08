Return-Path: <dmaengine+bounces-8100-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54355D014BE
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 07:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3D263006452
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF5F33D51C;
	Thu,  8 Jan 2026 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdgfRbNc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4269329E5E;
	Thu,  8 Jan 2026 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854638; cv=none; b=JQYZaQqdipv7HrkDzOkmGO/gZekz6sdR+PnwZRNM9JAX0HEKDqnMGg6dcYEg6LUBbTFglkI8eyAtVyCtTJeqTKvWJ4tDCx+vxwsCV0bW/JAiQ+zkfE/MJ9TnxotSXEjgVXX5VlZhzaucm5+h+kf3STfwFO+ul0WIquBZXpukJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854638; c=relaxed/simple;
	bh=LpVH+3PKxGed4Q3UQzXwTe23CXok4KDGAHpB6fzyc7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izF62wQdTUxNpoSEcqWrupL3RfQtei5l0l9qqHd1Lv9INEJF9EuqEc0nHuU+yI4qJ7YSAzoStr8w8d/Cgc+i7JzUjyQPY9YmM13+pHDIvuCc5ysj8eBFMk4mXCkNKA9oyi9R2AwP3p75lXvX4Lh6dRKYS0i6+Mqd6air9zOnB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdgfRbNc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767854636; x=1799390636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LpVH+3PKxGed4Q3UQzXwTe23CXok4KDGAHpB6fzyc7w=;
  b=AdgfRbNccMONMmvS6B2UJbUEknwNbL1UgtaZvMT16VtrftPxpC+Kb8Jj
   sIQDbZ2bnr1nQ0gS8P2mR1lx/hrKgFeA7PyJH5MC7/OhdQ/AWxbr0DFQy
   NDUyFRJPEy1dDgUKycaYlIBiPBYdC6uZZt9+dQrhfDQtTDZyu+kU8QFsc
   4TbKAgd/G7RpcFjZJPRlJa3y0mxnETEOJOOPbgEFPt275FBtbNMq2FEtQ
   2nnBGwftA7sb92Gke6m2Y0dCrwwgDM2IdnFeITNALieSBZPLI8bfesZw1
   +34WAO9INsggtTtuaSuBmkCkYKoxhhxAHqXAzujoAXNo4ijIuBwnSlhLl
   w==;
X-CSE-ConnectionGUID: b/RvcypPRJCxkIVOOlqUrA==
X-CSE-MsgGUID: FYNcUCd6QgulSMKIO+AZ/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73083160"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73083160"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 22:43:54 -0800
X-CSE-ConnectionGUID: mENwauxkRWy6GXsNT0Zu1Q==
X-CSE-MsgGUID: 6P6rfFj0TQeayuVa7bjBpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203566435"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.185])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 22:43:52 -0800
Date: Thu, 8 Jan 2026 08:43:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/3] dmaengine: A little cleanup and refactoring
Message-ID: <aV9SJrOpQvRsJ3nA@smile.fi.intel.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 09:47:42AM +0100, Andy Shevchenko wrote:
> This just a set of small almost ad-hoc cleanups and refactoring.
> Nothing special and nothing that changes behaviour.

Any comments on this series?

-- 
With Best Regards,
Andy Shevchenko



