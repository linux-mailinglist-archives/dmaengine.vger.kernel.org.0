Return-Path: <dmaengine+bounces-5452-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0476AD92BA
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BBC17CC39
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8F20B1F7;
	Fri, 13 Jun 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tqv9gHSI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4F2E11D2;
	Fri, 13 Jun 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831565; cv=none; b=P3NNI5Mi0NxnpLVTQtrolBM/Hgpjo1VWkflwDQwd5SJMf5MnFW0IELtKVdHo2JWu7+dXt+Zaqc8XAJsAIXLP7QL2/LiukSeKNTom3MWRCObPKwmjk+ePJ4eBonby6iRMu1B62V7kXhw9gPbezSdGEhtGah23u6KoOUo6EM7IzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831565; c=relaxed/simple;
	bh=qYXc05I9kfQEn1rmPewPYceI7Zj/YbKXlKi0qRk8FBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkJ1bOmEKzGE5TB0prTDXV8qT1yDARK8gX9h+12XWb7f8tnxDFRAdToYCMu33Su9NqAOC+85laGvDNSgRHxKivnY7jO7yi+9DbtDKUqdC/UYvFnkXfcJMvKb6aPAW25c7Oyv55a+evVvcoBDCnrcFuScvWyo6Ze4PgSARPPjlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tqv9gHSI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749831564; x=1781367564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qYXc05I9kfQEn1rmPewPYceI7Zj/YbKXlKi0qRk8FBM=;
  b=Tqv9gHSIDN+bWDCt5co4F+eC2EZvKqCs3FR08fscQO/+QOtvc4a+yd7w
   WK6bfLlahM9o5AKB6K46gIH8Pd7WI5qvrzwuSdcGNx4YgUdiUzT/PDuEE
   EWBFlBan1abrZUrgW9MJ8p9AFzPjDiXEpG8KuRaYBQ0IGRDOBqKV4lS82
   Uq6jM+saxE1kkXfCURD5XOTrHgdbfEly/uwVVdwwQgKfbl1G07lY837Nm
   OFZghrRFb0Y67Jv6T4cjUTF8OLMmS4+bbN7lxBkuiVxBLHrjbyn7duVhV
   Fk33RTsfYZPQ/nu2ok6Kyei7g9GrVPdXdo/uPyhIk6NNckbz33eMu6Krm
   A==;
X-CSE-ConnectionGUID: dGUpPL9HQWeAGa4WW1kWEQ==
X-CSE-MsgGUID: NlF2xPfCSOOGPxc+qRd0FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52149236"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="52149236"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:19:24 -0700
X-CSE-ConnectionGUID: sNGtecLVQZSo0ac87g/cJg==
X-CSE-MsgGUID: xuuKOLvcQAScNOMTl3KJfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="147859263"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa009.jf.intel.com with ESMTP; 13 Jun 2025 09:19:20 -0700
From: Yi Sun <yi.sun@intel.com>
To: dave.jiang@intel.com,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com,
	anil.s.keshavamurthy@intel.com,
	philip.lantz@intel.com
