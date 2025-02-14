Return-Path: <dmaengine+bounces-4470-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE0A3633A
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2FE3A5B4F
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E22676DF;
	Fri, 14 Feb 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej30a80Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F17E0ED;
	Fri, 14 Feb 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550963; cv=none; b=PFVOHu+2fNLhIyQMzUGNFCNju81TNMPNj8gya73iTFNyEJC316CV91QeMq1vnnusf3zRVTGSrIPT5VyTZIs3UDhAHuDe0608ZaJNIa8pZzy5qQOnLI6ljXbCpDgUMjehkyqey3Fj6O0LiYwxXZ9mcgDkYpGQgiKbHCczJtKTilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550963; c=relaxed/simple;
	bh=lnM4ri5uYA/P21OP0SAqz4XohpK/8s3XKn5vUW/M+2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7OAz9AX/r+CSvnHdi3eVwvBtFNxwF9DVqxyn97dr5+lBj2N8S36kScNu2o2TSLIlybhRxd1Y3YWywbffzqsIzUUNbhzwbfiZormZM2itqdnHcqaCGrcUN5Wh1q/EzKEfDtOxtr3nrfVsCCGdOgq50LyjpD//odNt09YdX2VcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej30a80Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739550962; x=1771086962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lnM4ri5uYA/P21OP0SAqz4XohpK/8s3XKn5vUW/M+2E=;
  b=ej30a80ZLFONyo05K/fgiYn9md6zubgoKQ2Rilq/j6sVdSyDKxYQg6y0
   L5Z3RMAj3wTisrDTLXNDCZH5MZTonaNJn7bSmkBIGljgnWWP6j5IRtEvw
   JonvMZIBciW1Q4yqLhA1dk4kZJXXauX6gqQ0TZ5B7dlq61zYVjHo7tS1j
   5Oa1xeg3xF19LXqXnerl04xmQ/vZybIqSxJn7UKYuIUti/XQejwnrPJ3V
   0Hg/8U7k7orpf9cP6AcjOtQ00AimlPtim8rhd42XkxZwU2W1rweYZkHmv
   PFyUSOc5A4IfC+tZxwn7yuObJ6C65C4gU0nZPQIsYHZVQdKMllztN2MNt
   g==;
X-CSE-ConnectionGUID: elD7g0k5QhSClKVCwUbaiw==
X-CSE-MsgGUID: nI1XkYHrTnStSQ1aab3/eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57711888"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57711888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:36:01 -0800
X-CSE-ConnectionGUID: QU+6SM/ETEW6aZXqPnoZqA==
X-CSE-MsgGUID: eJs1uAM0QRKPKBsQaEVMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114011202"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.34]) ([10.125.109.34])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:35:59 -0800
Message-ID: <d85f4871-4ebd-4f8b-b743-e46db522e4f8@intel.com>
Date: Fri, 14 Feb 2025 09:35:57 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_engines
To: Shuai Xue <xueshuai@linux.alibaba.com>, vkoul@kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <20250110082237.21135-3-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250110082237.21135-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/25 1:22 AM, Shuai Xue wrote:
> Memory allocated for engines is not freed if an error occurs during
> idxd_setup_engines(). To fix it, free the allocated memory in the
> reverse order of allocation before exiting the function in case of an
> error.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 6772d9251cd7..12df895dcbe9 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -275,6 +275,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>  		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
>  		if (rc < 0) {
>  			put_device(conf_dev);
> +			kfree(engine);
>  			goto err;
>  		}
>  
> @@ -288,7 +289,10 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>  		engine = idxd->engines[i];
>  		conf_dev = engine_confdev(engine);
>  		put_device(conf_dev);
> +		kfree(engine);
>  	}
> +	kfree(idxd->engines);
> +
>  	return rc;
>  }
>  


