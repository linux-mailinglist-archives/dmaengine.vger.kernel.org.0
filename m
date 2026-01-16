Return-Path: <dmaengine+bounces-8310-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A10D386F8
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 21:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E4D31256B0
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230D3A35B5;
	Fri, 16 Jan 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKvl9rMY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666D399A45;
	Fri, 16 Jan 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594100; cv=none; b=rZCz1KqjE7iPHjdFFm6kyjSVmqNzoZOQXuSBghGzcYBMQ3L5kC6fv5AcGXZQGfoxILP2CTEWX5PSPJmLeSfAo3y0umPK1dutMMt+vQwff9GIloO4ORvbeMqi3qL1douU2tyh6PHtIle3qDJPq+veggJ8qgM2EmFwLiHNbXXuW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594100; c=relaxed/simple;
	bh=JJ/b2IFw4hwJLnk88Am4wBbh7tFfJXwkpRAmcHN4R8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cee7hKK2QHKGd48CAWPaSte/CTNLMSv6Y7ftGU1W4nhWtUAuE29+D3YSsPhO0XtFqEJzX3lL9g+Mxp2hHXyCK7LO8+pkcd9G/Z8c6O/f4bZH6sfibgmRm8zaTqlfAGSnU0QoFcnBoF5O5M0dIIwruXIMXk/0Lnvq3xtt5C5Irpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKvl9rMY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768594098; x=1800130098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JJ/b2IFw4hwJLnk88Am4wBbh7tFfJXwkpRAmcHN4R8s=;
  b=cKvl9rMYq9y3M/UQrzJ2Z0PNRRT00Xy+xoVeYvS0866KNqM/lapOPped
   FdTX1Q9whye4bb3Jc6Z9EBR1gGzyuUoz0ksAuBGRQazdw5UWvAzxYyL6A
   82om5ugrFvXd+msI6o06bTGtjYNjpmF1dcoQlnipe9ltHm/8QEdZfm4rP
   mQ4GxmPc6sKIwD1oIJggGiOPq2jZQM9vLnwORR8G5W8Do8+HbbVHWbgTF
   32PkFYu0Vre0FkAcxprOWw0+5FUYs6t+gMCg26DASu4R2hVJ2zpbpxcoI
   Q6kK6r6xXmO7RDUaDwezYxDGHQZiYYdXLKtAtNeLeCLrciCKmO1waFouI
   w==;
X-CSE-ConnectionGUID: rwYpV7oqRoS6ZR2AobqtaQ==
X-CSE-MsgGUID: 5Sew6jbsTuGwMnJ5aq2EmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="73766236"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="73766236"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:08:18 -0800
X-CSE-ConnectionGUID: U2uho701TCyaZDo5Q3S29Q==
X-CSE-MsgGUID: 5ACBq1JARJS+JLn1aXAHtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="205384620"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.140]) ([10.125.111.140])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:08:18 -0800
Message-ID: <71ba3d88-70b0-4554-a379-1cfd6fec36be@intel.com>
Date: Fri, 16 Jan 2026 13:08:16 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 01/10] dmaengine: idxd: Fix lockdep warnings
 when calling idxd_device_config()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
 <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-1-59e106115a3e@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-1-59e106115a3e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 3:47 PM, Vinicius Costa Gomes wrote:
> Move the check for IDXD_FLAG_CONFIGURABLE and the locking to "inside"
> idxd_device_config(), as this is common to all callers, and the one
> that wasn't holding the lock was an error (that was causing the
> lockdep warning).
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/dma/idxd/device.c | 17 +++++++----------
>  drivers/dma/idxd/init.c   | 10 ++++------
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index c26128529ff4..a704475d87b3 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1125,7 +1125,11 @@ int idxd_device_config(struct idxd_device *idxd)
>  {
>  	int rc;
>  
> -	lockdep_assert_held(&idxd->dev_lock);
> +	guard(spinlock)(&idxd->dev_lock);
> +
> +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> +		return 0;
> +
>  	rc = idxd_wqs_setup(idxd);
>  	if (rc < 0)
>  		return rc;
> @@ -1454,11 +1458,7 @@ int idxd_drv_enable_wq(struct idxd_wq *wq)
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
> @@ -1554,10 +1554,7 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
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
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index fb80803d5b57..dd32b81a3108 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1104,12 +1104,10 @@ static void idxd_reset_done(struct pci_dev *pdev)
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


