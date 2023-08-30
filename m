Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2FE78DC37
	for <lists+dmaengine@lfdr.de>; Wed, 30 Aug 2023 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbjH3SoC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Aug 2023 14:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbjH3Ms4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Aug 2023 08:48:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627D8CD2
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 05:48:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b974031aeaso85482271fa.0
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693399731; x=1694004531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWiI/MO+dRLYiRlM6yuPgVrkrfGEHgAGx/JBsoZ6UJs=;
        b=AezHbQYgNOg5drXaw+6li3c7HTddL90Txak7dtzLkq42wLRpy0ENsMEKulCd8S1KU4
         BYD5NSalBF/wXXZWc+kFktTKdbJlMgqUKV+JaGRgn06ldmpBihOhbuvTlTHl6a1vYvPh
         wj4MAauNnzgHttjRPvLPsNJTf1AH6JtEzZppuVR/d1M6+CSPb3UHQSO2+CDuGeOdNLMJ
         xtFt/ya81Aa95URhqRAxYeTTlJnGDeUyf4oNTCnY8SuRJI1CLNWm52UuvlmTcNReQoO+
         q6XoQTmixw24fKw1vM70IlBCQIFNHn6YclUiyHPvSLhb1onnlvsobe/pG6lpD+2N+viv
         bepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399731; x=1694004531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWiI/MO+dRLYiRlM6yuPgVrkrfGEHgAGx/JBsoZ6UJs=;
        b=CYWqNTSVJEXCZBvla8AjvOSAdIW3kWcY+SWF+/qG0jldwaReQicRKDNVIT0ahqgWoj
         TQ948fB8UD0Ig3mHZRlGS3nYZUcG547BREtmWlpSHaIZdaZK44zhpAMfMKYD+Jm/zNJv
         7f28CFAkcWmDyKsgvMetAOJDzZr07sdNBuvEaIfnbjpblDxmpY4k/6ik9VH2ZCZ4KR7Z
         YHQBA+i3vZwZbKmpymjkTjNca4ggBQI2pHHMnjUd+e1KTy9PPWRJuQVkuAdEzIazP51Y
         RcwHbSJ2MVdvdUiocCY+yJ8cJfQDvPLVTvMRV/eBAnDM7y91TOZG0ogvLLOwDYq4SpM5
         WTyQ==
X-Gm-Message-State: AOJu0YzlCHKTp1aKQdUVNa60OV1U/LbUJXqYUyCqZA3GSXPrgtY+EfvR
        /nXFZqLLIa0DP//nML2wfYDl2g==
X-Google-Smtp-Source: AGHT+IGB6EjRvwDNWJL79VaWPpWpa//96gMp6keseMR2AQZCJmTBMEHBAohqGiuZ/tfwSe7ymS3Eng==
X-Received: by 2002:a2e:9ed3:0:b0:2bc:f756:341 with SMTP id h19-20020a2e9ed3000000b002bcf7560341mr1735083ljk.35.1693399731713;
        Wed, 30 Aug 2023 05:48:51 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e7d17000000b002b94b355527sm2602662ljc.32.2023.08.30.05.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 05:48:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 14:48:43 +0200
Subject: [PATCH 4/7] arm64: dts: qcom: sm8550: Mark QUPs and GPI
 dma-coherent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-8550_dmac2-v1-4-49bb25239fb1@linaro.org>
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
In-Reply-To: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693399725; l=1550;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KpP1uTJWmiR9lXNPKL0Q4ECVHINhEgm+GZ5ZKetVnSM=;
 b=+dD2d2XMnFSAp9IluhmgTkJG4at8z79Ut86xE2lm9psXhU19uVuohOEECjdUPhFsFNgj2V/cY
 3ys4iS9J/wyBllOhvAgptcW3SEJmrfB+je1ZLzPBHAIDsQFkB1eiWyO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

These peripherals are DMA-coherent on 8550. Mark them as such.

Interestingly enough, the I2C master hubs are not.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index c21ba6afa752..d1911b2f0bf3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -809,6 +809,7 @@ gpi_dma2: dma-controller@800000 {
 			dma-channels = <12>;
 			dma-channel-mask = <0x3e>;
 			iommus = <&apps_smmu 0x436 0>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -820,6 +821,7 @@ qupv3_id_1: geniqup@8c0000 {
 			clocks = <&gcc GCC_QUPV3_WRAP_2_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_2_S_AHB_CLK>;
 			iommus = <&apps_smmu 0x423 0>;
+			dma-coherent;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			status = "disabled";
@@ -1305,6 +1307,7 @@ gpi_dma1: dma-controller@a00000 {
 			dma-channels = <12>;
 			dma-channel-mask = <0x1e>;
 			iommus = <&apps_smmu 0xb6 0>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -1318,6 +1321,7 @@ qupv3_id_0: geniqup@ac0000 {
 			iommus = <&apps_smmu 0xa3 0>;
 			interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>;
 			interconnect-names = "qup-core";
+			dma-coherent;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			status = "disabled";

-- 
2.42.0

