Return-Path: <dmaengine+bounces-3674-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7189B9E44
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367CC1C21956
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D536A155336;
	Sat,  2 Nov 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hFuR/P6n"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9F13F435;
	Sat,  2 Nov 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540110; cv=none; b=VeNMElg7xpeoD2d8IquclUPf7scy0S3vjcqff21gnPUREEZCpQ3k91hTYTqABYBxWQjXpIH6AjxBsuSVIsLwsj4UbaTCUOpO9ZjMWarWeYNom9iTk+BPGaJSpQto/fe0EtXdL17i18Jz5DYMDFbc2ZvENaDBtXV/q+cgfIAcg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540110; c=relaxed/simple;
	bh=lb3FdtmXZ529erMSGmzhPSy7EpTjJEz70QHNq9gp5aU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOE/vpN2ZX3F9J4lBzELFHwZ6DrRBVlNdjRkwc6smrOJh2QQZbTVIuQVVFKXyjjASrhkJRRkGo3gFj3OjdQnXT6mtW/loTRw7XVeld3oBgUqb9diGj/VG/aWC0u34jgs3E+O89sIRtgi/R4hldG0CFj2LNGdjtLWVu9aBSoHgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hFuR/P6n; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 04910A0B13;
	Sat,  2 Nov 2024 10:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=3gSDJcJrPViNORmKns1X
	DDGG2gwhKJjhbhUHWkJaQcU=; b=hFuR/P6nzQgLg4hUe+AJYjbLuRjsNer3j4ep
	QxET4tCIU4r9mwnRESmmDOicXA4+EI5wTjU7AxagFLNXiaPRPnE3ZtIbcvx5rbX9
	2U48YPWrgcZhm5+792LjYUT5pa4uytsTKWF1nAaqwhqOt6xCo56hzbBlB2ACKXGA
	KvUKdvsZsXHJlRklMgW2p+uoIiwfTo2wIioMjwzJPHr82WpoIHGI9y6S/QeNttGy
	VSVoOM8Sd9I/xRJSaLhoFJEraUDNwoQH70SDa2cXOcnT3FtixGsZiy5iYTtiLqjo
	olDASN0fwwJE8t/EfY0H5zeDOm6UPMLlOIKMsHd9HCYdmSt7RMRV/oEJ+Tgs5x4c
	py2luAwES2OQ2fYhntmAH+pud3lLetHaXbD5dX7qYIzSFaTrtNyGLtECJgMncpyJ
	xCR3QYCbj8G7X2MpNk61Hn83XAc3BQDJE3UPax4QxqQNqhkBCfOOyHJJc5hXrrbg
	uL3TDA6cyKc51UrBLx872tY3NhyVbKoxsG7sA9sEDo4OWDVNJkMpDfwYxL9rVUF/
	72N+vybbPONyvExjy0kDpxutziFPCe/kOPSzYeaCz+oZgJW6RLcyVHhxb/9ehFvz
	SYOAApqFEJBnTJP/daTtKRBrjD/ViyasAXcq6C4OtLktxCQzT38mbHBXWGWxJxOZ
	ZFO9n1g=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?=
	<csokas.bence@prolan.hu>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v5 2/5] dma-engine: sun4i: Add has_reset option to quirk
Date: Sat, 2 Nov 2024 10:31:41 +0100
Message-ID: <20241102093140.2625230-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241102093140.2625230-1-csokas.bence@prolan.hu>
References: <20241102093140.2625230-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730540106;VERSION=7979;MC=3604976308;ID=220019;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667067

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
has this bit but in order to support suniv we need to add it. So add
support for reset bit.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Rebased and addressed comments ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * Call reset_control_deassert() unconditionally, as it supports optional resets
    * Use dev_err_probe()
    * Whitespace
    Changes in v3:
    * More dev_err_probe() fixes
    Changes in v4:
    * Use return value of dev_err_probe()
    Changes in v5:
    * More whitespace

 drivers/dma/sun4i-dma.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index b2c1e4b9f696..9d1e3c51342d 100644
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
@@ -1215,6 +1218,13 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
+	if (priv->cfg->has_reset) {
+		priv->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+		if (IS_ERR(priv->rst))
+			return dev_err_probe(&pdev->dev, PTR_ERR(priv->rst),
+					     "Failed to get reset control\n");
+	}
+
 	platform_set_drvdata(pdev, priv);
 	spin_lock_init(&priv->lock);
 
@@ -1287,6 +1297,14 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Deassert the reset control */
+	ret = reset_control_deassert(priv->rst);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+			      "Failed to deassert the reset control\n");
+		goto err_clk_disable;
+	}
+
 	/*
 	 * Make sure the IRQs are all disabled and accounted for. The bootloader
 	 * likes to leave these dirty
@@ -1355,6 +1373,7 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
 	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
 
 	.max_burst		= SUN4I_MAX_BURST,
+	.has_reset		= false,
 };
 
 static const struct of_device_id sun4i_dma_match[] = {
-- 
2.34.1



