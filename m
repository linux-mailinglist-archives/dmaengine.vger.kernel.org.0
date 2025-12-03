Return-Path: <dmaengine+bounces-7485-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44795C9EF04
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 13:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB728345225
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 12:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54A2D9499;
	Wed,  3 Dec 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="d4wchvhp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CB2BE059
	for <dmaengine@vger.kernel.org>; Wed,  3 Dec 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763942; cv=none; b=rOX3XA7oop3l29Z/TGiERbHxsd5qUEjEjFHXotFP+zeOb3IbtTzFZceLskEm21yO/c3Ty0uwqcXernAZwvGFgUxJVM9esxDIFCsCoVZXbHMMjECXHlv3g4SkkQtXM/RN5xzCQGtS/nGZkEThRQidLqjO4TpKFsO60sFhPJSYPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763942; c=relaxed/simple;
	bh=n22d6mzCMmzziGtUvDvzO8PMA1/MB2OVxO8lfoFv740=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzyDqFQ1aDNdOs4s3OhkmwN6xeMcnZ7g7y8sXqhJHQw1lZMQHM0k+K0JyojPJZvkn4zO33/BywJ/O6VKLiF36ngaxcC4TfvqMcVTnWgih35T+pd6ly2eMEkdJgaN2OCzx1TLdOHhRxoKY+PJNmGZ9sVraOVce2+Nsh+Ho2cvSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=d4wchvhp; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2d6df99c5so91367785a.1
        for <dmaengine@vger.kernel.org>; Wed, 03 Dec 2025 04:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1764763940; x=1765368740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmZ1Nnr8hYEbUibLvWDZg2doGxe3gLL84xuGJmKYhWk=;
        b=d4wchvhp/fdVV+86dGpn9e3BhEf1nc/r/WIAQfwV1s+gtwvlkGktoLOK4HDBPGRIbf
         74d1PGTEHFNHgVfSuqgm7jWwauiSJMwjmOfGoKH0jwLKeK2hbkvxGGdV0j5UhuogI/NM
         qgScIyfrBOQXA5SkuOPwg993LjJDnV3Um6N0HZbZVFImfFWoZbAm9Dldq/aFzf3xMIFz
         GtgEhd/DkaosYUOy+DqTxlUPBuVpCCJJRsq+u4G1f41AFK59QcL70t5K58agTQp4UyUR
         VfoMjY+FOs0nY1do1MY7V+XQp1caOlJDyWE/matlOvHaZh7eL0bzqrRMY3fEhqmk6M4v
         tbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764763940; x=1765368740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmZ1Nnr8hYEbUibLvWDZg2doGxe3gLL84xuGJmKYhWk=;
        b=Jpq5Ocqa8gV99tK/eZOhT564urKUYJVwY7AynPc08uSJ4wOT5qM39H5lLUzrHqKenY
         23a1yaIGvmhBnpMpmDAtID2jD0MmiduZzM+Hy9U6xfzNrMy0AsIhOYcnqINsUYT1EPcz
         DFVNYdwfai/xHRsdX0UCs0LqdnADNrAk1OwZnqc4zbdRrOeGEWs11P8ovoyFjL2gwfIW
         z4TAuzuo6+gJF3ncSbbSLCwej8yFmKNYlsTGskSIPel8FRuc/VaTSQOBgd4aWIGGML9C
         /n78R5TuoWMeQkP7KYNzD0Nj5I2e8u+V1vl7hVTZIQJWXcwvN6BJ0ObEY/T/a3uhUH8U
         L2ew==
X-Forwarded-Encrypted: i=1; AJvYcCXiD/jQbSP2z2NWuhnGQeyD9dVCPjwgvaSN5BoxkeBDhPSgTeyNy6Z2NbLIYSwWeGG6VtkdaFuYmzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5iLSCidpW+gDEvo5+Pt6WZazfILjcYVf+FHsuGEs8AamcAgC
	l0ZpipwnWExeCsmPxaEgj7q+xnubZr5Fz911X2vTKvGeSNtIDl3xroBKa6vQWHyIy+Q=
