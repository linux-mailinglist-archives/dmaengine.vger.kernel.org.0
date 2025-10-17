Return-Path: <dmaengine+bounces-6879-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC93BE811F
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 12:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D5874F6332
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C372D59F7;
	Fri, 17 Oct 2025 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijvcSNA1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921D3346A6
	for <dmaengine@vger.kernel.org>; Fri, 17 Oct 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697007; cv=none; b=D+xrXjT2vA6MOyMvMvtVDGZ2hHC08+3DT1O9+F3eayAK7XdbbWDbeSy0HiMP0iaPf/XRdcx6nU/r59E7wwf5mxreflBKN8uaOpx/pbwIbKcuTuQlw3hy6Qc3PnkKniLVOiPvv52qjEOJJjmdN7zd4+V5NBV2VHH8bvV5dR2uX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697007; c=relaxed/simple;
	bh=OzK0aYW2LWITX9fdd4z7rDbgFG5oDHlyFtFytqntWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzD+1bPnhqynbT/aE5C45npROtjnc3Bg1gFgJMhtjDYNmDyi9p274/VxYd38v0JOVPicRYsC0XeFE0svonK4aYe8HvYmTWkP7wwBPnjO11dQR8O00CcKlZmQb7+sLPFNQyykqewoYwlgljsmdvR3+WEhrkMccSj7gv9hWDaTeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijvcSNA1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d50882cc2so332847766b.2
        for <dmaengine@vger.kernel.org>; Fri, 17 Oct 2025 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760697004; x=1761301804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=ijvcSNA1o4yZw8Bs0KBl8xFMPpR7+lO+gOIztjrCYiKnQMOO01o7492+R9qkApsGFC
         pl0kiHiG6uZCmJ109/nJeE8sizT4jl1ohuBtwxKRPC2xjXEqsmNwiQDWJN2X/ZAEvlwX
         w65+PeZ184vO8f3/Zh0xUPXr2TnsR5Hj3NwU3hATELuBvgjpJ7e7qak0fNGKmlQFkjDc
         iSvA5S8IPTok+RF/KXWFEJ9WjNh3TtmEV9qaRrFKpNKgNsgK/rroRyDG3V7P2iyFG2T3
         cTPZZ8W1IoliD6UqpRTxd0z7KfWdSTqWjb+15y225CuoQgvTimOhmkGtVews61UExMRe
         3CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760697004; x=1761301804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=X6Cd+UrmZeW4es7vHXrPJFLFxgKm38X1wrxKCIRabyJrer5Sj5y5mIeiDMQT+9l73U
         ETX2dJJQ/cHQDYOoC0EijcLPDP428Cico1LFpwCWFpGIbK2xZ/IWKwIHSwdRrxCLMbvd
         /X65VqA7110HTzkcEj3lxa8Mg21VUXvfIJo5FWTYdqX9wOBChBUf5a/owR4v+uAeAkSY
         oNkZxmeazOuyzyO3/UOC3pl/1xLgmq9dXNpU0/p1XkXVJ0jUp5GB16R9oh4f1QsZB456
         13mng/1EiitGd/Y9nH5FjUk/gn6AaI5RC4DrSLdpPTIbriN5ZzhVWnD6O9doDVZKMDcP
         D/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUzxjpEC9daHqDjExPqgCfBlt4NbrEG9/tC4z9r7laoh/AiqskDaVCzG6xbL8GApPH3Qlt5bmpOTRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysiM2P07U8nHv3xmLyNlpggAFH54Nv27J7PEZuEiFiBmTQkKYf
	nZZS52RUKpd0KdKJd9rDAZziazwPid7ScscFIxVHFe/en44V96M2h/sv
X-Gm-Gg: ASbGncsT0EIL4uFQYgFR0o60N4DKUEYMX9UHCBJQuqGEZ6thEACYOr7UXouS6mCIc57
	CTmiFNM65bW7zx+UY1yhicrTZHYExPrue+jWmm0ny3fQZWT6fmXNRkz+7yCsXwyPTJR4JEW8DIa
	ODTa8p/A8ZBeKOXT4zJhVCKeeBMiNMvQSlKBWVkSweCIt4VuCB87WueZEZFwiB/UodkJ8EAk8D8
	laa7GM6Gd6D38SfxTgLi9RcuRFlffbHVa0UTLoTVx+B51gfGCPsZa6ZyTCSJWPhCqytsncFomP6
	r3tTpg4L5M/k6MLg+20zyag4TqiInng+6N+KTcctRaX3xm/qfvHHZ88jMz5LEZ9o6B0XJsWlT4t
	qlkH0Y/OFHFBPQgwTg9Msy1qUL+Rj2YWyYjo55GyLjCOU5IQHIuDZgAwcpPCSLVQ9UbZ20epnh6
	OM105uzqgvr6ttMIOB
