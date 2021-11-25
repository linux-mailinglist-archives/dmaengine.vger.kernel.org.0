Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8DF45D6D1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbhKYJHv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:07:51 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24985 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353715AbhKYJFv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830960; x=1669366960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4UJToV8z1d1CSnT1DHee/do0TBGgvnsbC5y36KVHVoA=;
  b=uCGDi907YfUzzXo99WdkitC4xP0xm+YbFQUBVwv0YjMneqL4wi0vY6j2
   RSr+ni7ZtivlXTxWaQQMoiE0JmvezF4VNcz8nkarQZUhjeX/Ax/RecjKd
   vSA/xUFijiag+t1PMwHvDSUTv7AZn8k3CpH1hNflRijpJmd17x3irlszH
   BJYFNgmJQZbwyhWapoMyl/sbSZXHSe1vfcJlsiqWQrb2PB+Fi2nktuQya
   ZkPVxPME5Zb+iJhPOLQdMse6Jeo9xvN9UHifAgNg34ktk96hTDvs1vEj5
   82sKrpkXGXFjtf+umEUZziCZFW24QQByEqDan2Lcux/Y83wzTT2GI8wB9
   A==;
IronPort-SDR: WtWwMmOjNZxfcvdh3RCLq++kbEcQo/nEclD5cbDkIS/rCBD81CYk07CWQWQnYDaeE7KAvwaogk
 mNEFVHTP5jgj2uVEJXtkdhgg8Cgn8NKv8uVPEuqsQQuFHknCi+DaVl6BB9OwMAKZ4rwwy+/4NX
 wqTNoln0JRUWkwOgmhymkTqfM8WHBCjZAZGtungScl7mzEXfIZMU7eACsYEdMURGJeLFDtEgpr
 8m5k9/vnBZSPebapgEyRuocQns36LyoMI872X3LPs/i2Nzs+LuYLdUVIpW4vJOY3E1+RnyWNZu
 xHUUqFkH+5WG/kQH4HuCi11k
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="77556153"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:01:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:01:06 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:01:03 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 10/13] dmaengine: at_xdmac: Remove a level of indentation in at_xdmac_advance_work()
Date:   Thu, 25 Nov 2021 11:00:25 +0200
Message-ID: <20211125090028.786832-11-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's easier to read code with fewer levels of indentation.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 81f6f1357dcb..89d0fc229d68 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1593,14 +1593,14 @@ static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
 	 * If channel is enabled, do nothing, advance_work will be triggered
 	 * after the interruption.
 	 */
-	if (!at_xdmac_chan_is_enabled(atchan) && !list_empty(&atchan->xfers_list)) {
-		desc = list_first_entry(&atchan->xfers_list,
-					struct at_xdmac_desc,
-					xfer_node);
-		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-		if (!desc->active_xfer)
-			at_xdmac_start_xfer(atchan, desc);
-	}
+	if (at_xdmac_chan_is_enabled(atchan) || list_empty(&atchan->xfers_list))
+		return;
+
+	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
+				xfer_node);
+	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
+	if (!desc->active_xfer)
+		at_xdmac_start_xfer(atchan, desc);
 }
 
 static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
-- 
2.25.1

