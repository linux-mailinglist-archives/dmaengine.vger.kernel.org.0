Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7665EB716
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 03:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiI0Bs6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiI0Bs4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 21:48:56 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62DA7ABA;
        Mon, 26 Sep 2022 18:48:55 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p202so6695784iod.6;
        Mon, 26 Sep 2022 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TD9RcFiA5bO7MHMjUJF8fxsi9gGsM0Psc7oBi/obCZE=;
        b=fI+51GHGFlN2/WCSqCet+tQ1zpZP+bvdmxUoAfq48SkPANU9Q/lxE6fZJ51ehQmx0T
         1/Ls51RYJhqRp//dpuDf4LBnUIvTOxsIr9cIQaSKIB/9tVM+cZCLTvpVFZD8J/+nlAa/
         LCl1mOzRvKNc1gJrMEudn5+r+GxMfosFRqmOoGMa4HR8kjssYqJXzRBEr6iq03Byt8aG
         bjtmjsDjZPxLiLqQOLDsLY6zQpOuMNSEPbA5wFXnwKvF6kuNQQ0CI0fb+jguLSrBwt2U
         TL9euoY5yxd/kexdqMaGVTUgTqP/z6Ud2UxYfkAKehFkurQP+FFbu2TnnIpxBpG7qi5b
         tIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TD9RcFiA5bO7MHMjUJF8fxsi9gGsM0Psc7oBi/obCZE=;
        b=w1f5Y2rGBjdaday+YQcd/O95HwpBuWEQmWW62CSycB3+6mcMZGnE2i42tWONWZsE3H
         b6ECUsG7jUMAr7r7YJOO+o/qF8eMUj7RuRPSpJsH2L/VGFhehM81qwQ+OOoJajr8miUm
         Ur1Z3Wq/PxND8uPTIgKxatH/qb26drlIyQ3Z9tbhgTCAjW4x/ICnp/Ss8CEfgU48SRUO
         vqQnKdv8/J/3BqPIr3qx/6B11z+/U3njfklzXqEXfBUDu6D7wP4nN3BEikxlbb0i3Yle
         AH0PNI98s78HV5p2zpTNA/dE94gZpdewZBPItRaJdX5fk/zvmOqjrbgot5Purk4601Ab
         x0bA==
X-Gm-Message-State: ACrzQf3SNNMCl/3SJI0aPqB7+zzqoPP/KhdoMWAk2Zlz45nj0t4VNrSl
        e1VtjIUo3WwVlUfvepKRIr7PGaElK88=
X-Google-Smtp-Source: AMsMyM5ny7/7Lj/6v4Z6ZQ4mRnFRv6evCA+GYKLbYoNXVyRwGLIl6ikwI32gSTjeX766pedu+pkNjA==
X-Received: by 2002:a02:880b:0:b0:35a:e4be:c408 with SMTP id r11-20020a02880b000000b0035ae4bec408mr13101307jai.113.1664243334877;
        Mon, 26 Sep 2022 18:48:54 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::ac99])
        by smtp.gmail.com with UTF8SMTPSA id i1-20020a056e020ec100b002eacd14e68esm143749ilk.71.2022.09.26.18.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 18:48:54 -0700 (PDT)
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
Subject: [PATCH v3 0/4] SDM670 GPI DMA support
Date:   Mon, 26 Sep 2022 21:48:42 -0400
Message-Id: <20220927014846.32892-1-mailingradian@gmail.com>
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
  arm64: dts: qcom: add gpi-dma fallback compatible
  dmaengine: qcom: gpi: drop redundant of_device_id entries

 .../devicetree/bindings/dma/qcom,gpi.yaml     | 22 ++++++++++++-------
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  6 ++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  6 ++---
 drivers/dma/qcom/gpi.c                        |  2 --
 4 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.37.3

