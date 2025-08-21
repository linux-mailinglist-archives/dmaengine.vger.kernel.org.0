Return-Path: <dmaengine+bounces-6098-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81AEB2F2FF
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DB67243FC
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FA92ECE96;
	Thu, 21 Aug 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdUpn04X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DC8F49;
	Thu, 21 Aug 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766332; cv=none; b=nUhQtfUAMvxW57+0Se3zwQh2kBgbW0F4s7OZL/doT2tJnCYWwHYdlPH2cQItM2Rq1/XQmUmIr28Iz3gsloN8cEzOi+THBH2WIS+i7loqFO0811wsrc753F3ntclBQwD8Gc+WuwK/saBMSOMMEgFTR1jtgmz7ka5jt+eEXlNW260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766332; c=relaxed/simple;
	bh=qF4P1DUKpsAXx7DJNKwrqT6hENBt2wDyJ/PJJAw6MvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpvdg0hCVWkVFyhA/lnTWQN5qaDEvweOkp49d432XfFyisk1KJOZdZ7OzYQFtBXUNoOVq0Erzox51G5KE6g8EWRdYiEp8/rf5MsWRk0UgW3II6jrvFTzTVExcdXJ9cDCVmO5FJuFrdd3NtVLfdAeT9nJmz5oV5GC3E328OtpCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdUpn04X; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755766331; x=1787302331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qF4P1DUKpsAXx7DJNKwrqT6hENBt2wDyJ/PJJAw6MvY=;
  b=YdUpn04Xg1NWGy6NRUYSRx7tJDTpF8aykQdoxkNxPlR+X3vfAE2DFvpj
   TM4janiHTvyejSXSFKIVtta2kc6FVVAq/xjL50+A89ApYdp6bYBJCKJ+r
   9GRL7oUFNm+Pr/gkNzwQdGtwnSSy0QCP4SixgauJurCabk1jUQ9h23VcC
   Hw9UgtoGcm04eqVBv/Tiw+lkbVbaCBI43mkQM2um9KJ4k+1OR8+Kd6Nx+
   Gh2UGck6sJt/HC/iludvrjF4A7tnKApL84xy4IBi9WhCgPA8LM0Redd7a
   BkHFHpTqV/NZJbrZ/8Tz2mh7J5mZD6+IpnOfBezv6XDVK/st7wbIZ+bOw
   Q==;
X-CSE-ConnectionGUID: J0sm67B1TOOg/lJZIMLAwQ==
X-CSE-MsgGUID: Bb2j3X2wRKaGyZSIvrxZUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61877144"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61877144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:52:10 -0700
X-CSE-ConnectionGUID: BFEUyEIXRqqj0QIhFNj2mw==
X-CSE-MsgGUID: SGA6vlOmTVKJRaiONDCfhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173624798"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2025 01:52:08 -0700
From: Yi Sun <yi.sun@intel.com>
To: vkoul@kernel.org
Cc: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com,
	yi1.lai@intel.com,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [PATCH v3 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through sysfs
Date: Thu, 21 Aug 2025 16:51:10 +0800
Message-ID: <20250821085111.1430076-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821085111.1430076-1-yi.sun@intel.com>
References: <20250821085111.1430076-1-yi.sun@intel.com>
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

The output format is <dsacap2>,<dsacap1>,<dsacap0>, where each DSA
capability value is a 64-bit hexadecimal number, separated by commas.
The ordering follows the DSA 3.0 specification layout:
 Offset:    0x190    0x188    0x180
 Reg:       dsacap2  dsacap1  dsacap0

Example:
cat /sys/bus/dsa/devices/dsa0/dsacaps
 000000000000f18d,0014000e000007aa,00fa01ff01ff03ff

According to the DSA 3.0 specification, there are 15 fields defined for
the three dsacap registers. However, there's no need to define all
register structures unless a use case requires them. At this point,
support for the Scatter-Gather List (SGL) located in dsacap0 is necessary,
so only dsacap0 is defined accordingly.

For reference, the DSA 3.0 specification is available at:
Link: https://software.intel.com/content/www/us/en/develop/articles/intel-data-streaming-accelerator-architecture-specification.html

Signed-off-by: Yi Sun <yi.sun@intel.com>
Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 4a355e6747ae..bd281063d626 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -136,6 +136,21 @@ Description:	The last executed device administrative command's status/error.
 		Also last configuration error overloaded.
 		Writing to it will clear the status.
 
+What:		/sys/bus/dsa/devices/dsa<m>/dsacaps
+Date:		Oct 5, 2025
+KernelVersion:	6.17.0
+Contact:	dmaengine@vger.kernel.org
+Description:	The DSA3 specification introduces three new capability
+		registers: dsacap[0-2]. User components (e.g., configuration
+		libraries and workload applications) require this information
+		to properly utilize the DSA3 features.
+		This includes SGL capability support, Enabling hardware-specific
+		optimizations, Configuring memory, etc.
+		The output format is '<dsacap2>,<dsacap1>,<dsacap0>' where each
+		DSA cap value is a 64 bit hex value.
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
index 35bdefd3728b..084df60d407b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -582,6 +582,12 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	}
 	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
 
