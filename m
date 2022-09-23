Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D047D5E849C
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 23:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiIWVJs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 17:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIWVJo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 17:09:44 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A985F56;
        Fri, 23 Sep 2022 14:09:38 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id m16so776809ili.9;
        Fri, 23 Sep 2022 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=WJf8TkYFfo7+edrcIuL4O47boKLRtK4HKRJRHhc/H3w=;
        b=IIm30rsE6KEk6+qLDIVRDeI/HTtZZGcM8ICgiHoVLOi0epKZG2+IsBU6dcJBAOLNZc
         gQVt29Ppx+28eAl58IXORVV6DAfcFQ4p0KzszvNczwkmihEB4hts41qn8g3QjHEajTx9
         bwJCMNU6CD0rqMJNvegFAa3RS4UySPN382gQqTCl7qZgnzJ6M9RbTXE05XoPApbJwsTy
         hHpQkblILaalFG8NffVNmJ0ZgCwRK/7QCAACvzY+mj6wLfs+V4EmVWYiq/vTdvTuoIxQ
         ZMQUvBiR4Ocsu2DaOD7XKDwAk7zFyxQrfRIBxonsdzzyVwsaCDUJxXv9I2FvFrnkqjDU
         jMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=WJf8TkYFfo7+edrcIuL4O47boKLRtK4HKRJRHhc/H3w=;
        b=Rh5+Mv7C9YnB7v0bPawSb4Bb/1PVGRgobKKP+A1m7PzMOTUZOCm0qjMi9U/daiOz1y
         pLlFxKhqqtXpaRYKonjrTLIeFrFexzoKw/cDD00AU/7SzTcSRPMPeV4mTLN+ub5iywsE
         XMwugIBjncxkad9l6uLlp9p0lsRvlmZHAlQdy9RQvFormRrBQrCf1q7KYukvpxf4D/+h
         vjXoBNyKyj5/FisYC4zrMpJQm7gp86EuZDBZkYZZFu75kXFtlnuBJ2F6F5+YIqvn1mpX
         V2wdJevP5ENLGLtWPa6CfwxcuYWG8Q+uES9WfhWcMj6sEGFMDPqLJLGI8sc7JAZYRVqG
         swUQ==
X-Gm-Message-State: ACrzQf1Cuz+TRea8znoQ5oL6RHapJoJfcKdFj1NSJwNWOXx7UeYgzHOu
        oPAsXjBoaDLG6JR7vg6LbrFuelbZ47g=
X-Google-Smtp-Source: AMsMyM75QAllE6Um68RNVmoTO5c4cPPagHq2328mgOMx5V7rf7LD2EmfXmXoaaD0ZBd/ofLt6SEVSA==
X-Received: by 2002:a05:6e02:1c0f:b0:2f1:8fec:256 with SMTP id l15-20020a056e021c0f00b002f18fec0256mr5219614ilh.149.1663967377302;
        Fri, 23 Sep 2022 14:09:37 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id e23-20020a0566380cd700b00352ce4f5e72sm1216732jak.179.2022.09.23.14.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 14:09:36 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 0/4] SDM670 GPI DMA support
Date:   Fri, 23 Sep 2022 17:09:30 -0400
Message-Id: <20220923210934.280034-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Changes since v1:
 - add fallback compatible

This patch series adds the compatible string for GPI DMA, needed for the
GENI interface, on Snapdragon 670.

Richard Acayan (4):
  dt-bindings: dma: qcom: gpi: add fallback compatible
  dt-bindings: dma: qcom: gpi: add compatible for sdm670
  arm64: dts: qcom: add gpi-dma fallback compatible
  dmaengine: qcom: gpi: drop redundant of_device_id entries

 .../devicetree/bindings/dma/qcom,gpi.yaml      | 18 ++++++++++--------
 arch/arm64/boot/dts/qcom/sc7280.dtsi           |  4 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi           |  4 ++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi           |  4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi           |  6 +++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi           |  6 +++---
 arch/arm64/boot/dts/qcom/sm8350.dtsi           |  6 +++---
 arch/arm64/boot/dts/qcom/sm8450.dtsi           |  6 +++---
 drivers/dma/qcom/gpi.c                         |  4 +---
 9 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.37.3

