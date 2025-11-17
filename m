Return-Path: <dmaengine+bounces-7230-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75115C6519D
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C7334291CA
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE128DB46;
	Mon, 17 Nov 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwKBFWJb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF92580FB;
	Mon, 17 Nov 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396324; cv=none; b=tKJBtFqCLTj3wBNNWMo/PbYqtycE+gdtGc3H2FTen5JZcseN9DyyhJgWE8WhccLm5IdDJbowUOPh5eM92lsnb/pzPSaVkxlW0iKZPxgiOGr/lH27qnMfwAY/LseVVS99IKjryJAcGkhoYrZv7Gpl3YnvmEnxdx8ASnUoBGXF6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396324; c=relaxed/simple;
	bh=CxdJG1DtwIhtNHF6oivollwcKRjHBoCIJ0fnwmVXetw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzN1LPkMDdyMyKu76SlZrLgDwEdM3eDeiXbiCpRc5NMuIZV/o5Om5AuUfSSnQcz793ZWUqNeeEdh6LrcVWid7rF+j36D3Q7PGsjPH/PNYFiZ0Qg/fFStGi6/7X8dTq5IN+7y+PHTDKZHslwqTPhaiD8sajpfexMGuX6GkaLakDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwKBFWJb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763396323; x=1794932323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CxdJG1DtwIhtNHF6oivollwcKRjHBoCIJ0fnwmVXetw=;
  b=CwKBFWJbgHstibApo2qegP3s8mQfPbHVmsvfsKiqozWTFQd2P1gQYv7q
   6vcFGToLExyXnx/Avyr36/rGbY8KCEM2+ZXMQLyOZS98oMXQ8FPyoM77v
   Mmft5Bd3pnM2+TkIkZTQqNMLqsi9f8kIILPd4K1rh7UBzOLIS0vaIoca5
   4gV8ZqpiDEBgKvPajiEc+jxJvTNnBsKFwOwL/pkw3bT451Pdg44N6ca4o
   ZWp9SrVOF4PHRNnpgnK1jnJ1S8qLoVheMRL7eXuRWnabKnyrM/j1lODXt
   9zhhYocX8ryrFjrc/0HohucyNLbhs/VST6zu/YGleJ+Nf85DrpraW2Ixl
   A==;
X-CSE-ConnectionGUID: k2L4uREeRsKGq1AvovNX2g==
X-CSE-MsgGUID: Kyf9ydvfQPG6gvlon442Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="64402738"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="64402738"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:18:42 -0800
X-CSE-ConnectionGUID: QFalgvZPR+2hazD+OCA7cQ==
X-CSE-MsgGUID: L7KrkB5+Sm22QI7IWOBxPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="227822458"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.43]) ([10.125.109.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:18:42 -0800
Message-ID: <867fa85c-8e7d-4b60-a354-630d4147c3ea@intel.com>
Date: Mon, 17 Nov 2025 09:18:39 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] dmaengine: idxd: fix device leaks on compat bind
 and unbind
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
 Viresh Kumar <vireshk@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vladimir Zapolskiy <vz@mleia.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 =?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-7-johan@kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251117161258.10679-7-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/25 9:12 AM, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the idxd device as
> part of the compat bind and unbind sysfs interface.
> 
> Fixes: 6e7f3ee97bbe ("dmaengine: idxd: move dsa_drv support to compatible mode")
> Cc: stable@vger.kernel.org	# 5.15
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/dma/idxd/compat.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
> index eff9943f1a42..95b8ef958633 100644
> --- a/drivers/dma/idxd/compat.c
> +++ b/drivers/dma/idxd/compat.c
> @@ -20,11 +20,16 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t c
>  	int rc = -ENODEV;
>  
>  	dev = bus_find_device_by_name(bus, NULL, buf);
> -	if (dev && dev->driver) {
> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (dev->driver) {
>  		device_driver_detach(dev);
>  		rc = count;
>  	}
>  
> +	put_device(dev);
> +
>  	return rc;
>  }
>  static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
> @@ -38,9 +43,12 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t cou
>  	struct idxd_dev *idxd_dev;
>  
>  	dev = bus_find_device_by_name(bus, NULL, buf);
> -	if (!dev || dev->driver || drv != &dsa_drv.drv)
> +	if (!dev)
>  		return -ENODEV;
>  
> +	if (dev->driver || drv != &dsa_drv.drv)
> +		goto err_put_dev;
> +
>  	idxd_dev = confdev_to_idxd_dev(dev);
>  	if (is_idxd_dev(idxd_dev)) {
>  		alt_drv = driver_find("idxd", bus);
> @@ -53,13 +61,20 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t cou
>  			alt_drv = driver_find("user", bus);
>  	}
>  	if (!alt_drv)
> -		return -ENODEV;
> +		goto err_put_dev;
>  
>  	rc = device_driver_attach(alt_drv, dev);
>  	if (rc < 0)
> -		return rc;
> +		goto err_put_dev;
> +
> +	put_device(dev);
>  
>  	return count;
> +
> +err_put_dev:
> +	put_device(dev);
> +
> +	return rc;
>  }
>  static DRIVER_ATTR_IGNORE_LOCKDEP(bind, 0200, NULL, bind_store);
>  


