Return-Path: <dmaengine+bounces-5934-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F07CB18920
	for <lists+dmaengine@lfdr.de>; Sat,  2 Aug 2025 00:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72360588091
	for <lists+dmaengine@lfdr.de>; Fri,  1 Aug 2025 22:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348722259E;
	Fri,  1 Aug 2025 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrn2vkmj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB12E36F8;
	Fri,  1 Aug 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754086136; cv=none; b=AyWuCOeTu+QGJPHRQqVchwRv6O+57De9pr/Y2YnM5WCU1d12VaqNPi/EWecgwq/Fi85eItgda2wmXzz5xnB/hsu5RcFOSlOwu2r3rT3RxZNAoHIvhKt3hiqtMxyGsEB2Jwz0eSWYrPD9vDaCjkJ3xZXJP5ktUYSd3mtSUUGYEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754086136; c=relaxed/simple;
	bh=uQ6zMqVlQY4KiSfQ9ZT2G3DVnYBY7rJDyuIo3bT9gSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n4JEkCyZuwUQQy46FaOLZeoyVmS+Ti/OZm56zZvodfHbop8GgW2lG75e+LnJTjnZqWL05+1uY1UARuf7i2qWBlzml5yx+oCVWPYy4nHDjiMy+BEVLQmrfZzhWvXnYVcHx/XAOUlYz4Yvi/DnecjbwBATFsICmqSEHLF4pgagzIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrn2vkmj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754086134; x=1785622134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uQ6zMqVlQY4KiSfQ9ZT2G3DVnYBY7rJDyuIo3bT9gSc=;
  b=nrn2vkmjcUobPBOiOu4sXOopYb2yYn9950wCu4QodcDYAX+hV4K83BYK
   TvXQTap29Jjai5pSy8TUv/6PLnfT2SblpmaeqFcaYQcAiYEJSlA3a8ZOK
   JZS/RYQQFcnA6BUl2Yf+log71wOIbNZ+Teo4/wR7Eo2PLMWqQK4lbpDOZ
   pwLJvodPpA0/UkyUeqKA1xK0r6Lb6yN9lvKLagfahLFADageqoZo1vNmh
   k0dpmNLlLXC3AxIWEiGmXhikLcwAxlYzBxU9ccodGxNDGsuQPZ71bFJRd
   IWooCfFqw5C/Org+sd+LBzfwM9kISMcCF8fMUUy3t2XCSzERhW7aY2uI1
   w==;
X-CSE-ConnectionGUID: X9ypP+rKRISCrDyWJXQ8Aw==
X-CSE-MsgGUID: fNmvRDDmR2+aT5enavcINw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="73899311"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="73899311"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 15:08:54 -0700
X-CSE-ConnectionGUID: 0zJ700BdSyaS4IECpd2vUg==
X-CSE-MsgGUID: S8xIxYcPTq2n611v6XZTfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163593949"
Received: from ldmartin-desk2.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.125.110.9])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 15:08:53 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: dmaengine@vger.kernel.org
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Add a new IAA device ID for Wildcat Lake family platforms
Date: Fri,  1 Aug 2025 14:59:35 -0700
Message-ID: <20250801215936.188555-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

A new IAA device ID, 0xfd2d, is introduced across all Wildcat Lake
family platforms. Add the device ID to the IDXD driver.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/init.c      | 2 ++
 drivers/dma/idxd/registers.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 35bdefd3728b..f98aa41fa42e 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -80,6 +80,8 @@ static struct pci_device_id idxd_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	/* IAA PTL platforms */
 	{ PCI_DEVICE_DATA(INTEL, IAA_PTL, &idxd_driver_data[IDXD_TYPE_IAX]) },
+	/* IAA WCL platforms */
+	{ PCI_DEVICE_DATA(INTEL, IAA_WCL, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 9c1c546fe443..0d84bd7a680b 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -10,6 +10,7 @@
 #define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
 #define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
 #define PCI_DEVICE_ID_INTEL_IAA_PTL	0xb02d
+#define PCI_DEVICE_ID_INTEL_IAA_WCL	0xfd2d
 
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
-- 
2.50.1


