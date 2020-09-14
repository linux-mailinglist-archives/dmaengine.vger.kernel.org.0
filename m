Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882FA268CFB
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgINOKp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 10:10:45 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19548 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgINOKb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Sep 2020 10:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600092631; x=1631628631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3vcZ3ZLnnd6S54k/d0i4PUQ85b1B7wkAsBhm1WELjkw=;
  b=xRKMTyXM1v15pnHKlfqByPmrhH7Yt0QLy5qnEF8xlHbGGuTA11OcYCr/
   nQ7qMDXWByDjGIPSK1M9SCvzh3Si4VAsyjwZrgWO9zSbV6maFGrMmQbqK
   o9ILiMgyI50Kh0vh6pJAMbSutobJjLh5HPJ4ebgU+5/qnmUEb/JTZa6Zq
   4xlFz9QETXO9REqd70b3Urw8YWX/VbxhrKpFJsz1mO/N8B5a7yl88CR2p
   nTPHQ0ZzklHo31+xU5dyT7k8N6OJpzVPoT/LUJhWBHLx9vJ2y2ugKKRRE
   3u47mBIXv0yjdd3ppSkv04rCOlsfxmD1xNsqcPf8ssARsRlNxe/Th9uE9
   w==;
IronPort-SDR: 90DgTnYAFRQBucT4e3cNm+/hJMKFgwu5B2J/IyFUYT00CWnayQizJ3ngYiQJraAEvXuozBGWe2
 prKUfcezWkEB7x2phFBJb1LjY9gl5Dhcie3MG9IiU6LPuJrluUC0I4qTXLr6Z3R3DdJKHX+dER
 HRcO7dQ4MKlCNJAaX7tJMZj58NP4f4Hm5G3OaYVwUJxy1L+hT6DyZefHiXADlut+r4lMXzGrrg
 6WivrINUyJrnlfc/EZ7GpTPc76RONDapd4IwzjlvCOAlUlNsTfIVwYtCM9h22sdrEFzmU2Pveu
 3vM=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="90900856"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:10:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:10:27 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 07:10:23 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <tudor.ambarus@microchip.com>, <ludovic.desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 6/7] dt-bindings: dmaengine: at_xdmac: add optional microchip,m2m property
Date:   Mon, 14 Sep 2020 17:09:55 +0300
Message-ID: <20200914140956.221432-7-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914140956.221432-1-eugen.hristev@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add optional microchip,m2m property that specifies if a controller is
dedicated to memory to memory operations only.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/dma/atmel-xdma.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
index 510b7f25ba24..642da6b95a29 100644
--- a/Documentation/devicetree/bindings/dma/atmel-xdma.txt
+++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
@@ -15,6 +15,12 @@ the dmas property of client devices.
     interface identifier,
     - bit 30-24: PERID, peripheral identifier.
 
+Optional properties:
+- microchip,m2m: this controller is connected on AXI only to memory and it's
+	dedicated to memory to memory DMA operations. If this option is
+	missing, it's assumed that the DMA controller is connected to
+	peripherals, thus it's a per2mem and mem2per.
+
 Example:
 
 dma1: dma-controller@f0004000 {
-- 
2.25.1

