Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8C6AA16C
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjCCVhs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjCCVhr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:37:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9B662D8C;
        Fri,  3 Mar 2023 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879466; x=1709415466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3uMSc7vnp0UG11z9FHv+RYvjjoY2I0CYOVB3hSp2Oo=;
  b=EsqhW2kvNUcA8f0D3uN1tuSLUfA4/RLCLOftrCHzbD5Spxq8lH08gXv2
   v/MlpP5SqPcEyVWnhsmOlQyMO4FH/U3Bq4NagVLzLg7rrNVQvPwH8Rf0H
   zGR+ohy2N4Vag/sLmdGrJNHKqwU9/+Z0zBKvjSMPkgrNJr38p6/q3txqg
   5bzh4YDigZUO5cqpn4lPJADwKaXstnvWNr5tm4xETg4/bPjfgG+4cjI1L
   PkXrxCWJpHx2ML5IOzCcWsh55PM2aOdl8Dijokxy3bu0Tu706KsSi9lfa
   Sszr+mRaggBdlyqpaeank2wjUNLkecFecKCU6CR86InHLfa97HSGuELEo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="332643553"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="332643553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:37:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="818650495"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="818650495"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2023 13:37:45 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 2/2] dmaengine: idxd: expose IAA CAP register via sysfs knob
Date:   Fri,  3 Mar 2023 13:37:32 -0800
Message-Id: <20230303213732.3357494-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230303213732.3357494-1-fenghua.yu@intel.com>
References: <20230303213732.3357494-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 .../ABI/stable/sysfs-driver-dma-idxd          |  8 +++++++
 drivers/dma/idxd/idxd.h                       |  1 +
 drivers/dma/idxd/init.c                       |  4 ++++
 drivers/dma/idxd/registers.h                  | 21 ++++++++++++++++
 drivers/dma/idxd/sysfs.c                      | 24 +++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 3becc9a82bdf..d5e3dd3d8434 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -136,6 +136,14 @@ Description:	The last executed device administrative command's status/error.
 		Also last configuration error overloaded.
 		Writing to it will clear the status.
 
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
index ad7a1e8a0e1c..eca2c9d76db6 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -232,6 +232,7 @@ struct idxd_hw {
 	union engine_cap_reg engine_cap;
 	struct opcap opcap;
 	u32 cmd_cap;
+	union iaa_cap_reg iaa_cap;
 };
 
 enum idxd_device_state {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 68d1c7fc9112..a408fc91144d 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -461,6 +461,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
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
index fe3b8d04f9db..338289a66f00 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -276,6 +276,27 @@ union sw_err_reg {
 	u64 bits[4];
 } __packed;
 
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
index 927c9d645121..2eba8cab25a1 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1561,6 +1561,18 @@ static ssize_t cmd_status_store(struct device *dev, struct device_attribute *att
 }
 static DEVICE_ATTR_RW(cmd_status);
 
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
@@ -1583,6 +1595,14 @@ static bool idxd_device_attr_read_buffers_invisible(struct attribute *attr,
 		idxd->data->type == IDXD_TYPE_IAX;
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
@@ -1595,6 +1615,9 @@ static umode_t idxd_device_attr_visible(struct kobject *kobj,
 	if (idxd_device_attr_read_buffers_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_device_attr_iaa_cap_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1620,6 +1643,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_read_buffer_limit.attr,
 	&dev_attr_cdev_major.attr,
 	&dev_attr_cmd_status.attr,
+	&dev_attr_iaa_cap.attr,
 	NULL,
 };
 
-- 
2.37.1

