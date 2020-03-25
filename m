Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63571920FD
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2020 07:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgCYGTO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Mar 2020 02:19:14 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:43949 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgCYGTN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Mar 2020 02:19:13 -0400
X-IronPort-AV: E=Sophos;i="5.72,303,1580742000"; 
   d="scan'208";a="42785431"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Mar 2020 15:19:12 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B857D4000FAF;
        Wed, 25 Mar 2020 15:19:12 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] dt-bindings: dma: renesas,usb-dmac: add r8a77961 support
Date:   Wed, 25 Mar 2020 15:18:58 +0900
Message-Id: <1585117138-8408-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds support for r8a77961 (R-Car M3-W+).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
index f1f95f6..e8f6c42 100644
--- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
@@ -16,6 +16,7 @@ Required Properties:
 	  - "renesas,r8a7794-usb-dmac" (R-Car E2)
 	  - "renesas,r8a7795-usb-dmac" (R-Car H3)
 	  - "renesas,r8a7796-usb-dmac" (R-Car M3-W)
+	  - "renesas,r8a77961-usb-dmac" (R-Car M3-W+)
 	  - "renesas,r8a77965-usb-dmac" (R-Car M3-N)
 	  - "renesas,r8a77990-usb-dmac" (R-Car E3)
 	  - "renesas,r8a77995-usb-dmac" (R-Car D3)
-- 
2.7.4

