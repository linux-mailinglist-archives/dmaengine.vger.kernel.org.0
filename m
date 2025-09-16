Return-Path: <dmaengine+bounces-6574-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 558E8B5A2B3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9AF7B3D08
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2232E2DB;
	Tue, 16 Sep 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/zXKcbU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30134323F7F;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=IL5xNR+e4IE9hDsyag+W9OMsli5LZduqYJoj6QDL9I2dYct+c2lvwWLAJgGaHKEN/fFiMjNzuOZcqrCj9+/eT0atVDsTxl13Or9iMmvfb7i4flDUctWOwfVwN3SiBjvhDAlN7Zuie+uETA8MH31xTesvh0eTmu018aYA53Yf5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=Pnv5+FFv2iFRwSYEkairmz1Zl0wNKr5bOgIcKGaNzuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PROsETQdDEP/ZTBRtzgQxE8vKjoDrEwIYbwAbC/wsRhPanfs8t2fBDXCc7QTfxZwvuIdG9NoKFLTEsT6fSEJAhpZuULnt7yg9p8+SqR2sPpLfTAE2j2cwgvbVUdYCgrTzFy3zz6m7vrFcyxZpWoFPeUZ5gcijdDwpEbNgW9R2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/zXKcbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E01F1C2BCAF;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=Pnv5+FFv2iFRwSYEkairmz1Zl0wNKr5bOgIcKGaNzuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q/zXKcbUevPgRlaTCib4V5P98tSX76eBivNWx8aALG6g89LwXwdkOWDEtegJwP8o5
	 tGfCaRb0U5ehZav9v3RBQ8a3F6v00Zil3B+e5QxFJvA8wxp+9zezYEkgBIZjHSFy//
	 WxzBFP3wIRZUpqfzQKWHq+MlptIZIQ81WW5jbFBOVoSZjKEtC+FpicXBwVQxmgklOq
	 r+7BVAXDyZa04CezBiVjDhAW0IVidoO2vqy+5dFINzxuez83g05w7TunPbBDZX8V5G
	 r9Yfyj6s/+FbjdJgO011hEw30hU/ez+Uj//nbHpf6OAIgZsP8W12J3E5bp1cAKDK+f
	 eGUK2k4pZiWYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D625FCAC592;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:13 +0700
Subject: [PATCH 16/25] dts: unisoc: rda8810pl: Enable modem reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-16-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=793;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=u8ofUfZnyL6AGUSAsraDhXZ8KtNj+jiTPktMzMifzHg=;
 b=fWZT1Fx32Hx9ZahhNzlPhngPS7qH4nNWfABkCpfT5wJanor1eQSweXur3kGePA0KRJvMK5TAB
 H8UQagjuGEgAjgojs4svCTAlHhh0Ir2INO/LHEgYgExeaecrkrYKpEG
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

This allows us to reboot the board from the OS.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index 299b29e4df6e0a04c5769a568eba73ed1684a9e5..e90ae7845de7b79e55e9cd339a82313b423e0252 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -98,6 +98,11 @@ modem@10000000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x10000000 0xfffffff>;
 
+		reset-controller@1a00000 {
+			compatible = "rda,md-reset";
+			reg = <0x1a00000 0x4>;
+		};
+
 		rtc@1a06000 {
 			compatible = "rda,8810pl-rtc";
 			reg = <0x1a06000 0x1000>;

-- 
2.51.0



