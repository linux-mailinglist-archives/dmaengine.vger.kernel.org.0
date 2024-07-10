Return-Path: <dmaengine+bounces-2670-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD292D531
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 17:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D92B1C215F5
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339F194A6F;
	Wed, 10 Jul 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2aOJovl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518581946DF;
	Wed, 10 Jul 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626149; cv=none; b=sMOhWiPvHFyiS3I+DsWSQfweRN7S/O0BilkG/ZCQxuF1IHXoT5jMht6aHv4Lb89KkBh/XrZrRHXiLH1k/OByclce83b1Md5NQJNED4z336aHW4cxlIZDTPR5kGH6EhzXvxFtzlWIU9JIwoQbXJY21gyVP+OTXbFWrj2YPU59OeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626149; c=relaxed/simple;
	bh=aFOr/mQFZylxPSulJht9IZixww6VB8Mp4pnEZJILIWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qel36GAcbav8qWmp2xsxMGCg+3mH7XqD0sojMSi1fsgSD5ClVDYb5mke9yT+8NJHYDuFQs9fj+gfAaI+MLm5NuaNRdNPAl1X/ksFeJU1bYcwp7uCB1p1sLdPhk3VtV2Mgyop72YcBRkbIpkmm+pOp85SWr2JuNaGokj6l7r0Y/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2aOJovl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720626147; x=1752162147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aFOr/mQFZylxPSulJht9IZixww6VB8Mp4pnEZJILIWY=;
  b=f2aOJovlIBNAaygpdOmlOjUpVAhq34LEPycTom4IE1hJwYmkHygrbuY5
   46OqvRdhUvILzkCis4loRrCDMFkHZsBA9QONfAGE9bCsfvU5w8woSZ8Xz
   M07YVgbva+yg6klADFMBXagQ5VrNf7esmkKpF1Ru1K5iiL0Mut05Rvu7x
   fzLD0zkQHjp5mBkgmUA4joeXF87uOyhUnmBaMDvKgpF5CaJ0ObjuP86zq
   Nvde4UNJWBcEcOMdjy6h8vc3iQMeuPQTLmW3AcWRrNcFmyIiJ0IZQWBjl
   cxI5Y2WH2BNisyyLnGJLBllER4wIikslKNXgzmiWE2+q/KuoAgSQOE1N7
   g==;
X-CSE-ConnectionGUID: Gf+lGHDKQuGwug6qcfbYiw==
X-CSE-MsgGUID: TcNXAjX8TrmWcGeiLaxFgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="40476765"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="40476765"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 08:38:58 -0700
X-CSE-ConnectionGUID: /Kymr7ecRPOhpbJmzv8+KA==
X-CSE-MsgGUID: 2ILA41B7TPu4Wb3xK+Bjjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="85754058"
Received: from eamartin-mobl1.amr.corp.intel.com (HELO [10.125.109.181]) ([10.125.109.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 08:38:58 -0700
Message-ID: <126da0b9-e7c3-42c8-881a-cf7f3d396397@intel.com>
Date: Wed, 10 Jul 2024 08:38:56 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, fenghua.yu@intel.com, vkoul@kernel.org,
 "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240710030725.1960882-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240710030725.1960882-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/24 8:07 PM, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Odd that it used to compile.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/perfmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index 5e94247e1ea7..e596ea60ed3c 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -480,8 +480,8 @@ static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
>  	idxd_pmu->pmu.attr_groups	= perfmon_attr_groups;
>  	idxd_pmu->pmu.task_ctx_nr	= perf_invalid_context;
>  	idxd_pmu->pmu.event_init	= perfmon_pmu_event_init;
> -	idxd_pmu->pmu.pmu_enable	= perfmon_pmu_enable,
> -	idxd_pmu->pmu.pmu_disable	= perfmon_pmu_disable,
> +	idxd_pmu->pmu.pmu_enable	= perfmon_pmu_enable;
> +	idxd_pmu->pmu.pmu_disable	= perfmon_pmu_disable;
>  	idxd_pmu->pmu.add		= perfmon_pmu_event_add;
>  	idxd_pmu->pmu.del		= perfmon_pmu_event_del;
>  	idxd_pmu->pmu.start		= perfmon_pmu_event_start;

