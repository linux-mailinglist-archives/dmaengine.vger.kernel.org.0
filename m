Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E645584F1C
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jul 2022 12:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiG2KpG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jul 2022 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiG2KpE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jul 2022 06:45:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5183F32;
        Fri, 29 Jul 2022 03:45:03 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB4FD6601B71;
        Fri, 29 Jul 2022 11:45:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659091501;
        bh=KHcQKTlIo6mCV2UKqcNxwuM/2dLWF39lYb6bnCpx53Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwUT9zuOSrT8H5P4zToiy+Yl6pA2pulVODhkXMqwm+n2Nzs6hwZE28f/4cmrzq6WS
         ScijsulJB37EnnP7WXkNM7w5t7yYLRHsE/2fB7jE2qanD/8E5xAjfqKd15wYzl2qMv
         LqWent0iYNsl1AfUsLfcCPmrM+y/nCzMnFQ+e+N/IP1n5zdDmDiFUbITNFQ9prAUxR
         SoXQFBSlgfMsoFkxZaHfs7PkdO2osJuM9dwrvGGbJAQ5Jlgh3lo8NVVazT38yNQA4d
         myuTXqnCJMmMA8kjb8Rv4isxk0twfkvYhtThe1rsraIEHM///fvjhSU+CJ5EbO4SOx
         EdZJRpVOvAPsQ==
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
Subject: [PATCH 7/8] dt-bindings: arm: mediatek: Add compatible for MT6795 Sony Xperia M5
Date:   Fri, 29 Jul 2022 12:44:40 +0200
Message-Id: <20220729104441.39177-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
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

Add a compatible for the Sony Xperia M5 smartphone.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 07c0ea94e850..c162b0df299b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -58,6 +58,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt6795-evb
+              - sony,xperia-m5
           - const: mediatek,mt6795
       - items:
           - enum:
-- 
2.35.1

