Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2633F268D19
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgINOMy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 10:12:54 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19500 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgINOKP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Sep 2020 10:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600092615; x=1631628615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zjX1ZDoVN5vFk7RnBEDR4gK3lHRk1XPsYEMncXzHsNU=;
  b=Vomvk54oWEqm/zb/wtfho0uB8s/VMpa/aDHtSt/tf2PGEK5hviiceZ3N
   3CpcdUNx/OMsWXBl90ExXPmVQt74KYDxebv/xtMIZ9xP5yQ0C0OXQwQqb
   4/G8w1RL3zF62f06Vgvo1KRfubKu1Zns2xUUXY9LyxlTCB/4LjWrau54q
   5RKnN7urnb32+E7dhMc5ORSBPLcyiNfxB2eR9Z+VZiOVjjNZ9IihNkMzs
   iUer2L47MP95Y2WbUStgl7yCp6DmdjKzdP6H8KNGHG7pf8jgonF8/zjx8
   TzW1H0mh295CCUGSn1uxIZI2M3e3g/Fj//J2ukF/mWLYINtflRJSXE4nX
   g==;
IronPort-SDR: z9NpU5wBJB0GfIMljjJHMN82jM/EqbxZuXX92hCUm00lvWZJP4U9kL+hAMzpChaFgql4wsnw7g
 O+92Cd/FlPYCT6qquXVJhBo+RFN8Y2AIXNHKOjgBVpdawvRQGMDw7peb7DvWOLxJxeCFjqw623
 t8FBkp2z3+Mz9boAX/KA8ql6Z3XNf36Dp7bUWU3fXIi2iNCwtWx3bxIvgNmFvOGdgPU9YmmqAX
 vnRqRuT1jGI9WIVxI10hMwk3+61k2yZG2Mr/5HfjRu+0YSjUEsLzhvUQivhUYFQu49icaGxcBO
 tn8=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="90900764"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:10:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:10:10 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 07:10:06 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <tudor.ambarus@microchip.com>, <ludovic.desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 2/7] MAINTAINERS: add dma/at_xdmac_regs.h to XDMAC driver entry
Date:   Mon, 14 Sep 2020 17:09:51 +0300
Message-ID: <20200914140956.221432-3-eugen.hristev@microchip.com>
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

Add new header file for the at_xdmac regs definition to the proper
MAINTAINERS entry.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5cfab015bd6..312ba6ae5fc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11361,6 +11361,7 @@ F:	Documentation/devicetree/bindings/dma/atmel-dma.txt
 F:	drivers/dma/at_hdmac.c
 F:	drivers/dma/at_hdmac_regs.h
 F:	drivers/dma/at_xdmac.c
+F:	drivers/dma/at_xdmac_regs.h
 F:	include/dt-bindings/dma/at91.h
 F:	include/linux/platform_data/dma-atmel.h
 
-- 
2.25.1

