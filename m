Return-Path: <dmaengine+bounces-3830-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23109DEB40
	for <lists+dmaengine@lfdr.de>; Fri, 29 Nov 2024 17:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E20D281693
	for <lists+dmaengine@lfdr.de>; Fri, 29 Nov 2024 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20214A098;
	Fri, 29 Nov 2024 16:44:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA121537AA;
	Fri, 29 Nov 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898688; cv=none; b=ko4Id7vIl4O//Pk3zmx2/EQY666AkovfypmnpxroIStKASxCMNBsDIPETuOe0AKmiZf43aQQ/XQewKufdD5D4CvZIgKNRSRQB/I5dctBegV+2CSYdBbrV8F1a3VC3KubloGCTMVn0flbuyL0VK0C8ZlfVBSvdXWgRCawUiwdUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898688; c=relaxed/simple;
	bh=LwiGdIJ+UE/ViD9rxTYJPRrt2Uwfhvvj4O0hqbwaEHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzMFe5JHeNP+Y734+Yhj20Nrq4eTCOfRwLgfdAuBPH5iV16NXaa36+gqDxVYbkdTPzuJWi3XmUyH3A7Vq8avZFH0BBoZgTug+XrtSqq8OESDPPKzrqNCPiWA1F7YlDACSNw2qvtix1NP3VE/sbCRPkjlrkBhqc8fCmpiIsnhuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3316312FC;
	Fri, 29 Nov 2024 08:45:15 -0800 (PST)
Received: from [10.57.90.216] (unknown [10.57.90.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72903F5A1;
	Fri, 29 Nov 2024 08:44:43 -0800 (PST)
Message-ID: <4dd1caa7-4b95-4e06-a5ac-e2d33ce88d04@arm.com>
Date: Fri, 29 Nov 2024 16:44:36 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: dma_request_chan_by_mask() defer probing
 unconditionally
To: Enric Balletbo i Serra <eballetb@redhat.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, vigneshr@ti.com,
 nm@ti.com
References: <20241127-defer-dma-request-chan-v1-1-203db7baf470@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241127-defer-dma-request-chan-v1-1-203db7baf470@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-27 8:23 am, Enric Balletbo i Serra wrote:
> Having no DMA devices registered is not a guarantee that the device
> doesn't exist, it could be that is not registered yet, so return
> EPROBE_DEFER unconditionally so the caller can wait for the required
> DMA device registered.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
> ---
> This patch fixes the following error on TI AM69-SK
> 
> [    2.854501] cadence-qspi 47040000.spi: error -ENODEV: No Rx DMA available
> 
> The DMA device is probed after cadence-qspi driver, so deferring it
> solves the problem.

Conversely, though, it does carry some risk that if there really is no 
DMA device/driver, other callers (e.g. spi-ti-qspi) may now get stuck 
deferring forever where the -ENODEV would have let them proceed with a 
fallback to non-DMA operation. driver_deferred_probe_check_state() is 
typically a good tool for these situations, but I guess it's a bit 
tricky in a context where we don't actually have the dependent device to 
hand :/

Thanks,
Robin.

> ---
>   drivers/dma/dmaengine.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c1357d7f3dc6ca7899c4d68a039567e73b0f089d..57f07b477a5d9ad8f2656584b8c0d6dffb2ab469 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -889,10 +889,10 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
>   	chan = __dma_request_channel(mask, NULL, NULL, NULL);
>   	if (!chan) {
>   		mutex_lock(&dma_list_mutex);
> -		if (list_empty(&dma_device_list))
> -			chan = ERR_PTR(-EPROBE_DEFER);
> -		else
> -			chan = ERR_PTR(-ENODEV);
> +		/* If the required DMA device is not registered yet,
> +		 * return EPROBE_DEFER
> +		 */
> +		chan = ERR_PTR(-EPROBE_DEFER);
>   		mutex_unlock(&dma_list_mutex);
>   	}
>   
> 
> ---
> base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
> change-id: 20241127-defer-dma-request-chan-4f26c62c8691
> 
> Best regards,


