Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528AB164BD4
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2020 18:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBSRYJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 12:24:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:17721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSRYJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Feb 2020 12:24:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 09:24:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; 
   d="scan'208";a="254164359"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002.jf.intel.com with ESMTP; 19 Feb 2020 09:24:08 -0800
Subject: [PATCH] dmaengine: idxd: sysfs input of wq incorrect wq type should
 return error
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, jerry.t.chen@intel.com,
        yixin.zhang@intel.com
Date:   Wed, 19 Feb 2020 10:24:08 -0700
Message-ID: <158213304803.2290.13336343633425868211.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently when inputing an unrecognized wq type, we set the wq type to
"none". It really should return error and not change the existing wq type
that's in the kernel.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Reported-by: Yixin Zhang <yixin.zhang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index edbfe83325eb..b4a7885e79ed 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1002,12 +1002,14 @@ static ssize_t wq_type_store(struct device *dev,
 		return -EPERM;
 
 	old_type = wq->type;
-	if (sysfs_streq(buf, idxd_wq_type_names[IDXD_WQT_KERNEL]))
+	if (sysfs_streq(buf, idxd_wq_type_names[IDXD_WQT_NONE]))
+		wq->type = IDXD_WQT_NONE;
+	else if (sysfs_streq(buf, idxd_wq_type_names[IDXD_WQT_KERNEL]))
 		wq->type = IDXD_WQT_KERNEL;
 	else if (sysfs_streq(buf, idxd_wq_type_names[IDXD_WQT_USER]))
 		wq->type = IDXD_WQT_USER;
 	else
-		wq->type = IDXD_WQT_NONE;
+		return -EINVAL;
 
 	/* If we are changing queue type, clear the name */
 	if (wq->type != old_type)

