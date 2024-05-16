Return-Path: <dmaengine+bounces-2039-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3418C7497
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D3E2845CC
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4514389A;
	Thu, 16 May 2024 10:25:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A35143897
	for <dmaengine@vger.kernel.org>; Thu, 16 May 2024 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855151; cv=none; b=KndbdYAaFYVjVR929dW6t2c5ijvDEf3jKGTL3uwEkZfrMg1ml+wEiGTyY711+thqDnx9DzMeAuePyWVY/QKiZq9EuxDjc7bdDoX25fPLIu/gZwKl7/6CMQn+W9C0ZMYoVyBYqZMZJvSBTS9vECuYb19o3jTMh8rsj6/H0Ozz1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855151; c=relaxed/simple;
	bh=HK4fcMci2trdwHn9Xf4F2bpeZlCq2jIARnWYqTAaR6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QDGjpLJZbZdg2M8CP+N/6PcfSAL/PGqL2gAb/Va0/vYe/KNFNoU2BqECAgvrke8PntLILXHW7WAEzd4d8rwNfkEJEIxuvp7iI1vHYMZJW7aeavoXWVdL3IChqX/coPuMTsGZvdBDe6H7zLQYMqvDeSeKhPblEbL0N3BJwEZDYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1s7YIn-0003ce-Lb; Thu, 16 May 2024 12:25:33 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1s7YIm-001h9D-Ko; Thu, 16 May 2024 12:25:32 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Vinod Koul <vkoul@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	patchwork-lst@pengutronix.de
Subject: [PATCH 1/2] firmware: add nowarn variant of request_firmware_nowait()
Date: Thu, 16 May 2024 12:25:31 +0200
Message-Id: <20240516102532.213874-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

Device drivers with optional firmware may still want to use the
asynchronous firmware loading interface. To avoid printing a
warning into the kernel log when the optional firmware is
absent, add a nowarn variant of this interface.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v3:
- v2-link: https://lore.kernel.org/all/20181112160143.4459-1-l.stach@pengutronix.de/
- Rename to firmware_*
- Drop uevent for new API
- Make use of EXPORT_SYMBOL_GPL
- Sort header alphabetical
---
 drivers/base/firmware_loader/main.c | 90 ++++++++++++++++++++---------
 include/linux/firmware.h            | 12 ++++
 2 files changed, 75 insertions(+), 27 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index da8ca01d011c..a03ee4b11134 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1172,34 +1172,11 @@ static void request_firmware_work_func(struct work_struct *work)
 	kfree(fw_work);
 }
 
-/**
- * request_firmware_nowait() - asynchronous version of request_firmware
- * @module: module requesting the firmware
- * @uevent: sends uevent to copy the firmware image if this flag
- *	is non-zero else the firmware copy must be done manually.
- * @name: name of firmware file
- * @device: device for which firmware is being loaded
- * @gfp: allocation flags
- * @context: will be passed over to @cont, and
- *	@fw may be %NULL if firmware request fails.
- * @cont: function will be called asynchronously when the firmware
- *	request is over.
- *
- *	Caller must hold the reference count of @device.
- *
- *	Asynchronous variant of request_firmware() for user contexts:
- *		- sleep for as small periods as possible since it may
- *		  increase kernel boot time of built-in device drivers
- *		  requesting firmware in their ->probe() methods, if
- *		  @gfp is GFP_KERNEL.
- *
- *		- can't sleep at all if @gfp is GFP_ATOMIC.
- **/
-int
-request_firmware_nowait(
+
+static int _request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
-	void (*cont)(const struct firmware *fw, void *context))
+	void (*cont)(const struct firmware *fw, void *context), bool nowarn)
 {
 	struct firmware_work *fw_work;
 
@@ -1217,7 +1194,8 @@ request_firmware_nowait(
 	fw_work->context = context;
 	fw_work->cont = cont;
 	fw_work->opt_flags = FW_OPT_NOWAIT |
-		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
+		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER) |
+		(nowarn ? FW_OPT_NO_WARN : 0);
 
 	if (!uevent && fw_cache_is_setup(device, name)) {
 		kfree_const(fw_work->name);
@@ -1236,8 +1214,66 @@ request_firmware_nowait(
 	schedule_work(&fw_work->work);
 	return 0;
 }
+
+/**
+ * request_firmware_nowait() - asynchronous version of request_firmware
+ * @module: module requesting the firmware
+ * @uevent: sends uevent to copy the firmware image if this flag
+ *	is non-zero else the firmware copy must be done manually.
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ * @gfp: allocation flags
+ * @context: will be passed over to @cont, and
+ *	@fw may be %NULL if firmware request fails.
+ * @cont: function will be called asynchronously when the firmware
+ *	request is over.
+ *
+ *	Caller must hold the reference count of @device.
+ *
+ *	Asynchronous variant of request_firmware() for user contexts:
+ *		- sleep for as small periods as possible since it may
+ *		  increase kernel boot time of built-in device drivers
+ *		  requesting firmware in their ->probe() methods, if
+ *		  @gfp is GFP_KERNEL.
+ *
+ *		- can't sleep at all if @gfp is GFP_ATOMIC.
+ **/
+int request_firmware_nowait(
+	struct module *module, bool uevent,
+	const char *name, struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	return _request_firmware_nowait(module, uevent, name, device, gfp,
+					context, cont, false);
+
+}
 EXPORT_SYMBOL(request_firmware_nowait);
 
+/**
+ * firmware_request_nowait_nowarn() - async version of request_firmware_nowarn
+ * @module: module requesting the firmware
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ * @gfp: allocation flags
+ * @context: will be passed over to @cont, and
+ *	@fw may be %NULL if firmware request fails.
+ * @cont: function will be called asynchronously when the firmware
+ *	request is over.
+ *
+ * Similar in function to request_firmware_nowait(), but doesn't print a warning
+ * when the firmware file could not be found and always sends a uevent to copy
+ * the firmware image.
+ */
+int firmware_request_nowait_nowarn(
+	struct module *module, const char *name,
+	struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	return _request_firmware_nowait(module, FW_ACTION_UEVENT, name, device,
+					gfp, context, cont, true);
+}
+EXPORT_SYMBOL_GPL(firmware_request_nowait_nowarn);
+
 #ifdef CONFIG_FW_CACHE
 static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index f026f8926d79..aae1b85ffc10 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -98,6 +98,10 @@ static inline bool firmware_request_builtin(struct firmware *fw,
 #if IS_REACHABLE(CONFIG_FW_LOADER)
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
+int firmware_request_nowait_nowarn(
+	struct module *module, const char *name,
+	struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context));
 int firmware_request_nowarn(const struct firmware **fw, const char *name,
 			    struct device *device);
 int firmware_request_platform(const struct firmware **fw, const char *name,
@@ -123,6 +127,14 @@ static inline int request_firmware(const struct firmware **fw,
 	return -EINVAL;
 }
 
+static inline int firmware_request_nowait_nowarn(
+	struct module *module, const char *name,
+	struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	return -EINVAL;
+}
+
 static inline int firmware_request_nowarn(const struct firmware **fw,
 					  const char *name,
 					  struct device *device)
-- 
2.39.2


