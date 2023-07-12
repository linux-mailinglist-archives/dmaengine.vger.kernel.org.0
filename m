Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADF750FE1
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 19:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGLRoq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGLRol (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 13:44:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326CE1BC6;
        Wed, 12 Jul 2023 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689183881; x=1720719881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U2R7b+iUtPFdxm/EIWwuSf9S3+IwEB4iHE7tb1dTlJE=;
  b=SGAmd4BfhJO5bxD2koM2x3WcjxJT2uHL5Vn5jQb6VTxg6SeUOLWSOo8C
   Ax+x/V+3un7PCe3mfGOHQ06AwRIVvJrO0Gdq00h1VKewOl8VUqqXTTKbV
   2Wx80EkbeoTyJspErtYcem62gn6Ko4SdchZMuO75LSTm9ZPL1g2AjNQoc
   imRvXswW/OdXAxat5nMFIbI0CANNDcDoUE/MkEQmZe+h6QQiUAa5CAdso
   wCaBaodXyZ1LXEYFXrKI6wNjAkApIOmXpODkb0GtNGZEzJo52DHzkbxSo
   oTXF+9XV20HdBsWizHPk3t35cZ4RnnjFHxe/EQt3EaYWc6js4nEwt5sL+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363828273"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="363828273"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="811671700"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="811671700"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2023 10:44:40 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/2] dmaengine: idxd: Simplify WQ attribute visibility checks
Date:   Wed, 12 Jul 2023 10:44:35 -0700
Message-Id: <20230712174436.3435088-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The functions that check if WQ attributes are invisible are almost
duplicate. Define a helper to simplify these functions and future
WQ attribute visibility checks as well.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 293739ac5596..388fba7c85f8 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1288,12 +1288,9 @@ static struct attribute *idxd_wq_attributes[] = {
 	NULL,
 };
 
-static bool idxd_wq_attr_op_config_invisible(struct attribute *attr,
-					     struct idxd_device *idxd)
-{
-	return attr == &dev_attr_wq_op_config.attr &&
-	       !idxd->hw.wq_cap.op_config;
-}
+/*  A WQ attr is invisible if the feature is not supported in WQCAP. */
+#define idxd_wq_attr_invisible(name, cap_field, a, idxd)		\
+	((a) == &dev_attr_wq_##name.attr && !(idxd)->hw.wq_cap.cap_field)
 
 static bool idxd_wq_attr_max_batch_size_invisible(struct attribute *attr,
 						  struct idxd_device *idxd)
@@ -1303,13 +1300,6 @@ static bool idxd_wq_attr_max_batch_size_invisible(struct attribute *attr,
 	       idxd->data->type == IDXD_TYPE_IAX;
 }
 
-static bool idxd_wq_attr_wq_prs_disable_invisible(struct attribute *attr,
-						  struct idxd_device *idxd)
-{
-	return attr == &dev_attr_wq_prs_disable.attr &&
-	       !idxd->hw.wq_cap.wq_prs_support;
-}
-
 static umode_t idxd_wq_attr_visible(struct kobject *kobj,
 				    struct attribute *attr, int n)
 {
@@ -1317,13 +1307,13 @@ static umode_t idxd_wq_attr_visible(struct kobject *kobj,
 	struct idxd_wq *wq = confdev_to_wq(dev);
 	struct idxd_device *idxd = wq->idxd;
 
-	if (idxd_wq_attr_op_config_invisible(attr, idxd))
+	if (idxd_wq_attr_invisible(op_config, op_config, attr, idxd))
 		return 0;
 
 	if (idxd_wq_attr_max_batch_size_invisible(attr, idxd))
 		return 0;
 
-	if (idxd_wq_attr_wq_prs_disable_invisible(attr, idxd))
+	if (idxd_wq_attr_invisible(prs_disable, wq_prs_support, attr, idxd))
 		return 0;
 
 	return attr->mode;
-- 
2.37.1

