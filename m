Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2F64F4F4
	for <lists+dmaengine@lfdr.de>; Sat, 17 Dec 2022 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiLPXWY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 18:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiLPXWV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 18:22:21 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36931FCCF
        for <dmaengine@vger.kernel.org>; Fri, 16 Dec 2022 15:22:20 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AD1DE3EF16;
        Sat, 17 Dec 2022 00:15:40 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: qcom: sm6125: Enable GPI DMA
Date:   Sat, 17 Dec 2022 00:15:26 +0100
Message-Id: <20221216231528.1268447-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable GPI DMA on SM6125 by using the new sdm845 compatible with
ee_offset 0.

Changes since v1:
- Drop driver patch in favour of using generic qcom,sdm845-gpi-dma
  compatible [1];
- Replace status = "okay" with "disabled";
- Use 3 instead of 5 dma cells;
- Reorder properties;
- Explicitly depend on APPS SMMU series to have apps_smmu label available.

v1: https://lore.kernel.org/all/20221001185526.494095-1-martin.botka@somainline.org/T/#u

Depends on:
- SM6125 APPS SMMU: https://lore.kernel.org/linux-arm-msm/20221216215819.1164973-1-marijn.suijten@somainline.org/T/#u

[1]: https://lore.kernel.org/all/20220927014846.32892-2-mailingradian@gmail.com/

Martin Botka (2):
  dt-bindings: dma: gpi: Document SM6125 compatible
  arm64: dts: qcom: sm6125: Add GPI DMA nodes

 .../devicetree/bindings/dma/qcom,gpi.yaml     |  1 +
 arch/arm64/boot/dts/qcom/sm6125.dtsi          | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)

--
2.39.0

