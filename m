Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F094584F06
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jul 2022 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiG2Ko6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jul 2022 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiG2Ko5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jul 2022 06:44:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A1883211;
        Fri, 29 Jul 2022 03:44:53 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC0A96601B51;
        Fri, 29 Jul 2022 11:44:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659091491;
        bh=AQdqE1GO0V3rreFgAXtrSDeQLlxnOolBtnCZSijQhOM=;
        h=From:To:Cc:Subject:Date:From;
        b=ejPq8DpUJ8FijUY0HCE1hwqrRnGZkQmBiPhNJ55XL1sQXbHsVMgjGe1BCdP+qI76Y
         ewXDYk3rAZk5Wvt3URjsXZ527wjn580VKlMj0Cs1nvepNKKXM2MqtWDQyjkKuBvvnQ
         fePyS983PRiJNWfYwEntuI/T3T5SKEf6UbP1aK2GyDz6hfoY9YpEhlt9K5s10T99fm
         eXYPUHUdo2yrzYHNodmG/i+SbKZVmShsbXNYfXV+DOCI24usdP7esV8m+7qaDLB1LF
         mQMUuJ1Hn2RgwUs9pGHW9aAYphmUDslW2I1i2AXz2G1d113krfwj6pWw+pbNdYYHxj
         nYAo9akqERQxg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        hsinyi@chromium.org, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, fparent@baylibre.com,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        long.cheng@mediatek.com, wenbin.mei@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/8] MT6795 Devicetrees and Sony Xperia M5
Date:   Fri, 29 Jul 2022 12:44:32 +0200
Message-Id: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series brings some more support for the MT6795 SoC, as it
adds support for basic clock controllers (and resets) and all
of the mtk-sd mmc controllers.

While at it, since now it's possible to get the "first signs of
life" out of a MT6795 smartphone platform, add a basic devicetree
for the Sony Xperia M5 (codename "Holly") device as to start
preparing the ground for a gradual bringup.

This series depends on [1] my mt6795 clocks series.

P.S.: Thumbs up for the first MediaTek-powered ARM64 smartphone
      going upstream! :-) :-) :-)

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=662165

AngeloGioacchino Del Regno (8):
  dt-bindings: dma: mediatek,uart-dma: Add binding for MT6795 SoC
  dt-bindings: mmc: Add compatible for MT6795 Helio X10 SoC
  arm64: dts: mediatek: mt6795: Add topckgen, infra, peri clocks/resets
  arm64: dts: mediatek: mt6795: Replace UART dummy clocks with pericfg
  arm64: dts: mediatek: mt6795: Add support for APDMA and wire up UART
    DMAs
  arm64: dts: mediatek: mt6795: Add support for eMMC/SD/SDIO controllers
  dt-bindings: arm: mediatek: Add compatible for MT6795 Sony Xperia M5
  arm64: dts: mediatek: Add support for MT6795 Sony Xperia M5 smartphone

 .../devicetree/bindings/arm/mediatek.yaml     |   1 +
 .../bindings/dma/mediatek,uart-dma.yaml       |   1 +
 .../devicetree/bindings/mmc/mtk-sd.yaml       |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    |  90 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt6795.dtsi      | 107 +++++++++++++++++-
 6 files changed, 197 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts

-- 
2.35.1

