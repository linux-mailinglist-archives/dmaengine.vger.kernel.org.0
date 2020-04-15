Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F91AAD2E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415296AbgDOQNQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 12:13:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:9872 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415288AbgDOQNO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 12:13:14 -0400
IronPort-SDR: /EipKK6o23f8TcIjYVPWbigeuaCrC1yRhHMWycxiNPHFZMp10Lvhj9mIFH2frAqg5k2aS4T/a7
 BG5tDfsYei/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 09:13:13 -0700
IronPort-SDR: ShMBxlKbWD7VogdU1/1B+WDiyGxFue9UJuwcejsKequ7LZLxFo31iYgyFBQ7oRySIQMfjJKORy
 YKyF9JpvqE2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="427484020"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2020 09:13:12 -0700
Subject: [PATCH v2] dmaengine: idxd: export hw version through sysfs
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 15 Apr 2020 09:13:12 -0700
Message-ID: <158696714008.39484.13401950732606906479.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some user apps would like to know the hardware version in order to
determine the variation of the hardware. Export the hardware version number
to userspace via sysfs.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2: Add sysfs ABI documentation (Vinod)

 Documentation/ABI/stable/sysfs-driver-dma-idxd |    6 ++++++
 drivers/dma/idxd/sysfs.c                       |   11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 7c89bfa00477..a6e77a5fbb97 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -1,3 +1,9 @@
+What:		sys/bus/dsa/devices/dsa<m>/version
+Date:		Apr 15, 2020
+KernelVersion:	5.8.0
+Contact:	dmaengine@vger.kernel.org
+Description:	The hardware version number.
+
 What:           sys/bus/dsa/devices/dsa<m>/cdev_major
 Date:           Oct 25, 2019
 KernelVersion: 	5.6.0
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 5fb6b5cafb55..bd05a04d3aa3 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1377,6 +1377,16 @@ static const struct attribute_group *idxd_wq_attribute_groups[] = {
 };
 
 /* IDXD device attribs */
+static ssize_t version_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct idxd_device *idxd =
+		container_of(dev, struct idxd_device, conf_dev);
+
+	return sprintf(buf, "%#x\n", idxd->hw.version);
+}
+static DEVICE_ATTR_RO(version);
+
 static ssize_t max_work_queues_size_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1618,6 +1628,7 @@ static ssize_t cdev_major_show(struct device *dev,
 static DEVICE_ATTR_RO(cdev_major);
 
 static struct attribute *idxd_device_attributes[] = {
+	&dev_attr_version.attr,
 	&dev_attr_max_groups.attr,
 	&dev_attr_max_work_queues.attr,
 	&dev_attr_max_work_queues_size.attr,

