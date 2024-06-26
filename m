Return-Path: <dmaengine+bounces-2542-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9A917DA4
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 12:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873D31C235BD
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AC617798C;
	Wed, 26 Jun 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FL/1rLlN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5144176AD3
	for <dmaengine@vger.kernel.org>; Wed, 26 Jun 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397097; cv=none; b=MF5PVuCvM/q4dVGEmEtY9vD8LMWO7fyrQs+8qJFMKEHsIUgmg9Ktdnj9Jx0iQwAKJfzddfLBlf+4Tk7UByGV/C41jpEiynxu29HHkQ7QPLKRBExW3+3X5YvxO2UlHf6AzkrvJNvoQK4dhh6htGhFTUj350gOUkmJ7mHA639RfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397097; c=relaxed/simple;
	bh=HxFLn3EKFP9/3frs9V6iy9Q1+ai79dM4oSUWkrspkNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HiRqYgAEsv5kIFktajmOzuEUU/EBSK1yyXNJKmwP/UKw8+yQB5strdHwOeeLZL9lyrCItB9HfV7+JoHYXjgCh3s8jt6BesGlj3rttif7nbuwIBs7CWWTQMghQxIWuxG57YAGzg4pQIK1U0KyOyTVC2MgWxDPqPjdVW/8qJ1QqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FL/1rLlN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so37507a12.1
        for <dmaengine@vger.kernel.org>; Wed, 26 Jun 2024 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719397094; x=1720001894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bdjU3nE5ZipGzXPlrfx4tB5EjZjaLf/s1zAFQ4DTHQ=;
        b=FL/1rLlN4StONzTTMqTS41LTLU5ZQTKm9+rF3c0+VuLgHk5lnbGed4BtNRiYSASwC+
         kss4tFI1nBqblO7j2VR7x3C/FONV0as4aaMbL3Mb8qcT6DuYjjF+W1hKsMvMKwif1gU5
         uGCQlNbraj668ebjVaqBAOR/CzOVkh8PSvOOta2lAm2aD7tduKtC1OM27OluSx1cOmt5
         0M9ndOAlFoexzZY5Md2uKCRHAZy0X1CEI7AqNxHXlbRFk82I90ndUbrXQr5fdbdK5H3s
         QWzlC9L/Ct9UUINI2RU6rIcLCl9oP7k5NGMBW6fL12WbboOioNw8hZSNNKqsDGogm7AE
         uwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719397094; x=1720001894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bdjU3nE5ZipGzXPlrfx4tB5EjZjaLf/s1zAFQ4DTHQ=;
        b=Vq2tRcc0I+pR4kzBloLkwWCdeEl5IPZA8pmwtpyoYVsf5P1j/y7goPScs3xGvRAec8
         i0rvTp4ggMZxozKVtvQt04limdakn+c/pi8mcVSyM78C82BLYMAP8o6Xl5SzlmUAvQqe
         zWxcoiDT+UgIVujN+bdLCEVJeKyK2sIyVdvnpIfxoKIN+GVfxy2UmOa5QzgpuKU8bFR6
         w68AcQW20EQxSSomZvyQbEzp+yq3HbWAg7TiTgfLCzPz4PmQNgUf6HIPtDNI+Cg549s2
         keuVCqNYGm9AqgvFgvLlOEuSAnX34kTn4/xh3AD4gDm6esLOJ1GaxZ9/3FtpZqswYcNZ
         U1/A==
X-Forwarded-Encrypted: i=1; AJvYcCXpNesMq19p8WxVm72Wsk9TcldY5DxQ92L+ZqoaWB1ZFpIoRWM2oIfDc7xvu8yhSpzuWkHhYLTo6SaUSh719VCQOh/BzIr+K8yW
X-Gm-Message-State: AOJu0Yw4d7pLvjhV/zkpkH4zLABQ23GYqmPVn2F5g/IMdOpbaqi/cYdj
	ZPqUfOLYybDZiD1VcwPEdRgaNqG3Y0r6eKmsjLyoOfpGZnn0rB7ZHmjEKeyijOA=
