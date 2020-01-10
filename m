Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46B8137348
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAJQUo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 11:20:44 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32688 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgAJQUo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jan 2020 11:20:44 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: jqXfijGp+uybqbwES1626qowsZbHD7EmbR21PZ69mlZ+z4Xfydcs/ypjBbjKL1jN0qh3oSALJT
 WJXTa85Rwr5ikQSvmN849xE7u3hY0qqr+nqDbRSIJZJk02dxZBfMmvZlDeEX4NCPRmeS+NWqvN
 W7S8kV244lSQUUhYcFuMJIAkddlGflA1cK708aj3/WVQXWjHZLejKhQxEYV5zTNV0TvFLQl/Kp
 DLEzanGb8pRbdKvJ7UJLcvNaeBQes6uqrrPSDaE9++ShI+uDjgAzEe373ny01bqnVpf/VW7Ezv
 2vo=
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="62249206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jan 2020 09:20:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Jan 2020 09:20:32 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 10 Jan 2020 09:20:24 -0700
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
Subject: [PATCH v2 13/17] dt-bindings: atmel-usart: remove wildcard
Date:   Fri, 10 Jan 2020 18:18:05 +0200
Message-ID: <1578673089-3484-14-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove chip whildcard and introduce the list of compatibles instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-usart.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 699fd3c9ace8..09013c49f6cc 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -1,10 +1,11 @@
 * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
 Required properties for USART:
-- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
-  The compatible <chip> indicated will be the first SoC to support an
-  additional mode or an USART new feature.
-  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
+- compatible: Should be one of the following:
+	- "atmel,at91rm9200-usart"
+	- "atmel,at91sam9260-usart"
+	- "atmel,at91rm9200-dbgu"
+	- "atmel,at91sam9260-dbgu"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
 - clock-names: tuple listing input clock names.
-- 
2.7.4

