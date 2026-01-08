Return-Path: <dmaengine+bounces-8097-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F1D00709
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 01:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF41C3023D3B
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 00:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA81CD2C;
	Thu,  8 Jan 2026 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzKptKNQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A1469D;
	Thu,  8 Jan 2026 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767830586; cv=none; b=rRSBwsPB3wd4uBvmwbWZj03KI6+7LRODAgBv4N/l7DQ4npB9VAin/TsoyVKXbjXDP3V1E4zMI03xhH8mtQWlL0yRPxDI65weXnqgCbNV6RayDbZrQg5S7c3CfVxrgUVri+Rfbgjv5frsgzEvh8adgTPiw/TlM8LBq/nCY/i/omw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767830586; c=relaxed/simple;
	bh=Bop3zpkorMkLEa3rPejwVhYu9CpvRTGItMYtNXIFDkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nf5+ZvmBsJBMrYU5ZMycFiZc4dkijLryGL4g03ZG3TjZWY9T+feln7xoSw73X39gigR8281Jhw5P2uQ5FaeZkZeshd300YgQyKs5PwaZVLWG8IRvb9ughSSCYDA3h1LFn+Poyhj09UVaFi4lg2jbu3oMU9VD+7FhiIXSZHDM0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzKptKNQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767830584; x=1799366584;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Bop3zpkorMkLEa3rPejwVhYu9CpvRTGItMYtNXIFDkk=;
  b=lzKptKNQVWHN83H+i5gkCLAwLcf2qWwbfWvyZ9ubt0BWMI31zCUuoMQM
   8ZhEcwxQ2r05hyPC7zLsYDp0oarcT145aa+6AmchNzPQ6fgETRZfwNhEn
   qt+uFrFEYj7i3Wy5zR6o3u/x+2zcmNBU7IU79orxtVPt5V2dSakQbdE8t
   Zubrwgs/U2TBk7JBFHl7sate8bCEsrs3/atxLGNAyYdQNSZK42Wp8j2SR
   YLAvTqdiPrp2BxZh/F072ks26bn/M/jvejGkeachMfCOSP4W1665Va93D
   JfRO1Yng4Ask884JW6tdq9EWAe7oL/KphIxHZ3Zm2ORdQrjMfiEzpBH0S
   w==;
X-CSE-ConnectionGUID: 1X1XDxilSWqQjOXLhBIWRA==
X-CSE-MsgGUID: tcxRrTg2TO23fZIfYyF8DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="68214635"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="68214635"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 16:03:01 -0800
X-CSE-ConnectionGUID: aQtYZUSmTBe79VgVIpfhCw==
X-CSE-MsgGUID: 2ixshudmSjWmot1Qka1FPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="203074580"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 16:03:01 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 07 Jan 2026 16:02:22 -0800
Subject: [PATCH RESEND v2 1/2] dmaengine: idxd: Expose DSA3.0 capabilities
 through sysfs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-1-dbef8f559e48@intel.com>
References: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-0-dbef8f559e48@intel.com>
In-Reply-To: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-0-dbef8f559e48@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Yi Sun <yi.sun@intel.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 Yi Lai <yi1.lai@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767830580; l=7284;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=X3/DM835J8N+Dt8QtaSm7nps284B0jwq7UC0laCdVlo=;
 b=rj3XGbTMy7oief0sVuGDsPs4YxGbWM3POBdyZuBi+egXnJOWIXN9VGBo/HASZKP4biAmXF1uf
 9cQwO4AI5gXDLSG7GXcgtjH0PrQOP/VgKVbptWoax8PwEc+786Juo25
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

From: Yi Sun <yi.sun@intel.com>

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
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd | 15 +++++++++++++++
 drivers/dma/idxd/idxd.h                        |  3 +++
 drivers/dma/idxd/init.c                        |  6 ++++++
 drivers/dma/idxd/registers.h                   | 25 +++++++++++++++++++++++++
 drivers/dma/idxd/sysfs.c                       | 24 ++++++++++++++++++++++++
 5 files changed, 73 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 4a355e6747ae..08d030159f09 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -136,6 +136,21 @@ Description:	The last executed device administrative command's status/error.
 		Also last configuration error overloaded.
 		Writing to it will clear the status.
 
+What:		/sys/bus/dsa/devices/dsa<m>/dsacaps
+Date:		April 5, 2026
+KernelVersion:	6.20.0
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
index 2acc34b3daff..2bdd1b34d50a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -585,6 +585,12 @@ static void idxd_read_caps(struct idxd_device *idxd)
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
index 8dc2e8bca779..85e83a61a50b 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -18,6 +18,7 @@
 
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
+#define DEVICE_VERSION_3		0x300
 
 #define IDXD_MMIO_BAR		0
 #define IDXD_WQ_BAR		2
@@ -587,6 +588,30 @@ union evl_status_reg {
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
2.52.0


