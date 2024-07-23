Return-Path: <dmaengine+bounces-2725-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97F939E56
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EE01F2309A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD0414D6E4;
	Tue, 23 Jul 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcfYJp0s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF914C59A;
	Tue, 23 Jul 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728648; cv=none; b=IvJbKNaBRsbegojVSQEYT1c58IhpMP0UvKv/Y/Dgy7R8AIj/Fsj4Ycl+iJHI+J6VZWO+Ygg86EaPVINUNvRZPb7Xl2dUPV+coXwdz7CfP/x0Y6dxRru7k9Oss+11bm/MqZq37tLNk5W9hMAqxZRPh3CjjiP+4q6mQP7d1ig6MSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728648; c=relaxed/simple;
	bh=fSRiTpFJ+cxugkIJpc4TjarMzIDWT8UFgo3xHPPSFog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnnWKRZqjOBO5Cw6e8B9lGbz7CJ8RIHnnWfWNeDeaHGMDgn7zvcSAXuiBcQQrj1FzQqJ9rRO5/ShyGtTTbSTA+o7+HUw3NZHE85kr0LDZMkbASRoOYiT2y4Z8Mw/oI+UXxGMW6GdPldiRIbtNCuIKUKfmAe1WxljkHd8cZjmRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcfYJp0s; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd69e44596so4923935ad.1;
        Tue, 23 Jul 2024 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721728646; x=1722333446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlBfCzWNZi0aG0eWhThvQ4GtGMrf6cBVcSllu/pg43k=;
        b=HcfYJp0s2s0U70jyicuPnjGZBDe607dxQ2rfz1JE7iwGIXIMCAFUx/k6Zx5fs/GgxW
         vZpyViYgVbB55wcVO05U2MtpOF0A7WZQzUIR6PnR6K6+r18mC6THPV0AbKYNDQNvBIjw
         s1LyoNZiolQmDi+sFJiyjkYcYGrfl6PwDOYXpaY4+VcZ6h7PwXEXhKrhsIhFu3LhiXe3
         wjIEFWX0aMXBgvxcUBTJSPre4/Ra9U6Twh8CQK5fAE8OMVgtUp8B7h1QTmQBCJW7yhAr
         0kZ43jk1i2K3fi7r6BzubLfQ5INYujI++ZAO7RptIEvXearW2YnABxWZYmvF3tThIGVX
         FTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721728646; x=1722333446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlBfCzWNZi0aG0eWhThvQ4GtGMrf6cBVcSllu/pg43k=;
        b=U79VhxTksQ+I5NmeOS6Asom/5nPgIyKJKsv0rqmn+PsrE0y3RcJ1oBi3Q/w+jYD7Ow
         yUNBSP1at5s8NuzT1OVJzuuJND/sP5yScPudqbZ5l1W41TbaS2x+J8z54k5G3E3K6P3D
         X8cpfVvwdOZoOwRwsEL/62LJ4LFqU8EAcAN/gCDmPyGJMtVO58g8pjlkclV9Pk0yejq+
         THqQ/GIwb3YEfsLKRQTRV9/lMnvlehEqIPjiaO9J5WIBA/MGrFTkBCPpGB1riEJxzKpM
         yA+4K3Ae8kgGY+bwQ9w1af8SsqrhJjIZh6licLyBOyuVZCf2QWCt2oMpATcUsYp5/mGg
         jEmg==
X-Forwarded-Encrypted: i=1; AJvYcCU0gT9iqEUHxXkSS6f5lIQAxicO3srEsYqoUyMt/g4B2AJ3WKaurDKwXvW3fDzPqA+y4k6IzMiK0Qk8g5ff6NhqUoKG3Pts1bJocnvXVk7WiVfVE0l2sTFpqknlxdupo2jL78sZ2fgoaQ==
X-Gm-Message-State: AOJu0YxRhFeHiFKCQCh3LVgH5X3wNY6dFZErBEJRkSPdTBeB59wGMdHL
	yxMnNR5ZMrVcbHFSG1/RQRF7xuKmUJCevW6NtdeeLuRaJGA+4Xl3
X-Google-Smtp-Source: AGHT+IG4sej/Vk08HhelJmhh0GUfvQzWX0qRJ3MHvPv96kfLGcqiMPGH+JKW8uB8rkb9fgY1aKnmDw==
X-Received: by 2002:a17:902:ecd2:b0:1fd:6f24:efad with SMTP id d9443c01a7336-1fdb95a3197mr27752575ad.26.1721728646103;
        Tue, 23 Jul 2024 02:57:26 -0700 (PDT)
Received: from localhost.localdomain ([122.161.52.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2ac0acsm70722255ad.114.2024.07.23.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:57:25 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH v3] dt-bindings: dma: mv-xor-v2: Convert to dtschema
Date: Tue, 23 Jul 2024 15:25:19 +0530
Message-ID: <20240723095518.9364-2-shresthprasad7@gmail.com>
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
Changes in v3:
    - Change maintainer
    - Simplify binding by removing `if:` block

Tested against `marvell/armada-7040-db.dtb`, `marvell/armada-7040-mochabin.dtb`
and `marvell/armada-8080-db.dtb`
---
 .../bindings/dma/marvell,xor-v2.yaml          | 61 +++++++++++++++++++
 .../devicetree/bindings/dma/mv-xor-v2.txt     | 28 ---------
 2 files changed, 61 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt

diff --git a/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
new file mode 100644
index 000000000000..646b4e779d8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/marvell,xor-v2.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/marvell,xor-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell XOR v2 engines
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
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


