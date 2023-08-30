Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DAF78DC2D
	for <lists+dmaengine@lfdr.de>; Wed, 30 Aug 2023 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjH3Snz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Aug 2023 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbjH3Ms5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Aug 2023 08:48:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E571132
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 05:48:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso82233831fa.1
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693399733; x=1694004533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKPXhXF1PLbuqp2N8PbVHGsxWJlF7sZyrRMN/kZaQfg=;
        b=Iwf+Sg2l+pMVTfdACffpzWyblWAqUX6mYK+WP20dOAVkBt48AL8z4uIk+ZKgT3LvN2
         MhPMVQP3fYMQBcuqM6oa6PDK5PfCSGSzRRkIHAp3PM0JdUfyDXX0XzoePSQ6cu6H0Vl8
         dNx7YhWThvzZIzp+SGDBc7DkNh87WmsF90v6f2HnFGZTOQV0N/qdbKf2nXkqAcIUsGfb
         HLevRRIguU47rX3pmF5C1irzPj3variRhAKam/XtAcLmrkax6yITJ5b/+68bPLRQjLdv
         +XZ2TxQDXWK846oo0jjwOiL6wns7mog1ajoaTLZSgHPJ8dJrbZlFGh2bLQtrFx/Gl6Pe
         nLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399733; x=1694004533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKPXhXF1PLbuqp2N8PbVHGsxWJlF7sZyrRMN/kZaQfg=;
        b=WvKbuAxp8nyccTRo09J8NuCMn1A5p7E8qBxmpDhqXbYIrmPVKjdg3cR/hSnFqNxaKh
         22VG5bDctVcLJw26K7BMBl4pDThfLcLG7lIgnXHpC+i6gNoJ8lFoZZB1OgbXso0+ayYF
         RO97ua/6Z5pW3bmsOi5gJ4hpNNguT9jc0aAkF/ekjgbuQtiXoOkWs5CSVWDCUDvHImQ/
         Qlo8j2xgYNE4cSSsuw3JP2i1zJAoIlXCxXeNU0mJ8QlrRoW6zFpEwYT6ZYNXdd80as6r
         1gNOskmEZTxJLvq4sQSyH9OZElXEJrKq+AL1sezfBUpn+0WsH8JutiL1kqN4z26Q8Ubm
         CYqg==
X-Gm-Message-State: AOJu0YziNISIcBMoF5eT0/9la6kTlLT/C+PPE9RU26YKhWYAAgHvEu2K
        PNxGjsb5m3chRVFslSkmoqPolw==
X-Google-Smtp-Source: AGHT+IEMqA8Wy1vPUEbfk80T0idVD4AwaoFtCsmwNdpJ/6NEPZQjtmG7nTLODMRmD5xy+1kpYdT7gA==
X-Received: by 2002:a2e:7316:0:b0:2bd:1614:d47 with SMTP id o22-20020a2e7316000000b002bd16140d47mr1774740ljc.42.1693399732906;
        Wed, 30 Aug 2023 05:48:52 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e7d17000000b002b94b355527sm2602662ljc.32.2023.08.30.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 05:48:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 14:48:44 +0200
Subject: [PATCH 5/7] arm64: dts: qcom: sm8550: Mark APPS SMMU as
 dma-coherent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-8550_dmac2-v1-5-49bb25239fb1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693399725; l=787;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dxb1X41je4rSeIgX7+gDy1NHdrHHkO6VZ2ImanBaUfE=;
 b=RnhOr3wT86Iumb2IEqK64ax6cEBUEMNSImGSUIVZrcGXpnCPKZWNcUmIKZUm7MJzPHM3sIvA8
 efPFh646mx2DZRzLKLxp4otgWTyEK++fXIVn2vEknLn21XV2ltd+j0M
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

Like on earlier flagship Qualcomm SoCs, the SMMU is dma-coherent.
Mark it as such.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d1911b2f0bf3..944b4b8c95f5 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3655,6 +3655,7 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 		};
 
 		intc: interrupt-controller@17100000 {

-- 
2.42.0

