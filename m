Return-Path: <dmaengine+bounces-6561-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD6B5A26B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0351C026AA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5A1323F78;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X40rBasv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB683304BD0;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054325; cv=none; b=lhSHZdf9j4BhR5arTuYBKpIFnGVpeIvCuPKGKOnH1VXzyceFpEynB/iZ6EtA5JD3QZEiqj0bS5b0R/dwsLULNzWFCs1euWWge5+c+4V2Fo5a48seyxbcpB56+zPoBh1uc3C9VTkiWGQOQQ/z33N8cYczbZOpEifVLDri38lll+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054325; c=relaxed/simple;
	bh=p/pUs0MZFo/+qdpENMcLyBKM/numNqXrgeAhrFls3Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxQITD8cIPZAR11hGkfJRekGjJPtVknKw4ubexL2BMQNIzh4QTKcVk3kv1PTGVzYKICP4H13RKgPq9VE43kIp+lKCwgQiBRljgztiaihj51XvnZkQsIj7WlyYCbCYJvsADOyImhtaDOXJKyNtsVFdNPnyNulaJTUj6nP/Lj7/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X40rBasv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B570C2BC9E;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=p/pUs0MZFo/+qdpENMcLyBKM/numNqXrgeAhrFls3Eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X40rBasvR7PF9fN2qZQCQCcMCvK+/79psNEO7of+ZdYpkF69MAr0mnbIigzoHre2b
	 jx9HjMjRyRSaCrimkK/eqqMxWdoW8v3CHPEww8hrQLkp3csUFfFeLLyCdqCcSvu6zI
	 HWOA3QD+Ku2kR8Dj7zScHUzKEsTBPK+YbDobYP8GQmOebRUlZlvYmXKEXp/q0TX3Tl
	 /QvOaZLAcZoPr92AEA3siTedj5AV3iHptxfTowEYaB1heIfj7/B49bp/Nkns7ifsEF
	 x8qKh8xWD46Mbc8VfSb1g+8SGej7y5tanDSXVqUIxhCpLNSAFSz34bFs1DQJYUV3a/
	 qEDMtb68I2Azw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ECFCAC598;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:02 +0700
Subject: [PATCH 05/25] dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-5-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1198;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=WXHBrmFovBDD+aODYzMgHF0ddvJv66eaBAA1wb46O10=;
 b=1AWpjOVHeC7A/fG05V5076Du73/ixlPO3tOlVdOzwByzDZgvNmGQVQIvJBjfRQdO6qHjcr8dk
 nUyBOunSsouDcKxdzeqOCwhm+B7f/3Zy6jwd0Awas0NtAUvq1ASF3OD
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Add documentation describing the RTC found in RDA8810PL SoC.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..3ceae294921cc3211cd775d9b3890393196faf82
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/rda,8810pl-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro RDA8810PL Real Time Clock
+
+maintainers:
+  - Dang Huynh <dang.huynh@mainlining.org>
+
+properties:
+  compatible:
+    const: rda,8810pl-rtc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc@1a06000 {
+      compatible = "rda,8810pl-rtc";
+      reg = <0x1a06000 0x1000>;
+    };

-- 
2.51.0



