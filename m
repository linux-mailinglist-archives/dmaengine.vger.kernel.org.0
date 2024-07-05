Return-Path: <dmaengine+bounces-2639-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FC928D60
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 20:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8103B1F23888
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1716C87B;
	Fri,  5 Jul 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfvuT8Hv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6713AD28;
	Fri,  5 Jul 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203324; cv=none; b=mU4hiKqTLvggHdSkxEdlDGw0nepFg0a6lmzzZP4juzxNnUL7MUhpdJ5DHoJEYZco6I3eNTwlfuOPs6W3SLpz9GM4uma9Yim6h5f45gIaOoVizzo/s1/4PjYxauPbGO46u08APic1fUN2WzQGypW6swqqc0nD/Ds79PShxXxDhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203324; c=relaxed/simple;
	bh=siTPzKLH0RjHwMR3sXWKjqOAmHVFayQ8o6rC3wLhP8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/3L/alQDVGDYjqNW/rKjzyh5pmOfZ1dny/OdbJ1gLNC+X4Goix0B6xHQNOqREn8vyBYwwbLgvdG2hpjxqXk4rV96ZE4SPV6+kwUXUgkmdXh5jyMyQaelMPmd8IoX9UcjrPBuJGFb3s435b00PKXn43bgnNVINd3Qb2XMeWPyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfvuT8Hv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720203322; x=1751739322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=siTPzKLH0RjHwMR3sXWKjqOAmHVFayQ8o6rC3wLhP8k=;
  b=FfvuT8Hvx+AQRGjjcQ23nsXoiTgfJQULG/CDyjMmOarX25aLpVh07wwe
   8tE8+rUsu67bqiUz33bxqyBFRH1Jvw0VHRXWd8EDyA87GLnSYu9aDN740
   sQJ1TyFojbJez7KIZI/rMVIKURgkgChIU3BSnMdvujsR9TSNFI4baK7Ms
   vEwQhax8+LRLJYis5lNcd29or78bY2Z2Uu6xTKbf/dIgx7YSLDdv96Efc
   Gnubtsd8nNXwQ2vcEcpDfeA1W9t++hho/FCXZrCDHc/YYGgswB5Ae6oo0
   bzOQ3yNc21KlJcTfy9TFaCtM2Sh3bbCB1Fahe9sAfk4rsXs953kcScCce
   g==;
X-CSE-ConnectionGUID: pMik5CFkTu+vT6L+Czk/Dg==
X-CSE-MsgGUID: C6QFCzZxTNChd1bbLbQcqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="12410719"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="12410719"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 11:15:20 -0700
X-CSE-ConnectionGUID: EssZeeqmR36L1o7F+8zh7g==
X-CSE-MsgGUID: GJwn3zD6QNytjnDEz2reeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="47672697"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa008.jf.intel.com with ESMTP; 05 Jul 2024 11:15:19 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/5] dmaengine: idxd: Binding and unbinding IDXD device and driver
Date: Fri,  5 Jul 2024 11:15:15 -0700
Message-Id: <20240705181519.4067507-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240705181519.4067507-1-fenghua.yu@intel.com>
References: <20240705181519.4067507-1-fenghua.yu@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add idxd_bind() and idxd_unbind() helpers to bind and unbind the IDXD
device and driver.

These helpers will be called during Function Level Reset (FLR) processing.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/init.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 068103b40223..a6d8097b2dcf 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -716,6 +716,39 @@ static void idxd_cleanup(struct idxd_device *idxd)
 		idxd_disable_sva(idxd->pdev);
 }
 
+/*
+ * Attach IDXD device to IDXD driver.
+ */
+static int idxd_bind(struct device_driver *drv, const char *buf)
+{
+	const struct bus_type *bus = drv->bus;
+	struct device *dev;
+	int err = -ENODEV;
+
+	dev = bus_find_device_by_name(bus, NULL, buf);
+	if (dev)
+		err = device_driver_attach(drv, dev);
+
+	put_device(dev);
+
+	return err;
+}
+
+/*
+ * Detach IDXD device from driver.
+ */
+static void idxd_unbind(struct device_driver *drv, const char *buf)
+{
+	const struct bus_type *bus = drv->bus;
+	struct device *dev;
+
+	dev = bus_find_device_by_name(bus, NULL, buf);
+	if (dev && dev->driver == drv)
+		device_release_driver(dev);
+
+	put_device(dev);
+}
+
 /*
  * Probe idxd PCI device.
  * If idxd is not given, need to allocate idxd and set up its data.
-- 
2.37.1


