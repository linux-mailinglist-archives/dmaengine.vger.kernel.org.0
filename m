Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895D12FD16C
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jan 2021 14:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhATMe3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jan 2021 07:34:29 -0500
Received: from aposti.net ([89.234.176.197]:49780 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388326AbhATKyg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Jan 2021 05:54:36 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: dma: ingenic: Add compatible strings for JZ4760(B) SoCs
Date:   Wed, 20 Jan 2021 10:53:21 +0000
Message-Id: <20210120105322.16116-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add ingenic,jz4760-dma and ingenic,jz4760b-dma compatible strings to
support the DMA engines present in the JZ4760 and JZ4760B SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/dma/ingenic,dma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index 6a2043721b95..ac4d59494fc8 100644
--- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -17,6 +17,8 @@ properties:
     enum:
       - ingenic,jz4740-dma
       - ingenic,jz4725b-dma
+      - ingenic,jz4760-dma
+      - ingenic,jz4760b-dma
       - ingenic,jz4770-dma
       - ingenic,jz4780-dma
       - ingenic,x1000-dma
-- 
2.29.2

