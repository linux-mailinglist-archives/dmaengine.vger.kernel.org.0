Return-Path: <dmaengine+bounces-6645-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7207CB86869
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 20:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6A0164BD3
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C62D6401;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og/baEEG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0B27B357;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221398; cv=none; b=cby+UyM7UD/DSiFWSdtmE4La0P3Ce91BVjguGqERc5Sx9tWVNi6cMkl4a1cWP0sLI1n9/TlrA+n5o75+x9f8123+gDpYTmMsEJzbn1+M2HGK0QKG4WGCnasLAKe28X172tflnnDvKE2M1eaH4f1hB+YyWVRVmCrj3tTQTiXWHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221398; c=relaxed/simple;
	bh=YFvqcq/2EL5NjJ0I4Ow1yGNyZwdpiGWa5I9vDyoHhPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aScE32gssX0u0rksk2iitkiYOahiNgsuCOcUYadc8PCkopzjpbE5Gcop7cjjSqD8ltEFces60SOj8xD4gqdLAE+H37L5u9lbZ4fd4yG8MCX+U9g4aKbhw0jr/tI2jem5DLAWBE3WCor5GJvqeD2I9gjh/CCd0Phmwbj2t2S2qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og/baEEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1079C4CEE7;
	Thu, 18 Sep 2025 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221398;
	bh=YFvqcq/2EL5NjJ0I4Ow1yGNyZwdpiGWa5I9vDyoHhPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Og/baEEG7RJIWsGueDpHJH38aV26kd+cei0lHMvj4xuiNJJ/EUHRWhGkpf+wsXzZY
	 6AVErdVzIuyyvjB6h9w6JkeJqoOuFONih7ykIxjunInVSd6KjpKNvnhOY8fAH7xpCF
	 l4odM4vXM772c6cdpNLBGXG6RP8cYUP0wOJ4Xd1rzcR8Rc/D4LFpal/Mwq5AUjLDrj
	 bm1IsbXoHx6i/Dfb3immgF2oCpJdfILx423U6yEwxsatvq2ECS2kWqbGnKRo/KaQef
	 x/zEdMl5HWXXB1ww6kxMqVTKHF9k3G0iIRjZHghjWJfLaJRSiGn0GjspvwpgxDOtVO
	 kzvp0gRnXvapQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D029FCAC59A;
	Thu, 18 Sep 2025 18:49:57 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Fri, 19 Sep 2025 01:48:41 +0700
Subject: [PATCH 01/10] dt-bindings: gpio: rda: Make interrupts optional
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-rda8810pl-mmc-v1-1-d4f08a05ba4d@mainlining.org>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758221395; l=820;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=2bdyJSmNfA84cD9RwcJK/nl1FiNGvBo/u1np6F84KKc=;
 b=DyZRaXM1kMO4Bvn2OOUEuGjeJosLpZO+vdO4EV+4Kzk2toTVfVMNwOFax9Lh/KERoSAaQrAAn
 gTzEsgHiZT0Cc3CM6CRQ0mx/+FPllcXT0qx3PI+xw69zxFy6ReLEoiV
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

The GPIO controller from the modem does not have an interrupt.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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



