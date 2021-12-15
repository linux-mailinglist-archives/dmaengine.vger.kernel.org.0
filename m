Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5838475735
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbhLOLBn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16372 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbhLOLBl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566101; x=1671102101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l7DYN6EzzogTUQIaI5uuaqM3uDK/flgG0AmVT1JLkvc=;
  b=BOxnIxqHEZT4yFvlIsdEWxR8ztnohM4CXc6OMIlY4cwzhEWfyIdf5j7g
   lD+aq5kesIandk506N4tn/f6t4gStMOSQEz8pNkTK+VxExFUlJ9hc23L9
   pn5Hva7SvzrmwvJIL8WTf3Opv7ttm4xN5c/IIYiuqx4D/1Uy2DGxTMnoi
   tV7pNsT+kMzw/TvXTKCB9jRk7oV/qckmBAFESWDU1J+zv9fkx9LhXW1V0
   RVmVaOp46GKVkYXdGkQhfi31cYSclRcjvR1gy/ZhZew2jvc9AUxO3/0PK
   ZuwO9fPO26V68O2NpCTStZealFdiJGQJjlutMb/KuZzerCipvJ5E5cgLF
   g==;
IronPort-SDR: o8CfNR0+lg6WOMERCQ3lgZrBaKvbjM3bGNy3ji3gY7rMCybmSm+hsrJpNX0/Mj62JVczP2CEaW
 6afEJgknx9Z3RQVOjiIFOGtto1dW+FfD1hnSviiwSOkeIzPwNTZZbT2uGt8ILox9FNEQ16kMCG
 oaNXPfF7gQ6P7zKeov2uKPv7PXrq2QmiDayJTDLlKUJ+KIN6o/9BGw9lYQq6H5nTtYl5wIFcEy
 +TGuZWgcQsYeFIBeSisHN2yWdUEUah28hGZljC6MwdDSF0ecqvdM1M5A9cp1mChbtsmU2vuMAB
 pBcZ24Zz9xKKEeEDhK4uIgaG
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="139842702"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:40 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:38 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 08/12] dmaengine: at_xdmac: Remove a level of indentation in at_xdmac_advance_work()
Date:   Wed, 15 Dec 2021 13:01:11 +0200
Message-ID: <20211215110115.191749-9-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's easier to read code with fewer levels of indentation, remove a level
of indentation in at_xdmac_advance_work()

if (!foo() & !bar()) {
}

was replaced by:

if (foo() || bar())
	return;

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index eeb03065d484..0b09ec752db4 100644
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

