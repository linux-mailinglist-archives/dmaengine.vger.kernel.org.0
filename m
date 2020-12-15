Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86EB2DADCE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 14:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLONNj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 08:13:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37528 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgLONNj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Dec 2020 08:13:39 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BFDCqlw038064;
        Tue, 15 Dec 2020 07:12:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608037972;
        bh=6CpEH4zEcV4+sDTHJ2Gtr/fJNLhzbnJgxMi7aSNIz6A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=omn4lusPf30t062llsGbEwrAtw0r9QUeGa0grsXyN1hVi5BareK8XNVLatot6JPhm
         EJWS77bIsb+oNGzM/w5S5eDJ/Ra1HcuIgt7V2R/yE/X4DQaN/MJM6BgLgX/pLh4kZi
         Ir2uojnt+rhuxFkI1e0ByjIZG9tgWgqD9jPvrteA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BFDCq1V099674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 07:12:52 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 07:12:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Dec 2020 07:12:52 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BFDCjku037808;
        Tue, 15 Dec 2020 07:12:49 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <peter.ujfalusi@gmail.com>
CC:     <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] MAINTAINERS: Add entry for Texas Instruments DMA drivers
Date:   Tue, 15 Dec 2020 15:13:47 +0200
Message-ID: <20201215131348.11282-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215131348.11282-1-peter.ujfalusi@ti.com>
References: <20201215131348.11282-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

My employment with TI is coming to an end, it is my intention to look after
the DMA drivers I have worked with over the years.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 952731d1e43c..f6e7162241eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17549,6 +17549,19 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
 F:	drivers/iio/dac/ti-dac7612.c
 
+TEXAS INSTRUMENTS DMA DRIVERS
+M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
+F:	Documentation/devicetree/bindings/dma/ti-edma.txt
+F:	Documentation/devicetree/bindings/dma/ti/
+F:	drivers/dma/ti/
+X:	drivers/dma/ti/cppi41.c
+F:	include/linux/dma/k3-udma-glue.h
+F:	include/linux/dma/ti-cppi5.h
+F:	include/linux/dma/k3-psil.h
+
 TEXAS INSTRUMENTS' SYSTEM CONTROL INTERFACE (TISCI) PROTOCOL DRIVER
 M:	Nishanth Menon <nm@ti.com>
 M:	Tero Kristo <t-kristo@ti.com>
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

