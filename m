Return-Path: <dmaengine+bounces-6665-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88BB8D989
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 13:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF61B3A7BDE
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EAE257AD3;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxPSD9yu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFB8F5B;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758452649; cv=none; b=e+2wzWn1k6kowYkHUgAQYZ8X0s4AOCUs+lH59hogVLomi/RlTDeOlAFOAma2jQINiqMmtlofiCoGxAE/h1onH0eJAMwHwcVzlYW+KwQI5tfjG7DXrQtf3VZl4BBqWbZY6l682zK2WYbSOwOLW/E8/Rs7jKTNlqq4GAONNr1MdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758452649; c=relaxed/simple;
	bh=qZbUvkV3I4SIv7OEUq7HXI4u9eGtm6gZMNg1T88s4O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s88ap6NCOL10eODmKuIMqH2Da28JYuqlzPTSifTHk9QxpyScd/iODMEIEsSEYhA4QuoNeGleeHd67FbvrjnV3djVZQCwscNjxYTZWZxBXyxBFtoe2WCW1SEMilfvp+jDZ/fR2PsDzfBeqKVoXV55o38gawr5l+EySEuNUGGEjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxPSD9yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11332C113D0;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758452649;
	bh=qZbUvkV3I4SIv7OEUq7HXI4u9eGtm6gZMNg1T88s4O4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mxPSD9yuN4VkI3XvPm6joul3OHUgxWhxFiAwPiYFVpf73ekd7v76P/MvQcRV4Q6gO
	 v9nj6kYaTHwiQC0kT30tKhEwAQ0Yk2b99NuvwtrOe12EoomB9ww4PUwLzThWAPYUh9
	 lFg0fIUktkCAERlPUjEHiaFm4X9wg0AioWJ/PyqTJfP5TmjbPnRk1EIXwTJIoBTEn7
	 QCh2H57CmcXFurQUVC9lFJiVxH98EgkURes4T9AbJS4hAXoKUovPgm9UIld64hKyHV
	 38Zfm+FD0XCXtY4ACezhPd4BYh32i2l+1/4YrG9v81C0/i948xsZH38ZYsmUngfCt0
	 +aBCzqBFOliNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F66CAC5A7;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
From: Max Shevchenko via B4 Relay <devnull+wctrl.proton.me@kernel.org>
Date: Sun, 21 Sep 2025 14:03:40 +0300
Subject: [PATCH 1/3] dt-bindings: dma: mediatek,uart-dma: drop
 mediatek,dma-33bits property
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-uart-apdma-v1-1-107543c7102c@proton.me>
References: <20250921-uart-apdma-v1-0-107543c7102c@proton.me>
In-Reply-To: <20250921-uart-apdma-v1-0-107543c7102c@proton.me>
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Long Cheng <long.cheng@mediatek.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Max Shevchenko <wctrl@proton.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758452646; l=1846;
 i=wctrl@proton.me; s=20250603; h=from:subject:message-id;
 bh=TB4BCx1QYYV4SmqIa8ENnGfC/AB4i29OQtOF7WQHovg=;
 b=I3qa4PxpaBPKoU6fi7fhLxPcD3csXcw7CPfWSXpq7UuMv9OoZ9NtUPgrB3r4Fe5nltPitCZXj
 UCi2HFiDvpIDS0qTK6ZmeNqloia69Lkev+R2nCbnT8xCU05mNgjYFlI
X-Developer-Key: i=wctrl@proton.me; a=ed25519;
 pk=JXUx3mL/OrnRvbK57HXgugBjEBKq4QgDKJqp7BALm74=
X-Endpoint-Received: by B4 Relay for wctrl@proton.me/20250603 with
 auth_id=421
X-Original-From: Max Shevchenko <wctrl@proton.me>
Reply-To: wctrl@proton.me

From: Max Shevchenko <wctrl@proton.me>

Many newer SoCs support more than 33 bits for DMA.
Drop the property in order to switch to the platform data.

The reference SoCs were taken from the downstream kernel (6.6) for
the MT6991 SoC.

Signed-off-by: Max Shevchenko <wctrl@proton.me>
---
 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
index dab468a88942d694525aa391f695c44d192f0c42..9dfdfe81af7edbe3540e4b757547a5d5e6ae810c 100644
--- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
@@ -22,12 +22,14 @@ properties:
       - items:
           - enum:
               - mediatek,mt2712-uart-dma
-              - mediatek,mt6795-uart-dma
               - mediatek,mt8365-uart-dma
               - mediatek,mt8516-uart-dma
           - const: mediatek,mt6577-uart-dma
       - enum:
-          - mediatek,mt6577-uart-dma
+          - mediatek,mt6577-uart-dma  # 32 bits
+          - mediatek,mt6795-uart-dma  # 33 bits
+          - mediatek,mt6779-uart-dma  # 34 bits
+          - mediatek,mt6985-uart-dma  # 35 bits
 
   reg:
     minItems: 1
@@ -56,10 +58,6 @@ properties:
       Number of virtual channels of the UART APDMA controller
     maximum: 16
 
-  mediatek,dma-33bits:
-    type: boolean
-    description: Enable 33-bits UART APDMA support
-
 required:
   - compatible
   - reg
@@ -116,7 +114,6 @@ examples:
             dma-requests = <12>;
             clocks = <&pericfg CLK_PERI_AP_DMA>;
             clock-names = "apdma";
-            mediatek,dma-33bits;
             #dma-cells = <1>;
         };
     };

-- 
2.51.0



