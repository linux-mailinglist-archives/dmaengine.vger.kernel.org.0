Return-Path: <dmaengine+bounces-7213-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B5C6512E
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13F934EDEE7
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C82C3745;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5OGDO/8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162AF2C235D;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=IBzyQGNvvm8qwx/eTpmDVddO+e1DAQz4lzT+dzQX6MAUW/rTcdVpQ7wtkeWKRE2tE18ATwMjagV+fuTjeyG/ARonSwqqJehAMHKKz37etq5ELP+tGjuLqHn2vuWPbhp6LEYxhQmO6hasQ+5/6oNk6SavaX1STOukAi9mWFeqcLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=AGV01UnVDJZRdNN3E9lTAeqlaL238kaCs0BNRl5f36Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG5/pApkexB0AW2XdicbEDaDhJnyQKd9IY54Ekh1vWvbND52LodTEpzgTO7U+XJ43NzgX7MYLP/9UoBwnGLQRP7/1dUEzkckMrNZDhyfnf00OUTnbCfjTpg0uV8udj5E1zskUksgq1bGrwHPCTJ4hBX31DmsMqTHNptbsZs4nF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5OGDO/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBDBC19423;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396004;
	bh=AGV01UnVDJZRdNN3E9lTAeqlaL238kaCs0BNRl5f36Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5OGDO/8M8JnaAvlv6uwOe9ZOC6on23fntxgXTRPLQrQTrFUrGuvnxXDkuqdnrfXF
	 sz2WSYb1cDLpxGdsRiIC6gg6YTjD58s1tfCPCzjqpz+RzsuXFLYNVcEsWXFqCWNrhA
	 pDpxYILO507gB2sCSlQSZ+uW41LiswaTeSXo8b2x9lkF9dFYK3iubt5wVjXjCPgyhy
	 YD4v42nsbE8Bk+ZbvLCWH7fCRkLL4iD7zZdBW3Rtxjw1kJK8FfUut7Re+YxmCytDw3
	 sVbOOl1L7nipB83yOACuZdTLUlRzQRXNaSLVYKFibNc2YwWoRopkUMk8YsoUiNZ4zX
	 9Q3Q+H0dQdKDw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002np-34IE;
	Mon, 17 Nov 2025 17:13:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 05/15] dmaengine: idxd: fix device leaks on compat bind and unbind
Date: Mon, 17 Nov 2025 17:12:48 +0100
Message-ID: <20251117161258.10679-7-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the idxd device as
part of the compat bind and unbind sysfs interface.

Fixes: 6e7f3ee97bbe ("dmaengine: idxd: move dsa_drv support to compatible mode")
Cc: stable@vger.kernel.org	# 5.15
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/idxd/compat.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
index eff9943f1a42..95b8ef958633 100644
--- a/drivers/dma/idxd/compat.c
+++ b/drivers/dma/idxd/compat.c
@@ -20,11 +20,16 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t c
 	int rc = -ENODEV;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (dev && dev->driver) {
+	if (!dev)
+		return -ENODEV;
+
+	if (dev->driver) {
 		device_driver_detach(dev);
 		rc = count;
 	}
 
+	put_device(dev);
+
 	return rc;
 }
 static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
@@ -38,9 +43,12 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t cou
 	struct idxd_dev *idxd_dev;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (!dev || dev->driver || drv != &dsa_drv.drv)
+	if (!dev)
 		return -ENODEV;
 
+	if (dev->driver || drv != &dsa_drv.drv)
+		goto err_put_dev;
+
 	idxd_dev = confdev_to_idxd_dev(dev);
 	if (is_idxd_dev(idxd_dev)) {
 		alt_drv = driver_find("idxd", bus);
@@ -53,13 +61,20 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t cou
 			alt_drv = driver_find("user", bus);
 	}
 	if (!alt_drv)
-		return -ENODEV;
+		goto err_put_dev;
 
 	rc = device_driver_attach(alt_drv, dev);
 	if (rc < 0)
-		return rc;
+		goto err_put_dev;
+
+	put_device(dev);
 
 	return count;
+
+err_put_dev:
+	put_device(dev);
+
+	return rc;
 }
 static DRIVER_ATTR_IGNORE_LOCKDEP(bind, 0200, NULL, bind_store);
 
-- 
2.51.0


