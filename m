Return-Path: <dmaengine+bounces-6550-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE5DB5A206
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507123A5097
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B32E8DF5;
	Tue, 16 Sep 2025 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YXBLMRGN";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RJA/1KAE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B002DE1E3;
	Tue, 16 Sep 2025 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053437; cv=none; b=H02JVIcivc7S3Rp4bdm2GncOG5MQDnVTiCheNFgDzfTUkoakGbzpmsloqS7Gk6SiuMc+z2tCshoYKKyNoF4tfx77qzujwBpd2lyaK2iF9M01eShDI7iCiAN6l4IrDiJOgiDrUAF1M93HQYS7aNRN83itlQy3lm1LyDlE8ikfixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053437; c=relaxed/simple;
	bh=Ifgj24X3WuB4jA0+A119cFjcjAjN444atKSTzNtV5QI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npYtXa/JqcnG9Dhm3dYmzub5Ul8u/BttodlWKAZbFrR3OjrCHhWvX+XfJpDXIinJ5BKgd8OFc/DxKcz+l2TWbkhE8lsa15kO1576NJ7w5j4XGOrfvFqxMiugIknlGeFrnsjGsS+m+8jJJcAj5qhgHo7qeiabxXR3GL0/g6WNp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=YXBLMRGN; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RJA/1KAE; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053295; bh=ummlr2UUKGVQ6te62E5zsly
	Cu0MUOMC+Asdn9tweZ+k=; b=YXBLMRGNXzq8m1lN4v8HGQLSnmIkn+lEy7gdvhEKyJOZadGSZB
	gQIE6lW1Itml2bHzizGcBAq4Q8IeNtyAEV5qJQHZz2rMPKTYgXeEZFg4HC8f1JghFJ6S+rDBhvq
	f3g3IwSGnsMQn+K0GywIyhpf6ZUvM9c1bRPptUwbfjJBYjZQT/FU8dDEnPQDFy7rymEhgJh5khL
	5g3NvAe7iXKoT+q1MeBJkdTYXvvS7DyNoQkZZsF2xM5nKbJp1McHUgUvrzCJE+3J9xTKnX9EJOv
	ZRpRnGuJsEfcXbuMDMYCGix6OLsOPnLgwrlwtdYhhoQvYB3g6yqJ3gTaO/VtQaTLCLQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053295; bh=ummlr2UUKGVQ6te62E5zsly
	Cu0MUOMC+Asdn9tweZ+k=; b=RJA/1KAEP/DRcdOPk6HdFI+JYu1sfHCUQLf7vIxa9BMY1c1NM1
	y40AEWm0WHX3or5NKR6Y88I0hVAoqK/mVnCg==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Wed, 17 Sep 2025 03:07:20 +0700
Subject: [PATCH 03/25] dt-bindings: gpio: rda: Make interrupts optional
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-3-74866def1fe3@mainlining.org>
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

The GPIO controller from the modem does not have an interrupt.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 Documentation/devicetree/bindings/gpio/gpio-rda.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-rda.yaml b/Documentation/devicetree/bindings/gpio/gpio-rda.yaml
index 6ece555f074f84b396537917d7149d4061724dcc..dbb73b4d33ed39aa65024376b1af0c4e2fb896db 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-rda.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-rda.yaml
@@ -41,9 +41,6 @@ required:
   - gpio-controller
   - "#gpio-cells"
   - ngpios
-  - interrupt-controller
-  - "#interrupt-cells"
-  - interrupts
 
 additionalProperties: false
 

-- 
2.51.0


