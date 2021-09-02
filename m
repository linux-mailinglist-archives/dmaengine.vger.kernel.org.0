Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0EA3FE682
	for <lists+dmaengine@lfdr.de>; Thu,  2 Sep 2021 02:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbhIBATE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Sep 2021 20:19:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:14054 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239574AbhIBATD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 1 Sep 2021 20:19:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="279919673"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="279919673"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 17:18:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="428895349"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 17:18:05 -0700
Subject: [PATCH] dmaengine: idxd: reconfig device after device reset command
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 01 Sep 2021 17:18:05 -0700
Message-ID: <163054188513.2853562.12077053294595278181.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Device reset clears the MSIXPERM table and the device registers. Re-program
the MSIXPERM table and re-enable the error interrupts post reset.

Fixes: 745e92a6d816 ("dmaengine: idxd: idxd: move remove() bits for idxd 'struct device' to device.c")
Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 83a5ff2ecf2a..39acb018664f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -584,6 +584,8 @@ void idxd_device_reset(struct idxd_device *idxd)
 	spin_lock(&idxd->dev_lock);
 	idxd_device_clear_state(idxd);
 	idxd->state = IDXD_DEV_DISABLED;
+	idxd_unmask_error_interrupts(idxd);
+	idxd_msix_perm_setup(idxd);
 	spin_unlock(&idxd->dev_lock);
 }
 


