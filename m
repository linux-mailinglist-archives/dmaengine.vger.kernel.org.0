Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC8601FFB
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 02:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJRA5v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 20:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRA5u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 20:57:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376CCC69;
        Mon, 17 Oct 2022 17:57:49 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id o65so10595938iof.4;
        Mon, 17 Oct 2022 17:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKXYM5dTwoXC7M0uSzVnC93RuKt7DwqvNvbHkwfaZjg=;
        b=KX9lE6azk5uRek7jP57t2ZQ00H8hlTREUVWxHg782G7YrBnnlHb+txM3tRLjciUU28
         NSJgRJESFu0BkW96cioEezmG5IaZ5IufMbUwUzE37Y/zexktdwbanA0gbL7x//U6S/Nh
         6WqS/aZjoGX7iUrifBj2yG2+PQMVS6u8X2lk6dhZ0gzQKx55/GF2jWX7rN+rHmmK1F1M
         tVeWPcn80qzvSKQ4Xif+8L+yD/SBONpL7OwysOPc8zsG/3sTbILFFc62hoqE1J27+rNI
         wJhva9c1bGCG34aLDZZWjMqWx8DVlr9FADTEkXNR0ow3I3UUlOmf2q3q1+T7WCRoaNS0
         jncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKXYM5dTwoXC7M0uSzVnC93RuKt7DwqvNvbHkwfaZjg=;
        b=1+7MKgSYPyHB7y1EFjxI63l0adb1oasOGmcW27wxxTVP2kC/yJMMoAYXWcPYDwXdMH
         Oo+Q9hPobB6wWdiKtH3I6JVPwrD3kXPGv96sp/GI3nnLERLRDRzcqplhz+U+oLpx4Qhk
         Gewj2GWUhjXokl9jyikVqAMAZ7i9oMLu2+b0HZJM63UDCgHHp0Tpq0oNhVo3pJQS4ZWk
         ui8glSvWN7MfyuXum1NMFTHO9pl5386/uRgoikVs2YjhypXWNyIpGWWlAKwWND3S5qY6
         iIYMYtmxoTpeKFfoQ9wxQvGmZyuifCICcKMu0VPKaTid0DEBnD6aXT20UYZzskwp427H
         3wwQ==
X-Gm-Message-State: ACrzQf0YuEIdXwYTVD69C0hbwZHGWaZIloNUrdjfvG4REREf/AaRvN2d
        EiUqgphQmOQM3YdXjwbgup/SoMEMY486ig==
X-Google-Smtp-Source: AMsMyM4KMDptP7XJyquJj4YqaD4y8rtj5dA/XO8jIyuNCTWYQoxhy0ZlopIXuS3OBB1G0uVwEzr9Kw==
X-Received: by 2002:a5e:c004:0:b0:6bc:9a7f:ebc7 with SMTP id u4-20020a5ec004000000b006bc9a7febc7mr484674iol.163.1666054668359;
        Mon, 17 Oct 2022 17:57:48 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id i17-20020a0566022c9100b006bccaa66ee4sm487462iow.40.2022.10.17.17.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 17:57:47 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 0/4] SDM670 GPI DMA support
Date:   Mon, 17 Oct 2022 20:57:36 -0400
Message-Id: <20221018005740.23952-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Changes since v5:
 - add back dts patch (4/4)
 - remove blank line (1/4)
 - add review tag from v4 (4/4)

Changes since v4:
 - drop dts patch (to be sent separately)
 - accumulate review tags

Changes since v3:
 - keep other compatible strings in driver and add comment
 - accumulate review tags

Changes since v2:
 - change fallback to sdm845 compat string (and keep compat string in
   driver)
 - fallback now only affects two SoCs + SDM670

Changes since v1:
 - add fallback compatible

This patch series adds the compatible string for GPI DMA, needed for the
GENI interface, on Snapdragon 670.

Richard Acayan (4):
  dt-bindings: dma: qcom: gpi: add fallback compatible
  dt-bindings: dma: qcom: gpi: add compatible for sdm670
  dmaengine: qcom: deprecate redundant of_device_id entries
  arm64: dts: qcom: add gpi-dma fallback compatible

 .../devicetree/bindings/dma/qcom,gpi.yaml     | 21 ++++++++++++-------
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  6 +++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  6 +++---
 drivers/dma/qcom/gpi.c                        |  4 ++++
 4 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.38.0

