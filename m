Return-Path: <dmaengine+bounces-6116-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB9BB309D1
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2436217E1
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC66D272E43;
	Thu, 21 Aug 2025 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJJE1KJP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCF18C933;
	Thu, 21 Aug 2025 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817545; cv=none; b=D5G4Zw+aE/CYHyxQXiYI9fD8x+NLySojSS4E5iKHXGWkQ/TTd/UCobs4MivVlO13qpXn6Pi8S8E9eYfR+1VqNaO9Ca0XbR9hx32eCoZNaSpqXDk2qvyTb3gEKztHtzVvFqvY/1mU5+6O6pJsOizn9ZKf26ppq7Tee7hV6kgFSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817545; c=relaxed/simple;
	bh=2+YrDbJHJ6ygCGQFcn0zz9RbDVUhv1XPLIL40BOyUuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3eXvR8BR1G2xh6Uxe6IhRcp3PoPRPk7WbaElzl4K/U3aPflButRC63VS7ZvjHt+Z69JqFxxGskvD/SUB1TovePY9FVbLD4YYirn3SXlNVB94/0tkDODpmqNJbcBifqnMhckDuF5AG6gzzFYTST0n/n5UptEhSIMDze4ZvPzFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJJE1KJP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817544; x=1787353544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+YrDbJHJ6ygCGQFcn0zz9RbDVUhv1XPLIL40BOyUuk=;
  b=kJJE1KJPlJDLNnMFN8q30f8qMguv9kVqnfon8Zq5/TqE/LKujdaBLFRt
   64O4Nd0FTgLmlhWGr9y3wkxsP56FL7+nT0b7hRlff7iP2tcwZpfxneqlt
   3Icsht+BLAOs4SuW+OWa85x0ZWkSjZojeLTsTlo+d5pkdMbQOlIWueheU
   UQHGsqMjFMb3I65gvfyDQOyDAvoa/7uTZ3TZfZ26gZFlaayxD6e75TvfZ
   6baYeC2pBE7qSi05+B7tJo2olXppM6lCK8ZE36owKSLXknWud5N7O1rA0
   nuFtKJdB7joE+ofiM+XGfPuiHBbD+w7FOK9jiPqmaN2svHF4t/+c8QNMe
   A==;
X-CSE-ConnectionGUID: w9b0VNtHQpu7OOC7Ully4g==
X-CSE-MsgGUID: TKEesTD6SNWLc15IdsTblQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57833739"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57833739"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:05:43 -0700
X-CSE-ConnectionGUID: M8twliceRxyteHULedGk3w==
X-CSE-MsgGUID: Hh71QzBrR1Ky0LLD+65Rrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173814619"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.210]) ([10.247.119.210])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:05:39 -0700
Message-ID: <bc336eeb-2456-4321-92fa-3be9eba15f4e@intel.com>
Date: Thu, 21 Aug 2025 16:05:34 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] dmaengine: idxd: Fix lockdep warnings when
 calling idxd_device_config()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
 <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-1-595d48fa065c@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-1-595d48fa065c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 3:59 PM, Vinicius Costa Gomes wrote:
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
> index 5cf419fe6b46..ac41889e4fe1 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1107,7 +1107,11 @@ int idxd_device_config(struct idxd_device *idxd)
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
> @@ -1434,11 +1438,7 @@ int idxd_drv_enable_wq(struct idxd_wq *wq)
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
> @@ -1534,10 +1534,7 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
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
> index f98aa41fa42e..c25bd0595561 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1092,12 +1092,10 @@ static void idxd_reset_done(struct pci_dev *pdev)
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


