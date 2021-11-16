Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E745304E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhKPLYw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9441 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbhKPLYY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061687; x=1668597687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9cKQ8DLE+KtiJG/oBAobTtHTIQZeH+YXTokO734xUTw=;
  b=r9ucFM20OtXXrUpnO87TnNSGTxqx4IIju26qOpE5NHggrxnmen5Nr33u
   5mpFVHUqvpYOhHrK2c9gvbNeJX8hQETuQa31SdKx56dur3eO9JwX8+AMT
   d+2YqXq5SQXO7ebmIy9jv09w4qpWqPUoOnGrLs77/Kk1/bmc0a4jFHQl5
   0WYXfdLiTCtkJMLewr/xPDG+62h0IFCPhhRkeRMIGUqGct79RBSs0fT78
   h/BfQzHQd42Xfd9C2nsGMh97HmuGVg3JRi6T1+S8Yu6kukxsZWMi4PPaI
   0Xw32Ag0WonmjFxO9f7Q7xfN7y0J7HVgsFLURcAAksi9TOpU4H2KVyaYp
   w==;
IronPort-SDR: YbAApsWQeRxOCI3wgOMxDyDDfskDzjL/SsnFWmWm9ppDJ/xZkCCvkPmfIVqn1+bTDJaqQFaBux
 Cu6f3YZwNmxcPHgqKzBQv/bA/Akz3pmi+Ky4MGP8NO7q0psMB+tJRC0vb/eIwey841NUsRgnGQ
 vZGp57Oo+zj7bAngS96MK5GmNTW7oWFrj2h09yCjZECI5G/s1wNbWS9lGPvVLPP3az1GT/ufJa
 HoSo/cHxJpNwPodask0Jr1F6VHo3R1H+OQKsb/vy8T68i4llqciAMQC5abkcGhV87Q1CgCr6nQ
 efTizVsPZH1O8g0ubRO0nynR
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="139278017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:21:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:21:25 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:21:22 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 12/13] dmaengine: at_xdmac: Fix at_xdmac_lld struct definition
Date:   Tue, 16 Nov 2021 13:20:35 +0200
Message-ID: <20211116112036.96349-13-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The hardware channel next descriptor view structure contains just
fields of 32 bits, while dma_addr_t can be of type u64 or u32
depending on CONFIG_ARCH_DMA_ADDR_T_64BIT. Force u32 to comply with
what the hardware expects.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ba2fe383fa5e..ccd6ddb12b83 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -253,15 +253,15 @@ struct at_xdmac {
 
 /* Linked List Descriptor */
 struct at_xdmac_lld {
-	dma_addr_t	mbr_nda;	/* Next Descriptor Member */
-	u32		mbr_ubc;	/* Microblock Control Member */
-	dma_addr_t	mbr_sa;		/* Source Address Member */
-	dma_addr_t	mbr_da;		/* Destination Address Member */
-	u32		mbr_cfg;	/* Configuration Register */
-	u32		mbr_bc;		/* Block Control Register */
-	u32		mbr_ds;		/* Data Stride Register */
-	u32		mbr_sus;	/* Source Microblock Stride Register */
-	u32		mbr_dus;	/* Destination Microblock Stride Register */
+	u32 mbr_nda;	/* Next Descriptor Member */
+	u32 mbr_ubc;	/* Microblock Control Member */
+	u32 mbr_sa;	/* Source Address Member */
+	u32 mbr_da;	/* Destination Address Member */
+	u32 mbr_cfg;	/* Configuration Register */
+	u32 mbr_bc;	/* Block Control Register */
+	u32 mbr_ds;	/* Data Stride Register */
+	u32 mbr_sus;	/* Source Microblock Stride Register */
+	u32 mbr_dus;	/* Destination Microblock Stride Register */
 };
 
 /* 64-bit alignment needed to update CNDA and CUBC registers in an atomic way. */
-- 
2.25.1

