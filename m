Return-Path: <dmaengine+bounces-5157-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC164AB57B6
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 16:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3041B3BF9FD
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D13D1F12F4;
	Tue, 13 May 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHuG57a4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84C1CBA18;
	Tue, 13 May 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148153; cv=none; b=CKGjP7BVZ8GZ30kFnXOSBS1uSWxGcE40n1++x3LUKEOjoSDcOl/pq2mAJjxlj7KxvRk33UENipgHUCiqY1xN97hgU5z5CFBT/fe28JxrgW6HSKsa/LJ3ZmqmokDkJ0u8r2YzKoR85KK9XPwprWGKZS4mqOZK9cLp1TFHK/VP0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148153; c=relaxed/simple;
	bh=kGReQn1cYvWqlE7xBA9//xVLx5kv0mjBbeYtWvrzHbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p14u9gg9D9ml0fqjPcXB+D7YyApE5hjgAxU7JEzxqapv3EwuOJVkJEmtnkEyfPcukMkVcZED3pYkSdMgpd5EYWzL1iC4NDAy1AX/4hiCejnU80UnUs+WQH2d2TKFLIJRx56nMwl8BQo0peHWrEAnPoOYcpcLLcDB34ORQMAW+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHuG57a4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747148152; x=1778684152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kGReQn1cYvWqlE7xBA9//xVLx5kv0mjBbeYtWvrzHbI=;
  b=lHuG57a4fnvfmEmnOn3gHDDpXrONVDcVUwKAoFnaKf8M9BYO6ruHCTH0
   N0eGp/AwDUxzNUtjozXiYFwAvzLlcXZwOGR/D53oF7FxK7/P7si8OGkEv
   Dl7DzBKBMnpVXM9Ydt27yk8FQpJw0wq93o3Ww+nti4kl7f/gCubWlWzB0
   uNoo6/xq/KUvaboQK2u+JzIA4xn9RfGvI4aKhXADlezqRsVO/wvN/IL0a
   I90msssDXM1dRtCHC7DB7V7yN7UexmTi4pT7g0wt7OJHJV38XApHj7FwM
   L6MyU9+wF4Lw6e3T/q8QbQMosJMR//By6omFfVz5lL25dFyixMjRxVsuF
   Q==;
X-CSE-ConnectionGUID: 4/7Urhz4SWe2bJhhNGpfBQ==
X-CSE-MsgGUID: rTrEyOeyTD+V57HXC9rZsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="52660992"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="52660992"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:55:51 -0700
X-CSE-ConnectionGUID: BSO3stHeQeKFClAByf+hhg==
X-CSE-MsgGUID: 6t9hf1lcS1Wyx3EWp4PxsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="137617687"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.111]) ([10.247.119.111])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:55:45 -0700
Message-ID: <498184a1-a819-4e08-8e47-7f6593812e13@intel.com>
Date: Tue, 13 May 2025 07:55:35 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] dmaengine: idxd: Add missing idxd cleanup to fix
 memory leak in remove call
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
 <20250404120217.48772-9-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250404120217.48772-9-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/4/25 5:02 AM, Shuai Xue wrote:
> The remove call stack is missing idxd cleanup to free bitmap, ida and
> the idxd_device. Call idxd_free() helper routines to make sure we exit
> gracefully.
> 
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Cc: stable@vger.kernel.org
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f2b5b17538c0..974b926bd930 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1335,6 +1335,7 @@ static void idxd_remove(struct pci_dev *pdev)
>  	destroy_workqueue(idxd->wq);
>  	perfmon_pmu_remove(idxd);
>  	put_device(idxd_confdev(idxd));
> +	idxd_free(idxd);
>  }
>  
>  static struct pci_driver idxd_pci_driver = {


