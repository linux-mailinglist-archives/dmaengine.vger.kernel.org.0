Return-Path: <dmaengine+bounces-5248-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B727AC0F0E
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB21188B4D7
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35DE28D8C1;
	Thu, 22 May 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqChgHQz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05F28D832;
	Thu, 22 May 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925733; cv=none; b=I2/290oKF+wacR7JziwVV2A4LvHp8n0Vquq1n3CY5uZTqDM5/HBL3QRD8lv3bZaOfsdHN7MhAm4AFVaE/Z3h+UZx1f3goQwZbQQFP0IDJZu7BovgDCE/kZwdnoPTArF68MrQMKX3Z7PK8NyMm+M8d6h5OHICNByRCLMel5gXts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925733; c=relaxed/simple;
	bh=M4arltpYO8hy79MR4V6FNG68E1nNtu37rt8MO/xTkTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBnB2g3syokv762kheBBnMmf5btEPlXqJg+mn1fTNsZ1C3xqIn854d/kTVSoUfqdT0BglQ9n6jrbezRKmgoZOPTfULEV/3nvBo1qOMnkC5WKDmRYHCEHQ2SOQQScvpPjQlkkhDeQ34FlaIcn+RjnWyIcJgpuF+V/dDbWUE6/s1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqChgHQz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747925731; x=1779461731;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M4arltpYO8hy79MR4V6FNG68E1nNtu37rt8MO/xTkTY=;
  b=YqChgHQzhRf2AXJuuIIyCAOy9p8G8V3IA9pBkZcIvFwZQH318cWB45uj
   VyAXFUZNOOriVRr9kijXGQG3jHutNLN7uUpLHUMMtVaSepJgmdm7/vqDc
   UD/xcDY/5gxUFsYKBJkYwhURXUl1QUbRFgbRp81p5oYjjvu8RVQsxjlrr
   1HxUMZKbb0e4tSH5Wzj73HVlfSIGmusBetT5BwOfroMx0oSBh4cuj2SLK
   rWyfrxHdKEzR19k9K+EcGjlyZ9ElDBiXjcGedvXx1bOGcMT9YfqbDQlcc
   uem4rJK+pXfNhbbdpeCS87Apo/NyuzhyXmlkTUUZW+EfcAe0BsEiQZPF3
   A==;
X-CSE-ConnectionGUID: ancPwm0ORqqN1ZyYiv3f/A==
X-CSE-MsgGUID: 4Hn3lzB0Sl+IBXVWHmk6Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50062103"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="50062103"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:55:31 -0700
X-CSE-ConnectionGUID: yRptlX9gQLuOrvSiqIG8mg==
X-CSE-MsgGUID: ymrH/h1gTOSwgYao8yadTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145502385"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.122]) ([10.125.109.122])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:55:30 -0700
Message-ID: <a03e4f97-2289-4af7-8bfc-ad2d38ec8677@intel.com>
Date: Thu, 22 May 2025 07:55:26 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Fix race condition between WQ
 enable and reset paths
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, colin.i.king@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
 <20250522063329.51156-2-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250522063329.51156-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 11:33 PM, Shuai Xue wrote:
> A device reset command disables all WQs in hardware. If issued while a WQ
> is being enabled, it can cause a mismatch between the software and hardware
> states.
> 
> When a hardware error occurs, the IDXD driver calls idxd_device_reset() to
> send a reset command and clear the state (wq->state) of all WQs. It then
> uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them and
> ensure consistency between the software and hardware states.
> 
> However, a race condition exists between the WQ enable path and the
> reset/recovery path. For example:
> 
> A: WQ enable path                   B: Reset and recovery path
> ------------------                 ------------------------
> a1. issue IDXD_CMD_ENABLE_WQ
>                                    b1. issue IDXD_CMD_RESET_DEVICE
>                                    b2. clear wq->state
>                                    b3. check wq_enable_map bit, not set
> a2. set wq->state = IDXD_WQ_ENABLED
> a3. set wq_enable_map
> 
> In this case, b1 issues a reset command that disables all WQs in hardware.
> Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
> leading to an inconsistency between wq->state (software) and the actual
> hardware state (IDXD_WQ_DISABLED).


Would it lessen the complication to just have wq enable path grab the device lock before proceeding?

DJ

> 
> To fix this, the WQ state should be set to IDXD_WQ_ENABLED before issuing
> the IDXD_CMD_ENABLE_WQ command. This ensures the software state aligns with
> the expected hardware behavior during resets:
> 
> A: WQ enable path                   B: Reset and recovery path
> ------------------                 ------------------------
>                                    b1. issue IDXD_CMD_RESET_DEVICE
>                                    b2. clear wq->state
> a1. set wq->state = IDXD_WQ_ENABLED
> a2. set wq_enable_map
>                                    b3. check wq_enable_map bit, true
>                                    b4. check wq state, return
> a3. issue IDXD_CMD_ENABLE_WQ
> 
> By updating the state early, the reset path can safely re-enable the WQ
> based on wq_enable_map.
> 
> A corner case arises when both paths attempt to enable the same WQ:
> 
> A: WQ enable path                   B: Reset and recovery path
> ------------------                 ------------------------
>                                    b1. issue IDXD_CMD_RESET_DEVICE
>                                    b2. clear wq->state
> a1. set wq->state = IDXD_WQ_ENABLED
> a2. set wq_enable_map
>                                    b3. check wq_enable_map bit
>                                    b4. check wq state, not reset
>                                    b5. issue IDXD_CMD_ENABLE_WQ
> a3. issue IDXD_CMD_ENABLE_WQ
> 
> Here, the command status (CMDSTS) returns IDXD_CMDSTS_ERR_WQ_ENABLED,
> but the driver treats it as success (IDXD_CMDSTS_SUCCESS), ensuring the WQ
> remains enabled.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/dma/idxd/device.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5cf419fe6b46..b424c3c8f359 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -188,16 +188,32 @@ int idxd_wq_enable(struct idxd_wq *wq)
>  		return 0;
>  	}
>  
> +	/*
> +	 * A device reset command disables all WQs in hardware. If issued
> +	 * while a WQ is being enabled, it can cause a mismatch between the
> +	 * software and hardware states.
> +	 *
> +	 * When a hardware error occurs, the IDXD driver calls
> +	 * idxd_device_reset() to send a reset command and clear the state
> +	 * (wq->state) of all WQs. It then uses wq_enable_map to re-enable
> +	 * them and ensure consistency between the software and hardware states.
> +	 *
> +	 * To avoid inconsistency between software and hardware states,
> +	 * issue the IDXD_CMD_ENABLE_WQ command as the final step.
> +	 */
> +	wq->state = IDXD_WQ_ENABLED;
> +	set_bit(wq->id, idxd->wq_enable_map);
> +
>  	idxd_cmd_exec(idxd, IDXD_CMD_ENABLE_WQ, wq->id, &status);
>  
>  	if (status != IDXD_CMDSTS_SUCCESS &&
>  	    status != IDXD_CMDSTS_ERR_WQ_ENABLED) {
> +		clear_bit(wq->id, idxd->wq_enable_map);
> +		wq->state = IDXD_WQ_DISABLED;
>  		dev_dbg(dev, "WQ enable failed: %#x\n", status);
>  		return -ENXIO;
>  	}
>  
> -	wq->state = IDXD_WQ_ENABLED;
> -	set_bit(wq->id, idxd->wq_enable_map);
>  	dev_dbg(dev, "WQ %d enabled\n", wq->id);
>  	return 0;
>  }


