Return-Path: <dmaengine+bounces-6741-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E215BB11F9
	for <lists+dmaengine@lfdr.de>; Wed, 01 Oct 2025 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DEC189348E
	for <lists+dmaengine@lfdr.de>; Wed,  1 Oct 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008C20468E;
	Wed,  1 Oct 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D89cEK9/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90F1FCCF8;
	Wed,  1 Oct 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333332; cv=none; b=Ha//UPqWcIccwcxVUm2Q56jOJcLRzcoU5A2kUBnpfBOfmgrJogShZBBzPvFreLO7TB0bssWXOGUf0RnBhh+J7md52CX+S96W/odKYRnD3aKOoCLU2dipy7ehhLF6aUvCfCQRlvKEtqVlo1NQbEQ2tO6diyz2CUFxsBc+IqQZQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333332; c=relaxed/simple;
	bh=5LgfWDLXbU3+ZSJ+d2bp+2xL5GUQjmcurD5GvPXYjOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiUucL0YbKZzfAwOExQFAPXW9dL1Kz6EaeKHkO7PsYRzrLU/JTbCFchJFJDFRvaFqkWDvMUNYzPNLg1R4dQnNjb7hyfzfa75phwqkYMfEKAxZgqwdU0NX9e5gToMTxV2Cc2neDliuPJ/xGKmtxT6269p+zl4OWPQhJPUOxomb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D89cEK9/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759333330; x=1790869330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5LgfWDLXbU3+ZSJ+d2bp+2xL5GUQjmcurD5GvPXYjOk=;
  b=D89cEK9/FjxrcrGxtq59M6QzPNUDSaSL0L6g55Qn2+RghJt5ZlrWgTG0
   0UHJG7A4+jT8mcI7eG8b6qJ2i2b0Gd9w/x9QTEVm01IePavqEGG5Pyra7
   SOY1mTy8kYiOnOW9Q8R+UUJ5uWTUd5tlgPfSfHMHUBWZDxDEDi3UOIWMK
   4lUN0jk+Pe08ydmW2vCGsruE9CTcxST9Cv6BdxJHnurj67pkhq2yvrgC9
   jHI082yqbjr/AeKPr+0sqW82As7TYrAkBX22GdyyDNGMZJKkkfkfKaAhI
   6hA76zl3oaZc5dCeewGfWd29bttA6wJej6wFWert78Ej+wOsIMM5wDZq/
   w==;
X-CSE-ConnectionGUID: e5Sybbs1TlGUdABCzfsmlA==
X-CSE-MsgGUID: 6gds1fCUQbmJxHG4PNpD5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60648067"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="60648067"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 08:42:06 -0700
X-CSE-ConnectionGUID: /Fxn0tAsSRGjTZSibRpw8g==
X-CSE-MsgGUID: xTz3/MZ5TSG7ykeCg6zfrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="183998916"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.109.218]) ([10.125.109.218])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 08:42:05 -0700
Message-ID: <e89ea10b-edb5-4e37-8eef-0fb99fc5b19f@intel.com>
Date: Wed, 1 Oct 2025 08:42:04 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dmaengine: idxd: drain ATS translations when disabling
 WQ
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, dmaengine@vger.kernel.org
Cc: vkoul@kernel.org, linux-kernel@vger.kernel.org
References: <20251001012226.1664994-1-vinicius.gomes@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251001012226.1664994-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/30/25 6:22 PM, Vinicius Costa Gomes wrote:
> From: Nikhil Rao <nikhil.rao@intel.com>
> 
> There's an errata[1], for the Disable WQ command that it
> does not guaranteee that address translations are drained. If WQ
> configuration is updated, pending address translations can use an
> updated WQ configuration, resulting an invalid translation response
> that is cached in the device translation cache.
> 
> Replace the Disable WQ command with a Drain WQ command followed by a
> Reset WQ command, this guarantees that all ATS translations are
> drained from the device before changing WQ configuration.
> 
> [1] https://cdrdv2.intel.com/v1/dl/getcontent/843306 ("Intel DSA May
> Cause Invalid Translation Caching")
> 
> Signed-off-by: Nikhil Rao <nikhil.rao@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/device.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5cf419fe6b46..c2cdf41b6e57 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -16,6 +16,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
>  			  u32 *status);
>  static void idxd_device_wqs_clear_state(struct idxd_device *idxd);
>  static void idxd_wq_disable_cleanup(struct idxd_wq *wq);
> +static int idxd_wq_config_write(struct idxd_wq *wq);
>  
>  /* Interrupt control bits */
>  void idxd_unmask_error_interrupts(struct idxd_device *idxd)
> @@ -215,14 +216,28 @@ int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
>  		return 0;
>  	}
>  
> +	/*
> +	 * Disable WQ does not drain address translations, if WQ attributes are
> +	 * changed before translations are drained, pending translations can
> +	 * be issued using updated WQ attibutes, resulting in invalid
> +	 * translations being cached in the device translation cache.
> +	 *
> +	 * To make sure pending translations are drained before WQ
> +	 * attributes are changed, we use a WQ Drain followed by WQ Reset and
> +	 * then restore the WQ configuration.
> +	 */
> +	idxd_wq_drain(wq);
> +
>  	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
> -	idxd_cmd_exec(idxd, IDXD_CMD_DISABLE_WQ, operand, &status);
> +	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, &status);
>  
>  	if (status != IDXD_CMDSTS_SUCCESS) {
> -		dev_dbg(dev, "WQ disable failed: %#x\n", status);
> +		dev_dbg(dev, "WQ reset failed: %#x\n", status);
>  		return -ENXIO;
>  	}
>  
> +	idxd_wq_config_write(wq);
> +
>  	if (reset_config)
>  		idxd_wq_disable_cleanup(wq);
>  	clear_bit(wq->id, idxd->wq_enable_map);


