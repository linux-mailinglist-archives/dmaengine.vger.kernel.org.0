Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34944CDFB0
	for <lists+dmaengine@lfdr.de>; Fri,  4 Mar 2022 22:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiCDVWu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Mar 2022 16:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCDVWt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Mar 2022 16:22:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184721176
        for <dmaengine@vger.kernel.org>; Fri,  4 Mar 2022 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646428921; x=1677964921;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mTBoJ1hHI3WuSg/m0MwBX8WvroCrzqYYQeMmHWbFil8=;
  b=Z3KXENWS59w84QQ3DFMzPZr1nxO4Gb4Q9h9Sx5OFZzhtQ2ETSw7opb+r
   gBkrM5gCxNtwh21iy+il6p1vckUxz2zKeVATKi15hpGwmoKU79PjJC0aX
   9OD/RugKJTM/HABVr/AvNJCGkrLC7HV3mC5yXeryymPsRwWOHs4Dhi2OK
   CiMbDKUgfykvqeXhWcIhzS8Y2IOzAK+OGXSeNsMF02obSYUvk7avFPxae
   f6ZB3yk4vrFRl0sckWPaSgoTB3gSU1pmWhe/xgyUxNFhQrODM3R7M2/HW
   q2jHX2UPiAtgmI00if8GRklnJ/vWMG4HXNJasebnQSFoukyjqrtTIbea/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="234673209"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="234673209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:22:00 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552373289"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:22:00 -0800
Subject: [PATCH] dmaengine: idxd: don't load pasid config until needed
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 04 Mar 2022 14:21:59 -0700
Message-ID: <164642891995.190921.7082046343492065429.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver currently programs the system pasid to the WQ preemptively when
system pasid is enabled. Given that a dwq will reprogram the pasid and
possibly a different pasid, the programming is not necessary. The pasid_en
bit can be set for swq as it does not need pasid pasid programming but
needs the pasid_en bit. Remove system pasid programming on device config
write. Add pasid programming for kernel wq type on wq driver enable. The
char dev driver already reprograms the dwq on ->open() call so there's no
change.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c    |   46 ++++++++++++++++++++++++++++++++++--------
 drivers/dma/idxd/registers.h |    1 +
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 573ad8b86804..b2aaf4b64a8b 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -299,16 +299,25 @@ void idxd_wqs_unmap_portal(struct idxd_device *idxd)
 	}
 }
 
-int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
+static void __idxd_wq_set_priv_locked(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
-	int rc;
 	union wqcfg wqcfg;
 	unsigned int offset;
 
-	rc = idxd_wq_disable(wq, false);
-	if (rc < 0)
-		return rc;
+	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PRIVL_IDX);
+	spin_lock(&idxd->dev_lock);
+	wqcfg.bits[WQCFG_PRIVL_IDX] = ioread32(idxd->reg_base + offset);
+	wqcfg.priv = 1;
+	iowrite32(wqcfg.bits[WQCFG_PRIVL_IDX], idxd->reg_base + offset);
+	spin_unlock(&idxd->dev_lock);
+}
+
+static void __idxd_wq_set_pasid_locked(struct idxd_wq *wq, int pasid)
+{
+	struct idxd_device *idxd = wq->idxd;
+	union wqcfg wqcfg;
+	unsigned int offset;
 
 	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PASID_IDX);
 	spin_lock(&idxd->dev_lock);
@@ -317,6 +326,17 @@ int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
 	wqcfg.pasid = pasid;
 	iowrite32(wqcfg.bits[WQCFG_PASID_IDX], idxd->reg_base + offset);
 	spin_unlock(&idxd->dev_lock);
+}
+
+int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
+{
+	int rc;
+
+	rc = idxd_wq_disable(wq, false);
+	if (rc < 0)
+		return rc;
+
+	__idxd_wq_set_pasid_locked(wq, pasid);
 
 	rc = idxd_wq_enable(wq);
 	if (rc < 0)
@@ -808,11 +828,13 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	if (wq_dedicated(wq))
 		wq->wqcfg->mode = 1;
 
-	if (device_pasid_enabled(idxd)) {
+	/*
+	 * Enable this for shared WQ. swq does not need to program the pasid field,
+	 * but pasid_en needs to be set. Programming here prevents swq needing to
+	 * be disabled and re-enabled for reprogramming, which is something to avoid.
+	 */
+	if (device_pasid_enabled(idxd))
 		wq->wqcfg->pasid_en = 1;
-		if (wq->type == IDXD_WQT_KERNEL && wq_dedicated(wq))
-			wq->wqcfg->pasid = idxd->pasid;
-	}
 
 	/*
 	 * Here the priv bit is set depending on the WQ type. priv = 1 if the
@@ -1258,6 +1280,12 @@ int __drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
+	if (is_idxd_wq_kernel(wq)) {
+		if (device_pasid_enabled(idxd) && wq_dedicated(wq))
+			__idxd_wq_set_pasid_locked(wq, idxd->pasid);
+		__idxd_wq_set_priv_locked(wq);
+	}
+
 	rc = 0;
 	spin_lock(&idxd->dev_lock);
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index aa642aecdc0b..02449aa9c454 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -353,6 +353,7 @@ union wqcfg {
 } __packed;
 
 #define WQCFG_PASID_IDX                2
+#define WQCFG_PRIVL_IDX		2
 #define WQCFG_OCCUP_IDX		6
 
 #define WQCFG_OCCUP_MASK	0xffff


