Return-Path: <dmaengine+bounces-5465-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1FAD989D
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 01:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F27AC8A2
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 23:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106528D8E6;
	Fri, 13 Jun 2025 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drSQKrh8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D0C28D8CA;
	Fri, 13 Jun 2025 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856852; cv=none; b=mGZ2/bCK68iRVYfAc/OFsS+ksXOHQZRv2BczG28I8wZ3/Xy2sCREBtnazds7Miy3klV/g9kYRU7/UAC/JqgzYXjrN5qpADl7EgbFJE6+VwwB8S2VH4cLVngQMJDwh4Sf5arBo8psnXHRg45bP/mAp38UJ/wX5C6bMDnO9IEm810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856852; c=relaxed/simple;
	bh=DQPacqRFq47t4t1mV2H6DBnnyvNPrh7szv6ag9li9Nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tv3yJL8kYpB7VfcowH8SRH3Hxkwev7+Bc6KkfOOOHnQmOlyyBWh2weolXK627TyVzyo3hxzhyVjrefqThIoAjvFAH9f+rnV9SF5g6+KeL4AuTL21i/NCXOMvqVuOefCVFQvE1LXlJxWteZaEqp6qBpix76dFHC2mMitocYL672Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drSQKrh8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749856850; x=1781392850;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DQPacqRFq47t4t1mV2H6DBnnyvNPrh7szv6ag9li9Nk=;
  b=drSQKrh8eAkiTvL7Rt5SC8/3EhJDztI7w80WNe57FTpzVqomJv3vZWju
   lNmQ49BT78ZbjQDdKoJKdQh9PLji8hzwBeDetEYIz5197b9UHOiHp0z+b
   NYGRmuaZMKxqGRa/4l7/fk+qiYgb4XSFK/oUfYeEavAwWHp56UHW7/kbH
   03ntG96naNxMlKUY7iN8rqVlwaZtZEHK7ZdRz1kxaBrLUOikfSsrCaeF1
   mWuZLFWS1hL/bTsoqM/yayOTrKlhuRfErdKxlyyL9GmpinLcUpxlpwrUS
   rW0vFuNzAPr0gIWfLPTC97a05Ejywz8SS3wTDdVcLy/g1JIDKR+Db2Vpw
   w==;
X-CSE-ConnectionGUID: FIhbxJyZRqiz9fxYoUBeBg==
X-CSE-MsgGUID: KsAF46G2SCqqmSudv1FtiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="69524360"
X-IronPort-AV: E=Sophos;i="6.16,235,1744095600"; 
   d="scan'208";a="69524360"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 16:20:50 -0700
X-CSE-ConnectionGUID: CMo9xzuVSAe6vQIZ/paMhg==
X-CSE-MsgGUID: rpd3kJhgQDe0Q5mg2fQqxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,235,1744095600"; 
   d="scan'208";a="147788027"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.194])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 16:20:49 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yi Sun <yi.sun@intel.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com, gordon.jin@intel.com
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: Fix refcount underflow on
 module unload
In-Reply-To: <20250607130616.514984-3-yi.sun@intel.com>
References: <20250607130616.514984-1-yi.sun@intel.com>
 <20250607130616.514984-3-yi.sun@intel.com>
Date: Fri, 13 Jun 2025 16:20:48 -0700
Message-ID: <87h60j8bzj.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yi Sun <yi.sun@intel.com> writes:

> A recent refactor introduced a misplaced put_device() call, leading to a
> reference count underflow during module unload.
>
> There is no need to add additional put_device() calls for idxd groups,
> engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
> also fixes the missing put_device() for idxd groups, engines, and wqs."
> It appears no such omission existed. The required cleanup is already
> handled by the call chain:
> idxd_unregister_devices() -> device_unregister() -> put_device()
>
> Extend idxd_cleanup() to perform the necessary cleanup, and remove
> idxd_cleanup_internals() which was not originally part of the driver
> unload path and introduced unintended reference count underflow.
>
> Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
> Signed-off-by: Yi Sun <yi.sun@intel.com>
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 504aca0fd597..a5eabeb6a8bd 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1321,7 +1321,12 @@ static void idxd_remove(struct pci_dev *pdev)
>  	device_unregister(idxd_confdev(idxd));
>  	idxd_shutdown(pdev);
>  	idxd_device_remove_debugfs(idxd);
> -	idxd_cleanup(idxd);
> +	perfmon_pmu_remove(idxd);
> +	idxd_cleanup_interrupts(idxd);
> +	if (device_pasid_enabled(idxd))
> +		idxd_disable_system_pasid(idxd);
> +	if (device_user_pasid_enabled(idxd))
> +		idxd_disable_sva(idxd->pdev);

idxd_disable_sva() got removed in commit 853b01b5efd7 ("dmaengine: idxd:
Remove unnecessary IOMMU_DEV_FEAT_IOPF")

>  	pci_iounmap(pdev, idxd->reg_base);
>  	put_device(idxd_confdev(idxd));
>  	pci_disable_device(pdev);
> -- 
> 2.43.0
>


Cheers,
-- 
Vinicius

