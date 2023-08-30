Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36178DC3C
	for <lists+dmaengine@lfdr.de>; Wed, 30 Aug 2023 20:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbjH3SoE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Aug 2023 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244262AbjH3Ms6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Aug 2023 08:48:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53A3193
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 05:48:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso84037591fa.0
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693399734; x=1694004534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgmwfxTnMmpefIt4Jxsh17oZItSNIKysBY26cGht8Zc=;
        b=KPonl6BB6Sgvtd/A5gRcEInNCvl0X7QckMMn3kbCck3rUAJf7SkV/t7nMHJAHYQtus
         Fx0+evm6NMe+BKpX5vQ3c6ZlF9cMaba/9gQnxL6uNUnj+Uv/spztI/kCt81y7wDs29VE
         14ZDD+rcxdZU6uYINAiB3r8XVc9ZmXYU/TlJ/T3IOsvfldx9XxAeOrkaW3Z8gM6dk5vu
         yzQ5cNWI56ok/4vFWb0RXoZSo305n/dbofpWxfjzTFARzd8Y+dEubfa7UA0SYO0GrWDc
         nJw/BXW98uLBfAgWlArFXSnKKShYPb9lbp1ZSyB+9ID7YYgoYn6RBBaq9X5IhsIFSXOx
         2tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399734; x=1694004534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgmwfxTnMmpefIt4Jxsh17oZItSNIKysBY26cGht8Zc=;
        b=F7k5vXR1LxnyjKsLLSU/BSQtovkAwb4WlzFF5ADja4i+BdLQCgB7fz76csGgdwB0uq
         pHv6tsNaq25b3Mxze6xKMR8GTH5m5ho3JtkGdHRvWt/NtOQe+q5kqx+SP469F1GLAUFJ
         A4gCHwe8v8AWzkLbF+LM+zUpMBQnhyJ45j6sqZdfr5Aj1y5ZFpE2wvgoVhXrr5WWZc50
         gy0s6DIV4+pvCFPZfCgMwAyZGAcJWT9taJtbwNXANPg1c0vul5SKckLd2Bo/1K21XSbQ
         p+VAuJNwqrQS/qtDVlb/XJA5FaydV67ocac2W2xQhyV+ioISMI6/fo8GXGAwC6HSxGWK
         KGEA==
X-Gm-Message-State: AOJu0YzBSsEmTYadL4+e0zYkY6sej51g9Y7FMwT1P5dmU5TbHtRHh9w1
        GQwJUX1SQbEcGXHUn4t3qcLkfQ==
X-Google-Smtp-Source: AGHT+IFxmlJWMrKdeEvbrVkC3wj6G7ZOc6vn7oa01VC/C/O4ks01gO0BjEXMjtPOcBmVH0jhNGL3KA==
X-Received: by 2002:a2e:83d0:0:b0:2b9:3883:a765 with SMTP id s16-20020a2e83d0000000b002b93883a765mr1884741ljh.31.1693399734253;
        Wed, 30 Aug 2023 05:48:54 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e7d17000000b002b94b355527sm2602662ljc.32.2023.08.30.05.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 05:48:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 14:48:45 +0200
Subject: [PATCH 6/7] arm64: dts: qcom: sm8550: Add missing DWC3 quirks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-8550_dmac2-v1-6-49bb25239fb1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693399725; l=1404;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jj9VVwygDZqQ39oRSM4g+RTt+SnGK4NeCXuTCm1OBo8=;
 b=Kcv2F6CZvKpkJBpMmgtDhALkq3Ni5KrCdIjwfcSr8Jl4ayer/gFPHk2spEc/Ew3HDGr3yhRBV
 /T9CqVnJJFTD81Nh28WTF2b6aYfnTB4sBVQAVujc8L/jMy92Ua9r9Az
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As expected, Qualcomm DWC3 implementation come with a sizable number
of quirks. Make sure to account for all of them.

Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 944b4b8c95f5..8ee61c9383ec 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2930,12 +2930,20 @@ usb_1_dwc3: usb@a600000 {
 				reg = <0x0 0x0a600000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0x40 0x0>;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_enblslpm_quirk;
-				snps,usb3_lpm_capable;
 				phys = <&usb_1_hsphy>,
 				       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,usb2-gadget-lpm-disable;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,dis-u1-entry-quirk;
+				snps,dis-u2-entry-quirk;
+				snps,is-utmi-l1-suspend;
+				snps,usb3_lpm_capable;
+				snps,usb2-lpm-disable;
+				snps,has-lpm-erratum;
+				tx-fifo-resize;
 
 				ports {
 					#address-cells = <1>;

-- 
2.42.0

