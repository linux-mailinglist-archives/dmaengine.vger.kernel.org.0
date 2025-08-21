Return-Path: <dmaengine+bounces-6119-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD590B309EA
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E601C82655
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B52E22B2;
	Thu, 21 Aug 2025 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7sr33t9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F472D1926;
	Thu, 21 Aug 2025 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818105; cv=none; b=BHwH7QwCkiaxgVvT/BUf3HzybmgqltD9I/Lu2Sqkype5rClzK2mzqlfLeNImofpekvnREVM5ijiVB/G4iJmWlcjH2atA1OLT1wxxB+LUXfWVh8gDCuf6crNN6UJqsBpX4HWIGt1FUPT9My34HnbS9knHp6gKE61vSZfpMSzUTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818105; c=relaxed/simple;
	bh=Y5YRBttXpGxG8WMvnxXgt5K9/PPNWUiabYThnLZpOs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPBAmdFbSoEnKot3Ef/euDyPc5EVemNi6TW69nNM8oQb3fecoXFWqRpuu4nNpDw5nO3cCWlYmCnXvGEs/CCaD3z/GtfPOWc8qLPoufR73pcGrXva57LYYTZnLNQByfRWfNvdJ2lDDud3SHeX6NHzL4wMBOEAYrmrmVjLntA7Jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7sr33t9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755818105; x=1787354105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y5YRBttXpGxG8WMvnxXgt5K9/PPNWUiabYThnLZpOs8=;
  b=B7sr33t9TJ1c437zxfaqoQXTKY5bM0h02aEg39paOsjan6xg+TP/98J9
   omvM7Rq83op5bbY5xx3oUzdzPYvc5FFPtUSlTZtMrSmeGZDgaa8PqV2xL
   NnHELmM9IWitpDcB9bDj4Zhc9er4hjd4AvzhwPoh00cT7p3qx20eE6mHg
   +SRjIW2tPjawsasOMQYt+gsHmIYzwonn9nJViZkI2PLw59wSO9JcvxRX/
   +LzfXzzlDQ0w3rWxjxF5t91MCyCb9JbzTDO7YyCe6xLvxBOjjh53/xy7l
   wVvwGESe5viHUuoGlgp859S/+62Sa4ShPPFlgwPRXe7htQlgfVlMYnncw
   Q==;
X-CSE-ConnectionGUID: awfXvcJHSwyNhaY5E+Mi9g==
X-CSE-MsgGUID: bot8bAe7TwG83v93851o8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61957530"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="61957530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:15:04 -0700
X-CSE-ConnectionGUID: CJ3Wz4aSQIW1tsZYyQiseA==
X-CSE-MsgGUID: HqHJ/PDMTWqcoajwM+0Szg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168765201"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.210]) ([10.247.119.210])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:15:01 -0700
Message-ID: <2b772882-5797-4fa0-aed1-02ea45b43a75@intel.com>
Date: Thu, 21 Aug 2025 16:14:55 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] dmaengine: idxd: Wait for submitted operations
 on .device_synchronize()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
 <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-6-595d48fa065c@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-6-595d48fa065c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 3:59 PM, Vinicius Costa Gomes wrote:
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


