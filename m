Return-Path: <dmaengine+bounces-4761-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E0A6AA2B
	for <lists+dmaengine@lfdr.de>; Thu, 20 Mar 2025 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE611892666
	for <lists+dmaengine@lfdr.de>; Thu, 20 Mar 2025 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677071EB1BE;
	Thu, 20 Mar 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqNpSZFe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689681EB1B4;
	Thu, 20 Mar 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485511; cv=none; b=IQPhpGSiOKFxnnOLVaFWoUjkge5vHlVd6hUfumgiIMc5MNpT9oNWSA5Tfg/h+aGh2iGM3uYTDo0QUEcokT7eUk+lfKnZkeVXzexf1rewUTkIp4lxT21szF1PNPbr3xGGatYAf55vkhgoP2YkzK1MvdbIaq1XgInEGppTS2OKj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485511; c=relaxed/simple;
	bh=mMupfITLRbLKWQ2+s0bAW+7rsaduGLwjPsgUMv4bs74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWpMcVLzEfh2gB8JMN8LtWo4eys1WIikb7yLiUpDsuTVoC3uBerbnxCSgoMd8XdYK6bES2KzjLhsOR9XKF7r3VaN+XhlQnBR+CTHtIcq2IgUqrXCaqb3UK/JcTCHDvJ5RwQ4A8US/YJD9tc+ExZKK1BPg3xsB5wuIli+SNoCxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqNpSZFe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742485510; x=1774021510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mMupfITLRbLKWQ2+s0bAW+7rsaduGLwjPsgUMv4bs74=;
  b=NqNpSZFepYlZxjgVanLxYjMIdSVoF+qzhdGrg+CjgBvg8USwx33CHefd
   PAvchXucPtRrHMQ44HZSjYDNx9Ou8Jv5IwNnMc+RLvob0EuAaBAkJ/xQS
   ZpjLYNKDfB6y6W1CpHSEOFTdMVJ0MbW2MXejnXxBthcGGaCaBMGYDs1NM
   ipXZSlnbpa4m1UMzqJvzovYbPPcX72oT3H9Ey/Ko+XPSiJx4B/40dfBf6
   dBefv1BfspEU7zynycHNbYlpgHN+7OT0N1RoFOV2YghUnCw2hv0qP63Ny
   GALlTqRSQgyMLWrxS2C4QgUTggIoGw00wb3kgU38yUtVFZedvnMpH+AO5
   g==;
X-CSE-ConnectionGUID: Q3G2F6uFQxuh6iaMw4sZ9g==
X-CSE-MsgGUID: UXVyLda8Soenm8E36HIj0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43915104"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43915104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 08:45:09 -0700
X-CSE-ConnectionGUID: iRp5/EDXR4WmOWK5qKiVUQ==
X-CSE-MsgGUID: h7CMH9FHRYesHqoFqVR3uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="127296966"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 08:45:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tvI4u-00000004GI7-0UOy;
	Thu, 20 Mar 2025 17:45:04 +0200
Date: Thu, 20 Mar 2025 17:45:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Yi Sun <yi.sun@intel.com>, anil.s.keshavamurthy@intel.com,
	vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, gordon.jin@intel.com,
	yi.sun@linux.intel.com
Subject: Re: [PATCH] dma/idxd: Remove __packed from structures
Message-ID: <Z9w3_2NkSJCvV9-l@smile.fi.intel.com>
References: <20250320081807.3688123-1-yi.sun@intel.com>
 <1ca7b324-9de2-41b8-8c5a-a823c861c692@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca7b324-9de2-41b8-8c5a-a823c861c692@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 08:22:39AM -0700, Dave Jiang wrote:
> On 3/20/25 1:18 AM, Yi Sun wrote:
> > The __packed attribute introduces potential unaligned memory accesses
> > and endianness portability issues. Instead of relying on compiler-specific
> > packing, it's much better to explicitly fill structure gaps using padding
> > fields, ensuring natural alignment.
> > 
> > Since all previously __packed structures already enforce proper alignment
> > through manual padding, the __packed qualifiers are unnecessary and can be
> > safely removed.
> 
> Although endian portability is probably not a concern given this driver is
> only for an Intel platform device.

The concern is that somebody, while writing a code for a non-Intel platform,
might take it as an example and do suboptimal or wrong things.

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



