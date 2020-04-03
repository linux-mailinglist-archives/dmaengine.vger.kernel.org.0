Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE2219DFDD
	for <lists+dmaengine@lfdr.de>; Fri,  3 Apr 2020 22:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgDCUwe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Apr 2020 16:52:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:20939 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgDCUwe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Apr 2020 16:52:34 -0400
IronPort-SDR: tf3yChL7cL3qI4AzhxLotE77oMW5nkvne54ty9XEOvgHn17manvWIS6cbzsH/1qAv71+PB8f8y
 +jDq8XBRG3Qg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 13:52:33 -0700
IronPort-SDR: Lcf5reOZXadEAUeU/aldxBtEK+AQfHogBb8Zz3rLcFZRN8fHlyXIitVnwN8FEGFdT2NwvRcr+a
 3kBCrPcsF3HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,341,1580803200"; 
   d="scan'208";a="274078281"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2020 13:52:33 -0700
Subject: [PATCH] dmaengine: idxd: export hw version through sysfs
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 03 Apr 2020 13:52:33 -0700
Message-ID: <158594715310.27813.14140257595400126459.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/sysfs.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

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

