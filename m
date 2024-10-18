Return-Path: <dmaengine+bounces-3394-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8249A48FF
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2024 23:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0A2840D7
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2024 21:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976B18E34E;
	Fri, 18 Oct 2024 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub/Vj2rz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265618D640;
	Fri, 18 Oct 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287437; cv=none; b=WLaxct3ZdvMYqpxrsoXgF/eHta2jvPX8z3rycgcgDhnOOdmVWrWZQl97y3qy9fW3BlcOLEbAgSVRRzQHyklJxJLMmfWU+aqd59SNKPLEGBx3+jhC0VKCPfTsLIfrV11nSu2epXLOVNHVLJkfBSiNUZKkMarW5Byr9t1pv5zEeYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287437; c=relaxed/simple;
	bh=QJ53Scw1t1SKQzFOABoj/pnvI/hnsCdkPuCpi2UA++w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sTBPOMIy3kmiPZnDuSGKsjQ9Xz907UTDd3nbI++H41/lhx1E64iEZl/dhPvU6OPNHJPlAdYD9MS38JKUYnRsEZA6O5P8fw3PcESvrWzGfAxeEvyLpaRogJT1j4lJhRvDL4FZBhvoBdiNmVJhUasEJrcQCT+fsTA4TyB2T8Wm8ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub/Vj2rz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729287435; x=1760823435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QJ53Scw1t1SKQzFOABoj/pnvI/hnsCdkPuCpi2UA++w=;
  b=Ub/Vj2rzx6g0ImjXcqriREmLf0dwjdjBzyrceZPKzyETj3OtPEPXNd2M
   o57wrieNBBmDQQtTfQqMAmEu2+ceyD1edusZ6AKwscKY+K2jViftl/sTs
   VD/sYSQfhP0QoitvNbQHw5jfLBY/n4jMoHQoPnu3BovH9JlcDowzW+KVd
   MoKDp8iyve/TaISeDF9XlYG2DDOAGD3cbw2rl/crraKJA2M4iX596Gz5V
   T9p0w6BgmS4KWRdb3fZkR7ayA+MTt3eaed/kO8VRSpbY+v+ytjikDhuxW
   uZBqWDrpr+NC4F+T+WYP2CMj1l9aNgra9OwfQgg1DsHQg+8ta6my2Zz7f
   g==;
X-CSE-ConnectionGUID: yBYUVHTLT3KDbBW8q5cstA==
X-CSE-MsgGUID: UT+ifT9ITqmEIZ3QUB0dNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28967219"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28967219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 14:37:13 -0700
X-CSE-ConnectionGUID: 6dMtU5KxQK6xpNw44/cymQ==
X-CSE-MsgGUID: Mysex+KgR/yR3AwHRVC3pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="116439670"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa001.jf.intel.com with ESMTP; 18 Oct 2024 14:37:13 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2] dmaengine: idxd: Move DSA/IAA device IDs to IDXD driver
Date: Fri, 18 Oct 2024 14:37:25 -0700
Message-Id: <20241018213725.4167413-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the DSA/IAA device IDs are only used by the IDXD driver, there is
no need to define them as public IDs. Move their definitions to the IDXD
driver to limit their scope. This change helps reduce unnecessary
exposure of the device IDs in the global space, making the codebase
cleaner and better encapsulated.

There is no functional change.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v2:
- Remove "Fixes" tags (Vinod)

 drivers/dma/idxd/registers.h | 4 ++++
 include/linux/pci_ids.h      | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index e16dbf9ab324..c426511f2104 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -6,6 +6,10 @@
 #include <uapi/linux/idxd.h>
 
 /* PCI Config */
+#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
+#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
+#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
+
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4cf6aaed5f35..e4bddb927795 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2709,9 +2709,6 @@
 #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
 #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
 #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
-#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
-#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
-#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_82437	0x122d
 #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
-- 
2.37.1