Subject: [PATCH 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through sysfs
Date: Sat, 14 Jun 2025 00:18:33 +0800
Message-ID: <20250613161834.2912353-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613161834.2912353-1-yi.sun@intel.com>
References: <20250613161834.2912353-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
capability registers (dsacap0-2) to enable userspace awareness of hardware
features in DSA version 3 and later devices.

Userspace components (e.g. configure libraries, workload Apps) require this
information to:
1. Select optimal data transfer strategies based on SGL capabilities
2. Enable hardware-specific optimizations for floating-point operations
3. Configure memory operations with proper numerical handling
4. Verify compute operation compatibility before submitting jobs

The output consists of values from the three dsacap registers, concatenated
in order and separated by commas.

Example:
cat /sys/bus/dsa/devices/dsa0/dsacap
 0014000e000007aa,00fa01ff01ff03ff,000000000000f18d

Signed-off-by: Yi Sun <yi.sun@intel.com>
Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 4a355e6747ae..f9568ea52b2f 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -136,6 +136,21 @@ Description:	The last executed device administrative command's status/error.
 		Also last configuration error overloaded.
 		Writing to it will clear the status.
 
+What:		/sys/bus/dsa/devices/dsa<m>/dsacap
+Date:		June 1, 2025
+KernelVersion:	6.17.0
+Contact:	dmaengine@vger.kernel.org
+Description:	The DSA3 specification introduces three new capability
+		registers: dsacap[0-2]. User components (e.g., configuration
+		libraries and workload applications) require this information
+		to properly utilize the DSA3 features.
+		This includes SGL capability support, Enabling hardware-specific
+		optimizations, Configuring memory, etc.
+		The output consists of values from the three dsacap registers,
+		concatenated in order and separated by commas.
+		This attribute should only be visible on DSA devices of version
+		3 or later.
+
 What:		/sys/bus/dsa/devices/dsa<m>/iaa_cap
 Date:		Sept 14, 2022
 KernelVersion: 6.0.0
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 74e6695881e6..cc0a3fe1c957 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -252,6 +252,9 @@ struct idxd_hw {
 	struct opcap opcap;
 	u32 cmd_cap;
 	union iaa_cap_reg iaa_cap;
+	union dsacap0_reg dsacap0;
+	union dsacap1_reg dsacap1;
+	union dsacap2_reg dsacap2;
 };
 
 enum idxd_device_state {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 80355d03004d..cc8203320d40 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -582,6 +582,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	}
 	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
 
+	idxd->hw.dsacap0.bits = ioread64(idxd->reg_base + IDXD_DSACAP0_OFFSET);
+	idxd->hw.dsacap1.bits = ioread64(idxd->reg_base + IDXD_DSACAP1_OFFSET);
+	idxd->hw.dsacap2.bits = ioread64(idxd->reg_base + IDXD_DSACAP2_OFFSET);
+
 	/* read iaa cap */
 	if (idxd->data->type == IDXD_TYPE_IAX && idxd->hw.version >= DEVICE_VERSION_2)
 		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 006ba206ab1b..45485ecd7bb6 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -13,6 +13,7 @@
 
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
+#define DEVICE_VERSION_3		0x300
 
 #define IDXD_MMIO_BAR		0
 #define IDXD_WQ_BAR		2
@@ -582,6 +583,21 @@ union evl_status_reg {
 	u64 bits;
 } __packed;
 
+#define IDXD_DSACAP0_OFFSET		0x180
+union dsacap0_reg {
+	u64 bits;
+};
+
+#define IDXD_DSACAP1_OFFSET		0x188
+union dsacap1_reg {
+	u64 bits;
+};
+
+#define IDXD_DSACAP2_OFFSET		0x190
+union dsacap2_reg {
+	u64 bits;
+};
+
 #define IDXD_MAX_BATCH_IDENT	256
 
 struct __evl_entry {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 9f0701021af0..624b7d1b193f 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1713,6 +1713,21 @@ static ssize_t event_log_size_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(event_log_size);
 
+static ssize_t dsacap_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct idxd_device *idxd = confdev_to_idxd(dev);
+
+	return sysfs_emit(buf, "%08x,%08x,%08x,%08x,%08x,%08x\n",
+			  upper_32_bits(idxd->hw.dsacap0.bits),
+			  lower_32_bits(idxd->hw.dsacap0.bits),
+			  upper_32_bits(idxd->hw.dsacap1.bits),
+			  lower_32_bits(idxd->hw.dsacap1.bits),
+			  upper_32_bits(idxd->hw.dsacap2.bits),
+			  lower_32_bits(idxd->hw.dsacap2.bits));
+}
+static DEVICE_ATTR_RO(dsacap);
+
 static bool idxd_device_attr_max_batch_size_invisible(struct attribute *attr,
 						      struct idxd_device *idxd)
 {
@@ -1750,6 +1765,14 @@ static bool idxd_device_attr_event_log_size_invisible(struct attribute *attr,
 		!idxd->hw.gen_cap.evl_support);
 }
 
+static bool idxd_device_attr_dsacap_invisible(struct attribute *attr,
+					      struct idxd_device *idxd)
+{
+	return attr == &dev_attr_dsacap.attr &&
+		(idxd->data->type != IDXD_TYPE_DSA ||
+		idxd->hw.version < DEVICE_VERSION_3);
+}
+
 static umode_t idxd_device_attr_visible(struct kobject *kobj,
 					struct attribute *attr, int n)
 {
@@ -1768,6 +1791,9 @@ static umode_t idxd_device_attr_visible(struct kobject *kobj,
 	if (idxd_device_attr_event_log_size_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_device_attr_dsacap_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1795,6 +1821,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_cmd_status.attr,
 	&dev_attr_iaa_cap.attr,
 	&dev_attr_event_log_size.attr,
+	&dev_attr_dsacap.attr,
 	NULL,
 };
 
-- 
2.43.0


