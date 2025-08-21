Return-Path: <dmaengine+bounces-6118-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F3EB309E8
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E361AE2FD1
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8122EAD19;
	Thu, 21 Aug 2025 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9DmopKH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A12E1F13;
	Thu, 21 Aug 2025 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818065; cv=none; b=dCX3/RIHo0BK/J/N42UzbJi+oaLhP8/z7QHElF7NkS97jhtQTYkduXlCd7anSOnynWbNL9Qe2m0H9Zyg0Q7GxcNeLBR4ZjyRuWdmzI2YubpPoLje92acx0Ra+19I4yUQ5Aks0WsHDXcDfHEcf4jANz7mWRyfgkkLthqmuRpDFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818065; c=relaxed/simple;
	bh=J9SVUO/FEloeUeTrYp5kk71lpvCtqLdAQomTwfs7YG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXe6d82HUGxw+4iwCx36iwPnE1gL8iZ0HQzAaWUphA9yicZVXbaeonM0q2M2Q2NeT7XB4PYsFqB4PGSKa1CJVp5UHD7kcN+K5I1h11P1k/6v9Qf3EF+vp9pGP1cE6Xmj5HJzxUHqHT/tsoFJWdZPmsSJZWt4n2Dh/dvjkkNacTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9DmopKH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755818064; x=1787354064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J9SVUO/FEloeUeTrYp5kk71lpvCtqLdAQomTwfs7YG4=;
  b=P9DmopKHiEov6a2bbbsuGWv9kL039l5ii9OAL4GrFEb4nK5WSTxzjOgp
   LjrEiNsH59AOQX9tUib7DbAmcrfv/oQ0LV5h34dqR4exlFmJBc3XBLgw5
   UPHV6SisXGmOcNi3BWVi700V6+fEqtnr9LllrEznDML0JmxoSrvGVqote
   axeFWJgl+3FeoqOV8is03NXSObWpVV9jAYv+PjGR4AKvdKjkBoWRCNrhv
   xhfMjJ0lrGPeuuoDOTtfh94gDm+Zhq6Ts3vToL6+z2Q4k08IbpnhqnNAR
   +DoNDpmFnb8Wkr3ZYMAaCyoOfUqY8z9AFtd+6eezaxpJ4ld5WUEuLfx32
   w==;
X-CSE-ConnectionGUID: FR7Mw+YrStqzOgp/kpMlLg==
X-CSE-MsgGUID: iLZSUAa3RqGqosFrAKBMvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61957499"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="61957499"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:14:23 -0700
X-CSE-ConnectionGUID: IXH5YKcFQ/KgX+hwZIKdDQ==
X-CSE-MsgGUID: qjDagPZHRfCg7nUhchvQ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168765157"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.210]) ([10.247.119.210])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:14:20 -0700
Message-ID: <eeb620c3-9d7b-43f8-80ae-4716c20c3bb8@intel.com>
Date: Thu, 21 Aug 2025 16:14:14 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] dmaengine: idxd: Flush all pending descriptors
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
 <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-5-595d48fa065c@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-5-595d48fa065c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 3:59 PM, Vinicius Costa Gomes wrote:
> When used as a dmaengine, the DMA "core" might ask the driver to
> terminate all pending requests, when that happens, flush all pending
> descriptors.
> 
> In this context, flush means removing the requests from the pending
> lists, so even if they are completed after, the user is not notified.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/dma.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index dbecd699237e..e4f9788aa635 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -194,6 +194,15 @@ static void idxd_dma_release(struct dma_device *device)
>  	kfree(idxd_dma);
>  }
>  
> +static int idxd_dma_terminate_all(struct dma_chan *c)
> +{
> +	struct idxd_wq *wq = to_idxd_wq(c);
> +
> +	idxd_wq_flush_descs(wq);
> +
> +	return 0;
> +}
> +
>  int idxd_register_dma_device(struct idxd_device *idxd)
>  {
>  	struct idxd_dma_dev *idxd_dma;
> @@ -224,6 +233,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
>  	dma->device_issue_pending = idxd_dma_issue_pending;
>  	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
> +	dma->device_terminate_all = idxd_dma_terminate_all;
>  
>  	rc = dma_async_device_register(dma);
>  	if (rc < 0) {
> 


