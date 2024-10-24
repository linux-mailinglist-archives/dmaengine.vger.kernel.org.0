Return-Path: <dmaengine+bounces-3498-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D909AEFBB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EACF1F23E0E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E1A1FC7CA;
	Thu, 24 Oct 2024 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+Yhp8li"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F212FB1B;
	Thu, 24 Oct 2024 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794893; cv=none; b=LAikDye3lYEdLwKr2Fn8aEOqxfEsISNFAJ+Sc3GXK2TkttMFK+OC7Mw75rce9CB0RPTmKGXbFBFNysaRs5hsPYKJCc93eMBhAfeeWbM4oCGZwLzoNsH3HtXWRN0L40Q9oCCs6EBU9vC4BeDz3SpLCmuN4nBTf4u1ltIfdpV1Ulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794893; c=relaxed/simple;
	bh=+PqaxGxw0jvmyv/+vk2vCMHqOyJcMePGrtUA//S8s3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CB/1T2pKtuQv/jI60JtcoGzV8HoB0i0o3hK9NJ1+AX4kphCGTiR20a7s4giBrvLuNPEYKoetSqJmymewo0DDeXGDgEy6fvQCkvDpGx1CE/95hW3U3/gGI7ltyCABvEP5aeG/D6mdX7mcHSs7Ge1lSuZurhfqL6Khzm9dmSmma8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+Yhp8li; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729794892; x=1761330892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+PqaxGxw0jvmyv/+vk2vCMHqOyJcMePGrtUA//S8s3I=;
  b=m+Yhp8lizg4yOR/NNtCtiyLpicb4XPpq6v4pkILLnvrkhL1DDG8ilvmr
   0N8jacJviR3X0d+77t7qxMnjEMVFXoA1vRLQ27XRNTv3JtuAWtGOXHspw
   dMItvPgba5445EmSaOMqIDJTvNJO5W6dRhkotFfdiAzpqhIPasVsMVSbV
   4y0vvFpzkyEHMij+6w2wxVREPf6gxGw4mPScLkv/FJg6AcnIJUpmCXlK3
   sJONKnGjQGIKqFAjZMYdvszmouLRAIrFLsWOT7OEn79c/na+Dfh9N/lyD
   6g7wdkywxlp8LkberiDlMuokFO2PUkNE61nFjNqZq/FXDX11TtF+YZB/8
   w==;
X-CSE-ConnectionGUID: EJiaCDSFQfGhgTFsIlDJjg==
X-CSE-MsgGUID: roecbN60SeCjBg27+O9DeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33138874"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33138874"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 11:34:52 -0700
X-CSE-ConnectionGUID: VyduRgGEQ7WAOQQsXmUEzQ==
X-CSE-MsgGUID: 56xTf9b9SDmLs0Je9F+zHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="111481700"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2024 11:34:51 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2] dmaengine: idxd: Add a new IAA device ID on Panther Lake family platforms
Date: Thu, 24 Oct 2024 11:35:00 -0700
Message-Id: <20241024183500.281268-1-fenghua.yu@intel.com>
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
v2:
- Change newly introduced "IAX" naming to "IAA" naming (Dave Jiang)
- Define PTL DSA device ID inside IDXD driver

 drivers/dma/idxd/init.c      | 2 ++
 drivers/dma/idxd/registers.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 234c1c658ec7..a96f49567313 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -78,6 +78,8 @@ static struct pci_device_id idxd_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	/* IAA on DMR platforms */
 	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
+	/* IAA PTL platforms */
+	{ PCI_DEVICE_DATA(INTEL, IAA_PTL, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index c426511f2104..006ba206ab1b 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -9,6 +9,7 @@
 #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
 #define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
 #define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
+#define PCI_DEVICE_ID_INTEL_IAA_PTL	0xb02d
 
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
-- 
2.37.1


