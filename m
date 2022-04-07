Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4938C4F8713
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiDGSac (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDGSab (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 14:30:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE226A43C
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649356109; x=1680892109;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ksw72prUC07xs17TzJrQy+Lc3IH/xB+Yc60WVhfe6KA=;
  b=LihrJaRDisZECQS2KyEg9YPLnuQC2J2daPowqjZM7Uc6RaIYQboaxqg5
   x5WvRWpRuDvRGiOTMffPnNe+5P19lCwsoNv/srlZuS254f0Iiya6PRgLH
   jGht4Lu/f8bUfh3un/Hun7Vf0YUXX3SagZNjXLjohxfngJOHUvLVFnvH/
   XZfic76UIqLrGg5Gva5uY47WMtVWFExzJmrEec/O67BtTkPl60oiy8hOL
   J8pTZK2cjBB90H1kfT0n0NnA7qBxaI2RHyqTZR+N43UiuQzpsiXCD+e4C
   NMNPAgNzR84BUMzBIxZfKDDJqJbD66zJ9IYJktnGyBF9Z4X/gS4t6Momh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="347850144"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="347850144"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 11:28:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571178119"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 11:28:28 -0700
Subject: [PATCH v2] dmaengine: idxd: don't load pasid config until needed
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 07 Apr 2022 11:28:28 -0700
Message-ID: <164935607115.1660372.6734518676950372366.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

v2:
- Make sure priv bit is explicitly set when programming WQCFG.

 drivers/dma/idxd/device.c    |   66 +++++++++++++++++++++++++++++++++---------
 drivers/dma/idxd/registers.h |    1 +
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 3061fe857d69..2903f8bb30e1 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -299,24 +299,46 @@ void idxd_wqs_unmap_portal(struct idxd_device *idxd)
 	}
 }
 
-int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
+static void __idxd_wq_set_priv_locked(struct idxd_wq *wq, int priv)
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
+	wqcfg.priv = priv;
+	wq->wqcfg->bits[WQCFG_PRIVL_IDX] = wqcfg.bits[WQCFG_PRIVL_IDX];
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
 	wqcfg.bits[WQCFG_PASID_IDX] = ioread32(idxd->reg_base + offset);
 	wqcfg.pasid_en = 1;
 	wqcfg.pasid = pasid;
+	wq->wqcfg->bits[WQCFG_PASID_IDX] = wqcfg.bits[WQCFG_PASID_IDX];
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
@@ -797,7 +819,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	 */
 	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
 		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
-		wq->wqcfg->bits[i] = ioread32(idxd->reg_base + wq_offset);
+		wq->wqcfg->bits[i] |= ioread32(idxd->reg_base + wq_offset);
 	}
 
 	if (wq->size == 0 && wq->type != IDXD_WQT_NONE)
@@ -813,14 +835,8 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	if (wq_dedicated(wq))
 		wq->wqcfg->mode = 1;
 
-	if (device_pasid_enabled(idxd)) {
-		wq->wqcfg->pasid_en = 1;
-		if (wq->type == IDXD_WQT_KERNEL && wq_dedicated(wq))
-			wq->wqcfg->pasid = idxd->pasid;
-	}
-
 	/*
-	 * Here the priv bit is set depending on the WQ type. priv = 1 if the
+	 * The WQ priv bit is set depending on the WQ type. priv = 1 if the
 	 * WQ type is kernel to indicate privileged access. This setting only
 	 * matters for dedicated WQ. According to the DSA spec:
 	 * If the WQ is in dedicated mode, WQ PASID Enable is 1, and the
@@ -830,7 +846,6 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	 * In the case of a dedicated kernel WQ that is not able to support
 	 * the PASID cap, then the configuration will be rejected.
 	 */
-	wq->wqcfg->priv = !!(wq->type == IDXD_WQT_KERNEL);
 	if (wq_dedicated(wq) && wq->wqcfg->pasid_en &&
 	    !idxd_device_pasid_priv_enabled(idxd) &&
 	    wq->type == IDXD_WQT_KERNEL) {
@@ -1263,6 +1278,29 @@ int __drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
+	/*
+	 * In the event that the WQ is configurable for pasid and priv bits.
+	 * For kernel wq, the driver should setup the pasid, pasid_en, and priv bit.
+	 * However, for non-kernel wq, the driver should only set the pasid_en bit for
+	 * shared wq. A dedicated wq that is not 'kernel' type will configure pasid and
+	 * pasid_en later on so there is no need to setup.
+	 */
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+		int priv = 0;
+
+		if (device_pasid_enabled(idxd)) {
+			if (is_idxd_wq_kernel(wq) || wq_shared(wq)) {
+				u32 pasid = wq_dedicated(wq) ? idxd->pasid : 0;
+
+				__idxd_wq_set_pasid_locked(wq, pasid);
+			}
+		}
+
+		if (is_idxd_wq_kernel(wq))
+			priv = 1;
+		__idxd_wq_set_priv_locked(wq, priv);
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


