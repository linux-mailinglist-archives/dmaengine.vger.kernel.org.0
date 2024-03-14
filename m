Return-Path: <dmaengine+bounces-1382-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E295987B5D5
	for <lists+dmaengine@lfdr.de>; Thu, 14 Mar 2024 01:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA267B21BF2
	for <lists+dmaengine@lfdr.de>; Thu, 14 Mar 2024 00:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A9440C;
	Thu, 14 Mar 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtVM7fZ7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA903D75;
	Thu, 14 Mar 2024 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376642; cv=none; b=jiljoG8y+13QjqxHeIa6DEhBPCP9BiSl5fGcTO1FC2d+CT2gNTBqSejYRL7VCz576e09sZWwI3TyXMP+TsKBUkjea59ggW9xyzjpmsG2+rW75PbH5otxi+JQU2xIlOCtNQgR30/ZxgTMzuQXr1JfjZQg63OQf1EYXeMG9QhEUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376642; c=relaxed/simple;
	bh=/QlMMY4Hg9yaPdoSTOcaEY42ynVEhlurCMB1qau/fbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdWsOFoRm9fP9z+rTqBXauvh3HuxnkpWyeWBWQBlHun6PjXtreGul6iDyz+kq4ssZ6xw+sxKLHFZ+QQiVoVRhGWlnn2t223yoAlM52W8UHVacI6vjLHYl0sD8h/BGk7PnLCbUKiYxRX3AVYX3u8hAsC2hd3DNL/N6IOTGbRXSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtVM7fZ7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710376641; x=1741912641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/QlMMY4Hg9yaPdoSTOcaEY42ynVEhlurCMB1qau/fbs=;
  b=NtVM7fZ73wU0gqAB5xSSQl3aIW2J8WvLGH/kVJr8pVSf1URZQ8eXAsqH
   QWkYJphA6diEPaBsdcwmmyG0pGTxOFI0pRO/UYgE2nugZQwDOncjhzx8o
   h+uiCelNV0iIFIWndGOVE3HjIlv4SZ8tRt4yi0acFzoEh2JxXV36b95P+
   4DwGoYw+wtUDZ1ifEqr999hR3dRuRZhkFlhHwglZf8J2lUC1KF2znYvme
   OKI+tR/axhlWoVZSnUskxbBK65HmIYTRWbFN1eKo9m4WlIfG5nCUqS2rd
   +UkBYfhdwusl9RWfe6qHbWUTM0iR1yfXMTUDusBdFX3zVUERym63Mfhc+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5041966"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="5041966"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 17:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="12189279"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.112.230]) ([10.212.112.230])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 17:37:19 -0700
Message-ID: <cfb23a18-ee56-4d3d-b0cf-fd47c0dc6f4b@intel.com>
Date: Wed, 13 Mar 2024 17:37:18 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Fix oops during rmmod on single-CPU
 platforms
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Terrence Xu <terrence.xu@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
References: <20240313214031.1658045-1-fenghua.yu@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240313214031.1658045-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/24 2:40 PM, Fenghua Yu wrote:
> During the removal of the idxd driver, registered offline callback is
> invoked as part of the clean up process. However, on systems with only
> one CPU online, no valid target is available to migrate the
> perf context, resulting in a kernel oops:
> 
>     BUG: unable to handle page fault for address: 000000000002a2b8
>     #PF: supervisor write access in kernel mode
>     #PF: error_code(0x0002) - not-present page
>     PGD 1470e1067 P4D 0 
>     Oops: 0002 [#1] PREEMPT SMP NOPTI
>     CPU: 0 PID: 20 Comm: cpuhp/0 Not tainted 6.8.0-rc6-dsa+ #57
>     Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.86B.2492.D03.2307181620 07/18/2023
>     RIP: 0010:mutex_lock+0x2e/0x50
>     ...
>     Call Trace:
>     <TASK>
>     __die+0x24/0x70
>     page_fault_oops+0x82/0x160
>     do_user_addr_fault+0x65/0x6b0
>     __pfx___rdmsr_safe_on_cpu+0x10/0x10
>     exc_page_fault+0x7d/0x170
>     asm_exc_page_fault+0x26/0x30
>     mutex_lock+0x2e/0x50
>     mutex_lock+0x1e/0x50
>     perf_pmu_migrate_context+0x87/0x1f0
>     perf_event_cpu_offline+0x76/0x90 [idxd]
>     cpuhp_invoke_callback+0xa2/0x4f0
>     __pfx_perf_event_cpu_offline+0x10/0x10 [idxd]
>     cpuhp_thread_fun+0x98/0x150
>     smpboot_thread_fn+0x27/0x260
>     smpboot_thread_fn+0x1af/0x260
>     __pfx_smpboot_thread_fn+0x10/0x10
>     kthread+0x103/0x140
>     __pfx_kthread+0x10/0x10
>     ret_from_fork+0x31/0x50
>     __pfx_kthread+0x10/0x10
>     ret_from_fork_asm+0x1b/0x30
>     <TASK>
> 
> Fix the issue by preventing the migration of the perf context to an
> invalid target.
> 
> Fixes: 81dd4d4d6178 ("dmaengine: idxd: Add IDXD performance monitor support")
> Reported-by: Terrence Xu <terrence.xu@intel.com>
> Tested-by: Terrence Xu <terrence.xu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Cc: Tom Zanussi


> ---
>  drivers/dma/idxd/perfmon.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index fdda6d604262..5e94247e1ea7 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -528,14 +528,11 @@ static int perf_event_cpu_offline(unsigned int cpu, struct hlist_node *node)
>  		return 0;
>  
>  	target = cpumask_any_but(cpu_online_mask, cpu);
> -
>  	/* migrate events if there is a valid target */
> -	if (target < nr_cpu_ids)
> +	if (target < nr_cpu_ids) {
>  		cpumask_set_cpu(target, &perfmon_dsa_cpu_mask);
> -	else
> -		target = -1;
> -
> -	perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
> +		perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
> +	}
>  
>  	return 0;
>  }

