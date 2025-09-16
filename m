Return-Path: <dmaengine+bounces-6564-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BFB5A290
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D0586160
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534232951D;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scV+PQn9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF128313D79;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=ojkd/hBMrha9MTPh/kPTdfc47VbM3/nVyg3Ed5XhyQZzPbcAL7U0k9W66C62KsKVh3gi3iIYFhFkJeBaCkY3BF3QlfDv58kTrdK84WvtojlFW/qYzszZkDZkUgEXahe/ezXIvbpJB8zXVUUvEqhsBw/lY4B6aJOzjOYyWxzykK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=z4pBrQcTtXZinSTJ2z7/T+NZA1J5YMX2432r92KbARY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAM+s4x5gEoVIbx1k0jPqYCw4XHbeW57ciGWIEgVPuOaZ+pQDFz0LDvP9KC4p7KqJXA7NbAuCiDaL4ibVG8oclT7PEIcy0w6QDNHAlxuGB2pB4gVihJF3zOUNSMlx+dzfi5rGDcabNK26MvFLtWbfjHCbI1KGwEOt6/z86/WkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scV+PQn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D156C2BCB4;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=z4pBrQcTtXZinSTJ2z7/T+NZA1J5YMX2432r92KbARY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=scV+PQn964rxS3ZPctvG+R7FhPeCSWfGf9komgdbw6iiuybNidlGvoDSt/xlkW0oc
	 4035P0m2F65qcztXQziIXfYUzzeAMXmfe0IKlGgpFzisjSvzHB0O5Pu0EvxA5gYG5Q
	 ycgEz0pF8VrUUAk/RSq6cpMrhuIyNGdfbQfwA2m60j6uvYCEYR7XKD8M0RQPLkar4y
	 ELufdydE/YKRaPQA78fbloBw9QejQGg5PQswdCf7rq7ahsdQVF02gE+j6wZ3VXfcGp
	 U9uWeolxbW+kUf/0aHZ3ZY2TSKtcWCBElAhxP3BSDy2dA/A+5gRkVTAsOr5Qy+0Aps
	 ieXYUVKmmH+MA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50625CAC59D;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:04 +0700
Subject: [PATCH 07/25] ARM: dts: unisoc: rda8810pl: Enable Real-Time Clock
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-7-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=779;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=CMytnUCPsfWK+Zir9iDw5CkhUnTaS4MnLkyTK6BwbAk=;
 b=8EhQxw0LLMM2LDVQTNZ8vl25jTC3/GCxaDYQ7uSwHCHHdz62F1wVQJjmy1WNmtyxi2SS9g+G1
 ldz7HeyKeUcBO6vdkIEyJR4XdsV1mIPJnTtzHx2ZgUV1OLieWUsiZ6x
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

The RDA8810PL has built-in RTC.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index 6553fc102c6751696e75e4de614fc3428d182061..609359aa91537168435934077e736b216adf50f4 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -39,6 +39,11 @@ modem@10000000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x10000000 0xfffffff>;
 
+		rtc@1a06000 {
+			compatible = "rda,8810pl-rtc";
+			reg = <0x1a06000 0x1000>;
+		};
+
 		gpioc: gpioc@1a08000 {
 			compatible = "rda,8810pl-gpio";
 			reg = <0x1a08000 0x1000>;

-- 
2.51.0



