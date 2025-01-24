Return-Path: <dmaengine+bounces-4184-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F00A1B205
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 09:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE14188F091
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B58219A73;
	Fri, 24 Jan 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="g7rLjC7w"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292A1F7907;
	Fri, 24 Jan 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709019; cv=none; b=uw8tsZAHn25YOpZFGtmozVjxl/mCcPmWALdqCrUWFf4pZ3S+XOm8S991VzrN74XnGAahlqC9P35i+F0l+3BwlVMGoxIAdHEP3cDm08Pq9gIBU9C3fo+ZuKrIwEqck/+FQTkrQVqqsJTvbeoIxSegPgcNiFk5xq0Uzs7cwHJeLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709019; c=relaxed/simple;
	bh=hMjK0JKCLQkifVL6xcp5SP3Txd+JKmmgLvrhO1+qQ0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlWTyAtS78lhIBhxnKL9LSPZq5I8xlT0HZoJOBiELbzvIioYH/IZXjNFJ9lHlRjnopd6JIvEwVw5xDTSh78MDeJufJtOecrK70j+OsvkSD2joIl36OqAWxooWnrnedxX+UnkGe+eXWRjU9rT13+qpHOSjkAfHvRGPrEhChWkoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=g7rLjC7w; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 836E3A09FF;
	Fri, 24 Jan 2025 09:56:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZlOzh0yVdNtO9Xo4eTT0
	ptUq5hK7+DDJWK0WMdAATE0=; b=g7rLjC7w1RWLE5CXrEPJAknMGKmzbtUJde/P
	EOew21O+3aI3OSgdhlz38WMoJdJNw6DfoiAPVpLFB9ZsULv8zLLwwh8gamVjrrqD
	gXazlAdLmKevEOFooxcn86Pvwl6Zr7dgXBvdnnUDc8oNk6tGMeeczHTZZDuXwMCA
	oXLLdORXZkS5o+atOk7SUL0q0rJieS8zbA6UFmHu9Ehj2wM8rEzPwF2oFFPIEWBI
	tT8lakaDiPUMdSG4oNW6p0Sclmkv10z9EnqXDDhUQYWJahYT0J9kN7NkBmefAPr6
	xC6fCtcpLEgYs9mOYlHKmSVQhzO5JNxm2KdnRocHYNJrhqHR+zmuJECHgizGw0Kb
	ZezsjwDdP2tgs4XQgWnRnIGCKTF+WnWzi6byuUdQgvo3+V9R1YoG4zJ443bEfrTD
	t7UyfrZ1stEVqhK+3IJ21+/omyu1k9buRONbsLvygY0bfza6Ypdk3AHFFP3D2hUJ
	zfafYq+wSH5agjXRBCcPDBpOd+3Rkn9fa2RiSllG00LgBABCl6K3aSaca7Q4cxkF
	0oYHWRctUCaAU174CKNd1DnvvEMblOEzN7MvV9uS19L7ws0T3g7eO9yCa1fMhMcj
	LaIYEamaYI8ccVYa2svsDosOaa68e66fiN2MjZgjzFxGTVneb9oDQm65hFRAQRvN
	ajDlf74=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>, "Pavel
 Machek" <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/4] pm: runtime: Add new devm functions
Date: Fri, 24 Jan 2025 09:52:22 +0100
Message-ID: <20250124085221.766303-10-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124085221.766303-4-csokas.bence@prolan.hu>
References: <20250124085221.766303-4-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1737709014;VERSION=7984;MC=2223755251;ID=70500;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852677063

Add `devm_pm_runtime_set_active()` and
`devm_pm_runtime_get_noresume()` for
simplifying common use cases in drivers.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2ee45841486b..f0a6c64bec19 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1545,6 +1545,24 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_set_suspended_action(void *data)
+{
+	pm_runtime_set_suspended(data);
+}
+
+/**
+ * devm_pm_runtime_set_active - devres-enabled version of pm_runtime_set_active.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_set_active(struct device *dev)
+{
+	pm_runtime_set_active(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_set_suspended_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active);
+
 static void pm_runtime_disable_action(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
@@ -1567,6 +1585,24 @@ int devm_pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
 
+static void pm_runtime_put_noidle_action(void *data)
+{
+	pm_runtime_put_noidle(data);
+}
+
+/**
+ * devm_pm_runtime_get_noresume - devres-enabled version of pm_runtime_get_noresume.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_get_noresume(struct device *dev)
+{
+	pm_runtime_get_noresume(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_put_noidle_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_get_noresume);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d39dc863f612..d7eca86150b8 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -93,7 +93,9 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+int devm_pm_runtime_set_active(struct device *dev);
 extern int devm_pm_runtime_enable(struct device *dev);
+int devm_pm_runtime_get_noresume(struct device *dev);
 
 /**
  * pm_suspend_ignore_children - Set runtime PM behavior regarding children.
@@ -276,7 +278,9 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_set_active(struct device *dev) { return 0; }
 static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+static inline int devm_pm_runtime_get_noresume(struct device *dev) { return 0; }
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
-- 
2.48.1



