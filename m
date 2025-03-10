Return-Path: <dmaengine+bounces-4677-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB80A59A18
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 16:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0E0188FC1E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28FD22D79B;
	Mon, 10 Mar 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mp1NPEM4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B922D79D;
	Mon, 10 Mar 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620993; cv=none; b=HKzneyR8a3yW021AmjcyxQy1PiyDqfQPCHFycOsQ/owBc28sXs19dnBh8dswEHnCUNZvkIbffxzQdniYdMYlA7dP71lKfVg4IMx8CM59BYZ3XoSSBqlp1QNOnNmwtw22RQcxOvO0SrMjdPwanMS+07t7k8iU5KCwK6wW/l1Mf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620993; c=relaxed/simple;
	bh=64F4B4yJEEAfxN3wUIZgI4lC2XVN5r8inKVe5WmZtRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QItSgq1xZk/DNB79G3MAC0UESQ2ylnCiuga0LXI8KTXhO+7HNalNjJ4qnLLe7U27xy41G6ZKz9IRAH1Ml6KeVpsbswc40Tws1s1LtPWQCn5jacGN239EubY3upYw98Q5BkQqvdRgXVD7z0NnGFF1mxRkG3iA9HysUgAH4u20Mv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mp1NPEM4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741620992; x=1773156992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=64F4B4yJEEAfxN3wUIZgI4lC2XVN5r8inKVe5WmZtRY=;
  b=mp1NPEM40uZILz1IrbOiJ0lF3BzJvYZdlmmdnyZNjYljuaahSFNv/jto
   NBwvNyuz1SQojnJgKuQJq4vqUMBSQrtRQ7tyRgN4Fc1gWI1Q1JP6wg+j3
   VdN5+qRMKpErzSeumUQNW1aRopcOC7nxmsaBk5Hq9xzFSGaLiiWy0HliI
   pSQdZb23B/6kHVzwBNum0oOLGXeS0DEemj47Oc6dS/1bcFweOqR68yq7J
   Qio2abDxXsgNOTGUTBsKxuMGMtBjKlyUPM86wdd2et/P6X951NKeu0bsI
   yORfWAH5XEEq/pUGmYu1hqSXMfPeVjskxZygwRKCLZ3ClWCvxljsNxrJW
   Q==;
X-CSE-ConnectionGUID: pja+oU0PR1mfojYMPPcj5A==
X-CSE-MsgGUID: ppoDMT9BQgey6ZEw3SYRxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41870588"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41870588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:36:30 -0700
X-CSE-ConnectionGUID: F3VoGm4ET5KIlKSB614RWQ==
X-CSE-MsgGUID: GZmB2o0OT2CBKOdaDJhi3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="150986398"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:36:29 -0700
Message-ID: <49c6ce4e-52a4-43e2-b67f-9aa096694f39@intel.com>
Date: Mon, 10 Mar 2025 08:36:28 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] dmaengine: idxd: Refactor remove call with
 idxd_cleanup() helper
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 Markus.Elfring@web.de, fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-10-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250309062058.58910-10-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/8/25 11:20 PM, Shuai Xue wrote:
> The idxd_cleanup() helper cleans up perfmon, interrupts, internals and
> so on. Refactor remove call with the idxd_cleanup() helper to avoid code
> duplication. Note, this also fixes the missing put_device() for idxd
> groups, enginces and wqs.
> 
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Cc: stable@vger.kernel.org
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index ecb8d534fac4..22b411b470be 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1310,7 +1310,6 @@ static void idxd_shutdown(struct pci_dev *pdev)
>  static void idxd_remove(struct pci_dev *pdev)
>  {
>  	struct idxd_device *idxd = pci_get_drvdata(pdev);
> -	struct idxd_irq_entry *irq_entry;
>  
>  	idxd_unregister_devices(idxd);
>  	/*
> @@ -1323,21 +1322,12 @@ static void idxd_remove(struct pci_dev *pdev)
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


