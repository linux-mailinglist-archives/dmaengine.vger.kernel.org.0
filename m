Return-Path: <dmaengine+bounces-3003-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB769963639
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 01:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F022853D6
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 23:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6BB1BA89C;
	Wed, 28 Aug 2024 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgMPZTUS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D911B0120;
	Wed, 28 Aug 2024 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888030; cv=none; b=YQ9utNVsVArMALFA4vE1gbMm1dFDwvHVlBswhGe+H3jkNUpe6m2c8FbaS4PNofK3gVrPRjtxNXCjlLo8ufifnKDZXXvSmvgqopM7RKk1ZA3eEAsRfODvIBR/LerGIouLD1RumT/XWNjB3jO0Mn+ykIZGid9LJ6e+l5+ZCxCrkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888030; c=relaxed/simple;
	bh=IH9sEBnO63vRxQkcBEHWPxvf5oeKCdA2qkhXGJcICNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=km3rI0qe5gWqP8jeRXwtiQOSanSy5lkf13TDPUU1y68rWGZwDr5QeQDGEk9lH1sIfjYp7F6vjT2zVGjzz0Cj7r9P6eK4WMjsMYwKGbeJCR+X4Q/HVIVnxVmL15w423Yofb1xDfSW1t8R3gsePW5Xr6YvSu0+Szt9bSdWRhLxrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgMPZTUS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724888029; x=1756424029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IH9sEBnO63vRxQkcBEHWPxvf5oeKCdA2qkhXGJcICNE=;
  b=VgMPZTUS4lcq8EpwNc0rhl8SVM9bnAAJHYXPdN6qzNyv76V/l39l69/R
   WnG8mf7uyHnZ954cQDgvD51LlEV2DSULu+1qHaew+4SlJHLSbMxtfkmEJ
   mUjVaL8lVAqQBDfY+MOPkp9RuqIrHWvD3mugHgrGJyEuprnSNFOSIjq7/
   qrI3IaOHzg+7XrSTsrD2hyYGuJmbzHiLiFyMrdYuw7IsjzaG1T7ogekix
   npUYp+ZGcF08BhwrK197FZtEKoNDtL8mLojbwF9ihpVrv6T8buOl8ysQ1
   PjPO3XNwugoCRs+Mm9GUhHEtX6ymDc1JGDwQliKGr1Krej68ENdEwXqYF
   A==;
X-CSE-ConnectionGUID: AJhclZK3RHu3YrjyrgjEQw==
X-CSE-MsgGUID: o7bNbi1kQrmzgkJZN6bGtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="27327252"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="27327252"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:33:46 -0700
X-CSE-ConnectionGUID: B+sYFwrURbGQUmyeqWYpoQ==
X-CSE-MsgGUID: 0jx/yqRUQ327vwVObkh7jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68162731"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa003.jf.intel.com with ESMTP; 28 Aug 2024 16:33:46 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 2/2] dmaengine: idxd: Add new DSA and IAA device IDs for Diamond Rapids platform
Date: Wed, 28 Aug 2024 16:34:01 -0700
Message-Id: <20240828233401.186007-3-fenghua.yu@intel.com>
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

A new DSA device ID, 0x1212, and a new IAA device ID, 0x1216, are
introduced for Diamond Rapids platform. Add the device IDs to the IDXD
driver.

The name "IAA" is used in new code instead of the old name "IAX".
However, the "IAX" naming (e.g., IDXD_TYPE_IAX) is retained for legacy
code compatibility.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v2:
- Replace "IAX" with "IAA" (Dave Jiang)

 drivers/dma/idxd/init.c | 4 ++++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 415b17b0acd0..0f693b27879c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -71,9 +71,13 @@ static struct pci_device_id idxd_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, DSA_SPR0, &idxd_driver_data[IDXD_TYPE_DSA]) },
 	/* DSA on GNR-D platforms */
 	{ PCI_DEVICE_DATA(INTEL, DSA_GNRD, &idxd_driver_data[IDXD_TYPE_DSA]) },
+	/* DSA on DMR platforms */
+	{ PCI_DEVICE_DATA(INTEL, DSA_DMR, &idxd_driver_data[IDXD_TYPE_DSA]) },
 
 	/* IAX ver 1.0 platforms */
 	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
+	/* IAA on DMR platforms */
+	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ff99047dac44..8139231d0e86 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2707,6 +2707,8 @@
 #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
 #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
 #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
+#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
+#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_82437	0x122d
 #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
-- 
2.37.1


