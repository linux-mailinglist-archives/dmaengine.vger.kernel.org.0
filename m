Return-Path: <dmaengine+bounces-5276-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A54FAC805B
	for <lists+dmaengine@lfdr.de>; Thu, 29 May 2025 17:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7F44A3A34
	for <lists+dmaengine@lfdr.de>; Thu, 29 May 2025 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C470421C9F5;
	Thu, 29 May 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOQrczb0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E6193062;
	Thu, 29 May 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532901; cv=none; b=iCZkfkrrfsLKeDvsAseitTf9RQQhHx67Oqkjdgb8W3ZuFJ+hsAVIL0Llvr3iDdRDigMIjSBxOdRjSFvY/fdFOWYjvIqdTvEo4Bs0F2fyXaI3H6E6n/8aT5csuUgP/IPj2Z6VP7gChlFJfgznGoy/kXy+sNaGRf7Uw19/wHjHwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532901; c=relaxed/simple;
	bh=DwuWMlKOrD35PgoLYYWFOEPzCZiE9WygjSlS6zsaK4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pxqhz3/AWug0UsLlIuPWnRF53fNtQgUOz4jZhlSkbwmfPjY9gT/uf3K9GYRsJIqBwyAh/wjhoUDf88f41NsQjPpUYg0zm4kq9c9KNsVRTDu6tHHSMWznkfiAUzWTRnUFgg5WcqeyjNOKkvP4qZE2yZLy1JwVF2IFy9mxSFkqDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOQrczb0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748532901; x=1780068901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwuWMlKOrD35PgoLYYWFOEPzCZiE9WygjSlS6zsaK4Q=;
  b=HOQrczb0TaGik8qDvgvni06ZaVq+PrLbx2468CPVdIh1yT+6HQT5Vxl0
   L2EyfXY3xPQaKG5M/kuNnaQv1eyW32kl6HvG2kEldUFPIaTpqiABowg5A
   3pgytEuLfFBV9vnvuufw0riEeOkFhaTPm9HIJPS+MtUuUaXmDRfQIR7lm
   1HEi/0bHy5rumoi7nITicpKeZ4ztdRGVNEIQ6VWYw5ZSvuQ8BWlztERA6
   o7yKqPFNdmcCvFUJYmafWw2EabtzUPiLmVvPGCvB8FRryBvGWcVeYkivK
   tAGsgU3H27ZyntWkV8E1ClACEr2LENif6gay/CLe3xwdkIe4Dn7PWr66x
   w==;
X-CSE-ConnectionGUID: dg++03c5RLy2apEChFL9LA==
X-CSE-MsgGUID: b7MPAUHeQb22TpXXjBgrxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50488585"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50488585"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:35:00 -0700
X-CSE-ConnectionGUID: qeFvmAjiQZ68v1INYqZ3VQ==
X-CSE-MsgGUID: wqWR4PFtQxWx0sT01XGPqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="147479005"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa003.fm.intel.com with ESMTP; 29 May 2025 08:34:58 -0700
From: Yi Sun <yi.sun@intel.com>
To: dave.jiang@intel.com,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	xueshuai@linux.alibaba.com,
	gordon.jin@intel.com
Subject: [PATCH 2/2] dmaengine: idxd: Fix refcount underflow on module unload
Date: Thu, 29 May 2025 23:34:31 +0800
Message-ID: <20250529153431.1160067-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529153431.1160067-1-yi.sun@intel.com>
References: <20250529153431.1160067-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent refactor introduced a misplaced put_device() call, resulting in
reference count underflow when the module is unloaded.

Expand the idxd_cleanup() function to handle proper cleanup, and remove
idxd_cleanup_internals() as it was not part of the driver unload path.

Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 504aca0fd597..a5eabeb6a8bd 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1321,7 +1321,12 @@ static void idxd_remove(struct pci_dev *pdev)
 	device_unregister(idxd_confdev(idxd));
 	idxd_shutdown(pdev);
 	idxd_device_remove_debugfs(idxd);
-	idxd_cleanup(idxd);
+	perfmon_pmu_remove(idxd);
+	idxd_cleanup_interrupts(idxd);
+	if (device_pasid_enabled(idxd))
+		idxd_disable_system_pasid(idxd);
+	if (device_user_pasid_enabled(idxd))
+		idxd_disable_sva(idxd->pdev);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
 	pci_disable_device(pdev);
-- 
2.43.0


