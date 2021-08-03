Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45953DF7D8
	for <lists+dmaengine@lfdr.de>; Wed,  4 Aug 2021 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhHCWcY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Aug 2021 18:32:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:58881 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhHCWcT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Aug 2021 18:32:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="235749587"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="235749587"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 15:32:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="670691590"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 15:32:06 -0700
Subject: [PATCH] dmaengine: idxd: add capability check for 'block on fault'
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 03 Aug 2021 15:32:06 -0700
Message-ID: <162802992615.3084999.12539468940404102898.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The device general capability has a bit that indicate whether 'block on
fault' is supported. Add check to wq sysfs knob to check if cap exists
before allowing user to toggle.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 4c01587c9d4a..a88886d0f27b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -642,6 +642,9 @@ static ssize_t wq_block_on_fault_store(struct device *dev,
 	bool bof;
 	int rc;
 
+	if (!idxd->hw.gen_cap.block_on_fault)
+		return -EOPNOTSUPP;
+
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		return -EPERM;
 


