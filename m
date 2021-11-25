Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7B45D6C7
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354044AbhKYJGb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:06:31 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35823 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346814AbhKYJEa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830879; x=1669366879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9cKQ8DLE+KtiJG/oBAobTtHTIQZeH+YXTokO734xUTw=;
  b=fzstjMVja644ShY6NaVbb5EMNPr6NtbxOsK2J9Yj1DK9a71sjBCu77eF
   RCK8NUmVKhJ5hF3t/S4dzR1wMp94JrW6q99q8D40Kr9DmJ2LXxl2+lqEe
   1KWOgg6/umycm1EWF3EUPhHEe9rMtaVe1M+CtmAc6hM5TcUr3Z9p5vEM2
   Mpqe1BgBogjNV8I+2XCnaIM3bF0bWO1DhnEUlljroYO2QwzVoena/OmJc
   Cj8U2/sODNWl9ljMaIMH9RAuYjbXo9nIa+O0joxHzIiGbSms5o8R/EkF6
   HqzxkBrGqq74G/8+KxmoqGbYLdadxLDGtP6tRD73vIOT/xWArxz0SfT3A
   g==;
IronPort-SDR: 8RpuItzUzgBGSz62CVpx1t3SlmyO1GkX7itwoz5juWqkyE5KxOQ9iXD8gpZjPVLM3y5HAGDrjK
 ou1VIP/l7Qr8fVuNltE/2wSy+L7dJKZXcZ/E7hpCuZZzneaVgD6d2/CAf8mdsyPm34fUfXXI6Z
 kdDh0D5KW7mVXXBS9veTrLe/BKg+SvZ7Ap3u2oW21avM5NVCSoBRSXYM8RyoznxllF9E8P4xKu
 BER4oLZQA6vAYszZx4bHd9eEdE21HLhyORnkynKBy/KIHknBGo0U5LxHdfgdAzJcJ6kVcir68D
 4TJZX1HIi2xkda7m4cwxHd9h
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="145122004"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:01:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:01:13 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:01:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 12/13] dmaengine: at_xdmac: Fix at_xdmac_lld struct definition
Date:   Thu, 25 Nov 2021 11:00:27 +0200
Message-ID: <20211125090028.786832-13-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
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

