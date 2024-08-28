Return-Path: <dmaengine+bounces-2995-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7F9634F1
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754FF1F254EF
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B81AD9C5;
	Wed, 28 Aug 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNtg2e/X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9E1AC89F;
	Wed, 28 Aug 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884906; cv=none; b=An8PpQp4yLzr7/BX9w+Yc61c+L712tCZ8gfCbcqa5KSYYZA2aEeGINd7cRmVnw24H22W+YBId1kNOshAlw2JiuPn17LprzGcn5ceS6Kgr42RsS1GTJlOlTjOjhkJv406RMJ1IkRy48gpMliPpheePOuX1a4IHT4PU4Ya8tV62tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884906; c=relaxed/simple;
	bh=xpsblPxj8MQBZhnwfMSzjOp3nVu9TEPCYbdLNAfUBPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8Rgl3V6QIvpgT345fVWantOiYP5YZdWWWZlIe1xxzFJkXDjEl3EncVTSHa+Ajro/q/C63ZLg0hyLJ6wrindWchpBbKZSFRuwQdTscqTMAq3U4p8FWfxKLzPhdjaYDmTGASj6FX++dx2+zX/Bh/r2ApIXaBY3O+Vgz0dNYgsNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNtg2e/X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884905; x=1756420905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xpsblPxj8MQBZhnwfMSzjOp3nVu9TEPCYbdLNAfUBPk=;
  b=bNtg2e/XmQIm2P3ZBxufiVVHea/5PWEgftbnpJ4hZOSj+VMOJ8cfbRpM
   XGFSaMwjYjIY3gyoO05y855mJSLqXV/V2iXYISxW5j47wYyq2xa1gqXjp
   U1PP+HFZGOzugHYH6wN3oU9YYdYpgJ8MglDl3ZwmKvk9VuHxaoc1sMt0m
   rXorsdqfHD8tFSExitSS9y+2MRfQ7xpFVahZXkTBfs15IiHyir9JMVGSi
   UE/+xbrozKGXBNlkdicNQX819hslsQm11CdGOCQK19S6qF0HWdvHpAY4E
   U3cWsMUU8M90NaEtDJIZIW+/HU1Nc9sfn4QB1v5WrgMeaUaMenZzJAa61
   A==;
X-CSE-ConnectionGUID: IlVQruHeT6uwDkqvLFKcqw==
X-CSE-MsgGUID: Zz+z7n8CROakhUMwJcbfWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="26348977"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="26348977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:41:43 -0700
X-CSE-ConnectionGUID: sWUiHppIT3SW9Y/KFcG+Hg==
X-CSE-MsgGUID: ad9S5w91SIunvqJfZS0dcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="67520118"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa003.fm.intel.com with ESMTP; 28 Aug 2024 15:41:42 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/2] dmaengine: idxd: Add a new DSA device ID on Granite Rapids-D platform
Date: Wed, 28 Aug 2024 15:42:03 -0700
Message-Id: <20240828224204.151761-2-fenghua.yu@intel.com>
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

A new DSA device ID, 0x11fb, is introduced on the Granite Rapids-D
platform. Add the device ID to the IDXD driver.

Since a potential security issue has been fixed on the new device, it's
secure to assign the device to virtual machines, and therefore, the new
device ID will not be added to the VFIO denylist. Additionally, the new
device ID may be useful in identifying and addressing any other potential
issues with this specific device in the future. The same is also applied
to any other new DSA/IAA devices with new device IDs.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
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


