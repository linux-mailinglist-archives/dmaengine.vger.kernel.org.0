Return-Path: <dmaengine+bounces-377-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A38060B2
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 22:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DBB2816B9
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22CE6E5B7;
	Tue,  5 Dec 2023 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUQ2bYSo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F39A1B6;
	Tue,  5 Dec 2023 13:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811549; x=1733347549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=buoGPdrkkKx4hhUIceeTcYHbzYQ9xgtGVojseC0ReWs=;
  b=GUQ2bYSo6LNnkcZpwdfzCl2Js7mnNOUWleXnvoADAlk57s4v+s0ZeHa8
   D60TFUOEocwM7vp0gkokT/nkaezGVaz377ktwLsQX7Kd7eiFbPeI7v8n3
   YVjE3qhoE6YJ19AvlzzHYmIracYwPTP2Qdlg2G7mIX7HOw7WN0mtEq8l5
   xluSXrI3OQFi730hKrAbFK5YhblQ7lYbjhD+cJQgQBI3fCVncatMhdEg1
   oULg0Fris1+ZvXk0EX/QyYae3z2w1xAQEiSVI462lnlAffvYmfySQ/KQq
   BUrqwfzjHK1iqmkNcDUyJfMd5MFe3ecQ2mpHdk6mxaeGAKj2k/KOAns/u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396751581"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="396751581"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:25:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="19102554"
Received: from jsamonte-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.71.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:25:42 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com,
	vkoul@kernel.org
Cc: dave.jiang@intel.com,
	tony.luck@intel.com,
	wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	kanchana.p.sridhar@intel.com,
	vinodh.gopal@intel.com,
	giovanni.cabiddu@intel.com,
	pavel@ucw.cz,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v12 01/14] dmaengine: idxd: add external module driver support for dsa_bus_type
Date: Tue,  5 Dec 2023 15:25:17 -0600
Message-Id: <20231205212530.285671-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
References: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

Add support to allow an external driver to be registered to the
dsa_bus_type and also auto-loaded.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
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
index 1e89c80a07fc..e541d19f14d0 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -655,6 +655,9 @@ static inline int idxd_wq_driver_name_match(struct idxd_wq *wq, struct device *d
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


