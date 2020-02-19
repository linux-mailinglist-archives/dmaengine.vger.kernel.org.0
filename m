Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCA6164BD5
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2020 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSRY5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 12:24:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:15331 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSRY5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Feb 2020 12:24:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 09:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; 
   d="scan'208";a="235956435"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003.jf.intel.com with ESMTP; 19 Feb 2020 09:24:56 -0800
Subject: [PATCH] dmaengine: idxd: wq size configuration needs to check
 global max size
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, jerry.t.chen@intel.com
Date:   Wed, 19 Feb 2020 10:24:56 -0700
Message-ID: <158213309629.2509.3583411832507185041.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current size_store() function for idxd sysfs does not check the total
wq size. This allows configuration of all wqs with total wq size. Add check
to make sure the wq sysfs attribute rejects storing of size over the total
wq size.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Reported-by: Jerry Chen <jerry.t.chen@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index b4a7885e79ed..6ca6e520a2fa 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -904,6 +904,20 @@ static ssize_t wq_size_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", wq->size);
 }
 
+static int total_claimed_wq_size(struct idxd_device *idxd)
+{
+	int i;
+	int wq_size = 0;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		wq_size += wq->size;
+	}
+
+	return wq_size;
+}
+
 static ssize_t wq_size_store(struct device *dev,
 			     struct device_attribute *attr, const char *buf,
 			     size_t count)
@@ -923,7 +937,7 @@ static ssize_t wq_size_store(struct device *dev,
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 
-	if (size > idxd->max_wq_size)
+	if (size + total_claimed_wq_size(idxd) - wq->size > idxd->max_wq_size)
 		return -EINVAL;
 
 	wq->size = size;

