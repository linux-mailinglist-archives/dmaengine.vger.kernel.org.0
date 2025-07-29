Return-Path: <dmaengine+bounces-5886-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462ADB14FF3
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 17:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2CD3A4C63
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49B207E1D;
	Tue, 29 Jul 2025 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJF2DKsz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A21DC994;
	Tue, 29 Jul 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801580; cv=none; b=EPY7ac2Q8eNsOQJEH7ylDJ8SSBYbCVIyLGg9UNnbvlzTLDuJTLaGBoXip5DwadVXCu2u4UvGTo7UkmeemZffHRay56OhA10XvNb9FueUJx1GyA4DpGIwYtmDSjl3TbjYrIfqtFUEYyPiZxzHZAsebzSdi6SOU5A4tJWd9uA2WVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801580; c=relaxed/simple;
	bh=hT7JoW/RThSzja2MVDnh4LyrBgsrXZ5kkkFBiqx5WKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAJPnkWb0DmC9WSF5CEVzT4FaandoP8WzdVUJpvtZJo4d9hEI8SjHL8dNbXanWMf86xgphJat33W/SPG2u2aN4gYD8iQFnmxdppHypbhJeMwzSREqT2fCEsHCTSmKXUNW/DsWKvlaHAcpoKj11pxCN8c2t4LvIv0iORfpDwt08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJF2DKsz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753801578; x=1785337578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hT7JoW/RThSzja2MVDnh4LyrBgsrXZ5kkkFBiqx5WKo=;
  b=IJF2DKszkmIA0chLkm+AIm6oqnW8xazIQA4pgfz5o/QlbEyJfbtEL4pB
   2BdEhbn/gGqwBDmrQxBa03N8MXuA84ensPke+WdiOFgeChq2DbBYDZpBl
   yXsN9QqTirol8CIjKe5SOEUDXvNOWf29G6OUwqf51lhBiJXonj2ydZx6E
   NeRJMo9yDmY9/eHI7Q9mOTYyHPsIkO59hv8sbZ0a5w/xvbeuqJm1U0nIy
   ESd9pxlsXXJID5Ni53QTvztBiejEvjCypP0IhYWlsTpmDP8hKvtl39DOw
   CWk8xu8/Wy5d3cr2qFd9bfjZBqsYOvZJXlCeq//dFlyEP+9voguhzsvt9
   w==;
X-CSE-ConnectionGUID: 0b1q9vP3Q4aFEqpGNNy7zA==
X-CSE-MsgGUID: QvmPVT9wSMa0ItqtmpIZbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="73527091"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="73527091"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:06:16 -0700
X-CSE-ConnectionGUID: wieQOfoGTC2Gjc4xOuad5w==
X-CSE-MsgGUID: WzhqFanBSYmUMMdYA7yshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="161999292"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.118.247]) ([10.247.118.247])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:06:11 -0700
Message-ID: <9b1b3405-26a2-4a30-b212-983568deccce@intel.com>
Date: Tue, 29 Jul 2025 08:06:06 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 0/2] dmaengine: idxd: Fix refcount and cleanup
 issues on module unload
To: Yi Sun <yi.sun@intel.com>, vinicius.gomes@intel.com, vkoul@kernel.org,
 fenghuay@nvidia.com, xueshuai@linux.alibaba.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 gordon.jin@intel.com
References: <20250729150313.1934101-1-yi.sun@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250729150313.1934101-1-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/25 8:03 AM, Yi Sun wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

for the series

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


