Return-Path: <dmaengine+bounces-3002-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED107963638
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 01:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F61C24175
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680891B375B;
	Wed, 28 Aug 2024 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bz9cO1Xj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4D1B011D;
	Wed, 28 Aug 2024 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888030; cv=none; b=D0EWiiJPtKBmpVdVOqWuxASSDDMGrQMx9QtWZ2GFIZ5nS8rEUzv351KB8UWQmT0ehevQoui/+yNEoWFDwVq44SFn4Kg+DhOXYQXbwvavwCw9qCjQQB0rEha9wHen4F4MXXIkeszBVOo6m2hOBWeCXymKvdM+V0gz6YsFxw/+or4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888030; c=relaxed/simple;
	bh=f7fsMdJW1PFbTvgw3AHif5zuCBukLeQvzqI94HYV4Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzcuLL4PxHh/aiFoQVKiO3e7L+t1rs6jUwG77qhV5H7PFHuIM8n8cJcqZ/4pRX1IWu2e/HoJzN8gpDSBr6/WQinwu8omk++ly9biPFiQmWPpSc7ee3MF8FLX4cGMN8tqFZVTLp9veEQFUvT9+9KXMTFu+MtDdneU0cXQr1rJ/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bz9cO1Xj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724888029; x=1756424029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f7fsMdJW1PFbTvgw3AHif5zuCBukLeQvzqI94HYV4Ng=;
  b=bz9cO1XjKsL3Cqe96L5RSu220cQAly6QlOcdpZBAT2ZCtYjiu0s6UTT/
   zLveIiKuMEdReQ6LZs/uWSRxBBOqO1G2v7f16CibBeCvecFAKDqY72YAW
   da8MNvKp/jEWBrH8QDHSRXlzKlgVUZBv9OmmDY14YGuCVO4orq0uq8YDN
   rTTidQd7JK/AC7GJTcCHR5Kr6DcAXjQ88s38uytSfEvgThm0PPk6PYBey
   0f5W97Z1BjrVs3q13X0CZvUWlE5vdT8+RE5ZjHxQjhx7UxqXNyOotwjUQ
   LVo/ogaZgiFavsq2x2/jWuRlk40rQd08KEph7TMyBvjrqaK3S5IDDU7lq
   A==;
X-CSE-ConnectionGUID: 7CIflM0hTouRw6F2oRiVew==
X-CSE-MsgGUID: GZ9TOTW3Rk2rz+XsYu74yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="27327251"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="27327251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:33:46 -0700
X-CSE-ConnectionGUID: eycsY9OcS9O3TUtCs8B04w==
X-CSE-MsgGUID: KZQo3oLtSDeQ7ysbAmx3mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68162727"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa003.jf.intel.com with ESMTP; 28 Aug 2024 16:33:46 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 1/2] dmaengine: idxd: Add a new DSA device ID for Granite Rapids-D platform
Date: Wed, 28 Aug 2024 16:34:00 -0700
Message-Id: <20240828233401.186007-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240828233401.186007-1-fenghua.yu@intel.com>
References: <20240828233401.186007-1-fenghua.yu@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new DSA device ID, 0x11fb, is introduced for the Granite Rapids-D
platform. Add the device ID to the IDXD driver.

Since a potential security issue has been fixed on the new device, it's
secure to assign the device to virtual machines, and therefore, the new
device ID will not be added to the VFIO denylist. Additionally, the new
device ID may be useful in identifying and addressing any other potential
issues with this specific device in the future. The same is also applied
to any other new DSA/IAA devices with new device IDs.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Add Reviwed-by

 drivers/dma/idxd/init.c | 2 ++
 include/linux/pci_ids.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 21f6905b554d..415b17b0acd0 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -69,6 +69,8 @@ static struct idxd_driver_data idxd_driver_data[] = {
 static struct pci_device_id idxd_pci_tbl[] = {
 	/* DSA ver 1.0 platforms */
 	{ PCI_DEVICE_DATA(INTEL, DSA_SPR0, &idxd_driver_data[IDXD_TYPE_DSA]) },
+	/* DSA on GNR-D platforms */
+	{ PCI_DEVICE_DATA(INTEL, DSA_GNRD, &idxd_driver_data[IDXD_TYPE_DSA]) },
 
 	/* IAX ver 1.0 platforms */
 	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e388c8b1cbc2..ff99047dac44 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2706,6 +2706,7 @@
 #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
 #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
 #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
+#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_82437	0x122d
 #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
-- 
2.37.1


