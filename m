Return-Path: <dmaengine+bounces-5964-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42FB1CAB6
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AAA722C2E
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507B429E0E5;
	Wed,  6 Aug 2025 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TV8MJEmO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57029CB24;
	Wed,  6 Aug 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501165; cv=none; b=CnLpdTv0SaSN0zMjaxQkhdDATkjLuq4miRQyqcU+Jp6yIH2WAk2IAlcPEzhW4TwN1ZUcTsdOf34E3PwjW0S3xvC5xDfpHlMUh/m2IkUlow+YEbh2udx1Lw1lV1vaRT3s5Q3gcttmkgltrmipJ9OvQgin6ZlcOYWPLAqYhb6mOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501165; c=relaxed/simple;
	bh=DkhWngBqiuz7S+IUctMLkwSmJSchzVBmxG1+YCRdigQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTM7ebA2g9t2gOXi1B5t65W1udCJRkFjelUAJizG2Gasha1wRDApc0B1bxIW/fQaotVHRjrIPyCfQ9IhbZo8swquQLQVSq13cZUl8Uh4FuwS+DHJHgmArYepjiQyb77+Jtr4VQw94aoAss62mJ/nzr+cb8wtBkSWQPj0CokYEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TV8MJEmO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754501161; x=1786037161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DkhWngBqiuz7S+IUctMLkwSmJSchzVBmxG1+YCRdigQ=;
  b=TV8MJEmOGI0wORFp8K9bgFvAGIWgDOB3VqSHWxrUAClfMnladq87WO1E
   7FM2fmS6Vv7mfUVE9nKrDkFwRGj0t78SAPLyBEfiPyIr06SIDG35cmSYW
   Qfc69JMKbqn2WwbIxlx0aoNCF+p2ZQSE7RMTT2Nr3ZgyAGAmKRaYtRt9i
   KAtN2d3y4CLLD2WL5YhZaN1c96irzwOrwn6+WaYwkrciQMsvzaIVOIixe
   6PyARH7h5leEKPhXK+SJuc+72bDZmzwJFAIeXGFfRM0qptyxrvKa9RfDa
   0YlmcmwdWsKqyOCLKiuX7wVMrJtAB4Fr3FasJD7hJnySlXlQAFYGA5xNJ
   A==;
X-CSE-ConnectionGUID: 8KhOkcrNQSWWghSZhEtiCQ==
X-CSE-MsgGUID: arhi2bW5QAK+GDqf9G8TEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44419936"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="44419936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:26:00 -0700
X-CSE-ConnectionGUID: QIO7cvY0SZWv7Ia236ZWOQ==
X-CSE-MsgGUID: XQR/hYS9QbO6Qfpk63PUtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="170099594"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:25:55 -0700
Message-ID: <11f47523-73dd-4504-be13-b57fba141c62@intel.com>
Date: Wed, 6 Aug 2025 10:25:51 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] dmaengine: idxd: Fix memory leak when a wq is reset
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-7-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-7-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
> idxd_wq_disable_cleanup() which is called from the reset path for a
> workqueue, sets the wq type to NONE, which for other parts of the
> driver mean that the wq is empty (all its resources were released).
> 
> Only set the wq type to NONE after its resources are released.
> 
> Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 287cf3bf1f5a2efdc9037968e9a4eed506e489c3..8f6afcba840ed7128259ad6b58b2fd967b0c151c 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -174,6 +174,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
>  	free_descs(wq);
>  	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
>  	sbitmap_queue_free(&wq->sbq);
> +	wq->type = IDXD_WQT_NONE;
>  }
>  EXPORT_SYMBOL_NS_GPL(idxd_wq_free_resources, "IDXD");
>  
> @@ -367,7 +368,6 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>  	lockdep_assert_held(&wq->wq_lock);
>  	wq->state = IDXD_WQ_DISABLED;
>  	memset(wq->wqcfg, 0, idxd->wqcfg_size);
> -	wq->type = IDXD_WQT_NONE;
>  	wq->threshold = 0;
>  	wq->priority = 0;
>  	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
> @@ -1540,7 +1540,6 @@ void idxd_drv_disable_wq(struct idxd_wq *wq)
>  	idxd_wq_reset(wq);
>  	idxd_wq_free_resources(wq);
>  	percpu_ref_exit(&wq->wq_active);
> -	wq->type = IDXD_WQT_NONE;
>  	wq->client_count = 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(idxd_drv_disable_wq, "IDXD");
> 


