Return-Path: <dmaengine+bounces-3148-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B229975C05
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 22:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6451C21DAB
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486F01B5808;
	Wed, 11 Sep 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIynpaYu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8F14F13E;
	Wed, 11 Sep 2024 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087494; cv=none; b=eSuzIaDJ15EEWYMAk7gHX5mV8v8+CNDnbdi2FtbwbiVOCzE2Z5Ky4SYkIOfwf3c4LQQj7PrhznPjbIOm/U8/YY/fMkVSN6Y6crGxZNZeq6mh7HPQ7YbuzQqV7XRgwmupEhTILt9fkOhHpgXkul8/Rx27YjFIllerkECERoofcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087494; c=relaxed/simple;
	bh=6vNFb7HWgfUgk50jvJhXChPC/H6FA227ImHnku7m1oU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDLGqQHxfiC3nSqdTeNKCMUSWbQYCoiaW6TE5eTvh7Zbm9cM7MBt3BTn3rrgnuBuToaE9r4JdmRURD7Qzql1jUgPYf+xpBlrOwsQ3ExFAUwZpEd8EtHw1WctRX9G2XxfprHX+q36g/gRI5TcrNL3vaq3vQOd+HxVIqqiK2/VpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIynpaYu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726087493; x=1757623493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6vNFb7HWgfUgk50jvJhXChPC/H6FA227ImHnku7m1oU=;
  b=kIynpaYux+zxBiRb+iZAJ8UymfJ/fRLbVFp7giKPtw7+ahBEe7MWwT+V
   xGUjyJbBOo5WFJ5/V4qyeM4jsa2KGwLhgTproKhNJtkKNz/Hu3WRsvjHa
   O0raE7RIavFF66+gcZTqZifJ2KUisjBz4PV8hJoXC+fI8yM+6CAQgh7/S
   H2/2KcO81NcEjMTWe13y2b9Gm3HutcmGrQ9MAEWF8GcDWajnb01zbSwiT
   2m+CRjbvTacup6bnBgLL9i0BjJecOe277qSUtiDR128zXFRYbqBp0hJrY
   bRRAZow0TL66qvqgMn0VvsJ9pBLkE5H+NHJnxhIQ2LcjVWdayLCJcO4VC
   A==;
X-CSE-ConnectionGUID: ksXcyAOpQxCdiZf+LwCFEw==
X-CSE-MsgGUID: QOUrIyYjS2iTrQ7hwEDdog==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36048673"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="36048673"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 13:44:53 -0700
X-CSE-ConnectionGUID: ivmzS7tgTH2/ypVd3DzZAQ==
X-CSE-MsgGUID: lwBwUDeOQcSWdypnDOqqjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67992557"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2024 13:44:52 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] dmaengine: idxd: Add a new IAA device ID on Panther Lake family platforms
Date: Wed, 11 Sep 2024 13:45:12 -0700
Message-Id: <20240911204512.1521789-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new IAA device ID, 0xb02d, is introduced across all Panther Lake family
platforms. Add the device ID to the IDXD driver.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Hi, Vinod,

This patch is applied cleanly on the next branch in the dmaengine repo.

The next branch already includes a few new DSA/IAA device IDs in IDXD
driver.

Please check the patches and the reasons why the new IDs should be added:
https://lore.kernel.org/lkml/20240828233401.186007-1-fenghua.yu@intel.com/

 drivers/dma/idxd/init.c | 2 ++
 include/linux/pci_ids.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 0f693b27879c..3ae494a7a706 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -78,6 +78,8 @@ static struct pci_device_id idxd_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	/* IAA on DMR platforms */
 	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
+	/* IAX PTL platforms */
+	{ PCI_DEVICE_DATA(INTEL, IAX_PTL, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 8139231d0e86..e598d6ff58bf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3117,6 +3117,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_CNL_H	0xa348
 #define PCI_DEVICE_ID_INTEL_HDA_CML_S	0xa3f0
 #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
+#define PCI_DEVICE_ID_INTEL_IAX_PTL	0xb02d
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
 #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
-- 
2.37.1


