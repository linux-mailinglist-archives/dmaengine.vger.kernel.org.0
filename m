Return-Path: <dmaengine+bounces-2216-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC428D4F2D
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE84285614
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDFC182D0B;
	Thu, 30 May 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nT9BexLL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB67182D12
	for <dmaengine@vger.kernel.org>; Thu, 30 May 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083332; cv=none; b=tHBQ/uwWXDOKHM3PIidKBaw0Ppj4dSHKkKQbrXDAObwN3/nLtjP1k4aPkzGeloXe3GtFfWBrUcMT+1JDwdcJA6DbH8WH1vYP+O7bLGwheAZJAqkaE1QHTFBlWcTh2VstC2G6XoqMtgaOAwycZsJXgJ0pZ3HDw4iWWsmfy9OdaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083332; c=relaxed/simple;
	bh=3Yc0IpKreBhw4+PRU+1oX0DK/9veMdihN0ZnVwbCjgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tQk2xy77vUAIJ1pTmIcPjRrMr1iHHGrE1Z9pToLeayuJyhUB3LXZArFqI/UupzLHGVu3MdTUXe6HXRH9Y7ZmNbeGs3HRdDUQ5Mj7pSEUetm/5L6MI2xxyst5pTjsfyxGcRqbbl9QA1OvCnKJbGPzSAC7yZ7+fuzWEW3N2nx4On8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nT9BexLL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717083331; x=1748619331;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3Yc0IpKreBhw4+PRU+1oX0DK/9veMdihN0ZnVwbCjgk=;
  b=nT9BexLLyByJLslOCQuN6uoiHUpNee7u03BWJnMh7jixo1CitjgjsnMo
   ChdVhyneBWH0kHXnkAJa/Ld+xKSb1dcQGPqHlDYhXZcxTLWLv7x56gI2d
   8FeIHpIl3IDrcL6ApkqGCJzr2SVRschPlAIuhERPKcXyr0+ygfM6Zjl0/
   7kBZC5+FObrwFKXTNoeZqmcgkvOebCNe0PN134T21mMwn9e+1+OW27O7r
   YtALS1Yt586B+OUHmZX1nvSxjoa5eiFInxudNkFDmsA46NUx2kBdCi044
   mlWeT2kyRFlewWB3jyt06j9E3AQ28EchipYCZxklppuvXaZU+fkBgI5d1
   w==;
X-CSE-ConnectionGUID: 66R3/tvsQguv5UJPTZ/ptg==
X-CSE-MsgGUID: RR3BiBx+QbuPqf1DGCaTAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13760791"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="13760791"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:35:31 -0700
X-CSE-ConnectionGUID: G0TAEf5ZRz2eGfUrdsUHFQ==
X-CSE-MsgGUID: ciwM1HHFRjmyLdss3oSRXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="35921445"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.201]) ([10.125.111.201])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:35:29 -0700
Message-ID: <efc77091-0760-4ae8-b932-6dde63c0f62e@intel.com>
Date: Thu, 30 May 2024 08:35:28 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v3] dmaengine: idxd: Fix possible Use-After-Free in
 irq_process_work_list
To: Li RongQing <lirongqing@baidu.com>, fenghua.yu@intel.com,
 vkoul@kernel.org, dmaengine@vger.kernel.org
References: <20240530054852.8858-1-lirongqing@baidu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240530054852.8858-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/24 10:48 PM, Li RongQing wrote:
> list_for_each_entry_safe() should be used when the descriptor will be
> freed in idxd_desc_complete(), Otherwise the freed descriptor will be
> dereferenced to get its next, and always deletes freed descriptor from
> list firstly

Maybe say it like this:

Use list_for_each_entry_safe() to allow iterating through the list and deleting the entry
in the iteration process. The descrptor is freed via idxd_desc_complete() and there's a
slight chance may cause issue for the list iterator when the descriptor is reused by another
thread without it being deleted from the list.

Otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
 
> 
> Fixes: 16e19e11228b ("dmaengine: idxd: Fix list corruption in description completion")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/dma/idxd/irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 8dc029c..fc049c9 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -611,11 +611,13 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
>  
>  	spin_unlock(&irq_entry->list_lock);
>  
> -	list_for_each_entry(desc, &flist, list) {
> +	list_for_each_entry_safe(desc, n, &flist, list) {
>  		/*
>  		 * Check against the original status as ABORT is software defined
>  		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
>  		 */
> +		list_del(&desc->list);
> +
>  		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
>  			idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
>  			continue;

