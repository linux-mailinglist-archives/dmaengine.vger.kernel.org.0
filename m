Return-Path: <dmaengine+bounces-1004-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF316852914
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 07:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915AA2841B6
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 06:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2221428E;
	Tue, 13 Feb 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+MGNRiQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D51426A;
	Tue, 13 Feb 2024 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707806385; cv=none; b=paPfjtlnWGykuRUKbL33XeqR10I+5OmVDnVJmm28bi1IjNwZK8cH2v4pRwi2joxYcd/K+fdf6lyxHYy8fO1ah2Emcp3UUp68PmFtFMQi+WGFtYBJjpFUiUprDVoFiSKOSNEtk/ix26QFsrgh6/y8cNt4b3PUvFYgwLsoLeiEBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707806385; c=relaxed/simple;
	bh=5z9UIrzaRsQ7ZunjBz8WH+0j8VWBYxAQUZhJg20X9eY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=h1Y3Os/DN5VAYniJ6wdJI5n+3gMq1PNG+ueCWzWA+ogSvgEWvnh0awwjuC0sIgOFzHMxMHQ95f6Orx8YJX4MFy6fPijiBv0QPUrZaYbs4GxV2Dv4gmkUU2pPNwiZ2GAbXbFJdZqtQ8I7CuezmmUufzMyKYiS+Pz1ES4kBhcxwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+MGNRiQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso5103237a12.0;
        Mon, 12 Feb 2024 22:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707806382; x=1708411182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8pt6VHhKtuQrCkrL4eYU+g664w9Q1Xy3QJwOydZtt8=;
        b=Q+MGNRiQsqnUizrS6rSXTOr9KDrjdQj321PCAXf31mYLucXFnp1OLnfqHVYpDlD2OS
         Bz5IcU68W1qrH3vi4aqLcG/x+BEWAplluI3v1+aGuTltowmIa6cvGvRUNbzRpo56k31K
         TD7RaWyYdAS7VYB0nEkJHxTQf7EC+FTnmEoIeV5Kz4wSsULiOxYDmCrpf63OdqV8Wi4M
         BLcXmCPdh+EMd6R7ZAcYh4HN8+mjZTlk27VGpjwZfrVbd8nGj1o+C2l597WYK9q5MqDb
         QL6LbaF2DTo7RrfAw3U0PxdTzzuKhnvnbM6nk5mmEKNy+IJKAlX5F2jRo4Inx/xFuNOi
         xKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707806382; x=1708411182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8pt6VHhKtuQrCkrL4eYU+g664w9Q1Xy3QJwOydZtt8=;
        b=p9Mj/fnqz1Jb//vQyRt5uEqoNF59Blq9AVQPoaBW9b2pSnzxVZ+NBT+4ZHXVwxB3hU
         hDCq51jCekpSsFKYJG9Fh8Is2BgfCwL2Ihk6Sb7Si9oBdH58Xn/0TY2OOkMOYdLhUjNo
         huEnnKCPmzEpryG8hD258j5jMrSvyKnz+x2pWp1LeeBjv8/2ET4S6whQBjgQD56xCQ+O
         MLIhfrH+to3k9MNQiPhkOJ1rl1etMnMjlLcASzO6p+1Y9V1j7CZ1tBblj48W+kqQGd6v
         yEIFxnQqTKRAMnV3e2k/u11Xoly99FZuvNxQJB5a24CMQGT/iR1GRjds8KPH0eoAHxnA
         wZcg==
X-Forwarded-Encrypted: i=1; AJvYcCW4LWRuItuFs2J7/b4wuT92fu8sUKh6eHszMSGWzuQRQNa/DCnR3IofK2fn0GRm6NWZ8spys4SlV41rD8ycui7WyO6600RcuQfZAHGkeMw+8FmUTNUumnVCfQ0kqCFa7ZQk2F/+EAESrxBO8mqY4xzBUXx2/rqEVN8hcUubkmNV8/Y8ZQ==
X-Gm-Message-State: AOJu0YzRU0O8Qi6wbyNe0zo5jMKX1hs6aUzfLEllCYilQZYLsgv44NWc
	K0cYvrVmJwKPFxtg/v0zB00jYcOIjIHrIkn8vCUiKoZzFGi4zoyv
