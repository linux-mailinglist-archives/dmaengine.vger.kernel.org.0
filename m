Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9D76A2AA
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGaV35 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 17:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGaV3u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 17:29:50 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2678126;
        Mon, 31 Jul 2023 14:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690838989; x=1722374989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jBw/HXHW9fVN4ZP2CymXmjYIPDw1g2uNvvdfLu9VKnU=;
  b=X72qDuJcwld01g0vJmSY8sb6xm/m8gWuLwqBypNSNTNUKb9kRKS3aQCy
   fx01qAHNF/pPQ5udfejmsi0j7Ep8ADTUce98dcvMeASgI7o3MQtwqSnD1
   ycxtj9TN1yoySqxT+GdcB17Y3sdKrO2sN8oPX2iEpUghMS7phLmWNhk9h
   xbMz3MhpKVM8SWUh0VSj81JK+bGtrIrl0f8aAVloePBXn3FLfM+VS0dvB
   ChGYlKi7tZV8ZJtLdH0OmOZ9Izm9gkKx2ZphbBpngcxOZdByvca8nUK4H
   h5dLyLjsK6WFnaPh/8e05WA7U0U6NYllKJ7Kt62MreKedYls0E+57ZjM5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349425749"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="349425749"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728428377"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="728428377"
Received: from sgimmeke-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.91.213])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:29:47 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v8 02/14] dmaengine: idxd: add external module driver support for dsa_bus_type
Date:   Mon, 31 Jul 2023 16:29:27 -0500
Message-Id: <20230731212939.1391453-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
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

