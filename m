Return-Path: <dmaengine+bounces-2558-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B797C91AA2C
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5EF1C231CB
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FE2197A7A;
	Thu, 27 Jun 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="CxIiYDOQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FF197A6B
	for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500542; cv=none; b=RLuOmKhkAgOwYri1kGJ5w7NUePOUl4/QcAU/uyq4G79ti3C2MjqYowtw+pxgmvP5SnwsrqtubsA+vtgRLel8aetjQPckTqD521GUW2ZlQMkACpVu87YNzyn9p6dFnRhC1HBOiJCq0MV+Jvrod9aK4P9wwoNFwvqLK6P0PniR+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500542; c=relaxed/simple;
	bh=BLOQubT6+WDGMXLbalL2gtus5F0xeE3IKPVA5IYu2Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFvPjmso29Rv6MTELtgc9AcZoVbViiMxQyHty1IoTblC/HZdbYyp31qPp73mYbLPhnktmZBWpMdklZnRPk6SlewBnPJL9SVem9xuALARl8sdLh9t6HO/pOes/1tCWB5M5Typ2dw3AfVTpCO6fJf+2QkkYXdsp9wJKqaxOvvO334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=CxIiYDOQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a725d756d41so308677166b.0
        for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719500538; x=1720105338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILtq9+4c141AHxBgbXMa+RP0emWEvg+/fmgpWsAX5kw=;
        b=CxIiYDOQ7V2PxKziJuZ64gyv5+XDJI1rxdIo8k+99KJ8uRYQdqzW2clKU9+x3AXY1x
         dYmhfOyt8N1bo0ZyJqjuvcfUkpEqwgr7X3RGZqLy+00enJ8TQNJ5pvfB/ZXHxsTjsXbK
         Lz3RkYY/LSBqAT7EfGGXkgYoUnWsUKWUwRr63QAwuwsz5L7S+gK+Y3oDELL7/6su69IX
         AHMhF9wVE6gMmiZHnWsgXC10js4CPF3tgzyzoY6sx3OJTgenGPTfgBtT6OYUni9J2D3f
         tMMhYldDvp4lXXR3rOWpwmET/tGTUOQhGCcbMcmxZJcmUuxPIMRT2U6s6tfS8F9cMobl
         4p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500538; x=1720105338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILtq9+4c141AHxBgbXMa+RP0emWEvg+/fmgpWsAX5kw=;
        b=DlrWzdApgCkf0/LjJbmcnoz35xUjjb0ne3TsqfzaUAFRfZyHQXLviu/BccrA2ubLpF
         4hEuWHqHiSWFOYkDFLMbDzDq63mS0OOTLOSs6Cz7RkIBn8s7iTMv+SCEeCPVxygZTW6e
         OlpISGqaAzE4OaqCZqyB5MnrCnEdQ0SZGZK4LZ5Q6nlI/S9hL51BG9YzR+okrybU1MLq
         mTDOCyCCyw1Jv9YdeEnyjFr8IvPZG6MiEB1lehQLcj2cNk/Pg30Rqbywv0CMI5t6fsus
         /smdZQ/qkDQ+MlDuwXUevFt+DOsROhvELfBDnOJjO7BUYRALq91OVWRUkvj9CdqAjRox
         g/ew==
X-Forwarded-Encrypted: i=1; AJvYcCXPrWAUu/5S1O1SP83g3cTDYBdBQNpuVnIxYwuKlWBhfjW3x13mfHNPFWCig5e9eYrciXVUDjiuNcr2Q+FRmmxD6XhTI7qgKNXM
X-Gm-Message-State: AOJu0YxRMjyMoAC5SxEkVp4LaSptH0bKNFJjIfrmvvIoIvMjVNbSEGJt
	8uhK5qK0/7JCzZixW7A603w2U/ws/JQnaUc7b3bbZBZ0UrIG9em4IBA86c/NxUc=
X-Google-Smtp-Source: AGHT+IGhzRCqP2RV73RAfCGRkGAsHtE5znhuHD+qNGBvgcJ+PHUmpdeZlb/WN59v+vhaTirBRQcRFg==
X-Received: by 2002:a17:906:dfc7:b0:a6e:f869:d718 with SMTP id a640c23a62f3a-a7296f808e2mr189909566b.21.1719500537821;
        Thu, 27 Jun 2024 08:02:17 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca289sm67189066b.222.2024.06.27.08.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:02:17 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chancel Liu <chancel.liu@nxp.com>,
	Corentin Labbe <clabbe@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [Patch v5 03/12] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
Date: Thu, 27 Jun 2024 17:00:21 +0200
Message-Id: <20240627150046.258795-4-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
References: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nxp,lpc3220-i2s DT binding documentation.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v5:
- Removed "N:" from the MAINTAINERS entry

Changes for v4:
- Custom dma-vc-names property with standard dmas and dma-names
- Added to MAINTAINERS

Changes for v3:
- Added '$ref: dai-common.yaml#' and '#sound-dai-cells'
- Dropped all clock-names, references
- Dropped status property from the example
- Added interrupts property
- 'make dt_binding_check' pass

Changes for v2:
- Added maintainers field
- Dropped clock-names
- Dropped unused unneded interrupts field

 .../bindings/sound/nxp,lpc3220-i2s.yaml       | 73 +++++++++++++++++++
 MAINTAINERS                                   |  9 +++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml b/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
new file mode 100644
index 000000000000..40a0877a8aba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nxp,lpc3220-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32XX I2S Controller
+
+description:
+  The I2S controller in LPC32XX SoCs, ASoC DAI.
+
+maintainers:
+  - J.M.B. Downing <jonathan.downing@nautel.com>
+  - Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nxp,lpc3220-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input clock of the peripheral.
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dmas
+  - dma-names
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc32xx-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2s@20094000 {
+      compatible = "nxp,lpc3220-i2s";
+      reg = <0x20094000 0x1000>;
+      interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk LPC32XX_CLK_I2S0>;
+      dmas = <&dma 0 1>, <&dma 13 1>;
+      dma-names = "rx", "tx";
+      #sound-dai-cells = <0>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 79b44addc139..ceec359c68fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8918,6 +8918,15 @@ S:	Maintained
 F:	sound/soc/fsl/fsl*
 F:	sound/soc/fsl/imx*
 
+FREESCALE SOC LPC32XX SOUND DRIVERS
+M:	J.M.B. Downing <jonathan.downing@nautel.com>
+M:	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+R:	Vladimir Zapolskiy <vz@mleia.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
+
 FREESCALE SOC SOUND QMC DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.25.1


