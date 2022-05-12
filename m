Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ABD524148
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 02:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349511AbiELAAr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 20:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiELAAq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 20:00:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644AB60F1
        for <dmaengine@vger.kernel.org>; Wed, 11 May 2022 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652313645; x=1683849645;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HWGwW9tUHyAv+BrzC6mDdNFhJanCgqOVLaCMOsuLTrM=;
  b=J12sq5/sLJkkmWvuW8nm0ksG/tmyh4jqU2yL7NhPZywPyifu7c8oLHVy
   MlD/JWJYM1I8uRdBPKFvna/gRaACuG2Bx/tY0ZwckhXR63+C2wRTToE3a
   Edci2JxQR7aSGJ00AzKTeoJceRiRp4YuYVkPEFRIdfDDUhiJciG4fTaMg
   b3toqNnzLIRKHjTTAIR2LHtLwxURona/F5VjzlKK10Ak8Aak6cgY3sYWx
   eVBb55dP8mQOiBWmAsRZ2YoVrJzNmGBRcEwUZm5cHYS/6xaIQuBMD9z4C
   gpCMOK1huHLhszgYSIlzt1wSYybAbW0qBgCJZ18odtBnwx6ExyEEj4q62
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="356268438"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="356268438"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:00:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="520722041"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:00:44 -0700
Subject: [PATCH] dmaengine: idxd: fix lockdep warning on device driver removal
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jacob Pan <jacob.jun.pan@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 11 May 2022 17:00:44 -0700
Message-ID: <165231364426.986304.9294302800482492780.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Jacob reported that with lockdep debug turned on, idxd_device_driver
removal causes kernel splat from lock assert warning for
idxd_device_wqs_clear_state(). Make sure
idxd_device_wqs_clear_state() holds the wq lock for each wq when
cleaning the wq state. Move the call outside of the device spinlock.

Reported-by: Jacob Pan <jacob.jun.pan@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 19a6cfaf4371..8d407d2bea4f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -578,19 +578,15 @@ int idxd_device_disable(struct idxd_device *idxd)
 		return -ENXIO;
 	}
 
-	spin_lock(&idxd->dev_lock);
 	idxd_device_clear_state(idxd);
-	idxd->state = IDXD_DEV_DISABLED;
-	spin_unlock(&idxd->dev_lock);
 	return 0;
 }
 
 void idxd_device_reset(struct idxd_device *idxd)
 {
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
-	spin_lock(&idxd->dev_lock);
 	idxd_device_clear_state(idxd);
-	idxd->state = IDXD_DEV_DISABLED;
+	spin_lock(&idxd->dev_lock);
 	idxd_unmask_error_interrupts(idxd);
 	spin_unlock(&idxd->dev_lock);
 }
@@ -717,23 +713,27 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 {
 	int i;
 
-	lockdep_assert_held(&idxd->dev_lock);
 	for (i = 0; i < idxd->max_wqs; i++) {
 		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (wq->state == IDXD_WQ_ENABLED) {
+			mutex_lock(&wq->wq_lock);
 			idxd_wq_disable_cleanup(wq);
 			idxd_wq_device_reset_cleanup(wq);
 			wq->state = IDXD_WQ_DISABLED;
+			mutex_unlock(&wq->wq_lock);
 		}
 	}
 }
 
 void idxd_device_clear_state(struct idxd_device *idxd)
 {
+	idxd_device_wqs_clear_state(idxd);
+	spin_lock(&idxd->dev_lock);
 	idxd_groups_clear_state(idxd);
 	idxd_engines_clear_state(idxd);
-	idxd_device_wqs_clear_state(idxd);
+	idxd->state = IDXD_DEV_DISABLED;
+	spin_unlock(&idxd->dev_lock);
 }
 
 static void idxd_group_config_write(struct idxd_group *group)


