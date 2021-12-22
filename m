Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C8547D133
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 12:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhLVLp0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 06:45:26 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:53136 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233541AbhLVLpZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 06:45:25 -0500
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000"; 
   d="scan'208";a="104834400"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2021 20:45:23 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1C0B642E4FF5;
        Wed, 22 Dec 2021 20:45:23 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] dt-bindings: renesas,rcar-dmac: Add r8a779f0 support
Date:   Wed, 22 Dec 2021 20:45:06 +0900
Message-Id: <20211222114507.1252947-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222114507.1252947-1-yoshihiro.shimoda.uh@renesas.com>
References: <20211222114507.1252947-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the compatible value for the Direct Memory Access Controller
blocks in the Renesas R-Car S4-8 (R8A779F0) SoC.

The most visible difference with DMAC blocks on other R-Car SoCs
(except R8A779A0) is the move of the per-channel registers to
a separate register block.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
index d8142cbd13d3..7c6badf39921 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
@@ -44,6 +44,10 @@ properties:
       - items:
           - const: renesas,dmac-r8a779a0 # R-Car V3U
 
+      - items:
+          - const: renesas,dmac-r8a779f0 # R-Car S4-8
+          - const: renesas,rcar-gen4-dmac
+
   reg: true
 
   interrupts:
@@ -118,6 +122,7 @@ if:
       contains:
         enum:
           - renesas,dmac-r8a779a0
+          - renesas,rcar-gen4-dmac
 then:
   properties:
     reg:
-- 
2.25.1

