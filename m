Return-Path: <dmaengine+bounces-5998-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9198B2203E
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 10:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520A41619D1
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233C2E03EB;
	Tue, 12 Aug 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTwTmU1Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113522E03EE;
	Tue, 12 Aug 2025 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985944; cv=none; b=HKm6gLg0HD7ghtAcnZBOFrRkutEj1prtA5mN4FjVsxertDNKleTpTxoLeD5r7B48/aS61kXSlvbYNi3eCdAkAVdpEMSNd6hqoG/pEq0wGpkIuDh0xfkbmbpFA8EzU8nIJITNvtk52Hxo83FHZC50MtyFTSj/CGaoCrbXThe/Si0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985944; c=relaxed/simple;
	bh=Joo1vcxbhrfZZJYvlFmJ2lQzVxuvgXO+X/iO5xAtLjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCIDcoAUns+EipyVHUS+rCUqPe17eL1CapWmwPJJUA2zoNg3sSmRtQJwx4J+4gyAmvgkN3XD1cVhjAP+Eee4LaU5SI0SKwAFy2FoZgKOu7Q00oFavGwsiezGm4PEz3N4kEnT2x2dac125blyRclZkZOrzUNtfVnbNQI5R7mqz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTwTmU1Z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754985943; x=1786521943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Joo1vcxbhrfZZJYvlFmJ2lQzVxuvgXO+X/iO5xAtLjQ=;
  b=QTwTmU1ZWlFEneamF4Ox8BUBoZodQn9aVQkCJqQe6ePgc/p/MIsnpet4
   Te0BHlP2fPtJt2m8RP0dgyyU++LkyvUVto361lhE/ZvL0mMwGS6yqYRD4
   0/zo5gVAXqItId1AEe8CJtl7nYM0zSXQ5mSkCeLXVediEbGo9TH0F/ftE
   bY+p2khPZNzeGgY+GbpUSwAwS4nAdseU/wIjnOG4JOOdHCjdGilX0GQ00
   4SHY0FozNX7KihE40fzl3JHWgAXwaNLr/CGknpPSrXX9o6JCFHd9kL5wq
   0qheM6YbAxV0n/fY8b2ChZBcIe87BE5fRiKaNRjyAWfXNQU1hELUlJlxv
   w==;
X-CSE-ConnectionGUID: xBu6+9dtRiKTv7gHvR2Eeg==
X-CSE-MsgGUID: hAKkZdCLR9OOTmc17e6eLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57331072"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57331072"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 01:05:41 -0700
X-CSE-ConnectionGUID: dC253ZcXRoKzxKGthAO62w==
X-CSE-MsgGUID: 8kly9eP1RwC6m6WBytrYMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165634786"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.53])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 01:05:39 -0700
Date: Tue, 12 Aug 2025 16:05:36 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Yi Sun <yi.sun@intel.com>
Cc: vinicius.gomes@intel.com, vkoul@kernel.org, dave.jiang@intel.com,
	fenghuay@nvidia.com, xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	gordon.jin@intel.com
Subject: Re: [PATCH RESEND v3 0/2] dmaengine: idxd: Fix refcount and cleanup
 issues on module unload
Message-ID: <aJr10DimV4k8oxQQ@ly-workstation>
References: <20250729150313.1934101-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729150313.1934101-1-yi.sun@intel.com>

On Tue, Jul 29, 2025 at 11:03:11PM +0800, Yi Sun wrote:
> This patch series addresses two issues related to the device reference
> counting and cleanup path in the idxd driver.
> 
> Recent changes introduced improper put_device() calls and duplicated
> cleanup logic, leading to refcount underflow and potential use-after-free
> during module unload.
> 
> Patch 1 removes an unnecessary call to idxd_free(), which could result in a
> use-after-free, because the function idxd_conf_device_release already
> covers everything done in idxd_free. The newly added idxd_free in commit
> 90022b3 doesn't resolve any memory leaks, but introduces several duplicated
> cleanup.
> 
> Patch 2 refactors the cleanup to avoid redundant put_device() calls
> introduced in commit a409e919ca3. The existing idxd_unregister_devices()
> already handles proper device reference release.
> 
> Both patches have been verified on hardware platform.
> 
> Both patches have been run through `checkpatch.pl`. Patch 2 gets 1 error
> and 1 warning. But these appear to be limitations in the checkpatch script
> itself, not reflect issues with the patches.
> 
> ---
> Changes in V3:
> - Removed function idxd_disable_sva which got removed recently (Vinicius)
> Changes in v2:
> - Reworded commit messages supplementing the call traces (Vinicius)
> - Explain why the put_device are unnecessary. (Vinicius)
> 
> Yi Sun (2):
>   dmaengine: idxd: Remove improper idxd_free
>   dmaengine: idxd: Fix refcount underflow on module unload
> 
>  drivers/dma/idxd/init.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Applied patch series on top of v6.17-rc1 kernel. Issue is fixed.

Please help add Tested-by: Yi Lai <yi1.lai@intel.com>

Regards,
Yi Lai
> -- 
> 2.43.0

