Return-Path: <dmaengine+bounces-2815-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3032794AE58
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 18:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CD51C20D80
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B37412D74F;
	Wed,  7 Aug 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8GMIDDu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2B2D05D;
	Wed,  7 Aug 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049222; cv=none; b=bKbN76wqqLED08kwmOyU5rWxdjRMney3y/fr4FYcUBNaSDdClLJjGiVgb03WA6j7icNm7E6gqG7UFa8lUq4ZETGKhmFZgEy8ZXX+ojwYpdtGm8eY3NOh/QzfeS19PC/gmWv0rSd2TlCI7d5MS9j0eZ6X4FRg67xvtwqUfOCeI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049222; c=relaxed/simple;
	bh=dwWYm5RLTzDBW2iYB2I3Zd977yQSE9GENluUMyWCWw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kIHvvHg8ItdNscwI1gbI7+YR4byufbPlseQ36baa0dPwh+A70ziA0wVZM+hmblmAC7DWcd7CGfuooWpq8OCTBFSIYl3lZU66gbv4kHQrT7arGcdz+2cvaZps0gBNH1cmLv8pW71dEfdvALJ4XdbZVnoMK3Rwxe0ALUx0olvkxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8GMIDDu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc57d0f15aso124355ad.2;
        Wed, 07 Aug 2024 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723049220; x=1723654020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhZ/KU2xRJ7VzklvUFPO00NSkyxb1fAeyVcGv38Yjz8=;
        b=L8GMIDDuJS73kW5SGTJ69wfFpzFesH9Jtydtcpq1tYcoQuKwsNJglZE8745N9ziusu
         5yZzFr84VZ8zgxzD3TdPwzBQvYEm4yFHUkymy2sjpo3MCkqmw6++6y3lUl3LqkoM/hmD
         fDzN4inCxMZ0+DmmiUbdiwwsNMnz34tv2I4mU/wyLa1WAmNBw16lGJjyg4hFSTsKKSTS
         vsNCTWkT0DXQRQL6KATtbyyIHU+/JjfphMEVXkbMaC0lQmQdbSuiZiCy6Ty8TLLeWipg
         5B2NSTisN2Y41MlUSgaVedNSeVJeGrOUy4JteekgN6eB+bPzoqYZaqB6VM6RQUPNaVyc
         gy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723049220; x=1723654020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhZ/KU2xRJ7VzklvUFPO00NSkyxb1fAeyVcGv38Yjz8=;
        b=FsBc8gAcFtnQ3JCVB4ofLw7xcXXYN0HW0xlSvkPsg1IIVPfGKTpcN457Zw2R7U04K9
         O5CRXuK2CeUqKA1yyoozgroX3NCE/kT6BFIYJNPA+QXeFLYGiI9MQ/o7U+Qx+irfYHOC
         AxaEEtpb1Y+EOFKsuOJEnbc3viUNBDurwSetne3IUPjDO+aUlZmNkYs6jdCld0JcX+hy
         Y2dc0irbj7ce8/AUzbO0ipYW35oIH5gbfB/q3pHpMe1h9UsCmh84BdcXRDNI18LZgkFL
         1txWkQRIgBNfPTAcOy5L4ZPkw/piuohgJNCtkEPFskBKD5tGGFPEVB7JkGDyvg0P4z9+
         6gKw==
X-Forwarded-Encrypted: i=1; AJvYcCWH+DKglbWoAjuJYnSzujELEdBiMX71oiQ5qnx7Yp2pOG5RCV7yjdbj3hsfJu2shDQHBUIXRn4tgwEvNU8QlxUUE1eC5a/rhPZTkoKJrXT2/safeCpcd1TmOf4oujM5S6JCqKzDxA==
X-Gm-Message-State: AOJu0YwfyDRzyB++D9tA0/wCc5GQUB6hJJYv5CUUxvGIcTGELGk2eCMR
	g5YefkwlLKO4PkBeMhwwl41WquGG5SAPwTjypiZn8wqQhiuNRbo0
X-Google-Smtp-Source: AGHT+IH3o23gRpRg0Q/HMUir8oyxHEa4lhoLc8wy5D5R+0IaQo0DbDFd8hmvk2gLUajh/swsv5ekAg==
X-Received: by 2002:a17:903:247:b0:1fc:52f4:9486 with SMTP id d9443c01a7336-1ff5751c912mr144199885ad.10.1723049220390;
        Wed, 07 Aug 2024 09:47:00 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5e1c:17b4:a72d:e3b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59059f6dsm108332385ad.132.2024.08.07.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 09:46:59 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: vkoul@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: dma: fsl,imx-dma: Document the DMA clocks
Date: Wed,  7 Aug 2024 13:46:54 -0300
Message-Id: <20240807164654.53472-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Document the IPG and AHB clocks that are needed by the DMA hardware.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../devicetree/bindings/dma/fsl,imx-dma.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
index 902a11f65be2..5cf80040565f 100644
--- a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
@@ -28,6 +28,14 @@ properties:
       - description: DMA Error interrupt
     minItems: 1
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ahb
+
   "#dma-cells":
     const: 1
 
@@ -47,10 +55,14 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/imx27-clock.h>
+
     dma-controller@10001000 {
       compatible = "fsl,imx27-dma";
       reg = <0x10001000 0x1000>;
       interrupts = <32 33>;
       #dma-cells = <1>;
       dma-channels = <16>;
+      clocks = <&clks IMX27_CLK_DMA_IPG_GATE>, <&clks IMX27_CLK_DMA_AHB_GATE>;
+      clock-names = "ipg", "ahb";
     };
-- 
2.34.1


