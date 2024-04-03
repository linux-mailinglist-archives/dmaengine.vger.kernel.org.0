Return-Path: <dmaengine+bounces-1727-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB52896B3B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008D1B25793
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACC134CEA;
	Wed,  3 Apr 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBwZKkMS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4C134CEC;
	Wed,  3 Apr 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137898; cv=none; b=mUBdwdI4qLqohIaF4M9NlV1G5DWKw7OB8VpNcyR6sp8nD9LlbXXFxACj727xmm2d0BqAQm2OjSXx+4dKKpTSZLoKnhNbZ3M8XixYoRVwM3oWAcxefl7CphO6tFDNTCSEoikQL4hgdP7wZ+55I7MW8k+u8vzQwaCKm85h3F0P3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137898; c=relaxed/simple;
	bh=UlQ5M5jQ/y1l1+Nge/gyBDCwSh9jn4Yk2MPadvINEZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko6hcVTRySgEOrQRyGU+P5GdIreNlk9ZPlCrJN47D3q0xb7e/O9pPbmVdlzH4L9lWsZ46XjUdBCQBxKm+CtEbUUrTRkkBnnMMo9MrKlPyYWS/CKIS621lWmNx3cBMJaz3XQisDEucwrW6nmyfIebcYcNlKs+5QQ69GwXZxWMFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBwZKkMS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712137898; x=1743673898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UlQ5M5jQ/y1l1+Nge/gyBDCwSh9jn4Yk2MPadvINEZA=;
  b=JBwZKkMSSU38nnixv0KV5FmxVoyCTchVSObSAXBF7Jqt+SuVcU3xkYJ4
   78KE/R6S/OSA9sgcY341dKqvZwZeEfuVxiAxfRaWIxKyJH2SVkcFJxKNT
   c4TvVYd/1QUndihLAEjrVvUa/LKeSjPIlOAL2vpJQB7r0736ojBKdKP8F
   q9mJdQKf6k130YC12eTD/fFsqPZMtGNqgnhOnqJgwi+Pp6vwUG1suSRIy
   7bi79qq6HIFG3+FLIgoCvKKwzHuBkG61TzBsj/RTcp3t9XHqgjIHZIRhM
   hcoZrM6iIUg550eYOdOZ2NQ8dFFXoduXjFeqLq1DcqsvTfKAod8P1N8WD
   A==;
X-CSE-ConnectionGUID: qNIAhV15S+aDxV5vPHevdg==
X-CSE-MsgGUID: oens4BLFROeAQi8lo/gqFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7484189"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7484189"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915176741"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915176741"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:51:35 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrxHJ-0000000154H-0VG5;
	Wed, 03 Apr 2024 12:51:33 +0300
Date: Wed, 3 Apr 2024 12:51:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idma64: Add check for dma_set_max_seg_size
Message-ID: <Zg0mpHgJ9bCbfxQv@smile.fi.intel.com>
References: <20240403024932.3342606-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403024932.3342606-1-nichen@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 02:49:32AM +0000, Chen Ni wrote:
> As the possible failure of the dma_set_max_seg_size(), it should be
> better to check the return value of the dma_set_max_seg_size().

OK.
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



