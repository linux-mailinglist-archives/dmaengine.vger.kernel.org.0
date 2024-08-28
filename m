Return-Path: <dmaengine+bounces-2996-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2429B9634F2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 00:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38F71F21DF4
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41BC1AD9D8;
	Wed, 28 Aug 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEwBZPCv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8B1AD3FD;
	Wed, 28 Aug 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884906; cv=none; b=uJQ/UMqSNh79uBnUuKpKX1sp+lE543dKactPc0/hBdrEoUbmebP6nrWugGp3kLdGYj2YNaSVuhW4CuA03rBB/i41CbCIPjHYgi6+ePdY4GW8cD7+oHuPnfBQB64Dlek9voda9JP5DLC80cEVnCogNxO90F67dwG/ttB34bw1vcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884906; c=relaxed/simple;
	bh=rfhhqtQV/Lw8e9UJf+v73dA8SchxPlXI1kSFw1LueEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSOkFAR7iJvgMpx+eOynoqG1xnP1ZQP+fI0vOgr3DJ6uGIsyQdydd5OnSC+WFtn3aKCJZLRpaKyzfSg4B7vHO/HS92ZHYdUaSJujcVda6YAcv16zWvH8rbnEhSz+18+MwPS0yPWijne9UnFwUn9+3HJvayJgvm9awMmP8N5jEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEwBZPCv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884905; x=1756420905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rfhhqtQV/Lw8e9UJf+v73dA8SchxPlXI1kSFw1LueEw=;
  b=TEwBZPCvqElh42zHWU20xpfiafEUQb148lxxK0fcNcfjYyG8MQGFY9zo
   ZOouBbFq+L5v1DkKrZR/Lzcw+8yIUow/Fl73iOXI9Y3N1MnCfQM4xugap
   VLCDns+sOxpj0ak3ZXGZ0JuuNXmNgtZM59kAf25TXyUq7G1qbX+1kuA0t
   wR2xs4dnrWj5Sgom/Sf6VhZbSDMb+KkljFg43aMADRksIuJ49UN/QVJKc
   cDslq9WCKGRXc+ryBvIOwovNhsHxLE3pyIegyBvDqRkjtQ1TN95dYJ9kp
   woygLa07TuDyMdmEGb+d34sS22pILtCvVC5ZhRKBmO2kyA5KzB/iq+Nyy
   g==;
X-CSE-ConnectionGUID: 3oSH6T4ETiSrLFXswcPtEQ==
X-CSE-MsgGUID: hZP1N/UKRrCwAO6x42Y0sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="26348979"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="26348979"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:41:43 -0700
X-CSE-ConnectionGUID: AkiDrQw/RAibhSzELYOelA==
X-CSE-MsgGUID: jxtSJegbRUGiwNaw6rpBjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="67520121"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa003.fm.intel.com with ESMTP; 28 Aug 2024 15:41:42 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/2] dmaengine: idxd: Add new DSA and IAA device IDs on Diamond Rapids platform
Date: Wed, 28 Aug 2024 15:42:04 -0700
Message-Id: <20240828224204.151761-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240828224204.151761-1-fenghua.yu@intel.com>
References: <20240828224204.151761-1-fenghua.yu@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new DSA device ID, 0x1212, and a new IAA device ID, 0x1216, are
introduced on Diamond Rapids platform. Add the device IDs to the IDXD
driver.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/init.c | 4 ++++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 415b17b0acd0..21e3cff66f77 100644
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
+	/* IAX on DMR platforms */
+	{ PCI_DEVICE_DATA(INTEL, IAX_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ff99047dac44..e15ebb3942ae 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2707,6 +2707,8 @@
 #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
 #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
 #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
+#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
+#define PCI_DEVICE_ID_INTEL_IAX_DMR	0x1216
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_82437	0x122d
 #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
-- 
2.37.1


