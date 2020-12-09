Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344C02D414B
	for <lists+dmaengine@lfdr.de>; Wed,  9 Dec 2020 12:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgLILpb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Dec 2020 06:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgLILpa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Dec 2020 06:45:30 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D0AC061794
        for <dmaengine@vger.kernel.org>; Wed,  9 Dec 2020 03:44:50 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id r5so1185764eda.12
        for <dmaengine@vger.kernel.org>; Wed, 09 Dec 2020 03:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3zBnoEd2BLvViOa+U8szKTE6OyLng93MHF1miQwX9o=;
        b=Byyh+WzGJwB9hb+hsnXSoHIvv+Tr7CA98iS13mEF37Dm62Y+yT8PAW5ZANj12pQ5sA
         xvYJQCYfDnP/mmuw0CNmbpbbk8YWu1rSlBZ04EPWvksHnWIRBBi6berkz8TuWyaS8kvV
         ep3ZCcV26ZEqwMuVeobHq7u/RFQ16VCoAjsvcZBtRakby1zzJCMCskm2VQjt/nx+30GA
         FKC23QCKr2trZC/BtbKKaJBPacLMroHcsHd8cj2y338s8XiSqWx9IgJV/766AeY/QMto
         Y5fG7Ls6ljj3PceYbWChqlGyj6fMRbV7NWK6UhJyvGIRlzw0Ttbfk5Go3apzggTfZm2B
         k1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3zBnoEd2BLvViOa+U8szKTE6OyLng93MHF1miQwX9o=;
        b=BjM05ZWsEF4W7h031mr621LJrPcNqy0NaaQ3ie8qbx8k9YWpAR37L5EuD+QyMLYsp4
         zuzmhSvDULRa9WtFUJ9nbIpleSBD1zYh0TLszn1MI5mXYn32wDzycDHZEhy0HoJMmztN
         WbFVKSpqBobM/qEFAJwzCcfJxVoCJHLSTOPYNo6XHwEa+fR74f1ofEM+Zg+gSopOvK1d
         ENlzehmzALSExcgitoM6ZB2OBcy5Snk0aySgLnDCzMpdVo5uqoxoBm2Dd0Ks8OEiVMom
         KtZOSiur/G84qKqSHKYP9KxFBvMYpEuNqJLdEWB0krloIDjvSsLM1v6o7+puP/3N3Ns4
         bn2w==
X-Gm-Message-State: AOAM531FOO6/b+O8tYY8973WW8Nb9rU+QUWXzt9aqy6NwPn3D89X50Zj
        5LedauWtxCdUM+OObQbRxCIVd9JEI1n4kw==
X-Google-Smtp-Source: ABdhPJzXaWJEsxBqW/suyQOFajp0LZEwwhaXnTCIKtAoFuT+paYDZO6DqYGylmK2TXlZJjMUrzx4qA==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr1602775edj.293.1607514289034;
        Wed, 09 Dec 2020 03:44:49 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id c25sm1260327ejx.39.2020.12.09.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:44:48 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] =?UTF-8?q?=F0=9F=93=A4=20dt-bindings:=20dma:=20mtk?= =?UTF-8?q?-apdma:=20add=20bindings=20for=20MT8516=20SOC?=
Date:   Wed,  9 Dec 2020 12:44:39 +0100
Message-Id: <20201209114440.62950-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---

V2: no change

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
2.29.2

