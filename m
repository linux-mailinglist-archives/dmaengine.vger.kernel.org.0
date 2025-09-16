Return-Path: <dmaengine+bounces-6556-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10AB5A23F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF44C7B1560
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FB2DF3CC;
	Tue, 16 Sep 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="jbxz3uEW";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ogmRHKwc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE125CC42;
	Tue, 16 Sep 2025 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053876; cv=none; b=kYbxGhc6PanrwG74LkjZLMcD+JdA9Mhsc1gWOg0I+xeCFg24s7aTYy92f7rBcJEmXLk7z3zbMFtR3uaOdvmPeFYaE3vD+YGDxSU74S3gt5x3hsOK4LcZPi5tK8NM1VGmRHGB1WcytFFviKR6kx69jcaJVEkajOPRnsBE6ajQ76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053876; c=relaxed/simple;
	bh=WXHBrmFovBDD+aODYzMgHF0ddvJv66eaBAA1wb46O10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcO7PhjtHkdbn70XjNGMiz+4ZIF28uSQcpNYW81q0GYRighTYfUrbIKaNDFau7ZQ7RYzNyxV+5IvxLHbcpKDeA5Jm8FdDb42S4Jz53LhtXGOtk4sQiC4tNziuMX8Qab9ef63MKM4gKPIPkNw4XvY31o5b7ZM4UA1bhncmKQJ3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=jbxz3uEW; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ogmRHKwc; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053309; bh=5hk0ozjipptLYfgR3SXbJso
	1g1gA/mg3fP/4pa9msVs=; b=jbxz3uEWexoqATZenETV+6A6dFkcWnG6OZj5Dt072mhRzu/YZG
	Vu56CkAPdzdeTmb1md6+xMW0Jb6v/26bQOFmjBMLA7eYjtOlTf+SIMg6Oz25dnOaoXTekETvmAO
	CtQ8spWiamXFlpvIYPmNajSYTuVH0i+sQWXgz3g5uz7PB5tvT+wvQUeeREKcsxWPZqwLYh3R3gb
	O1eMUJVWR8ha+hxdDXuXJQbD1MpBbktXFigsaWB05lCu5Ptm9ITkxZkVhYRJa2C1SDO6G6mtDT+
	Yuh9y9+PbyEBvCtJV8QS+xyaJdboiy38zI4XaFN5t0Jd0ZhdoH9myk2HlDMojKundkQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053309; bh=5hk0ozjipptLYfgR3SXbJso
	1g1gA/mg3fP/4pa9msVs=; b=ogmRHKwc9HhskqXLz/zm65B/tLZqPlTTHFc8QD+DANmS3Z1ij7
	pORkLFrhMRnkJ0Y3uUEcUeM+5SJdgVDrHSCw==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Wed, 17 Sep 2025 03:07:22 +0700
Subject: [PATCH 05/25] dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-5-74866def1fe3@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
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


