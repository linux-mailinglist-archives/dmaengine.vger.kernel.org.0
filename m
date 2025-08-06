Return-Path: <dmaengine+bounces-5958-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4EDB1CA36
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBE816C267
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7427FB1B;
	Wed,  6 Aug 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKenndtz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A682194137;
	Wed,  6 Aug 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499762; cv=none; b=mKeBBvj3LcGdPPhUasElcOGkIfWkrnoYGS16iykSfs2qBCHJHjk3iW2f9Xbx0dY9bvTWuPB0hXMy45Ar+srpEMGb5Ki94AW6ZnfkHPSIIqH+g1mMh5mdriAyycuDDvew//UfywQ/N333pHSFeG33YNTwb4Z8TRLV1cm8XqWYsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499762; c=relaxed/simple;
	bh=U8vJgPVZluP1iDndAeHFYCVFRdufbsSnmWNcXnt3vaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5Ka7uk/t2APsl4vxqH00MUoN8llwast7MUeJRyJV+BR3Dj3HLreEvxX6eCMkHzzecvA4bgCZeFTmnEM1fUxQAniT0dEHHfrAMV98HcTbJ4pEoKHSsOUqLbnHh5yV16A6mivgVf5rQIZ7Cc4uv5mjYXic98EBqWFOBxYEgWQf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKenndtz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754499760; x=1786035760;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U8vJgPVZluP1iDndAeHFYCVFRdufbsSnmWNcXnt3vaw=;
  b=nKenndtzjjKh9ZOm+JtFURQfp8PfCUUOFgFsJ3/CJ/n0CHFGBvr+A4dQ
   PgK4/a1tuj7WFWG/5Aah/cQpiByZ4d7p9YzFzIvbSY0M05aNkDJWRtzcV
   ODAXuXyrHeTtR737DWxDi1iPGX4VpExcv+fof+sT3zTNvK8cPxXdM+1vC
   H3aX3ZqHEhg2nCainCuNATQOx1sw7i7VU1FOoGdPWberkaeyAx08LFa/i
   fNGVUSZ4zkOWm4mREDrhdBE8mXd87Y+xnwWE60VS6Dx2c5zq4zcabH6vH
   RCY+Sv9D46fmV5/BxGY51u7nESec4E6vO+dEapn6nwyL4vS91AQuZ910i
   g==;
X-CSE-ConnectionGUID: MmfXAP9cQpa51pJPab+G1g==
X-CSE-MsgGUID: IWk47S62SH+/purMM/qJ6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60457007"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60457007"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:02:39 -0700
X-CSE-ConnectionGUID: HnoXLbE0RN+LLujYDXLaLw==
X-CSE-MsgGUID: 778Glej6QYyBcmVY+EGHvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165167785"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:02:35 -0700
Message-ID: <b0023322-2605-4189-83f8-d1cba64c6b39@intel.com>
Date: Wed, 6 Aug 2025 10:02:30 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dmaengine: idxd: Fix lockdep warnings when calling
 idxd_device_config()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-1-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-1-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
> idxd_device_config() should only be called with idxd->dev_lock held.
> Hold the lock to the calls that were missing.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Patch looks fine. What about doing something like this:

---

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5cf419fe6b46..06c182ec3c04 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1103,11 +1103,15 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 	return 0;
 }
 
-int idxd_device_config(struct idxd_device *idxd)
+int idxd_device_config_locked(struct idxd_device *idxd)
 {
 	int rc;
 
 	lockdep_assert_held(&idxd->dev_lock);
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
 	rc = idxd_wqs_setup(idxd);
 	if (rc < 0)
 		return rc;
@@ -1129,6 +1133,12 @@ int idxd_device_config(struct idxd_device *idxd)
 	return 0;
 }
 
+int idxd_device_config(struct idxd_device *idxd)
+{
+	guard(spinlock)(&idxd->dev_lock);
+	return idxd_device_config_locked(idxd);
+}
+
 static int idxd_wq_load_config(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
@@ -1434,11 +1444,7 @@ int idxd_drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
-	rc = 0;
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0) {
 		dev_dbg(dev, "Writing wq %d config failed: %d\n", wq->id, rc);
 		goto err;
@@ -1521,7 +1527,7 @@ EXPORT_SYMBOL_NS_GPL(idxd_drv_disable_wq, "IDXD");
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 {
 	struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
-	int rc = 0;
+	int rc;
 
 	/*
 	 * Device should be in disabled state for the idxd_drv to load. If it's in
@@ -1534,10 +1540,7 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	/* Device configuration */
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0)
 		return -ENXIO;
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 74e6695881e6..f15bc2281c6b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -760,6 +760,7 @@ int idxd_device_disable(struct idxd_device *idxd);
 void idxd_device_reset(struct idxd_device *idxd);
 void idxd_device_clear_state(struct idxd_device *idxd);
 int idxd_device_config(struct idxd_device *idxd);
+int idxd_device_config_locked(struct idxd_device *idxd);
 void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid);
 int idxd_device_load_config(struct idxd_device *idxd);
 int idxd_device_request_int_handle(struct idxd_device *idxd, int idx, int *handle,
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 80355d03004d..193b9282e30f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1091,12 +1091,10 @@ static void idxd_reset_done(struct pci_dev *pdev)
 	idxd_device_config_restore(idxd, idxd->idxd_saved);
 
 	/* Re-configure IDXD device if allowed. */
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-		rc = idxd_device_config(idxd);
-		if (rc < 0) {
-			dev_err(dev, "HALT: %s config fails\n", idxd_name);
-			goto out;
-		}
+	rc = idxd_device_config(idxd);
+	if (rc < 0) {
+		dev_err(dev, "HALT: %s config fails\n", idxd_name);
+		goto out;
 	}
 
 	/* Bind IDXD device to driver. */


> ---
>  drivers/dma/idxd/init.c | 2 ++
>  drivers/dma/idxd/irq.c  | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 35bdefd3728bb851beb0f235fae7c6d71bd59239..d828d352ab008127e5e442e7072c9d5df0f2c6cf 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1091,7 +1091,9 @@ static void idxd_reset_done(struct pci_dev *pdev)
>  
>  	/* Re-configure IDXD device if allowed. */
>  	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
> +		spin_lock(&idxd->dev_lock);
>  		rc = idxd_device_config(idxd);
> +		spin_unlock(&idxd->dev_lock);
>  		if (rc < 0) {
>  			dev_err(dev, "HALT: %s config fails\n", idxd_name);
>  			goto out;
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 1107db3ce0a3a65246bd0d9b1f96e99c9fa3def6..74059fe43fafeb930f58db21d3824f62b095b968 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -36,7 +36,9 @@ static void idxd_device_reinit(struct work_struct *work)
>  	int rc, i;
>  
>  	idxd_device_reset(idxd);
> +	spin_lock(&idxd->dev_lock);
>  	rc = idxd_device_config(idxd);
> +	spin_unlock(&idxd->dev_lock);
>  	if (rc < 0)
>  		goto out;
>  
> 


