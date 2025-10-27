Return-Path: <dmaengine+bounces-7002-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FABEC0DCB4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651483B5117
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30326056D;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/brPLd2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365925C838;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569820; cv=none; b=tXJrDHQqd76M5DxLUiKNyXguZC08ouHlcP1rtKOKX1z4zuKimA1fuIzPpBMDN/oO4qWVjxlKyyj29cpT6djx+P8UgJ6effC9AtbBdDAohwkvGzqCKX5LW1xE857Mt9jxHQlR0lLQhFuZOJEdecvoOF/tMFYBbp136SVhKreXsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569820; c=relaxed/simple;
	bh=tZng3pvLf5NVIYjrv5Cdlkb3kjII1JMSXNhC/Cdf7Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tal9yfGAaSgWkcWy3b5Crzyo5vyuiqAHzU+iOlnaTEpa+ryAxgIGRyvAjFMS9/kyF8O8S3gCQRw8k7yOYQz6OpoPynCmDYMldh4JMQxvE3A1f9NFYJtdkYeWMkQNh/C9Bn3QZWAGGCMmNkKxjCO/hipmL4iwR8z847wwbpCpfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/brPLd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F34C16AAE;
	Mon, 27 Oct 2025 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569819;
	bh=tZng3pvLf5NVIYjrv5Cdlkb3kjII1JMSXNhC/Cdf7Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/brPLd27LQxkag5GvBdnPPh7bFVokQlJWK6AREvtkOXp7m0Ter+XyZTQafVICWIL
	 XNX5HD29gmuENvJOFkRAgzO8W8T5Wx7bBHckFOOaw0cU+f2qwGBMWKLmuxrmJOQ+DZ
	 IhcY1MQaGv+x7kE6ys2jMpKouNNg/GOKrYDpWWQqVc6YN9pFkGke5Hs4+Hn9Gqwj+g
	 1gCSFNx7NPhZ3+vZFRHiuw1KOTbP+8JdtiXQgxe0zCCsuZ0YRx1cnoGkBWlz252F7q
	 zuciNLynCA+ngLHjDc9AKQa5SdAeUEZq5kbHMhur97m7r4LaqVUYRE6CTowG1o/QiK
	 uY7FEv03zbb9g==
Received: by wens.tw (Postfix, from userid 1000)
	id 8455C5FEEE; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 03/10] ASoC: dt-bindings: allwinner,sun4i-a10-spdif: Add compatible for A523
Date: Mon, 27 Oct 2025 20:56:44 +0800
Message-ID: <20251027125655.793277-4-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027125655.793277-1-wens@kernel.org>
References: <20251027125655.793277-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPDIF hardware block in the A523 SoC has the same layout as the
H616 for the transmitter side. However unlike previous generations,
the hardware block now takes separate module clocks for the TX and RX
sides. This presumably allows the hardware to send and receive audio
streams at different sample rates. The new hardware also gained RX
insertion detection, and some extra information registers.

Add a new compatible for it without any fallbacks.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../sound/allwinner,sun4i-a10-spdif.yaml      | 44 ++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
index aa32dc950e72..1d089ba70f45 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
@@ -23,6 +23,7 @@ properties:
       - const: allwinner,sun8i-h3-spdif
       - const: allwinner,sun50i-h6-spdif
       - const: allwinner,sun50i-h616-spdif
+      - const: allwinner,sun55i-a523-spdif
       - items:
           - const: allwinner,sun8i-a83t-spdif
           - const: allwinner,sun8i-h3-spdif
@@ -37,14 +38,12 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: Bus Clock
-      - description: Module Clock
+    minItems: 2
+    maxItems: 3
 
   clock-names:
-    items:
-      - const: apb
-      - const: spdif
+    minItems: 2
+    maxItems: 3
 
   # Even though it only applies to subschemas under the conditionals,
   # not listing them here will trigger a warning because of the
@@ -65,6 +64,7 @@ allOf:
               - allwinner,sun8i-h3-spdif
               - allwinner,sun50i-h6-spdif
               - allwinner,sun50i-h616-spdif
+              - allwinner,sun55i-a523-spdif
 
     then:
       required:
@@ -98,6 +98,38 @@ allOf:
             - const: rx
             - const: tx
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun55i-a523-spdif
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock
+            - description: TX Clock
+            - description: RX Clock
+
+        clock-names:
+          items:
+            - const: apb
+            - const: tx
+            - const: rx
+    else:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock
+            - description: Module Clock
+
+        clock-names:
+          items:
+            - const: apb
+            - const: spdif
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.47.3


