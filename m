Return-Path: <dmaengine+bounces-2646-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72692973B
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jul 2024 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F81B1F21474
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jul 2024 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3441BF9E8;
	Sun,  7 Jul 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3N9EzFY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4F79F2;
	Sun,  7 Jul 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720343772; cv=none; b=E+3BDvmTHos+MTTLAxHiyofaCx81MTHyPFlAIRnDgD8ueD9nDF7h1KZK7eCLgNW7yV59O3eI7oGyhixjCed5Pe2NGDDJYe2iROHWKk7TVi9SKudePeERBsFNMFCLCl4iTd2i9PYIfbiYh59UiTVydOeIi4cOYjYZWSvz956v0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720343772; c=relaxed/simple;
	bh=ydNFNYEIYmbYL4flftPV+UX9TvfxUFWYUJPOtpa6yMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlsTBRLrhr7RxfXZUX/7cQsRl/XVqc6VotjCOK2YQ6gKk4lHBwTAirbSokULFwMNI9p6c6OrBO8WH5HYzOMOcnJmXJfPedfMc4Vd4UoJ+RXxSLVbwolCpdgk5RJlQvzygRmG5r4EoNmNjIsZJN572kg/KGFZw4qPC2WaAdJS1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3N9EzFY; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f6841b6cc3so75117739f.1;
        Sun, 07 Jul 2024 02:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720343769; x=1720948569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wO019b4mVqD7G+2psdVM824ZYHOu6XzURu8wfc6C8YQ=;
        b=S3N9EzFYny1Uz54Mm+f6F399LGq3OKNRSeboXJFNc3BwXiDUiHKfCkbSFA3CfM69hw
         TkpGqp12h8bYFnvKWE1vML0AemnDwEE/u64vs+t4pUX5I8thuHkOTT5uB/XPS0Lr0OIm
         4UNhWq3iDNz5WRn70gDAngDLioqqPWc3F7OEpxN7x1HA7UORqndCiOIqJ6frI/Z27p3D
         TjC1kJRl8SuvtGed/ZE3VeeO8USdxHQOs1o2sJY5B5jG/P0FxEUNddqhKnwVwWhTOlCU
         zRXZfhNIrygXIAwk2twippmf8fcGnHBg4rQ8qn5TfAW0DBZ7E/gU3hm6L9T3FDMKl1x7
         wYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720343769; x=1720948569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wO019b4mVqD7G+2psdVM824ZYHOu6XzURu8wfc6C8YQ=;
        b=QHT8sl0Am0XyQlZxmy4V1gbgQSFIhhIUO12RLRI2g2mN++t6dZE8ahZeD+Hx/yasVo
         2aKBVyTeKC+FBDA1HmL9vKaR6dfHPjhLQ7gSNZ7+Cj3dMP3UqP2Zz5HmpgC3IfWV6aAW
         X1IIawCqqWBir/I1ZSqZT8I2+kEWh1GamrRepXkVfE69cNIhcojyrFtkqalTGjsr7DIY
         V5JafPzyJVDl3Tt8m5S7+C1H99K0GQ5hHvnvww2LvttutjoSA3M8Hhx0YrFcPAvS8xYG
         yHnYvuu3Bz8vqkAxkVhEXIGBF03E0uIMtTBnXd1BupVhwsSK0VV4e9tRwV1YCn+nVGQW
         cIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuesZjsM+fyt7zGX4PbBNCVW8yINedPkiOwbINu05yZGzkDsqZi0n/Xughn+HaQ0wz8ivSIL3k78OQILAWvTsOJB78Pnyo9JUAuULZ4jt+iUNPbxkbXJzIfFaR20FxO08SSiVGy5UVCw==
X-Gm-Message-State: AOJu0Yxfrx+nq2hpWN9nXNxc1P21yMjX8Psw54lLWo3qLjBKeM57pksP
	Df71kUr2Li5ZzUCuGDIq+5NOAN00OZl9G+NYE9U0ALLCyh4E/FQU
