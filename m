Return-Path: <dmaengine+bounces-5959-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B89B1CA4A
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C283AB155
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE72989BF;
	Wed,  6 Aug 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Olz1ICVV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE962222B4;
	Wed,  6 Aug 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500036; cv=none; b=K+6UjrIb+YZTAW4NRqWURCBHzzcflk9v8XjK2dav+QL/d2e56yZflR58lcJKNNdA+hK5/jJvBoSOzcNkBdGzSaQE9ASBVxsIVEDjLuaQW4hlbNFe62Oa4dI+HHRXeWrhJNy2bC2ST3oCcBjqbZKvEB9QLWlPa32OhbGJwpW0thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500036; c=relaxed/simple;
	bh=0I40zm+QW2nh0ltUf7Xu6AE4US7n+lnLRDbBI2XDTsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgXbOngfElKFFMKl3vwHpoA5K1ZbGqzUbNcZYaQ87BQpIQHO9YWhZuKkV+HjiHPKPjWZc/E4sAe6KXfVg+PI7ceWg/iTJwZvqpFVpPSV6ERoAx/R0KP61rx/yP+aEPqsm6ExUWMIeGYCB6dHR7qyJTUuWH8uOpVGaWgk8x8I+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Olz1ICVV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754500035; x=1786036035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0I40zm+QW2nh0ltUf7Xu6AE4US7n+lnLRDbBI2XDTsI=;
  b=Olz1ICVV7nb56+SEJWxSdpo6x8nBcLq9xYmE9eouylSBFLr/Muh4qCNb
   F5IzuLmpCz6dPkETRGkfy5lURroWSIl1MzTxyaETAc33/KSSzoqS9jnQv
   29J2OpZNPa4qmsalzhgNV8UYWMl0p2eBzLRdWsRpwjtUIvJcDlHPjGecE
   2ztGxcrB56lsDGaVaYN6WV8kwCst/0NqgwKKqnXCKUnzIp3qx/jexe8HE
   Gj4G1V2fXC6e5OF8RJSNqRjF+0KlHn1NTYu6k8uNyZ13lBflQYVLZbcr1
   Q7UwohA4LfL/WPXPuJuVc29R3F80jPliz/1RAbZmdhBZqFjr/YqC9AlaC
   g==;
X-CSE-ConnectionGUID: RG6QfEUGRb6cCHtRYyLZwg==
X-CSE-MsgGUID: oLUBrYorTC+R2rCi1va0pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68200813"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="68200813"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:07:14 -0700
X-CSE-ConnectionGUID: i/d/cIFWRw6EcLDqPQTb5w==
X-CSE-MsgGUID: MUIieTzeRTGyeBiIRo/YQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195661461"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:07:10 -0700
Message-ID: <585a324d-3a88-42e0-b4bf-2e757dcf5108@intel.com>
Date: Wed, 6 Aug 2025 10:07:05 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dmaengine: idxd: Fix crash when the event log is
 disabled
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-2-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-2-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
> If reporting errors to the event log is not supported by the hardware,
> and an error that causes Field Level Reset (FLR) is received, the
> driver will try to restore the event log even if it was not allocated.
> 
> Also, only try to free the event log if it was properly allocated.
> 
> Fixes: 6078a315aec1 ("dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c | 3 +++
>  drivers/dma/idxd/init.c   | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5cf419fe6b4645337cf361305ca066d34763b3c2..c599a902767ee9904d75a0510a911596e35a259b 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -815,6 +815,9 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
>  	struct device *dev = &idxd->pdev->dev;
>  	struct idxd_evl *evl = idxd->evl;
>  
> +	if (!evl)
> +		return;
> +
>  	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
>  	if (!gencfg.evl_en)
>  		return;
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index d828d352ab008127e5e442e7072c9d5df0f2c6cf..a58b8cdbfa60ba9f00b91a737df01517885bc41a 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -959,7 +959,8 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
>  
>  	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
>  
> -	idxd->evl->size = saved_evl->size;
> +	if (idxd->evl)
> +		idxd->evl->size = saved_evl->size;
>  
>  	for (i = 0; i < idxd->max_groups; i++) {
>  		struct idxd_group *saved_group, *group;
> 


