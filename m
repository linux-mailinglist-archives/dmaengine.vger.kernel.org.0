Return-Path: <dmaengine+bounces-8313-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF5D3877C
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 21:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AB383009F58
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F3366DB5;
	Fri, 16 Jan 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+F0k+pI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803428506A;
	Fri, 16 Jan 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595228; cv=none; b=kjQxQzNNgu6IgdulDi4Tbzi6lXj3VFIujBkrUcO9faLDeRc5N8BEu6UFbnMcenVHrwo9sDgPr+kRPmHQDvHrCedOuflVsGFWWV0kSLjrcuFknu8wNDDcallucrnkW2ZncyFaoc+cn6poes0NQLZ1pgDCDKIpYEj+oviCAtOByyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595228; c=relaxed/simple;
	bh=VOov7iCHzLHE82o5pjCHoRUwHO/wDmBKPSS9rf8vSDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7eVKwRQ8qt4c/472eGamxA3lVhbiJu1f8MuDkCRW9hEMCavVtoL71YRl7T1NVmsy5H+3Rh61eLCL5NnGxhLbnNyBDmgLURcQvAad1apnehq3heugaZBf8+6vF0wpoQbFUEQaQm86nvNLhHO4XbgFiiZtdescLA0UeC/wUc5LjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+F0k+pI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768595227; x=1800131227;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VOov7iCHzLHE82o5pjCHoRUwHO/wDmBKPSS9rf8vSDM=;
  b=T+F0k+pI288OG9/Rz/twzxH/JAktTmb7ThP7d1mEh2+SqqqYaI2a9bRb
   d5VOHJRg0kzcH792C01u2XMonpq+UsO9wfOrOG8RHk3YxqkgOVTOXucTs
   KQO+49FfukGkPUE32AWfYEcStCDNDnP4sezK6/ZGHkHta2g2hi0t9ACCH
   vpYuma41VSFkdZlRk2uEW3ODvN5jIbQc85JicOjhbsffElKHjVjMsFh1A
   O3ZBzQSnSG0+9RC3xZiphHFfTNlvzG5mdzFuiqVP7sLKnVb2PaPvWYZij
   SojBXxqYftuE15m2yRwWkg6lGVN7UOqyWpOxPo94a23yiLglRBWMQvf6d
   A==;
X-CSE-ConnectionGUID: YzvCbHK4SA+tYLAjxB+mkQ==
X-CSE-MsgGUID: aRvEZqwEQyeymDXdNWucXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="70083184"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="70083184"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:27:07 -0800
X-CSE-ConnectionGUID: KOLOh9dQSu+Way0tcedARg==
X-CSE-MsgGUID: zwnTDStdThOsfh+hJa5MNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="210191221"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.140]) ([10.125.111.140])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:27:06 -0800
Message-ID: <65df4fa8-f991-4eb8-84af-70518cbe243b@intel.com>
Date: Fri, 16 Jan 2026 13:27:04 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 06/10] dmaengine: idxd: Wait for submitted
 operations on .device_synchronize()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
 <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-6-59e106115a3e@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-6-59e106115a3e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 3:47 PM, Vinicius Costa Gomes wrote:
> When the dmaengine "core" asks the driver to synchronize, send a Drain
> operation to the device workqueue, which will wait for the already
> submitted operations to finish.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/dma/idxd/dma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index e4f9788aa635..9937b671f637 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -203,6 +203,13 @@ static int idxd_dma_terminate_all(struct dma_chan *c)
>  	return 0;
>  }
>  
> +static void idxd_dma_synchronize(struct dma_chan *c)
> +{
> +	struct idxd_wq *wq = to_idxd_wq(c);
> +
> +	idxd_wq_drain(wq);
> +}
> +
>  int idxd_register_dma_device(struct idxd_device *idxd)
>  {
>  	struct idxd_dma_dev *idxd_dma;
> @@ -234,6 +241,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
>  	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
>  	dma->device_terminate_all = idxd_dma_terminate_all;
> +	dma->device_synchronize = idxd_dma_synchronize;
>  
>  	rc = dma_async_device_register(dma);
>  	if (rc < 0) {
> 


