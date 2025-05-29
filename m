Return-Path: <dmaengine+bounces-5275-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69BAC8059
	for <lists+dmaengine@lfdr.de>; Thu, 29 May 2025 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F83617CD2C
	for <lists+dmaengine@lfdr.de>; Thu, 29 May 2025 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712F21C194;
	Thu, 29 May 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mtzrg0Ir"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9333E4;
	Thu, 29 May 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532892; cv=none; b=lsjmMg6b8DtbEIsX7VtpICTDSsSsSE+ICU8zhoaa5GvwIPN2rlIqKHFlh2QGWFu1jGNrjyg4iu4QCTVji7kvihaiof6tF4Mlj/3OtW/mbB5Qv4vJ1AdhjQnwtusN59pB6q2duwkgMvJZ1JTa8x+GVclvsEiaDP1B8qLFD0El5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532892; c=relaxed/simple;
	bh=OmqvxbTmgHDFbmZZW/23t+UTwlDWRXcjeVhGALxjOhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSWSjEheWSybNz6folYX/RBUrvdOALpcJr1LbX5vMF5VN4KvK4q58gewMBEgLPcpIQycrN7n23OjTF+32x0y7VSL6l1gXVwI0n1EWeBJwzgr5UWCNEKX4zjhEPTlfIrLWkVujJn/AOAAhiDKVPTDO0twU+WOfjrmSxH4dW3EE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mtzrg0Ir; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748532891; x=1780068891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OmqvxbTmgHDFbmZZW/23t+UTwlDWRXcjeVhGALxjOhY=;
  b=Mtzrg0Ir2CYd+9DO07twljHCTh26oQPM7vBKkAgBTrZ+qtLXL8i5JWLB
   4d0gSbWCgeLrC93dayKr0hn3XQcCtoKcB2ay/N0wbT3BEBHG8nT5TDyi8
   JzfSbCALJKyE68G5rg51AZseewC97e+z6xEKUYbxNiFglRZFt8VDQbnCD
   4oi0WGtXJaTIkcECfHDK+ILPn1bB9suPfVUmCpH7NNtAwlJUIL+50Gc+t
   uW/TzKZ0RyjB2xZrMxbeRul28Xe/72ny+W0MJnXixX6MfmbaPpbFCs6pY
   9r6yMjicI9LEtt83kqxV1xd6AV14Kn6Pe8EVdMHwZlkHhH40wDuwZv8Qa
   A==;
X-CSE-ConnectionGUID: vJYQ8LiYRAO/hR2Zi3k9KA==
X-CSE-MsgGUID: yDw+eUT8RHqIOzp2k1CxxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50488552"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50488552"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:34:45 -0700
X-CSE-ConnectionGUID: Ux0jqsZoRRGqJO/1l/BB5A==
X-CSE-MsgGUID: hsBA7rrVSye5dQxyWsTi2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="147478961"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa003.fm.intel.com with ESMTP; 29 May 2025 08:34:43 -0700
From: Yi Sun <yi.sun@intel.com>
To: dave.jiang@intel.com,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	xueshuai@linux.alibaba.com,
	gordon.jin@intel.com
Subject: [PATCH 1/2] dmaengine: idxd: Remove improper idxd_free
Date: Thu, 29 May 2025 23:34:30 +0800
Message-ID: <20250529153431.1160067-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The put_device() call can be asynchronous cleanup via schedule_delayed_work
when CONFIG_DEBUG_KOBJECT_RELEASE is set. This results in a use-after-free
failure during module unloading if invoking idxd_free() immediately
afterward.

Removes the improper call idxd_free() to prevent potential memory
corruption.

Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 760b7d81fcd8..504aca0fd597 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1324,7 +1324,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_cleanup(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
-	idxd_free(idxd);
 	pci_disable_device(pdev);
 }
 
-- 
2.43.0