X-Google-Smtp-Source: AGHT+IFBNccWMI7NTYfI9iYETbbac/VKuBb+ZnQdRhtrnkDqFlLEVtbm0dPVcl4LOR3fqWpc0urpjg==
X-Received: by 2002:a05:6402:340d:b0:582:5195:3a7a with SMTP id 4fb4d7f45d1cf-58251957777mr3714663a12.35.1719397094033;
        Wed, 26 Jun 2024 03:18:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3053558esm6965474a12.64.2024.06.26.03.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:18:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: intel,lgm: drop inactive maintainers from intel
Date: Wed, 26 Jun 2024 12:18:09 +0200
Message-ID: <20240626101809.25227-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to chuanhua.lei@intel.com, mallikarjunax.reddy@intel.com,
yixin.zhu@intel.com and vadivel.muruganx.ramuthevar@linux.intel.com
bounce with the same message:

  Your message wasn't delivered to Yixin.zhu@intel.com because the
  address couldn't be found or is unable to receive email.

The Intel LGM SoC was apparently part of Home Gateway division which was
acquired by Maxlinear, so switch maintenance of affected bindings to the
only known non-bouncing Maxlinear address: Rahul Tanwar.

I do not know if Rahul Tanwar or Maxlinear want to maintain the
bindings, so regardless of this change we should consider bindings
abandoned and probably drop soon.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml    | 2 +-
 Documentation/devicetree/bindings/dma/intel,ldma.yaml         | 3 +--
 Documentation/devicetree/bindings/leds/leds-lgm.yaml          | 3 +--
 Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml  | 2 +-
 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml | 2 +-
 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml  | 2 +-
 Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml   | 2 +-
 7 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
index 76609a390429..bd7f96515ab9 100644
--- a/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
+++ b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Intel Lightning Mountain SoC's Clock Controller(CGU)
 
 maintainers:
-  - Rahul Tanwar <rahul.tanwar@linux.intel.com>
+  - Rahul Tanwar <rtanwar@maxlinear.com>
 
 description: |
   Lightning Mountain(LGM) SoC's Clock Generation Unit(CGU) driver provides
diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
index d6bb553a2c6f..af96d52922f6 100644
--- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Lightning Mountain centralized DMA controllers.
 
 maintainers:
-  - chuanhua.lei@intel.com
-  - mallikarjunax.reddy@intel.com
+  - Rahul Tanwar <rtanwar@maxlinear.com>
 
 allOf:
   - $ref: dma-controller.yaml#
diff --git a/Documentation/devicetree/bindings/leds/leds-lgm.yaml b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
index 8b3b3bf1eaf2..4ea6cf0af836 100644
--- a/Documentation/devicetree/bindings/leds/leds-lgm.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Intel Lightning Mountain (LGM) SoC LED Serial Shift Output (SSO) Controller driver
 
 maintainers:
-  - Zhu, Yi Xin <Yixin.zhu@intel.com>
-  - Amireddy Mallikarjuna reddy <mallikarjunax.reddy@intel.com>
+  - Rahul Tanwar <rtanwar@maxlinear.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
index 07bc7e3efd3a..2582380bf657 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
@@ -10,7 +10,7 @@ allOf:
   - $ref: nand-controller.yaml
 
 maintainers:
-  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+  - Rahul Tanwar <rtanwar@maxlinear.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
index ca818f83579b..5af7e5f7e634 100644
--- a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Intel Lightning Mountain(LGM) eMMC PHY
 
 maintainers:
-  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+  - Rahul Tanwar <rtanwar@maxlinear.com>
 
 description: |+
   Bindings for eMMC PHY on Intel's Lightning Mountain SoC, syscon
diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
index 653a12286637..823a5fabf749 100644
--- a/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Intel LGM USB PHY
 
 maintainers:
-  - Vadivel Murugan Ramuthevar <vadivel.muruganx.ramuthevar@linux.intel.com>
+  - Rahul Tanwar <rtanwar@maxlinear.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml b/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
index 1144ca2896e3..1cd19db1aa50 100644
--- a/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Intel Lightning Mountain SoC pinmux & GPIO controller
 
 maintainers:
-  - Rahul Tanwar <rahul.tanwar@linux.intel.com>
+  - Rahul Tanwar <rtanwar@maxlinear.com>
 
 description: |
   Pinmux & GPIO controller controls pin multiplexing & configuration including
-- 
2.43.0


