Return-Path: <dmaengine+bounces-5918-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E6B169DE
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 03:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F518C6CD5
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 01:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C0433B1;
	Thu, 31 Jul 2025 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXMPEb/q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46FEAFA;
	Thu, 31 Jul 2025 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924168; cv=none; b=JfA+VzhRLfmlkt81qgFAyPGTRsLpqOw+Ls3kFbCZve72x24032HIo6QK+RdbLSFydm5ah9+986QkZOSqDZjmfSCsguLYOq4MmyDF0VFnPXV0vR5k6bRIS5c0LIxpAVfR26HVpqQp6OMHOJO1/QAemzLnyWSZbGaBujjnQEk/JJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924168; c=relaxed/simple;
	bh=UGa5ZMv7PDszQvoVUeIK7kPyakG5ZG3LkkdwnOMR414=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nyRnZKecaqN4H4W/Wt5gfcuLTYcJ8HRIr4osDneugSKAl/+xU9FJoRAsEQsWllB5hdgV1AUXfmoFaBMeDgi+IXZaFugWxj2Ha8zyArPjNs96gKshMR7uMWthqdNrWijs7OpDh701H8kRslbmGQIpAjWETQWsRqaEg6GpDvMLVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXMPEb/q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753924167; x=1785460167;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UGa5ZMv7PDszQvoVUeIK7kPyakG5ZG3LkkdwnOMR414=;
  b=YXMPEb/qhUcCe87sQQeg02d+MbWQpNShWqcRr4qbK9eo/uKInK9RGifW
   N9OHzOKFCZyrz6Ncw3P2S4/DbR0Hb9immvotdZcxWUg4jNXi0+EF5Elkt
   VYJ03xfCgdwFlkhvBmXTMTn5iGVWeY9ly5MIGQYWt1f4iiTXxFRmMVzZc
   iC5tSD94y6yJIygqXh5EjZ4NO9tCLMZWM/aDKGyiYKLgzGnGydwCxaYwM
   Lagn01A3vVGEj5WNUxNzF6MHh0GYG1jw7eJtAQOg6MhZ2ZdsP0mDZ7ZZM
   PQVOYYW3nYs9hPlLjeLrvagRUGj8xd509VsoFKfLHO+RQenlGz/WIzEbE
   g==;
X-CSE-ConnectionGUID: +q4R0ri9QMupaHUkd0bFDA==
X-CSE-MsgGUID: WaYSU3RNTyiuO6KLFD4vnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="60063710"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="60063710"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 18:09:27 -0700
X-CSE-ConnectionGUID: tpQp7BtmRyS2wh1CB2bANA==
X-CSE-MsgGUID: nLc8BBOjR6aFiPxxjnt+yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163914076"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.98.32.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 18:09:26 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yi Sun <yi.sun@intel.com>, vkoul@kernel.org, dave.jiang@intel.com,
 fenghuay@nvidia.com, xueshuai@linux.alibaba.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.sun@intel.com, gordon.jin@intel.com
Subject: Re: [PATCH RESEND v3 0/2] dmaengine: idxd: Fix refcount and cleanup
 issues on module unload
In-Reply-To: <20250729150313.1934101-1-yi.sun@intel.com>
References: <20250729150313.1934101-1-yi.sun@intel.com>
Date: Wed, 30 Jul 2025 18:09:25 -0700
Message-ID: <87tt2tkvy2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yi Sun <yi.sun@intel.com> writes:

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

For the series:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

