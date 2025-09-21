Return-Path: <dmaengine+bounces-6668-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48764B8D99E
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364DA189B302
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C495025A35D;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t56+27g4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A423B60A;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758452649; cv=none; b=qTbD9dQg18JwrvDDn9ULqw2nMBHZutwg229N4XlCwU0iaw62L1js2L7xPGpBrwGmgCJ5bS0g5RcrUePWn/YLduZ5CBujDQl1Q/Y7w/rLMazjkIZ9GwhQB49LMTbEm2aAbv9OJ93fpvSL+OS1lcClJOya7GgmyGi7tjSF9f/OjFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758452649; c=relaxed/simple;
	bh=ulSPXBA1u1faRv4/f8arTi2w78WVoq/znuBQRkfs6Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEFYnp7DUgJNPYmG/yPMjbCT2Q9cHPVZq1oWqzBqXPixhGijedXLoy+0rxwY0atQ+jLE9qEdk6PeWEbbx3C0er/Y8IwyayGUNAG3fpSsGqzwUPk1z53mmO4UfNKOR4MNosKPFrbPApsOWDSxg1RSKrhEmX2/OBlUbUq+sFWrmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t56+27g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A950C116D0;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758452649;
	bh=ulSPXBA1u1faRv4/f8arTi2w78WVoq/znuBQRkfs6Zo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t56+27g4EaW8nnlv1PZ3Su58UPdFiDAuie2uyPMxsjoXMsAHjpTucLIK9bOBDIqh+
	 hOPhXrFJXSbC0efVuWfAWR7eXSVgn67VtYEq4GaYEOdqqVSc8c1TlF9PpvtqJjpJMc
	 49cqXUyZX9RNUC/qsFCCRLZZQJFyzxUPu2DV0EemhUDp8T9fjmCvMfoip0kyF63n1c
	 iGGIXaXAE6vsAA7nrSz2sLhAN48GmTAXyvdWHH6u+VR/UOIK8DxcfxBKpAKeWmPSx8
	 A+5+VOKGv0ND8GwvuonbgB6E2H4ASAWv/YpmuljOY06Kr/bP7jPZTlQWlUJmHpPF/I
	 y9/Ti4RN2hUVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C82ACAC5A8;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
From: Max Shevchenko via B4 Relay <devnull+wctrl.proton.me@kernel.org>
Date: Sun, 21 Sep 2025 14:03:42 +0300
Subject: [PATCH 3/3] arm64: dts: mediatek: mt6795: drop mediatek,dma-33bits
 property
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-uart-apdma-v1-3-107543c7102c@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758452646; l=1089;
 i=wctrl@proton.me; s=20250603; h=from:subject:message-id;
 bh=efNh38U+hbw7SE9tyV1qJBxX+aihILQofpcGc0kC/ts=;
 b=P2Den4CzqXR4nni1RZlcgJUrU+BdnDEx6nZid1RneZyCMn5h8Mysh1cY8Rig6oOMQpbLsXBdS
 golrZUGOoSGA2ZCKjBqltNqDh1rkr621J5L7bYeinB8Sw0aZmqZIF3B
X-Developer-Key: i=wctrl@proton.me; a=ed25519;
 pk=JXUx3mL/OrnRvbK57HXgugBjEBKq4QgDKJqp7BALm74=
X-Endpoint-Received: by B4 Relay for wctrl@proton.me/20250603 with
 auth_id=421
X-Original-From: Max Shevchenko <wctrl@proton.me>
Reply-To: wctrl@proton.me

From: Max Shevchenko <wctrl@proton.me>

Drop the mediatek,dma-33bits property and use compatible for the
platform data instead.

Signed-off-by: Max Shevchenko <wctrl@proton.me>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index e5e269a660b11b0e94da1a1cf362ff0839f0dabf..5123316b21285cf589c0c616c0a12420f0b1ef19 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -547,8 +547,7 @@ uart1: serial@11003000 {
 		};
 
 		apdma: dma-controller@11000380 {
-			compatible = "mediatek,mt6795-uart-dma",
-				     "mediatek,mt6577-uart-dma";
+			compatible = "mediatek,mt6795-uart-dma";
 			reg = <0 0x11000380 0 0x60>,
 			      <0 0x11000400 0 0x60>,
 			      <0 0x11000480 0 0x60>,
@@ -568,7 +567,6 @@ apdma: dma-controller@11000380 {
 			dma-requests = <8>;
 			clocks = <&pericfg CLK_PERI_AP_DMA>;
 			clock-names = "apdma";
-			mediatek,dma-33bits;
 			#dma-cells = <1>;
 		};
 

-- 
2.51.0