+	if (idxd->hw.version >= DEVICE_VERSION_3) {
+		idxd->hw.dsacap0.bits = ioread64(idxd->reg_base + IDXD_DSACAP0_OFFSET);
+		idxd->hw.dsacap1.bits = ioread64(idxd->reg_base + IDXD_DSACAP1_OFFSET);
+		idxd->hw.dsacap2.bits = ioread64(idxd->reg_base + IDXD_DSACAP2_OFFSET);
+	}
+
 	/* read iaa cap */
 	if (idxd->data->type == IDXD_TYPE_IAX && idxd->hw.version >= DEVICE_VERSION_2)
 		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 9c1c546fe443..439bbc311591 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -13,6 +13,7 @@
 
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
+#define DEVICE_VERSION_3		0x300
 
 #define IDXD_MMIO_BAR		0
 #define IDXD_WQ_BAR		2
@@ -582,6 +583,30 @@ union evl_status_reg {
 	u64 bits;
 };
 
+#define IDXD_DSACAP0_OFFSET		0x180
+union dsacap0_reg {
+	u64 bits;
+	struct {
+		u64 max_sgl_shift:4;
+		u64 max_gr_block_shift:4;
+		u64 ops_inter_domain:7;
+		u64 rsvd1:17;
+		u64 sgl_formats:16;
+		u64 max_sg_process:8;
+		u64 rsvd2:8;
+	};
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
index 9f0701021af0..cc2c83d7f710 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1713,6 +1713,18 @@ static ssize_t event_log_size_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(event_log_size);
 
+static ssize_t dsacaps_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct idxd_device *idxd = confdev_to_idxd(dev);
+
+	return sysfs_emit(buf, "%016llx,%016llx,%016llx\n",
+			  (u64)idxd->hw.dsacap2.bits,
+			  (u64)idxd->hw.dsacap1.bits,
+			  (u64)idxd->hw.dsacap0.bits);
+}
+static DEVICE_ATTR_RO(dsacaps);
+
 static bool idxd_device_attr_max_batch_size_invisible(struct attribute *attr,
 						      struct idxd_device *idxd)
 {
@@ -1750,6 +1762,14 @@ static bool idxd_device_attr_event_log_size_invisible(struct attribute *attr,
 		!idxd->hw.gen_cap.evl_support);
 }
 
+static bool idxd_device_attr_dsacaps_invisible(struct attribute *attr,
+					       struct idxd_device *idxd)
+{
+	return attr == &dev_attr_dsacaps.attr &&
+		(idxd->data->type != IDXD_TYPE_DSA ||
+		idxd->hw.version < DEVICE_VERSION_3);
+}
+
 static umode_t idxd_device_attr_visible(struct kobject *kobj,
 					struct attribute *attr, int n)
 {
@@ -1768,6 +1788,9 @@ static umode_t idxd_device_attr_visible(struct kobject *kobj,
 	if (idxd_device_attr_event_log_size_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_device_attr_dsacaps_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1795,6 +1818,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_cmd_status.attr,
 	&dev_attr_iaa_cap.attr,
 	&dev_attr_event_log_size.attr,
+	&dev_attr_dsacaps.attr,
 	NULL,
 };
 
-- 
2.43.0


