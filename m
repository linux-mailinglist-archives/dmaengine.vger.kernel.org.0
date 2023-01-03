Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D5765C44C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjACQyD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjACQxy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:53:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E9A1A4;
        Tue,  3 Jan 2023 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672764833; x=1704300833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ViB6/yD80AcwdRZIzZyoeNUKUtdaAjrqYFetGoEMJ6U=;
  b=l6f6UfTajmbWF5CYG3D9CUQn991MwuwW3yk3G4xGwBPYUxDFnrGEnUTF
   /hvE2RRVkSk7UKfQhThFlgfM4UyksEb09RlwaeW+4JDDw5PQxMTmCzPHB
   mWlk8F7Mfxmu0q6ZS92dkdm81DWUeuVN/Lafub86B3xrunTFDCrYZxvI1
   p/q/xgDgt7aMFs90AqcceXRwB2CZ0C2Rj+wyw2R41oUljhqvesZ7dQmzb
   +tjxi9jhCtBnJrqWiA+xX3faxBcnPhNpNcuDw8zOv6qGH7fvTda6rHE4o
   pT1vZH+VxOj0C3GFO4uIqLCH1eINDFFdbvXfbW7oWrPDO2fkiTifxFFJ/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="322932870"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="322932870"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:53:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="828896816"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="828896816"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2023 08:53:51 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dmaengine: idxd: expose IAA CAP register via sysfs knob
Date:   Tue,  3 Jan 2023 08:53:37 -0800
Message-Id: <20230103165337.1570238-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103165337.1570238-1-fenghua.yu@intel.com>
References: <20230103165337.1570238-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add IAA (IAX) capability mask sysfs attribute to expose to applications.
The mask provides application knowledge of what capabilities this IAA
device supports. This mask is available for IAA 2.0 device or later.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
This patch is applied cleanly on top of DSA 2.0 Event Log and Completion
Record Faulting series: 
https://lore.kernel.org/dmaengine/20230103163505.1569356-1-fenghua.yu@intel.com/T/#m13ba6167994f3add6446d2d7e242ecb637c54426

 .../ABI/stable/sysfs-driver-dma-idxd          |  8 +++++++
 drivers/dma/idxd/idxd.h                       |  1 +
 drivers/dma/idxd/init.c                       |  4 ++++
 drivers/dma/idxd/registers.h                  | 21 ++++++++++++++++
 drivers/dma/idxd/sysfs.c                      | 24 +++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 603869112887..796a5dccdf04 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -144,6 +144,14 @@ Description:	The event log size to be configured. Default is 64 entries and
 		occupies 4k size if the evl entry is 64 bytes. It's visible
 		only on platforms that support the capability.
 
+What:		/sys/bus/dsa/devices/dsa<m>/iaa_cap
+Date:		Sept 14, 2022
+KernelVersion: 6.0.0
+Contact:	dmaengine@vger.kernel.org
+Description:	IAA (IAX) capability mask. Exported to user space for application
+		consumption. This attribute should only be visible on IAA devices
+		that are version 2 or later.
+
 What:		/sys/bus/dsa/devices/wq<m>.<n>/block_on_fault
 Date:		Oct 27, 2020
 KernelVersion:	5.11.0
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index e449d905bea3..3a20e4933d07 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -245,6 +245,7 @@ struct idxd_hw {
 	union engine_cap_reg engine_cap;
 	struct opcap opcap;
 	u32 cmd_cap;
+	union iaa_cap_reg iaa_cap;
 };
 
 enum idxd_device_state {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 996bd3e4e50f..6c1d1682fce9 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -497,6 +497,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		dev_dbg(dev, "opcap[%d]: %#llx\n", i, idxd->hw.opcap.bits[i]);
 	}
 	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
+
+	/* read iaa cap */
+	if (idxd->data->type == IDXD_TYPE_IAX && idxd->hw.version >= DEVICE_VERSION_2)
+		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
 }
 
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 6155dc7d2152..6de810d2d2d8 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -302,6 +302,27 @@ union evlcfg_reg {
 #define IDXD_EVL_SIZE_MIN	0x0040
 #define IDXD_EVL_SIZE_MAX	0xffff
 
+union iaa_cap_reg {
+	struct {
+		u64 dec_aecs_format_ver:1;
+		u64 drop_init_bits:1;
+		u64 chaining:1;
+		u64 force_array_output_mod:1;
+		u64 load_part_aecs:1;
+		u64 comp_early_abort:1;
+		u64 nested_comp:1;
+		u64 diction_comp:1;
+		u64 header_gen:1;
+		u64 crypto_gcm:1;
+		u64 crypto_cfb:1;
+		u64 crypto_xts:1;
+		u64 rsvd:52;
+	};
+	u64 bits;
+} __packed;
+
+#define IDXD_IAACAP_OFFSET	0x180
+
 union msix_perm {
 	struct {
 		u32 rsvd:2;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index dae28509e6ed..80a81d441252 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1656,6 +1656,18 @@ static ssize_t event_log_size_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(event_log_size);
 
+static ssize_t iaa_cap_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct idxd_device *idxd = confdev_to_idxd(dev);
+
+	if (idxd->hw.version < DEVICE_VERSION_2)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%#llx\n", idxd->hw.iaa_cap.bits);
+}
+static DEVICE_ATTR_RO(iaa_cap);
+
 static bool idxd_device_attr_max_batch_size_invisible(struct attribute *attr,
 						      struct idxd_device *idxd)
 {
@@ -1685,6 +1697,14 @@ static bool idxd_device_attr_event_log_size_invisible(struct attribute *attr,
 		!idxd->hw.gen_cap.evl_support);
 }
 
+static bool idxd_device_attr_iaa_cap_invisible(struct attribute *attr,
+					       struct idxd_device *idxd)
+{
+	return attr == &dev_attr_iaa_cap.attr &&
+	       (idxd->data->type != IDXD_TYPE_IAX ||
+	       idxd->hw.version < DEVICE_VERSION_2);
+}
+
 static umode_t idxd_device_attr_visible(struct kobject *kobj,
 					struct attribute *attr, int n)
 {
@@ -1700,6 +1720,9 @@ static umode_t idxd_device_attr_visible(struct kobject *kobj,
 	if (idxd_device_attr_event_log_size_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_device_attr_iaa_cap_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1726,6 +1749,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_cdev_major.attr,
 	&dev_attr_cmd_status.attr,
 	&dev_attr_event_log_size.attr,
+	&dev_attr_iaa_cap.attr,
 	NULL,
 };
 
-- 
2.32.0

