Return-Path: <dmaengine+bounces-3268-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F0D99100B
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 22:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB10281BD1
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 20:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182D1E103A;
	Fri,  4 Oct 2024 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inUKv3Il"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F771DACA8;
	Fri,  4 Oct 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071508; cv=none; b=d8HYPrJCuN0ZrwpKw+Gk/bIPqDUwkszatI2eHVrJ6TuQ3KVE5SNy7Q8t4QbWV5B1G7o/XYhran0hULmYORu5kMcfAEtNeIyTnFI/91o8Yp6I0LWLcJUW8soFk7+qSl8PzV9TJubNYvuQn3xNh4x4gVFQsRu7nAwe7dHDCciEJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071508; c=relaxed/simple;
	bh=ZqMO7zV/SWnkUyAYpItW9rq9PNiumdMNfFXOCtoE3Ww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VgMlEVFKLqkz3WRt33E/HZ5gr9Y4kDhtmMoV21xIM1avMsVfc7FmusM/ylxoK0KTVS3+C722+4rROBkSaT4jJj2X4oeGPY98T4E+tV0J0ny8Mn80XbraiU60re0vl0SpYBCt3cFbRpDUs9f4mR3fZAAD8Zqhj8FR9nbmXnscbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inUKv3Il; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728071507; x=1759607507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZqMO7zV/SWnkUyAYpItW9rq9PNiumdMNfFXOCtoE3Ww=;
  b=inUKv3Il1XMEs9ApSPjhxenEBfPM2JigKPJ/kO+mvkcEgcH+DL7yo8Ba
   bk5ClwrfBo99j9idrNJsmG96ttA88m6P+bID1mfITyKkTFLf9AeKMYhZY
   eZCibtXWTerKQBGruV5WOj+1+BjvR3xbGVSzpYZ2Eu12GuLAAVP8coVDq
   9b96PRgqnveGshfT7qsDHDNkQ2z8oh6Vui5AEE51RKJrx58jseZJkCFjH
   YPXhTqN9i2JClY2vurDwZvX5rdV27wb9odtQYA8KQwERqmWEzXh2F1nKR
   6fHg+dPdcmeOJd93FdBY68EvqRkq5CLimiknvjtj7vrFfVwcMrN6IDcRR
   w==;
X-CSE-ConnectionGUID: Dz7VbBv/QOm33cmSQPLwsg==
X-CSE-MsgGUID: sZWr9K83RUWtUUtcC944UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27451695"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27451695"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 12:51:45 -0700
X-CSE-ConnectionGUID: mojvLxTPSYGK+a4ZkbDUgQ==
X-CSE-MsgGUID: KLF5Sg/xRX276CTU/TinzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="112273157"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa001.jf.intel.com with ESMTP; 04 Oct 2024 12:51:44 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] dmaengine: idxd: Move DSA/IAA device IDs to IDXD driver
Date: Fri,  4 Oct 2024 12:52:00 -0700
Message-Id: <20241004195200.3398664-1-fenghua.yu@intel.com>
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

Fixes: 4fecf944c051 ("dmaengine: idxd: Add new DSA and IAA device IDs for Diamond Rapids platform")
Fixes: f91f2a9879cc ("dmaengine: idxd: Add a new DSA device ID for Granite Rapids-D platform")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
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


