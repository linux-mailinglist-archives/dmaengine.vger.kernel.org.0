Return-Path: <dmaengine+bounces-5967-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C2B1CD6C
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 22:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E153B1DB9
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43341218AAD;
	Wed,  6 Aug 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqoUXbLD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E345038;
	Wed,  6 Aug 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511916; cv=none; b=qI9XBvdpzknFfRZzkEWIbgWoj4jy/zEs7Q9TeoIgHEsYuzZOpaQcncvDI398CRHo5s1OAuqtn8pynGuvnngavK7/M0GtIz4ACpiikdOrOZZYcuIj/BfrBPt+XT1+48L5HHMQUIS+FpWDXxII5FAExy7+hPYhPGGGaG+H11nlCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511916; c=relaxed/simple;
	bh=asmxH9BxAkFD6RulxTbYIjtbh8OyxQm8dhYQSRVJ2NE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u7L195jRrQSVsX61YwsbHmGIq6JeUdWXTtFCRrjxZ/czmw6I3SujtNLCOVB+au8yQ5T3gyYWQgpofe7hn0PVFC9edAgDIGY8rEuqbpbJqYR6wmC4NsXe6GS0nPdb824s8w4Kqq5TY9yEB8ABdoM5uN1hGOPYWKZGofNl9XNSlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqoUXbLD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754511915; x=1786047915;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=asmxH9BxAkFD6RulxTbYIjtbh8OyxQm8dhYQSRVJ2NE=;
  b=aqoUXbLD4VbpkWWG20nrshqKtHkpBpRMz/ExFmZJ2NnaRsamRTE1ahWo
   Tm9iZdxlQEDdGawmPeX9gEiB+h6PMBiujTJ/9bQqQBmiuvloYcWAz9fpM
   16CW7TgCtndO17XeXrOnFWtxK/V/7ZSvTCAxLwyTiBv2acXqcKmVxs5zl
   BIrm2ftD5WMZ7J8tnqb9/eTar6Ud0wnXVhG3L32CEsUlM5JDfTUc29/C7
   tXpTYtpeNDtnPCSy+hzkQQqAKpJ0H99d1vJqwAxYHUi0ZYnQ0HdkybOPj
   qM00B0V7kuQnIN7ghOJEFUFV75Z9IN/wdSX1BtjwGaeRjJsc2p1VidvF0
   g==;
X-CSE-ConnectionGUID: 0s22XWZLRWSUIWsFxkWAgA==
X-CSE-MsgGUID: 4aaQN5BvSmCtavx/Lp22lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56805738"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56805738"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:25:14 -0700
X-CSE-ConnectionGUID: ylb72ZZ/QpGteRWJ6LNHxA==
X-CSE-MsgGUID: k9crn3DjSLGE1291i2PEMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165276016"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.98.32.147])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:25:13 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] dmaengine: idxd: Fix lockdep warnings when calling
 idxd_device_config()
In-Reply-To: <b0023322-2605-4189-83f8-d1cba64c6b39@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-1-4e020fbf52c1@intel.com>
 <b0023322-2605-4189-83f8-d1cba64c6b39@intel.com>
Date: Wed, 06 Aug 2025 13:25:12 -0700
Message-ID: <87y0rwtcyf.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Jiang <dave.jiang@intel.com> writes:

> On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
>> idxd_device_config() should only be called with idxd->dev_lock held.
>> Hold the lock to the calls that were missing.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> Patch looks fine. What about doing something like this:
>
> ---
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5cf419fe6b46..06c182ec3c04 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1103,11 +1103,15 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
>  	return 0;
>  }
>  
> -int idxd_device_config(struct idxd_device *idxd)
> +int idxd_device_config_locked(struct idxd_device *idxd)
>  {
>  	int rc;
>  
>  	lockdep_assert_held(&idxd->dev_lock);
> +
> +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> +		return -EPERM;
> +
>  	rc = idxd_wqs_setup(idxd);
>  	if (rc < 0)
>  		return rc;
> @@ -1129,6 +1133,12 @@ int idxd_device_config(struct idxd_device *idxd)
>  	return 0;
>  }
>  
> +int idxd_device_config(struct idxd_device *idxd)
> +{
> +	guard(spinlock)(&idxd->dev_lock);
> +	return idxd_device_config_locked(idxd);
> +}
> +

