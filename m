Return-Path: <dmaengine+bounces-5327-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37683AD0D8A
	for <lists+dmaengine@lfdr.de>; Sat,  7 Jun 2025 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AF5163221
	for <lists+dmaengine@lfdr.de>; Sat,  7 Jun 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4C322541D;
	Sat,  7 Jun 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D64AA5h1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C43228CBE;
	Sat,  7 Jun 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301594; cv=none; b=fCMt+4GnF1tKxfqbju6DOrMArMN9qUeh+4Iv/+xlR2j5svmKsJg/wq0WkzVE3UO27aqBk6kGGtzPMXoDl7GztG9ZIzrNDfiPs2x7Q9ApkuRi1k1o+0koohIX6ipy62yrA23q9QvEm8uuZWJzJsn76YzlS+2TD+zUJaNuCd7h5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301594; c=relaxed/simple;
	bh=MZXxfUSkH1A79O9u48J/QWYARZQdYKawpA/PHmDBm+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYkYUYWaQ6Uz2KvPYF+6KaJnCl30N0odPAkhIIkKxffT5HB/8M+ERQd/sTDxp3EvhOkuQexN3lJ/nnBy2RFK0Gi5jtY38YMJ2vFjuV41QHbMA2xRRoEDPqJqrdYiwmo6wWxbqUmcaZMKsF3StTDXb8nEvjQV4UrAjDqC/ShqasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D64AA5h1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749301593; x=1780837593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZXxfUSkH1A79O9u48J/QWYARZQdYKawpA/PHmDBm+U=;
  b=D64AA5h120fb2CwRRJ1P67kNeSxBQpy9+wOBudHuz7e8FdY0rkD8ZEsL
   BrJ0LH6Y78BeZL+SnaIZH4W0gLi6YOtoa2jZdimD+HMxcvBcBY8/LgQxq
   gR0+vMM5LolbY8A5LcFBSNRM7sppQMg+yAPfllOH3Ay24OSP1gqF1NoUN
   37+feeqLVyMvOjj23lhvvKw0BMVj/BskE2D6eml7FjpLlU7ZOBSNwlZVv
   B7D4WDR443A3+c97Kap/7NpDfK3wlbxfqXaC+CQFTF/u7VpFQrPXy61qJ
   YSKn7aWzvXBmocDjsEqXi8QYFp/nmKidWIdw6JYh3LXlaMUrreLcD62fO
   Q==;
X-CSE-ConnectionGUID: Mo4yF/cPQVeE9r/tpA2/UA==
X-CSE-MsgGUID: 4c6u7zLqSJeRBkHM12L65Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="55242778"
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="55242778"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 06:06:32 -0700
X-CSE-ConnectionGUID: zfpFekLQQFWIrVNFszrPpQ==
X-CSE-MsgGUID: j6iCpDsST++BuTxrOtabNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="151074672"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa004.jf.intel.com with ESMTP; 07 Jun 2025 06:06:31 -0700
From: Yi Sun <yi.sun@intel.com>
To: vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	gordon.jin@intel.com
Subject: [PATCH v2 2/2] dmaengine: idxd: Fix refcount underflow on module unload
Date: Sat,  7 Jun 2025 21:06:16 +0800
Message-ID: <20250607130616.514984-3-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607130616.514984-1-yi.sun@intel.com>
References: <20250607130616.514984-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent refactor introduced a misplaced put_device() call, leading to a
reference count underflow during module unload.

There is no need to add additional put_device() calls for idxd groups,
engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
also fixes the missing put_device() for idxd groups, engines, and wqs."
It appears no such omission existed. The required cleanup is already
handled by the call chain:
idxd_unregister_devices() -> device_unregister() -> put_device()

Extend idxd_cleanup() to perform the necessary cleanup, and remove
idxd_cleanup_internals() which was not originally part of the driver
unload path and introduced unintended reference count underflow.

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


