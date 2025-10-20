Return-Path: <dmaengine+bounces-6889-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BBBBF29DF
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F855420F79
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE6331A64;
	Mon, 20 Oct 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLckVGJ5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6C32F74C;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980280; cv=none; b=YcxDaNwm7BnrvRUq1055xXkUl/ikSlmKQIumQWc/G0PnBy2LAuFFARXWABqahKP4FAUnd6OScVBEHso2bufMLMV8hFQmK5b/baW8sY+XNr07uodmVoCwA8mmkexq4KasTvAsO++IXylJlaH8yI4ljjABwUsuRaq3rjcthEF1x7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980280; c=relaxed/simple;
	bh=bfZTvPbJKxHOKhlO78loZoETiX7+tlInaGSPp76tZcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQxYVtUue5TmW127URkGui2kilRCfRLf/ftY3GzLxRDfffLmLrkvLAq7MN+lFhKQ8YBfx1UF3XUVb4L7qy1lWDo0/luqtg5eeqT/mncJ4OFPeEvZzua7Pr2O/dhYJ9myUNtwGbWAcypJWSctzJAP+UKTd5WoxXIG/P9BxBlZEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLckVGJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4614BC4CEFE;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980280;
	bh=bfZTvPbJKxHOKhlO78loZoETiX7+tlInaGSPp76tZcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLckVGJ5tDHhW7IotJ9DZCXI7B/SYprw7XvmrT3wvjQCMu7z2uoptGX1kX4mFqP37
	 KIyemA8gOhpgtNjQhxd3daeWK16mFZVDorTEaUIn4TeH0q/CQWwo2r7g6wxUSf1ST0
	 TZetVf80aXNAUs+KzDujeHQDCjh6htC53i1jTP8YTTYF8EhHiBXZUpO/ITebx6xlUz
	 WRDYSatVJoUnYWPnFbJp+bnWryZLOfJC2YlrLR+luGgothpRNSDng9Naig3NUme0jP
	 DaQqe7aQ48s8oePQg21kcrkBCzYfQvRAY0DpD/k4JgGKHB6/0i06+rElKB/TdlOyAf
	 dEPcVO6kC5b0w==
Received: by wens.tw (Postfix, from userid 1000)
	id 3BFAC5FE31; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] ASoC: dt-bindings: allwinner,sun4i-a10-spdif: Add compatible for A523
Date: Tue, 21 Oct 2025 01:10:49 +0800
Message-ID: <20251020171059.2786070-4-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020171059.2786070-1-wens@kernel.org>
References: <20251020171059.2786070-1-wens@kernel.org>
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


