Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1411F28FFDB
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405019AbgJPISn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 04:18:43 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:3747 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404992AbgJPISm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Oct 2020 04:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602836322; x=1634372322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FQiY+u3yLkMuP0Qqk5TM9IZJRRRUTajSE4D/OI6vgoo=;
  b=Wn3n3rPcSPA885W9E6YkJnvoMgfa6MCUg+x4aPXx1kkC6GphwQ5Ul3WU
   2jDgIND+AZwwvJoGf/wUyCozA9xbt7ImNFmIhY3yvb8wCMjBalVCNH2FJ
   IZICStdHgt5yzeJY+yVPpQymVnsH+DOiHKyTynLsTZ8Iy8GDWZvhUclUl
   pwF3vel2OIxQuMweJF96lR4MmVCQ3MJ3ESQVNC3Xyz0srAx6a7hZ8aOI7
   lRBbYCJ9X+64xOmyelSM/jCguVoPWhACQ9UoxM1bn2aAkvtnsHEVfKuS2
   pKm9qGNOLpnJfvRSYGrzv9i5ClHzfdqUiNkqhFFVJogQ+DJYZu0lP3Asr
   g==;
IronPort-SDR: 7HZ2svuXbSoAwo/wpFlTmOG65l0Et/yLOjVa5vcLruopKr0NGAC7LZ6mQ4XsqPx/6BCA8DipVr
 SY1jz5OtsUFrgWU8vRfkV4mQXnAp3CT/6I9Q0Qe4S/tEwNZcOfUW0nOoRgMUSRig37bv2EIjGd
 khDvx7t3YSwi8OZEb6c0fZ+Q4JT5hRqtvlLRxKZRYnifPlZpX/BvmQrREyIxLr6zTz0/loM6T7
 K1EPqOfPShFsnvfh6v6lOJuv1pT5TXp6Nhn44zDVhG7riZUaRSZ8grVUkdPNMz2Uuze+n9qddK
 3Fw=
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="99779782"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Oct 2020 01:18:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 01:18:01 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 16 Oct 2020 01:17:57 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <tudor.ambarus@microchip.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: dmaengine: at_xdmac: add compatible with microchip,sama7g5
Date:   Fri, 16 Oct 2020 11:17:51 +0300
Message-ID: <20201016081754.288488-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add compatible to sama7g5 SoC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- no changes

 Documentation/devicetree/bindings/dma/atmel-xdma.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
index 4dc398e1a371..510b7f25ba24 100644
--- a/Documentation/devicetree/bindings/dma/atmel-xdma.txt
+++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
@@ -2,7 +2,8 @@
 
 * XDMA Controller
 Required properties:
-- compatible: Should be "atmel,sama5d4-dma" or "microchip,sam9x60-dma".
+- compatible: Should be "atmel,sama5d4-dma", "microchip,sam9x60-dma" or
+  "microchip,sama7g5-dma".
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain DMA interrupt.
 - #dma-cells: Must be <1>, used to represent the number of integer cells in
-- 
2.25.1

