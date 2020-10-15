Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0028F223
	for <lists+dmaengine@lfdr.de>; Thu, 15 Oct 2020 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgJOMdV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 08:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgJOMdV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Oct 2020 08:33:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E4C061755
        for <dmaengine@vger.kernel.org>; Thu, 15 Oct 2020 05:33:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q5so3459669wmq.0
        for <dmaengine@vger.kernel.org>; Thu, 15 Oct 2020 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gAf5fB5iQjUkbZE2PNnBqlTvtlb0W+hOlezFL2z0t0=;
        b=phvyFg4xjOGamHGSk/i05nAsDluAs0yWPaT2/eZkZDWz6fh0DSNW+CxmypNWD3fgle
         8AC8w0CuYMtRyP2XvJCqOl7LznkwXyw+cmbpYGi9Qvqk8v4qgD+YVngklOb1YPlZNUpY
         PUWRaFKto7ziGDDuVUXqr9Gw9rozNF27/AkXBF4b5bOmiDhfX6B8+YubTpadSuWCYwie
         5taGkWoqWKn2JjKsSHJby4S6ytLFCNrBGBbw946DYXamCF6ZEmR3PIZB5q+GCgpnYqgd
         xZCtA59kD753+zU0S0xYgVc8jfTVBYa3C4BjN1b3+U879tXdYkKFu/JEEAjFabYwHVHo
         Vfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gAf5fB5iQjUkbZE2PNnBqlTvtlb0W+hOlezFL2z0t0=;
        b=Q2SfDVyRka1hDYTsbPW7fEFc/wrmn+Oqq/Po+Gs1w5H4YJNSu6Pfc1MOv9ES7+u/68
         ytqgUKtszm1pP/wer1DEUEShjB+XAuE1azrqI0zId0afxawRxBcIQGs45e7RHI5v7KW4
         t659Qkq2Hp0wuj0xAWyX6/H8ts/strmg6DG7VHBb/QwY+fn8S8oL5nIorOgYLskyR2G9
         aduDBJMwH5GXMl6YrGUQH4Nts1g4wHm7SzJS2ahnhhfyaNHqXUg/Mn9pfHn6/Jr5F3tS
         sUWYLgzxNZgwMM8mJtpbOeSGCLGw8j0Q2JFxUfEu/+DEKdbOALSZ/rzal9ViDpn4kdlv
         A5Ug==
X-Gm-Message-State: AOAM531+VOfMe1LkXbQ5dCs7pmeFY7vTf3I6DxZfbvIUpCz/0jxrMvhk
        I6C0/+5LQ+o5VvVJYH4wP6Ue6sdsswM8vA==
X-Google-Smtp-Source: ABdhPJwMWmhzac8KOGYrXil1jcjuEazEomj2N1xyRdOMuoCb7xSRa3SeIB2Z0+rBWSrgh8MElOQYdQ==
X-Received: by 2002:a05:600c:2905:: with SMTP id i5mr3815469wmd.9.1602765199464;
        Thu, 15 Oct 2020 05:33:19 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net. [81.185.163.129])
        by smtp.gmail.com with ESMTPSA id j7sm4017406wmc.7.2020.10.15.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 05:33:18 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, vkoul@kernel.org,
        sean.wang@mediatek.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: dma: mtk-apdma: add bindings for MT8516 SOC
Date:   Thu, 15 Oct 2020 14:33:14 +0200
Message-Id: <20201015123315.334919-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
index 2117db0ce4f2..fef9c1eeb264 100644
--- a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
+++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible should contain:
   * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
   * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
+  * "mediatek,mt8516-uart-dma", "mediatek,mt6577" for MT8516 SoC
 
 - reg: The base address of the APDMA register bank.
 
-- 
2.28.0

