Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAE7059D2
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 23:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjEPVu2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjEPVuT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 17:50:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F806EB5;
        Tue, 16 May 2023 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684273818; x=1715809818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lbQolgcAlS0UEuGw8aWww3sQPK4nsrdYvipioZ0YH2E=;
  b=n6D6MDSlJdH83yIewfyzGeGyHui0JrAqqnWnGrXCiqtWGFTvubu3XINU
   LspDx68XoX4q3hRiF7lN28Y9cUzbh1r/qBInJiMBHOmhj2Dnvgs6R41L3
   jtuEW36vo9pPhWy5/jOz+bmb5XIYf8S0SoftZ2G/ThMsb08F2sejGVe3h
   DpLZpHaIhUt8MlxhrZWS9E9fLQ2Ys73s5s+UO7AwasiRkNgbWy/TJaXXZ
   2GsUP4Bg0L64R70rQUAyjhTefXCtxLv5SA5Nrgjy22DEYCNxrtmcBw3cb
   +j418NdKqUa6SVmktV1INc0CI9zoLNoRkbK6UGKw675T2z6KTNeApzxGV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331961640"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331961640"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="704564792"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="704564792"
Received: from fmunozug-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.83.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:50:16 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v5 02/15] dmaengine: idxd: add external module driver support for dsa_bus_type
Date:   Tue, 16 May 2023 16:49:56 -0500
Message-Id: <20230516215009.51794-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
References: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add support to allow an external driver to be registered to the
dsa_bus_type and also auto-loaded.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/dma/idxd/bus.c  | 6 ++++++
 drivers/dma/idxd/idxd.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/idxd/bus.c b/drivers/dma/idxd/bus.c
index 6f84621053c6..0c9e689a2e77 100644
--- a/drivers/dma/idxd/bus.c
+++ b/drivers/dma/idxd/bus.c
@@ -67,11 +67,17 @@ static void idxd_config_bus_remove(struct device *dev)
 	idxd_drv->remove(idxd_dev);
 }
 
+static int idxd_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	return add_uevent_var(env, "MODALIAS=" IDXD_DEVICES_MODALIAS_FMT, 0);
+}
+
 struct bus_type dsa_bus_type = {
 	.name = "dsa",
 	.match = idxd_config_bus_match,
 	.probe = idxd_config_bus_probe,
 	.remove = idxd_config_bus_remove,
+	.uevent = idxd_bus_uevent,
 };
 EXPORT_SYMBOL_GPL(dsa_bus_type);
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c62c78e1c9fa..276b5f9cf967 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -646,6 +646,9 @@ static inline int idxd_wq_driver_name_match(struct idxd_wq *wq, struct device *d
 	return (strncmp(wq->driver_name, dev->driver->name, strlen(dev->driver->name)) == 0);
 }
 
+#define MODULE_ALIAS_IDXD_DEVICE(type) MODULE_ALIAS("idxd:t" __stringify(type) "*")
+#define IDXD_DEVICES_MODALIAS_FMT "idxd:t%d"
+
 int __must_check __idxd_driver_register(struct idxd_device_driver *idxd_drv,
 					struct module *module, const char *mod_name);
 #define idxd_driver_register(driver) \
-- 
2.34.1

