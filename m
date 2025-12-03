Return-Path: <dmaengine+bounces-7484-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20128C9EEF5
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 13:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF2234E05A0
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935BA2BF3C5;
	Wed,  3 Dec 2025 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="C4sjjgNA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BC2BE059
	for <dmaengine@vger.kernel.org>; Wed,  3 Dec 2025 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763749; cv=none; b=knYvlrElgiRDlG32BRGtGLNffqTHBqmhiVzRcRcPCmF0W7d0N75M8CA/Uad1hq2YKio8lPCyUo2qYJBwLb7/zhsSG33vNfFbSl4NgluffDUD2aUSbiADUkMvzhoaD64i/vFijJYcODi/gDVWZofH2irXD3AHTNw/6fSkVD0HOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763749; c=relaxed/simple;
	bh=P7lSmpig9zvj2k3eR7cFCUad6kDfPxhEgkhD6MAg9ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFCtELnh2kOkUBsQtQ72Z7taM/TKYxmoPNaGKCmNPz9RlzjmV2kD5Tepwq0A6beR8x+YM4hI48O0RMTLC5CDkItCNBEAjvHpkJM8ogiclfGcHbvd1AG/aT83qubBdQ2NLhr8CkcbDzF+yieKEuceUdNS5BbblrTbSHkN8wzu7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=C4sjjgNA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8804650ca32so56594406d6.0
        for <dmaengine@vger.kernel.org>; Wed, 03 Dec 2025 04:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1764763747; x=1765368547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HY6LofQj0a46MQGd5q5uk/dioxwk+UPp1qGJ6sCZzPw=;
        b=C4sjjgNA8FMDK1xGguDM1lBjSRBwp1u04sFFvfLypnEJa/mPP+FnURA+ZEiLeyWdad
         usGyR+kWBcWnSeB6Pgf4WHnyGHrGt/XT83Tz4Rs6g1zQxBp29j8w0P77MH0o3KE3xIU0
         low89WAIzGXjZqsSeYJffjdwBJhw8AP+N3TdszY+bn/msHMISjKrmjPzP2Nc+1Lt2lFv
         H1l/NG/300+mOjV3kofjuQrmoV781VK2myIc0uNUJQL+xV/BfDTUD3lL/+D1E9wFY+vh
         k4jgGH2YC8OlXmpROkLdwjz7A/YTTDU8c8lrzoSlB2uYyKAkZWWGzq7iuj17rwhNxBZM
         EjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764763747; x=1765368547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY6LofQj0a46MQGd5q5uk/dioxwk+UPp1qGJ6sCZzPw=;
        b=bHuoh6s8HONQcZJ44Ayk0+V5T+KpuCYVcPn4tXcTshLVEqvUFkE5PdKlJ0rRUorKMC
         iq22j6UIFEhvcPtWm2h6JkicbKDe8RHC9atm26QqErE74bapG9Z5DE7LoxeLbxm8PkLW
         YeaYz8zPl/q3UTdROxrwBPhc8Gnp1vok7TVGZvHtFQyeb3VMlBm912kSMeccCyWkhZcr
         F5svoA2jDzOsnh5TpCd8c34hk1tzP2iZ/U9vPiGubowaNuoyZs2PiUh4WU6bv9g1YesO
         10bMhTAlldoeDb5RuMTStSP2Y61V03HcdMAL0HTiwil0VxyWqy4pENyW3f0/FhCcqWiY
         coKA==
X-Forwarded-Encrypted: i=1; AJvYcCW7FVQrf9F6GHicr4DUPSbRjTGAOyb7E05s3s0DmR/vkQ0cfYqU0iVlXZlHOqVbPvAPHjQ0SuXOM2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNyrcsRwUUbfd3FKSUSBROIkQGqTzj5x/kgA53/2bz2xqccll
	F4AexXQIjZC39uX6ncYHpzSqSvd1qBe8c1qOEoCstnpGd2BrY5axmmd970NGjc+JiWE=
X-Gm-Gg: ASbGncuP7YyG0kKCo4CH8mohSBiBKFlb3gsn/lciqVqYHrrdtmVXcvoOLXDwblMNZES
	k6SWT/cq3OfSsd5/aohEZ+PIIVMaB6qmxtuy9oSZwqZjS6JdkUgaWjx1LsiB0n4lyARjWGJt/tT
	uHbSvKEIuuo0K751iH+2ehctimkVoPqpvOKPAYJu+FmsCGajUmZdCMbIKhfYHW3U6nZTRY4r8hD
	wJ+ntblrlqFfiMFgOvZvAdm2tbkQkcCylrVQD4Qt0VjgzjbxJA2W136RGytzxIo3lrYpZRbTDWL
	XlAuMEwnUWGYQQ6ptztA94PhPRy7pcYbiNytlQUmDoSXLUxDCl/kpgUwPIuJ74RFudlp+Zs68ts
	7Hmhwdefp8GAwBYB/wpLqkrR393Mf3xwMS5xPl2ZEv3BgYOihUuFXen15qcbp7/wEn6aeL2QkHl
	I5cCCx+ILay2IypKq7ageydvdIO/xnJwkXHQaGnLRlM7Oc+1JXaoNOFkY=
X-Google-Smtp-Source: AGHT+IEvNXdED/r4HNe9JNsgMM/9LcSRInAqa0tAj0HpibxFF7yD3qYBXk2NGsNRo5JcknABVsIKhw==
X-Received: by 2002:ad4:5aa5:0:b0:880:448b:b893 with SMTP id 6a1803df08f44-8881956a88amr25245066d6.50.1764763746646;
        Wed, 03 Dec 2025 04:09:06 -0800 (PST)
Received: from fedora (cpezg-94-253-146-247-cbl.xnet.hr. [94.253.146.247])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-88652b49390sm126308036d6.32.2025.12.03.04.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 04:09:06 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: ludovic.desroches@microchip.com,
	vkoul@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Tony Han <tony.han@microchip.com>,
	Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH] dmaengine: at_xdmac: get the number of DMA channels from device tree
Date: Wed,  3 Dec 2025 13:08:23 +0100
Message-ID: <20251203120856.1267671-1-robert.marko@sartura.hr>
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

Signed-off-by: Tony Han <tony.han@microchip.com>
Reviewed-by: Cristian Birsan <cristian.birsan@microchip.com>
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


