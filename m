Return-Path: <dmaengine+bounces-4186-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE2A1B216
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 09:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3E316DA0A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E721A43B;
	Fri, 24 Jan 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bWYdEBiI"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10421A424;
	Fri, 24 Jan 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709120; cv=none; b=evIoaBi/gECFiA6iE9nQla50RZ2/hz8Y9AU5CSLp543dSN585FTcVufiCz1iwvf1iEacRdyEFMn2qqZaY8dBNg6n5Ou0V2dEYNVwjXaJ8tTTYkADPoX2pJpwVF7W+YF3DqnoqEQlrNejtKwcyVsso2tg/kCF+NIcVmX2QcbDbEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709120; c=relaxed/simple;
	bh=00BIKWjEFdesAJiVHawtYMPiLZHbdAdarr4Sl8y0DgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVEM10RjCzsbnq4fjBmTcPqn3gjTfsuXjVoVHhl8WzADKvk+Xo9C3RzNS1gFKIMnuqSL/I6EH2ha2W8wtT14EeoB61q1RVKpOUi4Da55OIT6EOqyzt/p3zrOl+58ENGU5iSFGjm+RU/+1Oh2w3vUFEGgwFRbyPv1LGWR+TPjOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bWYdEBiI; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 67C1FA09FF;
	Fri, 24 Jan 2025 09:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=91vGKH59fvOB6uF7f30s
	PCflWM08DH4/8R/h6OH+xOk=; b=bWYdEBiIDfkr5t2LBwXOpExJcaNdyEpjr3q2
	ujGRpZDepB+Fx3X3FYnLbdlDmMxfY3wHv0NYj6BUtLajCg44fS555JfAKXu/+f49
	qu9A574fniGVyIevXemx7T1caMjd6NJr+sZSb/2sW315WOaAuQMgB9x2MqhTNkU5
	On4CKaM4B/ep3/QMX9gY8i9nJJSoKN8pajGpyixUlc5blKLnoIFkc4lHc3rmBIdg
	rQWc+cKNU99krC1xf8pOMHpVXaRbB7XDlK55Ek5GU1uS9GieGzhqx0PRzduawBUU
	sgr59jdZzZHacGyk9t0Tyr6zLp1tYoHB1trhaDB4UnsWhaKoirFEwnHtvhntNpTG
	7k/APjH6FD3pfQWHiG78iYXuFVQ9r0gdCZ4sE/Vz98Vv/lUpemkky1sKAYu0XjkS
	TVBNa2Z7F8vb1MgrF3DMe3hBUvgl8R9TtNM+FAvBBNayDlgrroxxA/FKQO/BXh3e
	3aljHpxEVc0tyUJx1t+gu78iZTUPVELAE3NbEk1ncS/zoilz1InQAfMz7oaQSFZE
	VKZ+lXImIMm4fM2U542tYqr6Er0Ni1im0U9lzAJuycrW88k4LVyM/zEpPYA7DV0J
	86WA0YFH+JE9KQkZfJw2C9vdjQrmup3iGmI+qNdrOump5JWjQLZlIIAm+UpK1VIq
	yTsUm3g=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Mark
 Brown" <broonie@kernel.org>, Varshini Rajendran
	<varshini.rajendran@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Alexander Dahl <ada@thorsis.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v2 4/4] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API
Date: Fri, 24 Jan 2025 09:52:27 +0100
Message-ID: <20250124085221.766303-15-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1737709115;VERSION=7984;MC=139577634;ID=70505;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852677063

Fix unbalanced PM in error path of `atmel_qspi_probe()`
by using `devm_pm_runtime_*()` functions.

Reported-by: Alexander Dahl <ada@thorsis.com>
Closes: https://lore.kernel.org/linux-spi/20250110-paycheck-irregular-bcddab1276c7@thorsis.com/
Fixes: 5af42209a4d2 ("spi: atmel-quadspi: Add support for sama7g5 QSPI")
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index b1fb4426c78d..f2164685d3d5 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1426,22 +1426,18 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_noresume(&pdev->dev);
+	devm_pm_runtime_set_active(&pdev->dev);
+	devm_pm_runtime_enable(&pdev->dev);
+	devm_pm_runtime_get_noresume(&pdev->dev);
 
 	err = atmel_qspi_init(aq);
 	if (err)
 		return err;
 
 	err = spi_register_controller(ctrl);
-	if (err) {
-		pm_runtime_put_noidle(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-		pm_runtime_set_suspended(&pdev->dev);
-		pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (err)
 		return err;
-	}
+
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
@@ -1511,10 +1507,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 		 */
 		dev_warn(&pdev->dev, "Failed to resume device on remove\n");
 	}
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
 }
 
 static int __maybe_unused atmel_qspi_suspend(struct device *dev)
-- 
2.48.1



