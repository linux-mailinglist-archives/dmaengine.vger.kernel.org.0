Return-Path: <dmaengine+bounces-3456-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179509ADC8B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EF51C20DA2
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 06:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49704189B9B;
	Thu, 24 Oct 2024 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Bl5t6sXl"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC7175D50;
	Thu, 24 Oct 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752662; cv=none; b=Kq1EGevZemEf70ceGglzyleAnL6lYciGvX5miKkHO8UM3EQeYo46qcvPqI1RhooEU4byAFcKoLtbww/yLjoCDH01D0HHuDC3dyNmp0TJQ2mSC3GiIMg46r4EbSKTJ9T7zUcEk1bC6L/GUWFjdOo9r21gqumVHXp/buLtiCnTjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752662; c=relaxed/simple;
	bh=OfqqZUFbF5ur/gCAQtvYoTBdw4wYk5M2eXPxex2njbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbD8h8ujm8scB9HiLrNtRWC4zyhVWXvmX59l/lXa4z69ZQO/jiJSaAUa2Gqn2HYBE3iy0QzY64GNcOrKZka4CFAokrCzGWjfP1au9Nhbu8vQdXvmFlp3dI6aLvqtbfFzcRVPjGX2RRM1FXXamGMeGAafaYbh84iaPKMIEIPzllM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Bl5t6sXl; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 47074A0642;
	Thu, 24 Oct 2024 08:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=oEkMkOoeysYlj2KcLEx7
	PgbymfxkS+ZogQhGsMWtRJg=; b=Bl5t6sXlV7X7dFZwUX7P84yQLLobWyw7Phyu
	nSrBStmsWPT3XVu1X/e3SQQcSNCwni+VYLTYRx0VqE9vb5mHbTVOBDw9MWGeo1+H
	eShqSzLPp8JIf9rSONfy5rMnz5PpviAoNab/1JGqPQiIpCWzMUsg/Qx/UOCRWDlO
	cc7yBgoA4FKpNJX5FK7YXtszRsUiBoZt35nRdYI9JWfSFlFhQl1Q4rNu5HJ95QsH
	es7ToRb1//C48ozqxsqGQzLftikhVmd3YM44GsFPYmlIBZVnafjobrTBWhwO27HG
	fg01OM9FZTuBldilzijhWw5Rh+wXHcYx6hQtrd/OogQGBeQDQ9L+S7D3KvYBkz5x
	YAhQ8XiYptVXqGDmquyoroWqkQWcC03U13FVWakAm7NFOsvzgQjYWTcPeQ9govol
	q5L6dJ2iwrLOF65uPr7jzkPXhpic1YS3AWbNpvNnLTItsV2SYJJSASDNEjuuUW94
	VCNL3XjyFz24X41tJ1pXgCPAKZ7F9Xlm3Ts7fCbkEVE6Nk2kqOeGqrEJg7Udej0s
	wru7pNVPI1CJJ0XcZxRM5pKYH3GME9njP0ROuKcZLwMZrk8a7F5iY81j/a07/UbY
	F1zBSa8IaVHuHoYdwA/cEKvID8TynioDTcIrtp0vJRZ8v8v+PkXxyn5PRXcPHb7L
	2402iN0=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 02/10] dma-engine: sun4i: Add has_reset option to quirk
Date: Thu, 24 Oct 2024 08:49:23 +0200
Message-ID: <20241024064931.1144605-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
References:
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729752650;VERSION=7978;MC=1474290725;ID=135549;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677065

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
has this bit but in order to support suniv we need to add it. So add
support for reset bit.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/dma/sun4i-dma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 5efbed7c546f..0b99b3884971 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -15,6 +15,7 @@
 #include <linux/of_dma.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -159,6 +160,7 @@ struct sun4i_dma_config {
 	u8 ddma_drq_sdram;
 
 	u8 max_burst;
+	bool has_reset;
 };
 
 struct sun4i_dma_pchan {
@@ -208,6 +210,7 @@ struct sun4i_dma_dev {
 	int				irq;
 	spinlock_t			lock;
 	const struct sun4i_dma_config *cfg;
+	struct reset_control *rst;
 };
 
 static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
@@ -1215,6 +1218,15 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
+	if (priv->cfg->has_reset) {
+		priv->rst = devm_reset_control_get_exclusive(&pdev->dev,
+							       NULL);
+		if (IS_ERR(priv->rst)) {
+			dev_err(&pdev->dev, "Failed to get reset control\n");
+			return PTR_ERR(priv->rst);
+		}
+	}
+
 	platform_set_drvdata(pdev, priv);
 	spin_lock_init(&priv->lock);
 
@@ -1287,6 +1299,16 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Deassert the reset control */
+	if (priv->rst) {
+		ret = reset_control_deassert(priv->rst);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to deassert the reset control\n");
+			goto err_clk_disable;
+		}
+	}
+
 	/*
 	 * Make sure the IRQs are all disabled and accounted for. The bootloader
 	 * likes to leave these dirty
@@ -1356,6 +1378,7 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
 	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
 
 	.max_burst		= SUN4I_MAX_BURST,
+	.has_reset		= false,
 };
 
 static const struct of_device_id sun4i_dma_match[] = {
-- 
2.34.1



