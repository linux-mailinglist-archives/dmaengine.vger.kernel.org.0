Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A30300BC6
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jan 2021 19:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbhAVSrt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Jan 2021 13:47:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:36417 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbhAVSqb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Jan 2021 13:46:31 -0500
IronPort-SDR: BdDxAmv+TokbaY4XeaTTD1S9mS3f+tgWc3kl/7z0Wo85+C4zIRxT0O2tX3Q5+hk3l9GnyCOd7Q
 ybR2RdjqPZrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="198247902"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="198247902"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 10:46:01 -0800
IronPort-SDR: 64oQ/PcPHBMcW52W1oDFFH+TCHYd8YWFJsNS2x5beBSZFH2qNU1Wusa6w6pAaGkJVtEsBqrLks
 QDBHrLIS9hgA==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="503134559"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 10:46:00 -0800
Subject: [PATCH v2] dmaengine: idxd: add module parameter to force disable of
 SVA
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:46:00 -0700
Message-ID: <161134110457.4005461.13171197785259115852.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a module parameter that overrides the SVA feature enabling. This keeps
the driver in legacy mode even when intel_iommu=sm_on is set. In this mode,
the descriptor fields must be programmed with dma_addr_t from the Linux DMA
API for source, destination, and completion descriptors.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2: 
- Add documentation (Vinod)

 Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
 drivers/dma/idxd/init.c                         |    8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec19cd00..c25786b95419 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1673,6 +1673,12 @@
 			In such case C2/C3 won't be used again.
 			idle=nomwait: Disable mwait for CPU C-states
 
+	idxd.sva=	[HW]
+			Format: <bool>
+			Allow force disabling of Shared Virtual Memory (SVA)
+			support for the idxd driver. By default it is set to
+			true (1).
+
 	ieee754=	[MIPS] Select IEEE Std 754 conformance mode
 			Format: { strict | legacy | 2008 | relaxed }
 			Default: strict
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 25cc947c6179..9687a24ff982 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -26,6 +26,10 @@ MODULE_VERSION(IDXD_DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
 
+static bool sva = true;
+module_param(sva, bool, 0644);
+MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
+
 #define DRV_NAME "idxd"
 
 bool support_enqcmd;
@@ -338,12 +342,14 @@ static int idxd_probe(struct idxd_device *idxd)
 	idxd_device_init_reset(idxd);
 	dev_dbg(dev, "IDXD reset complete\n");
 
-	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM)) {
+	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
 		rc = idxd_enable_system_pasid(idxd);
 		if (rc < 0)
 			dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
 		else
 			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+	} else if (!sva) {
+		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
 
 	idxd_read_caps(idxd);


