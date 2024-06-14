Return-Path: <dmaengine+bounces-2366-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1C69087B5
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D6A1C22954
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1B1922FA;
	Fri, 14 Jun 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjhGAQQA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5018413A;
	Fri, 14 Jun 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358073; cv=none; b=Fzom/2t33+5LbkeBMc4ObzqfknSW+a+uzk+YNU1NmHwQkcUMOaxCHrRLey6az+CzXkIqthjNYQLaaGwhU2XxfeW5AIS2lkhACb929hM0Igh3aZYWRjGdjdnpTmchMNFMMz/grV4+Gt/hI4CWbQWPNoC0NwsttWGOw/D5EpzcRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358073; c=relaxed/simple;
	bh=MYSVS817SJFLybeVanCWjJV+RmOQvgWuvklPkpl1yFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elRTfI5Wt7SP2hOGpQXpak2hx4q2V3avNf6tXqVHdvUXzYegccLHkdfAY5SOrw+zwpjxmeDaNkwkF/2REOi/U3DpzhwyvBeHMGMUyUaXEVeEZIJzApOKmubwDEv5kllPsX/vdmbQD8SBuF2OZrMi+WxGNSu1kAhXFoPXU/7T8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjhGAQQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E450C2BD10;
	Fri, 14 Jun 2024 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718358072;
	bh=MYSVS817SJFLybeVanCWjJV+RmOQvgWuvklPkpl1yFA=;
	h=From:To:Cc:Subject:Date:From;
	b=HjhGAQQAzBRbUBOnaCRkafwendaatuyeCEVezk84p5kl2c8CYRivMdPnStGqjQ6Li
	 s8akvzu+DdyTE59nMm/lgcYvDvgvRK+YRWX545ztGuO+APqKeq1Whts+BbwuFV9QUU
	 Zmsi/D4HVbOopG11sbbhyNQBG+wdRPT9RRQ7kWkA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Tesarik <petr.tesarik.ext@huawei.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	dmaengine@vger.kernel.org
Subject: [PATCH] driver core: make [device_]driver_attach take a const *
Date: Fri, 14 Jun 2024 11:41:02 +0200
Message-ID: <2024061401-rasping-manger-c385@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 92
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=MYSVS817SJFLybeVanCWjJV+RmOQvgWuvklPkpl1yFA=; b=owGbwMvMwCRo6H6F97bub03G02pJDGk5AnrhImJZ1m8O9KxlCBXcoCz35N0boxCGrGxpTU1pg f/3rzZ1xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwET+uTIsmOSzVyJbxylwtZy6 v+nF75pRF45JMCyYss2m0nxf8ovD3qpR1+ervciIOdoKAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Change device_driver_attach() and driver_attach() to take a const * to
struct device driver as neither of them modify the structure at all.

Also, for some odd reason, drivers/dma/idxd/compat.c had a duplicate
external reference to device_driver_attach(), so remove that to fix up
the build, it should never have had that there in the first place.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c         | 9 +++++----
 drivers/dma/idxd/compat.c | 1 -
 include/linux/device.h    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8ec22229e259..9b745ba54de1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1118,7 +1118,7 @@ static void __device_driver_unlock(struct device *dev, struct device *parent)
  * Manually attach driver to a device. Will acquire both @dev lock and
  * @dev->parent lock if needed. Returns 0 on success, -ERR on failure.
  */
-int device_driver_attach(struct device_driver *drv, struct device *dev)
+int device_driver_attach(const struct device_driver *drv, struct device *dev)
 {
 	int ret;
 
@@ -1154,7 +1154,7 @@ static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
 
 static int __driver_attach(struct device *dev, void *data)
 {
-	struct device_driver *drv = data;
+	const struct device_driver *drv = data;
 	bool async = false;
 	int ret;
 
@@ -1227,9 +1227,10 @@ static int __driver_attach(struct device *dev, void *data)
  * returns 0 and the @dev->driver is set, we've found a
  * compatible pair.
  */
-int driver_attach(struct device_driver *drv)
+int driver_attach(const struct device_driver *drv)
 {
-	return bus_for_each_dev(drv->bus, NULL, drv, __driver_attach);
+	/* The (void *) will be put back to const * in __driver_attach() */
+	return bus_for_each_dev(drv->bus, NULL, (void *)drv, __driver_attach);
 }
 EXPORT_SYMBOL_GPL(driver_attach);
 
diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
index 5fd38d1b9d28..a4adb0c17995 100644
--- a/drivers/dma/idxd/compat.c
+++ b/drivers/dma/idxd/compat.c
@@ -7,7 +7,6 @@
 #include <linux/device/bus.h>
 #include "idxd.h"
 
-extern int device_driver_attach(struct device_driver *drv, struct device *dev);
 extern void device_driver_detach(struct device *dev);
 
 #define DRIVER_ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)	\
diff --git a/include/linux/device.h b/include/linux/device.h
index 56f266429229..26cb17d49609 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1177,12 +1177,12 @@ static inline void *dev_get_platdata(const struct device *dev)
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
-int __must_check device_driver_attach(struct device_driver *drv,
+int __must_check device_driver_attach(const struct device_driver *drv,
 				      struct device *dev);
 int __must_check device_bind_driver(struct device *dev);
 void device_release_driver(struct device *dev);
 int  __must_check device_attach(struct device *dev);
-int __must_check driver_attach(struct device_driver *drv);
+int __must_check driver_attach(const struct device_driver *drv);
 void device_initial_probe(struct device *dev);
 int __must_check device_reprobe(struct device *dev);
 

base-commit: c6c631d2b72b9390587cd1ee5b7905f8ea5bb1ea
-- 
2.45.2