X-Gm-Gg: ASbGnctN8aPXuyUCfNsNFzJc6YeqmVb8G5bejhnwGnARa7qaPU93pen3Bcs/+dbMBm/
	ez+yeUQNbwSMTWoG6cWYX6/pUFFNid0Cjjh7dlbkebSNo/v5LkjlmqLHEOa1mLIWRwfikRJSbRk
	W+k141GSDl0z3bzBuX3xiro++10KbCQ15wwb/+NwgAeZFLDnWCD+F9ijFwmuJ7TH67LhyM6RsWA
	qeisjR8rTipptxTcWQFgdfsE5lHoPx4jtXtA17OfZUlu6Gkz+qhoDOoyjawUgESsGVlb7eu9mdP
	JsO05V+C9GCXhOQZGNPUJOUdij4axvJO/VQLlg+UDE+R2K3LKlnM9ulRPCf4owOkPl4yXGPtd34
	Xigkne8pNVyODnOVZMbr5hQuZcSf+SDh7alnCNbqPNhd7XBFmoWYhyfIzAlt+9OQTWcB7mGxpGf
	92xQK3q2QhAvLZYBfvOdR3TMY7seJpudrKsLpDoaWQkuu/
X-Google-Smtp-Source: AGHT+IG6GEiIMrlIJ16aAfiqLcEureDC4oQURs3Fa/1GaHuA+RFp6sYuomKRuRIY11PjdxnazNDFvA==
X-Received: by 2002:a05:620a:1aa3:b0:8b2:faa3:5639 with SMTP id af79cd13be357-8b5df10bb7bmr297923085a.11.1764763940117;
        Wed, 03 Dec 2025 04:12:20 -0800 (PST)
Received: from fedora (cpezg-94-253-146-247-cbl.xnet.hr. [94.253.146.247])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-8b52a1dd353sm1294658485a.49.2025.12.03.04.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 04:12:19 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: ludovic.desroches@microchip.com,
	vkoul@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Tony Han <tony.han@microchip.com>,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH RESEND] dmaengine: at_xdmac: get the number of DMA channels from device tree
Date: Wed,  3 Dec 2025 13:11:43 +0100
Message-ID: <20251203121208.1269487-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Han <tony.han@microchip.com>

In case of kernel runs in non-secure mode, the number of DMA channels can
be got from device tree since the value read from GTYPE register is "0" as
it's always secured.

As the number of channels can never be negative, update them to the type
"unsigned".

This is required for LAN969x.

Signed-off-by: Tony Han <tony.han@microchip.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/dma/at_xdmac.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 3fbc74710a13..acabf82e293c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2257,12 +2257,29 @@ static int __maybe_unused atmel_xdmac_runtime_resume(struct device *dev)
 	return clk_enable(atxdmac->clk);
 }
 
+static inline int at_xdmac_get_channel_number(struct platform_device *pdev,
+					      u32 reg, u32 *pchannels)
+{
+	int	ret;
+
+	if (reg) {
+		*pchannels = AT_XDMAC_NB_CH(reg);
+		return 0;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels", pchannels);
+	if (ret)
+		dev_err(&pdev->dev, "can't get number of channels\n");
+
+	return ret;
+}
+
 static int at_xdmac_probe(struct platform_device *pdev)
 {
 	struct at_xdmac	*atxdmac;
-	int		irq, nr_channels, i, ret;
+	int		irq, ret;
 	void __iomem	*base;
-	u32		reg;
+	u32		nr_channels, i, reg;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -2278,7 +2295,10 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	 * of channels to do the allocation.
 	 */
 	reg = readl_relaxed(base + AT_XDMAC_GTYPE);
-	nr_channels = AT_XDMAC_NB_CH(reg);
+	ret = at_xdmac_get_channel_number(pdev, reg, &nr_channels);
+	if (ret)
+		return ret;
+
 	if (nr_channels > AT_XDMAC_MAX_CHAN) {
 		dev_err(&pdev->dev, "invalid number of channels (%u)\n",
 			nr_channels);
-- 
2.52.0


