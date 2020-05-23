Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28A41DFAE8
	for <lists+dmaengine@lfdr.de>; Sat, 23 May 2020 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgEWUPq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 May 2020 16:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387834AbgEWUPp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 23 May 2020 16:15:45 -0400
Received: from ziggy.de (unknown [213.195.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 332B420735;
        Sat, 23 May 2020 20:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590264945;
        bh=6NVJkDskDeSVG7nACrgOiBNrXbEYpv5thIkjzs1fYpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YqJ1UC6/w724lYfsZMcCtX6NO+gGocMubK8pXx+Y7r0uYeXyR+3ErvxQlffNYL3pf
         VD+VpIpVPxmTiN2S8S1PUOCUjN3npLKQ1iIlvkW1BET+zmFVX10n3nYiqQZMfkuFXn
         M16XalZKAkz22ItTu9hAFLiRjAAAoINHcjlR/C3o=
From:   matthias.bgg@kernel.org
To:     sean.wang@mediatek.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     matthias.bgg@gmail.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] dt-bindings: dma: uart: mtk: fix example
Date:   Sat, 23 May 2020 22:15:30 +0200
Message-Id: <20200523201530.18225-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The binding example is missing the fallback compatible.
This is needed as the driver only matches against mt6577.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
index 5d6f98c43e3d..2117db0ce4f2 100644
--- a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
+++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
@@ -21,7 +21,8 @@ Required properties:
 Examples:
 
 	apdma: dma-controller@11000400 {
-		compatible = "mediatek,mt2712-uart-dma";
+		compatible = "mediatek,mt2712-uart-dma",
+			     "mediatek,mt6577-uart-dma";
 		reg = <0 0x11000400 0 0x80>,
 		      <0 0x11000480 0 0x80>,
 		      <0 0x11000500 0 0x80>,
-- 
2.26.2

