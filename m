Return-Path: <dmaengine+bounces-2507-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A327913AA8
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2024 14:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E975F28195F
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D3F148301;
	Sun, 23 Jun 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8wYZ04B"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B01C294;
	Sun, 23 Jun 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719146772; cv=none; b=hsOVjwmJRHr1mp5vdGoVf2+2ArAz0Sf88VKi+lvefwaeHgHgoUMgpwcNGI5QMmWZziLgFmm0xnD0IUjqFZmUP6VCOt9oyTz+k/OwymFayhHINn75wCmXOJk+MjjjFdGcJs6Q1scUM3lzMUWeKvt0W9vr1R0A/o9cAOqwBt9XoaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719146772; c=relaxed/simple;
	bh=+JfN/0iCiQDLYYc6xdFvjYXq+QVjc9/5RVUMzbECoAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBAtTFjofHH2/rCm/SZTQuoGRp5ows3BPPx4AD4+iYgDpsKmRwjQAuPBa3LtqjV3IwWmfvv1pDbHDspdojFfkW62gK6Kf7dTWlw2RVFa7VJPUJqIGu+8CcVe7LctLGMGwIcADLR2aCZoc6RMMxqG9wK6gjJGtL3RRJkMS4cfqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8wYZ04B; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f98178ceb3so2033174a34.0;
        Sun, 23 Jun 2024 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719146770; x=1719751570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJNAeilBksHHe+cfHTJcl7ZQDvy9diRDI1WmGo+xzJE=;
        b=J8wYZ04BTnmCTyDIx257/Ug0wboSP6Oza82wmpdN50M5I2qS8KQzwkYFbAa914j/w6
         FRR6Qk34Hou8ey8UU/OEpA3ljuwTKKORovQUMRDhZaiEjUbp497uA2e2Ohv2W9nZRdLu
         7UV08kR8PW5sT3LoNjonUUS22UgJgvXE9tJxyTlk5wWo2MNMp4GD7UGvZpMGeuqYmMtu
         SLNCcgqezt6u2PedXP+bFkcQjAAifvG4yJ7x+9Cm/HFoGrKXNIO8rJzWxHpkRoIBnQAG
         S+vtRlqjS1yWorONnjXJ+rWu1Iq7WoM2JGFFLHZ3dcu7uVozsp2dHu0+IiK/lwMIlEPn
         ubjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719146770; x=1719751570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJNAeilBksHHe+cfHTJcl7ZQDvy9diRDI1WmGo+xzJE=;
        b=HrjVtwQAeOsaAIK84m78K1if64gQtYiXqE4X0NVaeX+zUHb5FKUm6lTGwjwl3DDCsv
         Dt2RelAs+/qB0FpCeF7jgHdmONySmjchYRiZyH2GZL8qPJPu3uQlSewE6PnCTibA41QI
         D9J2wcQDGonYkIxYr1aMxF8zIWlkPpRbP3hGytb9K1MMsMhGV3bucdnqyNT8XIEjnEFM
         RYEfEzFyoLFIInapqjpl5p6YuwBl83ZyDIZ8kpqrRWo21rfhN15yBEau/35isgtlIg7o
         V3BLObUWiCgobg5+9R+tVyEZWxb7KBmuROaO4ldbl2hmDygQeWh1//plNOuRmbXixjet
         9Uew==
X-Forwarded-Encrypted: i=1; AJvYcCWsguRtvy1rYbcpt8RiEoihJMtaok6+ceQxlHyvLrcD5Kd+7nSStfoGDyIT60O7XNGRmkPvUYWjDNwx+y9XDQtLhnrkHC/R4jdiSiM/J83wT2Eq5oDmI8f1PhOOGUim3ktKh1V4DjUu1A==
X-Gm-Message-State: AOJu0YxlsU9nNBoBczBZxNOeM+tSm5lq1fCJbGB+EraSAZyIr1PznxSr
	keNusjJUgHNS+1Al5PB0jbAdaXAhcf0fdTEWeIemARIqynd4sl0K
X-Google-Smtp-Source: AGHT+IFV1crtHngw/vnqMq/uGtF0d5wmm4DRllelLbe0vVK9LapMVELIZY+oVe+w5y3CFZirsDVxjw==
X-Received: by 2002:a05:6871:3a21:b0:25d:fd3:5039 with SMTP id 586e51a60fabf-25d0fd38867mr1171820fac.39.1719146770285;
        Sun, 23 Jun 2024 05:46:10 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([117.55.241.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107ae68sm4419391b3a.27.2024.06.23.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:46:09 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH] dt-bindings: dma: mv-xor-v2: Convert to dtschema
Date: Sun, 23 Jun 2024 18:15:08 +0530
Message-ID: <20240623124507.27297-2-shresthprasad7@gmail.com>
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

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Tested against `marvell/armada-7040-db.dtb`, `marvell/armada-7040-mochabin.dtb`
and `marvell/armada-8080-db.dtb`

 .../bindings/dma/marvell,xor-v2.yaml          | 69 +++++++++++++++++++
 .../devicetree/bindings/dma/mv-xor-v2.txt     | 28 --------
 2 files changed, 69 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt

diff --git a/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
new file mode 100644
index 000000000000..3d7481c1917e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/marvell,xor-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell XOR v2 engines
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - marvell,armada-7k-xor
+        - marvell,xor-v2
+
+  reg:
+    items:
+      - description: DMA registers location and length
+      - description: global registers location and length
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
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
+if:
+  required:
+    - clocks
+  properties:
+    clocks:
+      minItems: 2
+      maxItems: 2
+then:
+  required:
+    - clock-names
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


