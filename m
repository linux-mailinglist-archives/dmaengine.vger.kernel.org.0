Return-Path: <dmaengine+bounces-4759-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AEAA6A424
	for <lists+dmaengine@lfdr.de>; Thu, 20 Mar 2025 11:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFA38A624A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Mar 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F81224AED;
	Thu, 20 Mar 2025 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzSLz3Pz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5943224258;
	Thu, 20 Mar 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467908; cv=none; b=WxwGsVZ6yKjtZujYgFBdu8LmDrw+s2l2e/Y35+KZjvErt3npZyjHkHv3ICp19P0UjTo5JRcQ23MeNcI0FH1wsig6QbcWMuzkI6l3chK2rlDpYiugkiXPYZa4UsSyIDY46kNucKhraCtvfrV148RJ9sh3iUkFxVHchDOHJgfRJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467908; c=relaxed/simple;
	bh=GnJm0ioVG9H5C50aU0aT7WwiVrPzm07VO5JZTJO6q6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuxQu00YPdX67VUwSnTar0Kon/Of3HWMWqrfJzc0LgmlWriFAUhQDSXeQH2vKJwIgimvRSzoCndHAL9X+snsr3AI8t2jwo3VNzs0GUwQdpq71HZS1dB3/4ypbI56yo7yy5IWVzuKAPRfI5piqdCoSPWe+h5gXo2njNRiiPqL8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzSLz3Pz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742467907; x=1774003907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GnJm0ioVG9H5C50aU0aT7WwiVrPzm07VO5JZTJO6q6c=;
  b=OzSLz3Pzv4SPFpcfFm4Nd3QzQM4gwqMgwyp0TYBDf5NEphqWWBgM/1aR
   LIdyeuhXuIltu44ycHhhcYaQ8P4zf6AVYs6YmspQYzcrYRAt28q3ssGRR
   4w/LcJxnmBGsYWwfFmgb9b7A11T0YfxfQ8mQZUBBR6p7np8U/KuxUUZ6H
   WdQNI8Wjmnw/RqCeZ4F+f+idBzUApnH2Mt6iw8CV2GCF3tQ1HrCN5z51i
   bXfMz232XNnXeiAaNyqDCx+YSBxq3JIVQ52s/PHf+nLtbx9jDaq2Gtbhi
   e/eCFJ1u1AlcFMXsl7K84Qepy9L3FhCqNiqs3RVXoqxvLquYEYkSebSs1
   g==;
X-CSE-ConnectionGUID: hmEqMHiOTiiPLpszukmlug==
X-CSE-MsgGUID: B/xuCAxQQvqjXkxu10zSSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="46447065"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="46447065"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:51:45 -0700
X-CSE-ConnectionGUID: PFoRi9r1QHuzaP7hO/Zjzg==
X-CSE-MsgGUID: SoqLMKRlQJip4/A7+w92Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123063393"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:51:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvDUq-00000004CNx-0fAW;
	Thu, 20 Mar 2025 12:51:32 +0200
Date: Thu, 20 Mar 2025 12:51:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yi Sun <yi.sun@intel.com>
Cc: dave.jiang@intel.com, anil.s.keshavamurthy@intel.com, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	gordon.jin@intel.com, yi.sun@linux.intel.com
Subject: Re: [PATCH] dma/idxd: Remove __packed from structures
Message-ID: <Z9vzM7UedzpkdHKZ@smile.fi.intel.com>
References: <20250320081807.3688123-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320081807.3688123-1-yi.sun@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 04:18:07PM +0800, Yi Sun wrote:
> The __packed attribute introduces potential unaligned memory accesses
> and endianness portability issues. Instead of relying on compiler-specific
> packing, it's much better to explicitly fill structure gaps using padding
> fields, ensuring natural alignment.
> 
> Since all previously __packed structures already enforce proper alignment
> through manual padding, the __packed qualifiers are unnecessary and can be
> safely removed.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



