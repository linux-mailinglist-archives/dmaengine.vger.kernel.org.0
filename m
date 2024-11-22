Return-Path: <dmaengine+bounces-3775-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F49D6658
	for <lists+dmaengine@lfdr.de>; Sat, 23 Nov 2024 00:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7979A2824CA
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5F1D042A;
	Fri, 22 Nov 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLruEoTS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA941BD9E9;
	Fri, 22 Nov 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318238; cv=none; b=qrshdGPjrQZJVAfz99upSYy9lI5sljlEubTQmc8Ube/COL1wGEKkAhG5SGTxNfuCgSCpWmrcRW1N7XnrHBFc1vf1yN9zljrMj2MkX6/ifXljBeQbGMpz8ofYQt7JZjjm7XIuwn+Z8NEON2Sr3NEq1Ct4OEZb4emw0zzDt4G9eSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318238; c=relaxed/simple;
	bh=EQi1PaOy37qrygt1mNhzvx9dMK17qv0Z7AHg2IO6eTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ix1xHCkEU5jfLXtfVj6cRnwNZhTCAGcTOgjpuVBIRLb14RLTy3jctlm0PsG8bg9nIwhBDJt/Ux74S9x8vyGD53WmwVzjvCfCvaIekEwAf+DRxkOPqRHF5gXOXVb6XmKi/JeosPQZgfsT2GLYg9PvGiE7KzWfNzer4u7V1byXMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLruEoTS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732318237; x=1763854237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQi1PaOy37qrygt1mNhzvx9dMK17qv0Z7AHg2IO6eTQ=;
  b=gLruEoTSRbAwK4p2e60VZY0e0ePuzRqa+oWeMJmxYBtwCymeqNh1suRy
   FwJ0/XySyB4fCiaaOc3s/7uX8WPBOoFbpY7eJBpi7BvJmKDW4Fsv2XU0c
   abI4U9IeIl/SOuL+PxCXC1vKDdK8Z4nLjRttPdlDmNIgk1/rzppqsnCht
   X6o5PpMLE/si6p9AWUJ0aaCG3nWTu++MrKv+1fS0/Hj7ucLnTCAeGb+8e
   YQxVae8joa6/jP9j6lZvZxMRkxggEa8cOZXCUdUlDKI63/GBeqbntEdRp
   dXzi+IedHHYEB7y7hvuXS26RctoIF2EzKY3Wgph3CrD5OR3pwmCRwH6Pm
   g==;
X-CSE-ConnectionGUID: bQ3XiUaRQHOSVQCmtm0c7w==
X-CSE-MsgGUID: vgvNZQ2jTo64pOm24vx3yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43134421"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="43134421"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:30:35 -0800
X-CSE-ConnectionGUID: H9/2pKbuRJ2kj29wesbbIQ==
X-CSE-MsgGUID: dPFXdL5gQCCfT6rvMnpTfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="95127794"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa005.fm.intel.com with ESMTP; 22 Nov 2024 15:30:35 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 2/5] dmaengine: idxd: Binding and unbinding IDXD device and driver
Date: Fri, 22 Nov 2024 15:30:25 -0800
Message-Id: <20241122233028.2762809-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241122233028.2762809-1-fenghua.yu@intel.com>
References: <20241122233028.2762809-1-fenghua.yu@intel.com>
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
index 6679105336ca..a76ec4312a94 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -723,6 +723,39 @@ static void idxd_cleanup(struct idxd_device *idxd)
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


