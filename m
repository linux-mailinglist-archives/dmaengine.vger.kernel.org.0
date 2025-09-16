Return-Path: <dmaengine+bounces-6579-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFA8B5A2F8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257DB1C05158
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEBC33089E;
	Tue, 16 Sep 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqjJmG2A"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F432B49D;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=KhnFjeKDOZOl4W/Mm/VwolAXJvmdaO8ANVBK/cnj+i+ng3fhMCkEtKN9HWBtqiJjgMwOiuJMLHFSv7gzkxA9doaCg18uNciBlaZOuXTdYqG4+A3TaKKh1gWbsO//XQdqSM5LpyLO023dYb51zOmnISvCAUDAeu9LcQ/Y19QLy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=EegadZyE2ka3lqNPNKWfrSgt+VjG3SDvPe99w5hVinc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hKOMUkGlmPXVfj9/+wJF06OdLomHvQwpltA/jwpuL86gzXAnFdRoz0+2b7cKk368oGJEFLfZ5QjeTjqE+/l6vC5O2r85DJ6OOj4zRiHkWHN2VvKPL8ivYeLPFXmhU62hR4BI3nACXYPoDftM74IbG4cfmnS9Nld0T/jmQpkLfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqjJmG2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C537FC2BCC6;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=EegadZyE2ka3lqNPNKWfrSgt+VjG3SDvPe99w5hVinc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TqjJmG2A2cB8ngo4ajZYfJfPMOULRsF5fOoBAUEkiwgNY4F+FZ8BLxj7ewB+GWcz0
	 nCkyo4BZtNjh80Z1IoBu2Y5ocJGUGVMU0DqkV0nMKQGm/rUmk0yVMrYCbpXue27U6Z
	 oktZfW0Qg1zrv3ndCM3+dY+9U+RyBpYOGU1iRPem8jfqa7hCKxFVY54M9u7h6xheDX
	 dlvUQBNj8nUtlBaTWbIdhOtUBnlxn75aAGQFpCJYHW1BnnxYVFJ++IBJfPRvxLvGs+
	 IfmyJ/v9X67Ke2B79rvjVMcyoDKN1kp8N61hTJOC+szpM94zN1FmGX11jZSi+GODFL
	 xEU2XYSFcDWKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B989BCAC59F;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:11 +0700
Subject: [PATCH 14/25] dt-bindings: power: reset: Add RDA Micro Modem Reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-14-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=1439;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=Qx3A0YEz2hiOBr1X7Hx7B2Yur/VncHTnIWLD5/fTYjI=;
 b=ZgRTCdZsa4zMPNeOMmGFLo6ICngX1GwmdnktW4A702PqmzxT6psP5W8kdNHEKlVW88+WFP8Gv
 ElMMuGq68W5A4Nx++rKEmZFCTm3eK1x3SrQ1TYSmUBZhC4BLDLaBhGC
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Add documentation describing the RDA Micro modem reset controller

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 .../bindings/power/reset/rda,md-reset.yaml         | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/rda,md-reset.yaml b/Documentation/devicetree/bindings/power/reset/rda,md-reset.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6d09bc8ee6b257aec9d2c4738d285490044003ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/rda,md-reset.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/rda,md-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro Modem Reset
+
+maintainers:
+  - Dang Huynh <dang.huynh@mainlining.org>
+
+description:
+  The modem has a reset register that can be used to fully reset the board.
+
+  To do that, a magic value needs to be written to unprotect the register,
+  then the soft reset register can be used.
+
+properties:
+  compatible:
+    const: rda,md-reset
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
+    reset-controller@1a00000 {
+      compatible = "rda,md-reset";
+      reg = <0x1a00000 0x4>;
+    };

-- 
2.51.0



