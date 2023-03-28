Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7696D6CC683
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjC1Pfz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjC1Pfu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:35:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A9C3;
        Tue, 28 Mar 2023 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017747; x=1711553747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kO38bfPMogxI1tGFhan6UK8YLGWBnl59qm86GfdzocM=;
  b=RVMxGRtDoL90VBS8feoVxBgewC9oFoqiHVZV6YzQxzIJFXup5PDavxfV
   fUEnvimvq5nXNdopIDlnjqva+JNCJspbOtVQus35n9QjgURIGdvTtI2I4
   4zDSRwodUNe6JeCuFR7BZffE4/pdWIYV5RvowoTshuhotZN6lCfTprJMz
   VFsHm0gn+N8Kiz0lFMNkBG4w9hIMj2Ing+NuzNgwqMjzK5c7qVPeepuKk
   PCE9/y7MBeEORb1EZ1FbzHn4FNhs2M2AhiS65VNG4yBoTkahZ9LrHlXU9
   rHKLD9/cAk/7FVt5C7c/npqxDoqOQb5RWGqsUWPpUDiBL0pDjmANlDbj+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342192034"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342192034"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683948280"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683948280"
Received: from sdwarak1-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.127.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:35:44 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v2 02/15] dmaengine: idxd: add external module driver support for dsa_bus_type
Date:   Tue, 28 Mar 2023 10:35:22 -0500
Message-Id: <20230328153535.126223-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
index 505118fc19de..719f9f1662ad 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -587,6 +587,9 @@ static inline int idxd_wq_driver_name_match(struct idxd_wq *wq, struct device *d
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

