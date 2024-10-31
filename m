Return-Path: <dmaengine+bounces-3658-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FAA9B7AA9
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 13:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB841F252D4
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569FE19CC33;
	Thu, 31 Oct 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Kvf1xsAn"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180C1990AE;
	Thu, 31 Oct 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378193; cv=none; b=a9MLaVlmnIpHgSFPWl8oT2mFFjfVqtEPY2YGYmYRVx3EWYTTFJqDPygozG1A+UZI0IReGm4VZu/j4oKdRtaSlcuNBRMpjMZs8npWvuLOnkl6f6nYTLO8x0FESNiLX1JpiHQ8GMmHp8Xk0T9DbkzwEQdnTFJn2pHqim2sfwY/10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378193; c=relaxed/simple;
	bh=1KNRHX66EFNQnHTBjG9iI7ITlroZ/Z7tpKvqoyt5S2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4oauhWSOvMXiIWyeEQC8/170GWB2DkuJ0mw9hLEOkFEXd2Cm0mS7Wie9A1FIwe3seruK/KBMdxsxCvJNopLZhJvfSSuAAihx4Ne6QmJGp8n5F4tLrhJqUndnWUl24NeKsS3IL/VweGwivrNW7M3/Npr5rhYzsGVbZjfASfZAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Kvf1xsAn; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8B760A0E19;
	Thu, 31 Oct 2024 13:36:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=LNpVFYx8OTvMo9bgzpXM
	QTFYCg9msi89VC+X0jgjFKg=; b=Kvf1xsAnCnBwryoZRrlOqy+uppoG2/NZtsMF
	/Rz1fWEy0PjmOvCrqV8zHecPxWYJHS+AhV2F/IaWyxlCJnWjJkQtD7+uMIJdkAE+
	EEArxCjTxiT6YpOwN8u4B2nyzVOF6p6Z/8hHjH8wR2XAWBgMers0o2GmqYMmX+HO
	cN2k7+N5tVg/GtFZkMNEZbt4Ar5rMrf39dqKunia1L99jePI1YdupIC3pR8UcBda
	T5wmhfMe1luzCjXAZm0Yfuo7hr9UCVK6R4YPP9LB/YGSItjYh45BO9teIEPabnAC
	zk6joZI+WcOSE+ksuEpiG8UQ0IC75CYFncWrQIF7lmnmmpgHIgXtxuXbBLi5aOVb
	HGDjbsgqf/i8WTdCWylVUlkG7u6cz0xF4cxNDYdJDqgwR2MVgpQrlDTvUZGv1CQr
	r+id5rsT4DvyIWNfIP425CfHraxWqDVai4SndUnEpMu9FlSD3PzTb6xCN2BcH4l6
	afpzUlRUeqISBdLqDDvcDlau/9dz9RbPTTzk24H3gEA+9sONvzU1Ry1p0dqnzwRn
	Zn78T2QcXN9e5ceL9E0eDNWoNe+A76k78eZr3mNFm6BtNhpd1BbZ9YKpQ1U8s1C7
	F0DAmaB/KIU4T/T4LRJvZ2nbpg35FfuF73XE66dqTOE3jJK4tMsvno8sR2SqIDIa
	rZxMW0w=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
Subject: [PATCH v4 02/10] dma-engine: sun4i: Add has_reset option to quirk
Date: Thu, 31 Oct 2024 13:35:28 +0100
Message-ID: <20241031123538.2582675-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031123538.2582675-1-csokas.bence@prolan.hu>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730378188;VERSION=7979;MC=3052623669;ID=207182;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667667

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
    Changes in v3:
    * Use return value of dev_err_probe()

 drivers/dma/sun4i-dma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index d472f57a39ea..4626cc8ad114 100644
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
+							     NULL);
+		if (IS_ERR(priv->rst)) {
+			return dev_err_probe(&pdev->dev, PTR_ERR(priv->rst),
+						  "Failed to get reset control\n");
+		}
+	}
+
 	platform_set_drvdata(pdev, priv);
 	spin_lock_init(&priv->lock);
 
@@ -1287,6 +1299,14 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Deassert the reset control */
+	ret = reset_control_deassert(priv->rst);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+			"Failed to deassert the reset control\n");
+		goto err_clk_disable;
+	}
+
 	/*
 	 * Make sure the IRQs are all disabled and accounted for. The bootloader
 	 * likes to leave these dirty
@@ -1356,6 +1376,7 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
 	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
 
 	.max_burst		= SUN4I_MAX_BURST,
+	.has_reset		= false,
 };
 
 static const struct of_device_id sun4i_dma_match[] = {
-- 
2.34.1



