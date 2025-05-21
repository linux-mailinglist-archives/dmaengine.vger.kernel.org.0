Return-Path: <dmaengine+bounces-5242-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26C2AC0079
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 01:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7821BC4B13
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 23:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C123BCE2;
	Wed, 21 May 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndYf5gzm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF591D90C8;
	Wed, 21 May 2025 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869233; cv=none; b=BZTLb50j8KiJZk6OEchmQgnV1AVLJYYg+XD/Q0KUut1POrHNO+d977m1tmbvB5Hldc/1t6nrYtcG6/XDjlA02p0vUQtqV7a/Ni9vBLwjdpw2JSV09SlX/MHS4f7YemhxNQgxXo4PXzHeE1JRjj9tLvIqV6OT6pnZw/7C8YCEMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869233; c=relaxed/simple;
	bh=UkPkxlmT5TTBmd4M/wdKQQyQtwF7tAXs5pjR7gjIeqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jw6XckHAMNR3oH9isfDM45wGLUAFuSCepLC+yzwvpEgDw/28//ETkz7Sew3cNSp7tWjJ16pQDoPgzfMv6M3UpcOK4Y9W0j/Lp0CbM8hBgOreinZOb8MA66YsK2YVrdNMoq1jSCfa/rrZYURde8F7oaydX+k1QcnaCHh/avWNVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndYf5gzm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747869232; x=1779405232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UkPkxlmT5TTBmd4M/wdKQQyQtwF7tAXs5pjR7gjIeqQ=;
  b=ndYf5gzmFowg10vMck4Fr7NKsyMTXOvGlBPCZh4f/OW6HGVoL/TJZtAv
   W64V3rj6HIlU+so82slBe4/mwWePhqTD9asFb6EGAusHfVBzFqVNBc0kL
   ooyQdO5BxiWAh127RkiXsnBK3w+bK25WAYEzVXd36TvWnSdWGus14V7fm
   rfiGznrr0iAQhqT1u/4x+za/G9JnMDttvkpktRSL9FQps/6hSMbktpkVW
   odVjMelvBMY5oZtuGhGa/gBMziGvQnm44eMzfji4R4mACdrBN4ZMCajaf
   7mOhIggsxkUGPCkZ/GSQd7i4hDANjPA1BazmP8XHdA07W4A9ywd2vsk59
   w==;
X-CSE-ConnectionGUID: DXXZBLxHT2egvfEoN9lDig==
X-CSE-MsgGUID: D45z+G+CSFe1Rlcdr9ZUBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53680084"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="53680084"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:13:52 -0700
X-CSE-ConnectionGUID: Nyybb3nZTvSMMvrvVilHRQ==
X-CSE-MsgGUID: ijMVxJJhSbWRCK4MzqwVxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="141360908"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.106]) ([10.125.109.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:13:50 -0700
Message-ID: <502b82d9-7343-46b2-a820-c7f47f12de10@intel.com>
Date: Wed, 21 May 2025 16:13:49 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Fix warning for deadcode.deadstore
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 vinicius.gomes@intel.com, fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250521231331.889204-1-anil.s.keshavamurthy@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250521231331.889204-1-anil.s.keshavamurthy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 4:13 PM, Anil S Keshavamurthy wrote:
> Deletes the  second initialization as the value stored to 'dev' during
> its initialization (struct device *dev = &idxd->pdev->dev;) is
> sufficient.
> 
> ../drivers/dma/idxd/init.c:988:17: warning: Value stored to 'dev' during
> its initialization is never read [deadcode.DeadStores]
>   988 |         struct device *dev = &idxd->pdev->dev;
>       |                        ^~~   ~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index fca1d2924999..b7664136fc67 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -989,7 +989,6 @@ static void idxd_reset_prepare(struct pci_dev *pdev)
>  	const char *idxd_name;
>  	int rc;
>  
> -	dev = &idxd->pdev->dev;
>  	idxd_name = dev_name(idxd_confdev(idxd));
>  
>  	struct idxd_saved_states *idxd_saved __free(kfree) =


