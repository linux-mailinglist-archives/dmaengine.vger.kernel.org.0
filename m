Return-Path: <dmaengine+bounces-5966-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8DEB1CAC7
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611AF18C4E1E
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA69E1A8F84;
	Wed,  6 Aug 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glbMLMdp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BCEEA6;
	Wed,  6 Aug 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501363; cv=none; b=n8ZmdW4koiuyf9sKQZcCzr9C4bDtWAag1o3uCrvz8JPuLTcDQyGpzEBwJxr0b3eT6T3MJCND25zeQxwTYZeJVt9A/UzC7c1oFJE/GqZU6f0OtxhVgHRVCG49k57OZMvy75VpidoBmILTscSZW7F+r1fab5ORpFOzMoUamHNd35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501363; c=relaxed/simple;
	bh=LghXY3001z0/rACCK8pulTxdYVyg8AVkJ9CIwzakM30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivLyZGe+VuKWlbv+sPh70F2YDf3nXupUV5PYNETO6vxBjZK3jd7Z68otlrP3ooHpTTsDb5C87N8cz0xNDU0L4XXoq5VGdhYyXWhGLB+NduaXOT3A9E/rZU9AUt8dzR9tN1ncYTPvmmWPMoXEjwSyk5/g7sn37T/IypjNHJiXbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glbMLMdp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754501363; x=1786037363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LghXY3001z0/rACCK8pulTxdYVyg8AVkJ9CIwzakM30=;
  b=glbMLMdpfbl8FVtoHrMmPQBsSMZSfoCVC/3qlMUNnSagubbTSqmyrrlv
   Ugeeb7vfd9wjziglmlt43Rv+PC654nGtGdox2njIHHvo4Yr2Ztb/Akgjm
   +DeOAkdnVMflOj3D9NVPe4EoZt+99r0xRQBHZEXMt3dD8XFTaaYnQad4B
   7S5SmzxsjDjVJcyKQsWPzxylueehGg001ZZSHf10yjCFNz0oorGNU4yW4
   X9UAqpanjm35CTqQvWiv+GE+D0+e4LPtzyROi6Us1pD8QkcKdSvORj5p2
   LcUspnwvTYlI/zalj08cqp2BpzovjPzqZ4A9TDmWhzOJhLpDeKiFIXZ6H
   Q==;
X-CSE-ConnectionGUID: tpQD3zqOSuGv9cuTtrkVyQ==
X-CSE-MsgGUID: rIj8lcm5QKymKF90Xy88RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44420209"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="44420209"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:29:21 -0700
X-CSE-ConnectionGUID: kAeuoi8xQ9+joDImz+pYEQ==
X-CSE-MsgGUID: EsGy4KfNSeiaO6gZFbhmxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195812111"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:29:18 -0700
Message-ID: <8460f5bf-ca1e-408a-a497-61663ec2eb6f@intel.com>
Date: Wed, 6 Aug 2025 10:29:12 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dmaengine: idxd: Fix leaking event log memory
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-9-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-9-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:28 PM, Vinicius Costa Gomes wrote:
> During the device remove process, the device is reset, causing the
> configuration registers to go back to their default state, which is
> zero. As the driver is checking if the event log support was enabled
> before deallocating, it will fail if a reset happened before.
> 
> Do not check if the support was enabled, the check for 'idxd->evl'
> being valid (only allocated if the HW capability is available) is
> enough.
> 
> Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 8f6afcba840ed7128259ad6b58b2fd967b0c151c..288cfd85f3a91f40ce2f8d8150830ad0628eacbe 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -818,10 +818,6 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
>  	if (!evl)
>  		return;
>  
> -	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> -	if (!gencfg.evl_en)
> -		return;
> -
>  	mutex_lock(&evl->lock);
>  	gencfg.evl_en = 0;
>  	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
> 


