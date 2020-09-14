Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4C268D04
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgINOLZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 10:11:25 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19529 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgINOKX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Sep 2020 10:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600092623; x=1631628623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYRccNXwySLX58revlIKoNQBOK8H5HsF57JSqx1w6TE=;
  b=IV9DwHGW+4lUCFNx8JdaHcrZ/sEve19OE75+gx/o+w22/B7sY4cQcAXO
   I7eGaF65qtxZCTxe3Y5I055Qu2BCgsfF+MpWK2uRQBdVE3Jz9sg7jgXuA
   ASW53T5FhlNO9VzLGU4yVMs9WpVogGmaA0rJ10Ce5GyHN5+iqg73oT8b+
   ouxdNINpH0ORrCwt8MA+gnyypscruhyBGQ6b2BrKMVdT9nVvD8W8RBsOw
   ZaVrkPy3xbeBJZBajBh7pTKwd0pJKAcGBq12ut4fc+imfWMkVMvbWI04S
   YXqQEiNOOAqzfUgYT4V0qTQ0AuPHiTzLi3AmA++9tJZyXfYW3p9qhsVmU
   g==;
IronPort-SDR: eojmRW+qCHdtuviNt2OGagycY38wXXA8TVYNr0bbaqWQLX6sYBFgbjhIlLCgdfsOCdFclaps7W
 Eff3f4PgTA68HcVGIpaJeL0xjO5/8KwFpNYHlI2WT/TNvosjn5ObXkwjNsJiGzSJrg50sJaCDP
 o9A/pn98aA6/rQVea5/A90ekUDHAq/an2f2wPn8zG0lggk5jaONeeiP+oYDs7LkDGXdpCc18vr
 /Rc1z43ABisgnLDzxx6FeH8gTI20zAo5PRY6c8d5NFVbVLYkAweyzq9sjrjeKSrFvYs9aCK53U
 TfY=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="90900801"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:10:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:10:19 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 07:10:15 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <tudor.ambarus@microchip.com>, <ludovic.desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 4/7] dmaengine: at_xdmac: adapt perid for mem2mem operations
Date:   Mon, 14 Sep 2020 17:09:53 +0300
Message-ID: <20200914140956.221432-5-eugen.hristev@microchip.com>
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

The PERID in the CC register for mem2mem operations must match an unused
PERID.
The PERID field is 7 bits, but the selected value is 0x3f.
On later products we can have more reserved PERIDs for actual peripherals,
thus this needs to be increased to maximum size.
Changing the value to 0x7f, which is the maximum for 7 bits field.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/dma/at_xdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fab19e00a7be..81bb90206092 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -726,7 +726,7 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 	 * match the one of another channel. If not, it could lead to spurious
 	 * flag status.
 	 */
-	u32			chan_cc = AT_XDMAC_CC_PERID(0x3f)
+	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DIF(0)
 					| AT_XDMAC_CC_SIF(0)
 					| AT_XDMAC_CC_MBSIZE_SIXTEEN
@@ -908,7 +908,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	 * match the one of another channel. If not, it could lead to spurious
 	 * flag status.
 	 */
-	u32			chan_cc = AT_XDMAC_CC_PERID(0x3f)
+	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DAM_INCREMENTED_AM
 					| AT_XDMAC_CC_SAM_INCREMENTED_AM
 					| AT_XDMAC_CC_DIF(0)
@@ -1014,7 +1014,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	 * match the one of another channel. If not, it could lead to spurious
 	 * flag status.
 	 */
-	u32			chan_cc = AT_XDMAC_CC_PERID(0x3f)
+	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DAM_UBS_AM
 					| AT_XDMAC_CC_SAM_INCREMENTED_AM
 					| AT_XDMAC_CC_DIF(0)
-- 
2.25.1