X-Google-Smtp-Source: AGHT+IEa37RO3Pj/DcXH28CRIjq9XM5K9gK+G9rsnp/N6R99j1OHyvizJiprmMKpf0yPan2T4GTjtQ==
X-Received: by 2002:a05:6602:234f:b0:7fa:d9e6:14d6 with SMTP id ca18e2360f4ac-7fad9e61c79mr152328539f.5.1720343769631;
        Sun, 07 Jul 2024 02:16:09 -0700 (PDT)
Received: from localhost.localdomain ([122.161.53.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a95b572sm6107944a91.18.2024.07.07.02.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 02:16:09 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hdegoede@redhat.com
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH v2] dt-bindings: dma: mv-xor-v2: Convert to dtschema
Date: Sun,  7 Jul 2024 14:43:33 +0530
Message-ID: <20240707091331.127520-3-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert txt bindings of Marvell XOR v2 engines to dtschema to allow
for validation.

Also add missing property `dma-coherent` as `drivers/dma/mv_xor_v2.c`
calls various dma-coherent memory functions.

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Changes in v2:
    - Update commit message to indicate addition of `dma-coherent`
    - Change maintainer
    - Change compatible section
    - Add `minItems` to `clock-names`
    - Remove "location and length" from reg description
    - List out `clock-names` items in `if:`
    - Create two variants of `if:`

Tested against `marvell/armada-7040-db.dtb`, `marvell/armada-7040-mochabin.dtb`
and `marvell/armada-8080-db.dtb`

 .../bindings/dma/marvell,xor-v2.yaml          | 86 +++++++++++++++++++
 .../devicetree/bindings/dma/mv-xor-v2.txt     | 28 ------
 2 files changed, 86 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt

diff --git a/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
new file mode 100644
index 000000000000..da58f6e0feab
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/marvell,xor-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell XOR v2 engines
+
+maintainers:
+  - Hans de Goede <hdegoede@redhat.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: marvell,xor-v2
+      - items:
+          - enum:
+              - marvell,armada-7k-xor
+          - const: marvell,xor-v2
+
+  reg:
+    items:
+      - description: DMA registers
+      - description: global registers
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: reg
+
+  msi-parent:
+    description:
+      Phandle to the MSI-capable interrupt controller used for
+      interrupts.
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - msi-parent
+  - dma-coherent
+
+allOf:
+  - if:
+      properties:
+        clocks:
+          maxItems: 1
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: core
+  - if:
+      properties:
+        clocks:
+          minItems: 2
+      required:
+        - clocks
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: core
+            - const: reg
+      required:
+        - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    xor0@6a0000 {
+        compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+        reg = <0x6a0000 0x1000>, <0x6b0000 0x1000>;
+        clocks = <&ap_clk 0>, <&ap_clk 1>;
+        clock-names = "core", "reg";
+        msi-parent = <&gic_v2m0>;
+        dma-coherent;
+    };
diff --git a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
deleted file mode 100644
index 9c38bbe7e6d7..000000000000
--- a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Marvell XOR v2 engines
-
-Required properties:
-- compatible: one of the following values:
-    "marvell,armada-7k-xor"
-    "marvell,xor-v2"
-- reg: Should contain registers location and length (two sets)
-    the first set is the DMA registers
-    the second set is the global registers
-- msi-parent: Phandle to the MSI-capable interrupt controller used for
-  interrupts.
-
-Optional properties:
-- clocks: Optional reference to the clocks used by the XOR engine.
-- clock-names: mandatory if there is a second clock, in this case the
-   name must be "core" for the first clock and "reg" for the second
-   one
-
-
-Example:
-
-	xor0@400000 {
-		compatible = "marvell,xor-v2";
-		reg = <0x400000 0x1000>,
-		      <0x410000 0x1000>;
-		msi-parent = <&gic_v2m0>;
-		dma-coherent;
-	};
-- 
2.45.2


