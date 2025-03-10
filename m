Return-Path: <dmaengine+bounces-4675-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7795A59A0A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 16:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38503AA2DE
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 15:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096922A4E0;
	Mon, 10 Mar 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxB/lbdc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499D2206BE;
	Mon, 10 Mar 2025 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620850; cv=none; b=HCDryE7yyCKZZGsdTx9EOGLE6O19w2w6530zqodJoTzeqkB1ONOSom9ATFcR8teeOnNK8trSpGUdkQkrp4f4nHJPaVauY7oDF513ZAeMsbF+nFRbt/C6Yyu6vSkYQ5HloYsMFttkMnbHTFDor9DmnHvQhDATjkAftk4qjGmct9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620850; c=relaxed/simple;
	bh=od6OgXKRdSosxkM09V+gA4vcysLkIiN3641sJedhtWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgOweIMjJ47bvqsbSIyu4UpuPKfHojXPs7mj31bCY6EyT+MVTxiPo9ZRQr5Ix16aUhuyWEi4z9Bs4b1arWYwHX5YJt4BsXl0r0Xc7xX0AYkW9BKzvU2fa8NcYis/Y7xnXI8H1rUFIraNERLAbzgC0OxRM8TUZajhjzSz1+8Oj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxB/lbdc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741620849; x=1773156849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=od6OgXKRdSosxkM09V+gA4vcysLkIiN3641sJedhtWg=;
  b=QxB/lbdcDQA31kiFUdsED3TXCbk2VIMzNqfLgzrxGorK20vX05jQFTT9
   o5S3B6npt4pf6pEE5U1i3OubpMjNr7XfXvf2ue3bwcgal6vyEEThQvJMf
   j7oi2wQzm5C7pBvzFtjDxp9El3YPpcxMxKFypMJdGL66kK2iWfRbtyVhd
   7mdchprvalBvWcX/GRY1lA9pVw515/yngqWgNo+sRyxtp6aa4B59v1Xij
   PFB3ik3IiH1BTP3zU29hQpSMV1msFQsz7uDL8KfPQ3sPa06n1sYHzfl9M
   iXiCkH9tCJ+dfyaqAelcmSIkgvLGpS9smJP9KXQC0GCG3C5I13c06u2xk
   A==;
X-CSE-ConnectionGUID: G4pJnzNrSIauH/BBDXC9Pw==
X-CSE-MsgGUID: AImg92PFRCScg92YZzPGQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41870233"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41870233"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:34:08 -0700
X-CSE-ConnectionGUID: jEc/8p7yS1eaxZ7ep2CEEQ==
X-CSE-MsgGUID: /y8bZ5LxSyWdDZehi768mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="150984930"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:34:07 -0700
Message-ID: <1deab9b3-4447-4b21-87ce-7d787f43ebc1@intel.com>
Date: Mon, 10 Mar 2025 08:34:05 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] dmaengine: idxd: Add missing cleanups in cleanup
 internals
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 Markus.Elfring@web.de, fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-6-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250309062058.58910-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/8/25 11:20 PM, Shuai Xue wrote:
> The idxd_cleanup_internals() function only decreases the reference count
> of groups, engines, and wqs but is missing the step to release memory
> resources.
> 
> To fix this, use the cleanup helper to properly release the memory
> resources.
> 
> Fixes: ddf742d4f3f1 ("dmaengine: idxd: Add missing cleanup for early error out in probe call")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 7334085939dc..cf5dc981be32 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -408,14 +408,9 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>  
>  static void idxd_cleanup_internals(struct idxd_device *idxd)
>  {
> -	int i;
> -
> -	for (i = 0; i < idxd->max_groups; i++)
> -		put_device(group_confdev(idxd->groups[i]));
> -	for (i = 0; i < idxd->max_engines; i++)
> -		put_device(engine_confdev(idxd->engines[i]));
> -	for (i = 0; i < idxd->max_wqs; i++)
> -		put_device(wq_confdev(idxd->wqs[i]));
> +	idxd_clean_groups(idxd);
> +	idxd_clean_engines(idxd);
> +	idxd_clean_wqs(idxd);
>  	destroy_workqueue(idxd->wq);
>  }
>  


