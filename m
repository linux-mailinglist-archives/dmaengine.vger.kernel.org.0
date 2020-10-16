Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D93290207
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 11:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406106AbgJPJhm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 05:37:42 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:65225 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394879AbgJPJhm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Oct 2020 05:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602841061; x=1634377061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lujI1g3huvNqkYRQ+HidQkZKquZdNSZ+cvnov+49KA8=;
  b=wfH2izH/mes8zVAgrc1HEFKmN4QP9VFsPZX8QaCDj+hg8cxjmffy5bC7
   kcLHxvU9T2V3h6p0Yz+36GjE2vYztM7xOVgWk0/5d/FJXLcYoCPA0LcB7
   n5QTtj6fhoFm3KVwGJEE8lt5Vb9K/QUeuRJq3xqAzTPaoxjGvKLGYUQhX
   ZPADhGXtb1aRyrLRt/FyVNPbyypYI+QCLQcQnAP4IdY07SUtlsGIjz6Zf
   1eKphQjQkcEuJIWZdwnZgu6tpzTAzZ5sKxJRR71RpZ6O+I7b48zlPfjDA
   P2u2T+oKxPiSAxVsdyCvapQ2xLve7LsBB+Fw8U0VWEYjiugyL7jUIC8pD
   g==;
IronPort-SDR: G7snkBFVuEt06kK+r/9/tpIRk+A6V5wEC9er9ASq3qtguZc2xLmgQifUUY7qans208w/io2sjm
 Q/B08x2XCtIOvyewcZZGPaC65ZgILBptn8ILqBKzJnnjmwtDMKuz6MtaUW845e8b9pb7F+DT2e
 FX4J6LsKR/b1Vcsa4DSbai8mNx1hGT2IdWaHyXzuhYWGQA45Ex0WczYJnIqbKJf2CqL4V3clVE
 mU/cTZCJvy+ghR2MNhVO63yCJAGhXeY5xS/65X39ADhnMUtdp5C8q680AUM6dk3/SDtQSceg2p
 Ifs=
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="99790163"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Oct 2020 02:37:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 02:37:31 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 16 Oct 2020 02:37:28 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <tudor.ambarus@microchip.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v2 2/4] dmaengine: at_xdmac: adapt perid for mem2mem operations
Date:   Fri, 16 Oct 2020 12:37:25 +0300
Message-ID: <20201016093725.289880-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
Changes in v2:
- no changes

 drivers/dma/at_xdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fd92f048c491..94f7023472bb 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -867,7 +867,7 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 	 * match the one of another channel. If not, it could lead to spurious
 	 * flag status.
 	 */
-	u32			chan_cc = AT_XDMAC_CC_PERID(0x3f)
+	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DIF(0)
 					| AT_XDMAC_CC_SIF(0)
 					| AT_XDMAC_CC_MBSIZE_SIXTEEN
@@ -1049,7 +1049,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	 * match the one of another channel. If not, it could lead to spurious
 	 * flag status.
 	 */
-	u32			chan_cc = AT_XDMAC_CC_PERID(0x3f)
+	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DAM_INCREMENTED_AM
 					| AT_XDMAC_CC_SAM_INCREMENTED_AM
 					| AT_XDMAC_CC_DIF(0)
@@ -1155,7 +1155,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
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

