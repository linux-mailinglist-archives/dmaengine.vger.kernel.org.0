Return-Path: <dmaengine+bounces-8312-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B9CD3878C
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 21:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDE531778BC
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 20:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9733ADA9;
	Fri, 16 Jan 2026 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZWqMvSh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3826A1B9;
	Fri, 16 Jan 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594942; cv=none; b=LWfIsn+Ippr54D4R+IZyBOnBVieP2yT367yEfLeEiSKzsnv+fJ+uh7W83M/MekHKgfT+j/H/Kdo3jLstwAgfxazvqq9NvGGgHiJoIy5C6SEd8b9LNBks0DCr8vcYoJF7fGu15/reWujE2N3p++wYDMYUe9zceO1Xcns+Zxzc5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594942; c=relaxed/simple;
	bh=MX/mbkM84ECFI/nQ5fK4JrQwW4NUcKHEyize+cGYPTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FH9yMeYBfGh/etrVm4u6Vl3jzGddBDvNZY+PvDXUJ5AnKve3hLekgZa1f+TMdyLTneyLb954U4YujW+F2yUtoMGva5vN7Wq45RYdxs3NgFim4DiM9bfPS5435vrLNhupO+Lj2BIAw0dtMWrusjIa+qBmp+2Ajlboi/X+BaTg77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZWqMvSh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768594941; x=1800130941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MX/mbkM84ECFI/nQ5fK4JrQwW4NUcKHEyize+cGYPTs=;
  b=AZWqMvShQ/2Tkmx39I9zqxT+8YK4f4gMdsqOKrXeAtvOUWqVgYDMLYDH
   Ebwtjc7ZgrDD5J3VCJe8aeczgKCv8NgDevc2DSb4Bzwt8LebaiMEoPouu
   yZ3TTYJzApNOG69LRVPmOY0QCz5dkv8+8HJ3EjrFQsGHYzuYNqHRz6RIq
   7w7zfa8uNr7u38Jr1azqKKxP/K1Ndh/WclgcQtXONsbj+gMNcC/zEmjBL
   BHPhOcPnDfI5c5AjQFIXRink28f6UwOiWD5HutgOHpw3Te2KBZ9DNVz9q
   /Pqmw9ZsTxKoEKECB1UnCALscm6557N6T50J3f9STjpduICjAJPFN0V27
   g==;
X-CSE-ConnectionGUID: +ZyIMO27Qae21MS6AedqkQ==
X-CSE-MsgGUID: XnTgu3eeRQ2R24PnLIphOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69816445"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="69816445"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:22:20 -0800
X-CSE-ConnectionGUID: N9eUu/pBRTm82dDr4nmREQ==
X-CSE-MsgGUID: V2451IwxQeS50Qet6MLHoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="204558590"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.140]) ([10.125.111.140])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:22:20 -0800
Message-ID: <917d2e4c-1dce-422c-82c1-1989889144b7@intel.com>
Date: Fri, 16 Jan 2026 13:22:19 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 05/10] dmaengine: idxd: Flush all pending
 descriptors
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
 <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-5-59e106115a3e@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-5-59e106115a3e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 3:47 PM, Vinicius Costa Gomes wrote:
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


