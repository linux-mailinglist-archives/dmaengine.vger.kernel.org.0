Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D933216AE49
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2020 19:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgBXSBf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Feb 2020 13:01:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:64192 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBXSBf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Feb 2020 13:01:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 10:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="241075661"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006.jf.intel.com with ESMTP; 24 Feb 2020 10:01:34 -0800
Subject: [PATCH] dmaengine: idxd: expose general capabilities register in
 sysfs
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 24 Feb 2020 11:01:34 -0700
Message-ID: <158256729399.55526.10842505054968710547.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are some capabilities for the device that are interesting to user
apps that are interacting directly with the device. Expose gencap register
in sysfs to allow that information.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6ca6e520a2fa..193290a0ff76 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1180,6 +1180,16 @@ static ssize_t op_cap_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(op_cap);
 
+static ssize_t gen_cap_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct idxd_device *idxd =
+		container_of(dev, struct idxd_device, conf_dev);
+
+	return sprintf(buf, "%#llx\n", idxd->hw.gen_cap.bits);
+}
+static DEVICE_ATTR_RO(gen_cap);
+
 static ssize_t configurable_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -1317,6 +1327,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_max_batch_size.attr,
 	&dev_attr_max_transfer_size.attr,
 	&dev_attr_op_cap.attr,
+	&dev_attr_gen_cap.attr,
 	&dev_attr_configurable.attr,
 	&dev_attr_clients.attr,
 	&dev_attr_state.attr,

