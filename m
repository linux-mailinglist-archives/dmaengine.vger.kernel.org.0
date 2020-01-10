Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9AC137339
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 17:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAJQU1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 11:20:27 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:25465 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgAJQU0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jan 2020 11:20:26 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: LrzaHbSQy37L8CEyNm9sxZucOUH5zKlVbNSkSOctqn2dAInOP4KemBehINfeWmnpa7GQqPWezN
 nUPDt1IWXdJhHAWpmKbYpm6tVPRZK62QGj+M6EqMgToCB44RUdz5sDdkN5RQTf218fqSM9aWoJ
 U/JKGr7Ei20tlYQnRdjF46lspCy+gAB/FgMy3SStBZnQcIVgbePADoX7R7SBkQ9SZncs5r55Yr
 /Y4NnGZI5P+TTWL03GP+WrA0lBfKIujdiiZDHJbczWT0ipOBmz+5YuLwhRzeYs3QqepWUdwyXJ
 S0s=
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="60748452"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jan 2020 09:20:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Jan 2020 09:20:23 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 10 Jan 2020 09:20:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <mchehab@kernel.org>, <lee.jones@linaro.org>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <a.zummo@towertech.it>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-can@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 12/17] dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
Date:   Fri, 10 Jan 2020 18:18:04 +0200
Message-ID: <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add microchip,sam9x60-rtc to DT bindings documentation.

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Alexandre,

I kept this patch as in v1 (same for patch
"dt-bindings: atmel-tcb: add microchip,sam9x60-tcb").
I'm waiting your response to this version and take an action aftewards.

Thank you,
Claudiu Beznea

 Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
index 5d3791e789c6..35eab9138d0b 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
@@ -1,7 +1,8 @@
 Atmel AT91RM9200 Real Time Clock
 
 Required properties:
-- compatible: should be: "atmel,at91rm9200-rtc" or "atmel,at91sam9x5-rtc"
+- compatible: should be: "atmel,at91rm9200-rtc", "atmel,at91sam9x5-rtc" or
+  "microchip,sam9x60-rtc"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: rtc alarm/event interrupt
-- 
2.7.4

