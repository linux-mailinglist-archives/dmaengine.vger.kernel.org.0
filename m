Return-Path: <dmaengine+bounces-5991-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16EB2115A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D493AF784
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EC12DECC6;
	Mon, 11 Aug 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUmnQnCM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E429BDAE;
	Mon, 11 Aug 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928144; cv=none; b=EgJy1QGFJKsH3HnSlUFpkXURWAlujN8u/lUTeULlUeCvB6ByNybuEOnvd5TBtGHkjRH4frSjJ4Mxt97BFgoVb0u0oxU2w0LPb1qKP/5VkOqZbyEqsGz4h/+D6R1mnJuiJSOV+HpbU9poHIS0MSAgYybFVRW/2lSqtNQ1RGHOt0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928144; c=relaxed/simple;
	bh=C0YeLo+QrnMfCU48sqIKEtj6gv3YrfL49zOooRu34XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbOnTQbwhOYCiwCmjLeNXPQWC9ffFP/51ZcXoCM3WPXDDLLG38T6yjWQgn/s3GusM9+iOSw5lv5H3uH7srBnZzpNmkjlgSvF3ZKuIfYgANkN96aTVvSEBSMzDpzQimsFX/z6qWi2KgQgIpwipgGFg3P8Fa1h60g4yCdcFtayWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUmnQnCM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928143; x=1786464143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C0YeLo+QrnMfCU48sqIKEtj6gv3YrfL49zOooRu34XY=;
  b=IUmnQnCMIOaX0feDxNesMj094BXW73aczSzXyOmJ3kwIkmRtdChl2skL
   2xZArAFwlyifgl+hcw4MwIwSmJu3dQNm/gqWNCWaNw+PIHSK88qFa23x3
   yxuPE/9r50VPkLc+6Y0snoA+ft+lkbNS1LJFhojhSyBS6GIDAYpMjKS+C
   fTgJcbt3IVYWDHkzoUqmgA3gQj4OAi2qzo0oBKUwgIvfJX5llhNdvKdXd
   e/104Ak0mgZkT6JvOA/kL9cX9gcZMNkPFvCYsHsyDB+nhk4FZzgNLACOb
   d8YwtTnqGoBNSq8gWQPmFqEPvj0qJwOrWGI8A3b1EKtF9EXTehyVsqpy/
   Q==;
X-CSE-ConnectionGUID: vTSoCSZMQMKcrESf5ncjRA==
X-CSE-MsgGUID: e2N8t9H0T/6FhXBwRS9qpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67894347"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67894347"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:02:22 -0700
X-CSE-ConnectionGUID: CByM2r3CQCGGimtDhEWCDg==
X-CSE-MsgGUID: uLWlT41NQV2tgixo1qysAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165447249"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.140]) ([10.247.119.140])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:02:18 -0700
Message-ID: <34846223-7ab7-46d9-9e8b-4adc2bc59c44@intel.com>
Date: Mon, 11 Aug 2025 09:02:12 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Replace memset(0) + strscpy() with
 strscpy_pad()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810225858.2953-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250810225858.2953-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/10/25 3:58 PM, Thorsten Blum wrote:
> Replace memset(0) followed by strscpy() with strscpy_pad() to improve
> idxd_load_iaa_device_defaults(). This avoids zeroing the memory before
> copying the strings and ensures the destination buffers are only written
> to once, simplifying the code and improving efficiency.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/defaults.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
> index c607ae8dd12c..2bbbcd02a0da 100644
> --- a/drivers/dma/idxd/defaults.c
> +++ b/drivers/dma/idxd/defaults.c
> @@ -36,12 +36,10 @@ int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
>  	group->num_wqs++;
>  
>  	/* set name to "iaa_crypto" */
> -	memset(wq->name, 0, WQ_NAME_SIZE + 1);
> -	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);
> +	strscpy_pad(wq->name, "iaa_crypto");
>  
>  	/* set driver_name to "crypto" */
> -	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
> -	strscpy(wq->driver_name, "crypto", DRIVER_NAME_SIZE + 1);
> +	strscpy_pad(wq->driver_name, "crypto");
>  
>  	engine = idxd->engines[0];
>  


