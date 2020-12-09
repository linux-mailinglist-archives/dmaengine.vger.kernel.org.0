Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2D2D415C
	for <lists+dmaengine@lfdr.de>; Wed,  9 Dec 2020 12:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgLILse (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Dec 2020 06:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbgLILsW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Dec 2020 06:48:22 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA41C061793
        for <dmaengine@vger.kernel.org>; Wed,  9 Dec 2020 03:47:41 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id jx16so1662439ejb.10
        for <dmaengine@vger.kernel.org>; Wed, 09 Dec 2020 03:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rs3z5HiZz52Q+PqaHhfTF1Q+uRexoKTRYXUuslD9bJA=;
        b=d3T36ZkNR/AUgVDsWMcv+epjmknEjkr1S4/hA5BmOBbmMp3QPmqbQ5+T5urLbZsaZm
         yddM22Ca/MjmaZ65L9Ziy8Eis/rNNRh6ZWV33tysfBDK99xgKIFsPiG/pLxOIGV2msux
         3VZ4X/R76YQSx/b/gtQiCbkElRc8FjmqEJZ9snzxdIWHO32LjhfnKFPVl2brKq/cbdPl
         zpDqtSxW6OC+2JHBCUwRoKYHHWYHCx4jqiOhBquIjUJ4tNKpJzn/IlzziXa4/3PKi8pE
         aTb57hm0IUn94GQTHu2NhsmG7apvTb2fEUQ2K5isvTgowQlyZ+eEA7pRISQ75ZxcifFr
         j0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rs3z5HiZz52Q+PqaHhfTF1Q+uRexoKTRYXUuslD9bJA=;
        b=kkTGTk5M2vwOOP0iypWyEjedi33XDXTfq7Hq+9IXAgb0RTl/yQF7+qfgJo0UWuJqoa
         /h9SXuiyWDUjlyRgC4ZCQZOIRxSPV8QT/zlX/PQsRxhoNuxTVc9stoiJeMRlXAUw53dL
         y7GgszE1MtjJTxxwdHADCBwGouISbjDitq21n+XT5EL3l8EZIo+MjEm0l0aU16UqmCei
         GIQXPJWtNX/XPmYOy1ryLOwW5xVEyx4VgNIgoyAOi2moUyh7SmSGhG6mu5caDD863ohL
         hjSgBHJWy97mtW9L/xb7fU8h924j0tJ1Z7ZECjQO/U6Tz8Oev/itWsKtattP3BuLCova
         6RVg==
X-Gm-Message-State: AOAM530CEuOiZRyntyoRbyvEIjXzAxcYFKp44HXWpoSwvNNTubvfIxo+
        3mthTxt0iHT4SHJbYNUvX784ig==
X-Google-Smtp-Source: ABdhPJz4K0kLaWeuPBop0IAkjqejJVnYvx1By/KhxM6pBUYlU2Hn4uST4po7Bl+o5xWrlrVSPgRe1g==
X-Received: by 2002:a17:906:98d4:: with SMTP id zd20mr1710918ejb.532.1607514460504;
        Wed, 09 Dec 2020 03:47:40 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k23sm1244877ejs.100.2020.12.09.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:47:39 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: dma: mtk-apdma: add bindings for MT8516 SOC
Date:   Wed,  9 Dec 2020 12:47:35 +0100
Message-Id: <20201209114736.70625-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---

V3: remove unicode symbol that slips into patch summary
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

