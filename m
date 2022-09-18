Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C8A5BBD44
	for <lists+dmaengine@lfdr.de>; Sun, 18 Sep 2022 11:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIRJ7r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Sep 2022 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiIRJ7X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Sep 2022 05:59:23 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1906AE66;
        Sun, 18 Sep 2022 02:59:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663495157; bh=qnGOJumwtyGpUE/bizuGjZuhRpU7ggZcgLNtbjRUrfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oBBDa2YCU2I+FScSOWbiZpral4VSrn39yrKx56wL1+HzZz/kNHuKx8AKAhQiBr1hu
         4oBaDqSyIMyqvasbVic7HbH/Z6q2/rWfMKN3i3ab196E1+keC/USx09nKgZdfJjuBr
         haEe6xRQPo/BIgAqiI4RW6jM4OEx6UiIfQEqAcVI=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 2/4] arm64: dts: apple: Add ADMAC resets on t8103/t600x
Date:   Sun, 18 Sep 2022 11:58:43 +0200
Message-Id: <20220918095845.68860-3-povik+lin@cutebit.org>
In-Reply-To: <20220918095845.68860-1-povik+lin@cutebit.org>
References: <20220918095845.68860-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There's a shared reset for the ADMAC and MCA peripherals. The MCA node
already describes it, and being a shared reset it is important we
describe it on the ADMAC node too.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi | 1 +
 arch/arm64/boot/dts/apple/t8103.dtsi      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 639c90e108a7..0b8958a8db77 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -181,6 +181,7 @@ admac: dma-controller@39b400000 {
 				      <0>;
 		iommus = <&dart_sio_0 2>, <&dart_sio_1 2>;
 		power-domains = <&ps_sio_adma>;
+		resets = <&ps_audio_p>;
 	};
 
 	mca: mca@39b600000 {
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 51bc901482db..358906a9274d 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -249,6 +249,7 @@ admac: dma-controller@238200000 {
 			#dma-cells = <1>;
 			iommus = <&dart_sio 2>;
 			power-domains = <&ps_sio_adma>;
+			resets = <&ps_audio_p>;
 		};
 
 		mca: i2s@238400000 {
-- 
2.33.0