X-Google-Smtp-Source: AGHT+IEqTmOc0sq5TASgr87A4NKy6RXgxM2CfARszUCki67UusO4d/oDgeciP7n5Wq9/B0mV0FG0vQ==
X-Received: by 2002:a05:6402:22ec:b0:561:f77b:c0b0 with SMTP id dn12-20020a05640222ec00b00561f77bc0b0mr366141edb.39.1707806381728;
        Mon, 12 Feb 2024 22:39:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmM20RiFucNWcWudlwle5UIyivsj+VmyDj7ESp8ItNoGl5Yc18W9SP3AlsHqwsqVhGWO2jvgKyufk2AkNY/kAD7VeW+AyCnXMFpNiPKQE3S/sTlke2zF7/3CBJL6u/KU058BjWwOxnhM9KyOH/OT1e7xPJ+XrN3Qclo5vCGFpkhzC0uM6UVp7b3W5clFIF3+c0ap7yZxWuPUH8SSwwE3/okSnIeLpnOOqlMcrWHE5+ZHlBEvgpSVlwDRm5Bb4QfaLsswyoKzvTAWoIwwj3ctKeudkLu5+8ggfaIUscp8N3YO7D16b5lH2WMzFppilQ/WYcW7t8DM8Yb5sP3RKNnI7XSiAhQYMK2JQPMLlQY/MiMiZ9enOfMxvC11YJWP5KpcqWyhPiy40pWVS5tlb88WdcYF6fEs3I1rIfmmHdYdlYuC8P/uhwKKWjS+XIFHD6Nhdfyz+iU7ca6CBmaMbcDGUc7rjLOZgrUXJh
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id fg5-20020a056402548500b00561814de0easm2847074edb.62.2024.02.12.22.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:39:41 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: dma: convert MediaTek High-Speed controller to the json-schema
Date: Tue, 13 Feb 2024 07:39:19 +0100
Message-Id: <20240213063919.20196-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files. Introduced changes:
1. Adjusted "reg" in example
2. Added includes to example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/dma/mediatek,mt7622-hsdma.yaml   | 63 +++++++++++++++++++
 .../devicetree/bindings/dma/mtk-hsdma.txt     | 33 ----------
 2 files changed, 63 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mediatek,mt7622-hsdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt

diff --git a/Documentation/devicetree/bindings/dma/mediatek,mt7622-hsdma.yaml b/Documentation/devicetree/bindings/dma/mediatek,mt7622-hsdma.yaml
new file mode 100644
index 000000000000..3f1e120e40a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mediatek,mt7622-hsdma.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/mediatek,mt7622-hsdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek High-Speed DMA Controller
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7622-hsdma
+      - mediatek,mt7623-hsdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: hsdma
+
+  power-domains:
+    maxItems: 1
+
+  "#dma-cells":
+    description: Channel number
+    const: 1
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/mt2701-power.h>
+
+    dma-controller@1b007000 {
+        compatible = "mediatek,mt7623-hsdma";
+        reg = <0x1b007000 0x1000>;
+        interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&ethsys CLK_ETHSYS_HSDMA>;
+        clock-names = "hsdma";
+        power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
+        #dma-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/mtk-hsdma.txt b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
deleted file mode 100644
index 4bb317359dc6..000000000000
--- a/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-MediaTek High-Speed DMA Controller
-==================================
-
-This device follows the generic DMA bindings defined in dma/dma.txt.
-
-Required properties:
-
-- compatible:	Must be one of
-		  "mediatek,mt7622-hsdma": for MT7622 SoC
-		  "mediatek,mt7623-hsdma": for MT7623 SoC
-- reg:		Should contain the register's base address and length.
-- interrupts:	Should contain a reference to the interrupt used by this
-		device.
-- clocks:	Should be the clock specifiers corresponding to the entry in
-		clock-names property.
-- clock-names:	Should contain "hsdma" entries.
-- power-domains: Phandle to the power domain that the device is part of
-- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
-		in dmas property of a client device represents the channel
-		number.
-Example:
-
-        hsdma: dma-controller@1b007000 {
-		compatible = "mediatek,mt7623-hsdma";
-		reg = <0 0x1b007000 0 0x1000>;
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&ethsys CLK_ETHSYS_HSDMA>;
-		clock-names = "hsdma";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
-		#dma-cells = <1>;
-	};
-
-DMA clients must use the format described in dma/dma.txt file.
-- 
2.35.3


