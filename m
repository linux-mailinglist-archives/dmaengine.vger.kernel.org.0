Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3334531A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhCVXhe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:37:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:57865 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230327AbhCVXha (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:37:30 -0400
IronPort-SDR: 7fenzAiQq03QtdjOGwl5W73vn5WZLlxcUrkvYsYwM95Qoc8HarxY1qozGIbWDIr00ZM41X6nSM
 9yflkVKivpyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188050320"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="188050320"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:37:30 -0700
IronPort-SDR: hVHmb7fba/meFZsc1V0Qftp4fA2vaE6ikyfXVWgzQL0gnr+ahn4s6mEmbStrUWklzYuwgPvWEU
 d0SnyKTYiv9Q==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="442316295"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:37:29 -0700
Subject: [PATCH] dmaengine: idxd: fix opcap sysfs attribute output
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Lucas Van <lucas.van@intel.com>, dmaengine@vger.kernel.org
Date:   Mon, 22 Mar 2021 16:37:29 -0700
Message-ID: <161645624963.2003736.829798666998490151.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The operation capability register is 256bits. The current output only
prints out the first 64bits. Fix to output the entire 256bits. The current
code omits operation caps from IAX devices.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Reported-by: Lucas Van <lucas.van@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index e018d2339ccd..9cc7ad939307 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1427,8 +1427,14 @@ static ssize_t op_cap_show(struct device *dev,
 {
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
+	int i, rc = 0;
+
+	for (i = 0; i < 4; i++)
+		rc += sysfs_emit_at(buf, rc, "%#llx ", idxd->hw.opcap.bits[i]);
 
-	return sprintf(buf, "%#llx\n", idxd->hw.opcap.bits[0]);
+	rc--;
+	rc += sysfs_emit_at(buf, rc, "\n");
+	return rc;
 }
 static DEVICE_ATTR_RO(op_cap);
 