X-Google-Smtp-Source: AGHT+IF5gSR2M2MiuN3SoOR9pgQV4QlGdicE+1VsOagna/9hxbsiwFcdvaUC577ZxJBWxnrkc06fEw==
X-Received: by 2002:a17:907:9607:b0:b3e:26ae:7288 with SMTP id a640c23a62f3a-b6471d48331mr342475066b.8.1760697004054;
        Fri, 17 Oct 2025 03:30:04 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdacd88sm780513166b.43.2025.10.17.03.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:30:03 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: p.zabel@pengutronix.de,
	Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
Date: Fri, 17 Oct 2025 13:29:48 +0300
Message-ID: <20251017102950.206443-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017102950.206443-1-a.shimko.dev@gmail.com>
References: <20251017102950.206443-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the power management code by removing redundant wrapper functions
and using modern kernel PM macros. This reduces code duplication and
improves maintainability.

The changes convert the suspend/resume functions to take device pointer
directly instead of the chip structure, allowing removal of the runtime
PM wrapper functions. The manual PM ops definition is replaced with
DEFINE_RUNTIME_DEV_PM_OPS() macro and pm_ptr() is used for the platform
driver. Probe and remove functions are updated to call PM functions with
device pointer.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 31 ++++++-------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..8b7cf3baf5d3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1314,8 +1314,10 @@ static int dma_chan_resume(struct dma_chan *dchan)
 	return 0;
 }
 
-static int axi_dma_suspend(struct axi_dma_chip *chip)
+static int axi_dma_suspend(struct device *dev)
 {
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
+
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
@@ -1325,9 +1327,10 @@ static int axi_dma_suspend(struct axi_dma_chip *chip)
 	return 0;
 }
 
-static int axi_dma_resume(struct axi_dma_chip *chip)
+static int axi_dma_resume(struct device *dev)
 {
 	int ret;
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
 
 	ret = clk_prepare_enable(chip->cfgr_clk);
 	if (ret < 0)
@@ -1343,20 +1346,6 @@ static int axi_dma_resume(struct axi_dma_chip *chip)
 	return 0;
 }
 
-static int __maybe_unused axi_dma_runtime_suspend(struct device *dev)
-{
-	struct axi_dma_chip *chip = dev_get_drvdata(dev);
-
-	return axi_dma_suspend(chip);
-}
-
-static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
-{
-	struct axi_dma_chip *chip = dev_get_drvdata(dev);
-
-	return axi_dma_resume(chip);
-}
-
 static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
@@ -1590,7 +1579,7 @@ static int dw_probe(struct platform_device *pdev)
 	 * driver to work also without Runtime PM.
 	 */
 	pm_runtime_get_noresume(chip->dev);
-	ret = axi_dma_resume(chip);
+	ret = axi_dma_resume(chip->dev);
 	if (ret < 0)
 		goto err_pm_disable;
 
@@ -1638,7 +1627,7 @@ static void dw_remove(struct platform_device *pdev)
 	axi_dma_disable(chip);
 
 	pm_runtime_disable(chip->dev);
-	axi_dma_suspend(chip);
+	axi_dma_suspend(chip->dev);
 
 	for (i = 0; i < DMAC_MAX_CHANNELS; i++)
 		if (chip->irq[i] > 0)
@@ -1653,9 +1642,7 @@ static void dw_remove(struct platform_device *pdev)
 	}
 }
 
-static const struct dev_pm_ops dw_axi_dma_pm_ops = {
-	SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(dw_axi_dma_pm_ops, axi_dma_suspend, axi_dma_resume, NULL);
 
 static const struct of_device_id dw_dma_of_id_table[] = {
 	{
@@ -1680,7 +1667,7 @@ static struct platform_driver dw_driver = {
 	.driver = {
 		.name	= KBUILD_MODNAME,
 		.of_match_table = dw_dma_of_id_table,
-		.pm = &dw_axi_dma_pm_ops,
+		.pm = pm_ptr(&dw_axi_dma_pm_ops),
 	},
 };
 module_platform_driver(dw_driver);
-- 
2.43.0


