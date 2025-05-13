Return-Path: <dmaengine+bounces-5158-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093CDAB57BE
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4017B735D
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF071C84BA;
	Tue, 13 May 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqSMo0nQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F561C84CE;
	Tue, 13 May 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148163; cv=none; b=NFolybjEAFbbda4V0wTlMprY8BgldjKHgHbAr6rgH0dtjtDKmQCbqK+iogQwivwovQgdlDkrOVnVkhwd7xxrVCJdfYmvONOgMVE6H+02o2n31Xjvr7uGfoZKBN9oJHeZXyNS6AGwhk4Qk+f0wQ8z1YK9vN2ZFmzWDu0vclku7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148163; c=relaxed/simple;
	bh=GaEe2emDQDOS0+dFaWSr+BUQP6J5YivU0LIwN5SmKCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8kzFMHY+1ZyC2jKTempG6dxnyiBovQLoIooce8t1rsIyP6GldxneoUzD/B77AOhXF7ul+OG66G+JtM40EU25xS2UOih/oWorQ5wyqZDeTLp+lacgKEMOjMiYl5YNDav39AvD353dwNkzUmV30HEChSQlNliDZedjDKcTeb7e4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqSMo0nQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747148162; x=1778684162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GaEe2emDQDOS0+dFaWSr+BUQP6J5YivU0LIwN5SmKCA=;
  b=dqSMo0nQeRq7TBVp4fIwePWg9b3btwHZEvUUztJO8FoeUa+1aeGapxwN
   AcoE7OBabimUi8iwRfchJp0JLHVThu+4se1EvWCxBjp9V6jnmmP/sUvPq
   oT1aiKV1UC0tGs87a1iSgiRcCWGIbXx7mkWixnaoTJ2WniAwsNGcXmmud
   2855w6PJHGBRyDawNqJw+Zeqj8Y7B1hjzSxEQawzD/Vc+PzZYDctLFI9/
   RL7KcnrcNyC9SyDwNESCgmlJ5rntrHAytG5ziHfLmKsnFquO+KM+XJmUB
   XKr8LQvTuvXrMw9x7ya/ZdOvtD9mx7zhgmVj8zyPSgGXuFMLgW7c6pqv7
   g==;
X-CSE-ConnectionGUID: BIg4XFryTfaGtKsF8/oGvQ==
X-CSE-MsgGUID: DBiC13YSS7OHR5RM6l6oVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="52661001"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="52661001"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:56:02 -0700
X-CSE-ConnectionGUID: 7DLUX/kPR6C7hTXBhyhzrw==
X-CSE-MsgGUID: DRtOX2tRSZCGMBnRDbRGqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="137617693"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.111]) ([10.247.119.111])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:55:55 -0700
Message-ID: <383c91a8-4a17-4d45-b326-14257f1158cc@intel.com>
Date: Tue, 13 May 2025 07:55:55 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] dmaengine: idxd: Refactor remove call with
 idxd_cleanup() helper
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
 <20250404120217.48772-10-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250404120217.48772-10-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/4/25 5:02 AM, Shuai Xue wrote:
> The idxd_cleanup() helper cleans up perfmon, interrupts, internals and
> so on. Refactor remove call with the idxd_cleanup() helper to avoid code
> duplication. Note, this also fixes the missing put_device() for idxd
> groups, enginces and wqs.
> 
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Cc: stable@vger.kernel.org
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 974b926bd930..760b7d81fcd8 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1308,7 +1308,6 @@ static void idxd_shutdown(struct pci_dev *pdev)
>  static void idxd_remove(struct pci_dev *pdev)
>  {
>  	struct idxd_device *idxd = pci_get_drvdata(pdev);
> -	struct idxd_irq_entry *irq_entry;
>  
>  	idxd_unregister_devices(idxd);
>  	/*
> @@ -1321,21 +1320,12 @@ static void idxd_remove(struct pci_dev *pdev)
>  	get_device(idxd_confdev(idxd));
>  	device_unregister(idxd_confdev(idxd));
>  	idxd_shutdown(pdev);
> -	if (device_pasid_enabled(idxd))
> -		idxd_disable_system_pasid(idxd);
>  	idxd_device_remove_debugfs(idxd);
> -
> -	irq_entry = idxd_get_ie(idxd, 0);
> -	free_irq(irq_entry->vector, irq_entry);
> -	pci_free_irq_vectors(pdev);
> +	idxd_cleanup(idxd);
>  	pci_iounmap(pdev, idxd->reg_base);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(pdev);
> -	pci_disable_device(pdev);
> -	destroy_workqueue(idxd->wq);
> -	perfmon_pmu_remove(idxd);
>  	put_device(idxd_confdev(idxd));
>  	idxd_free(idxd);
> +	pci_disable_device(pdev);
>  }
>  
>  static struct pci_driver idxd_pci_driver = {