This gave me the idea that moving the lock to idxd_device_config() might
be a better idea. As the _locked() variant doesn't seem to be used, I
don't see why we should keep it around. Will give it a try and see how
it looks.

Thanks.

>  static int idxd_wq_load_config(struct idxd_wq *wq)
>  {
>  	struct idxd_device *idxd = wq->idxd;
> @@ -1434,11 +1444,7 @@ int idxd_drv_enable_wq(struct idxd_wq *wq)
>  		}
>  	}
>  
> -	rc = 0;
> -	spin_lock(&idxd->dev_lock);
> -	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> -		rc = idxd_device_config(idxd);
> -	spin_unlock(&idxd->dev_lock);
> +	rc = idxd_device_config(idxd);
>  	if (rc < 0) {
>  		dev_dbg(dev, "Writing wq %d config failed: %d\n", wq->id, rc);
>  		goto err;
> @@ -1521,7 +1527,7 @@ EXPORT_SYMBOL_NS_GPL(idxd_drv_disable_wq, "IDXD");
>  int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
>  {
>  	struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
> -	int rc = 0;
> +	int rc;
>  
>  	/*
>  	 * Device should be in disabled state for the idxd_drv to load. If it's in
> @@ -1534,10 +1540,7 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
>  	}
>  
>  	/* Device configuration */
> -	spin_lock(&idxd->dev_lock);
> -	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> -		rc = idxd_device_config(idxd);
> -	spin_unlock(&idxd->dev_lock);
> +	rc = idxd_device_config(idxd);
>  	if (rc < 0)
>  		return -ENXIO;
>  
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 74e6695881e6..f15bc2281c6b 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -760,6 +760,7 @@ int idxd_device_disable(struct idxd_device *idxd);
>  void idxd_device_reset(struct idxd_device *idxd);
>  void idxd_device_clear_state(struct idxd_device *idxd);
>  int idxd_device_config(struct idxd_device *idxd);
> +int idxd_device_config_locked(struct idxd_device *idxd);
>  void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid);
>  int idxd_device_load_config(struct idxd_device *idxd);
>  int idxd_device_request_int_handle(struct idxd_device *idxd, int idx, int *handle,
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 80355d03004d..193b9282e30f 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1091,12 +1091,10 @@ static void idxd_reset_done(struct pci_dev *pdev)
>  	idxd_device_config_restore(idxd, idxd->idxd_saved);
>  
>  	/* Re-configure IDXD device if allowed. */
> -	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
> -		rc = idxd_device_config(idxd);
> -		if (rc < 0) {
> -			dev_err(dev, "HALT: %s config fails\n", idxd_name);
> -			goto out;
> -		}
> +	rc = idxd_device_config(idxd);
> +	if (rc < 0) {
> +		dev_err(dev, "HALT: %s config fails\n", idxd_name);
> +		goto out;
>  	}
>  
>  	/* Bind IDXD device to driver. */
>
>
>> ---
>>  drivers/dma/idxd/init.c | 2 ++
>>  drivers/dma/idxd/irq.c  | 2 ++
>>  2 files changed, 4 insertions(+)
>> 
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 35bdefd3728bb851beb0f235fae7c6d71bd59239..d828d352ab008127e5e442e7072c9d5df0f2c6cf 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -1091,7 +1091,9 @@ static void idxd_reset_done(struct pci_dev *pdev)
>>  
>>  	/* Re-configure IDXD device if allowed. */
>>  	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
>> +		spin_lock(&idxd->dev_lock);
>>  		rc = idxd_device_config(idxd);
>> +		spin_unlock(&idxd->dev_lock);
>>  		if (rc < 0) {
>>  			dev_err(dev, "HALT: %s config fails\n", idxd_name);
>>  			goto out;
>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
>> index 1107db3ce0a3a65246bd0d9b1f96e99c9fa3def6..74059fe43fafeb930f58db21d3824f62b095b968 100644
>> --- a/drivers/dma/idxd/irq.c
>> +++ b/drivers/dma/idxd/irq.c
>> @@ -36,7 +36,9 @@ static void idxd_device_reinit(struct work_struct *work)
>>  	int rc, i;
>>  
>>  	idxd_device_reset(idxd);
>> +	spin_lock(&idxd->dev_lock);
>>  	rc = idxd_device_config(idxd);
>> +	spin_unlock(&idxd->dev_lock);
>>  	if (rc < 0)
>>  		goto out;
>>  
>> 
>

-- 
Vinicius

