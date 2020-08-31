Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6593B257609
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHaJIl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 05:08:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45342 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgHaJIk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 05:08:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07V98a5r063080;
        Mon, 31 Aug 2020 04:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598864916;
        bh=MjsvdfEMy6GjtTN6j2sOW8wOL0kqR2f7yz1NLZ13fG8=;
        h=From:To:CC:Subject:Date;
        b=uQItU2FeegecNeaODB/TbUPNavPcfSh+ygM/pNQ3BdiZux/mjn8VnkFJn/oLMfeGt
         rkXIrEGe6JkLjZFJqlqiO0/ree4ktyxwAoTARfBrpYaJfonQwH7A6axe2plSWMVmo/
         mwJAclWTkuMbCsoJ50XyziBArbyMMT1a7aKzT5eo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07V98awq052252;
        Mon, 31 Aug 2020 04:08:36 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 31
 Aug 2020 04:08:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 31 Aug 2020 04:08:36 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07V98YWk026158;
        Mon, 31 Aug 2020 04:08:34 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>, <nm@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Update rchan_oes_offset for am654 SYSFW ABI 3.0
Date:   Mon, 31 Aug 2020 12:10:19 +0300
Message-ID: <20200831091019.25273-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SYSFW ABI 3.0 has changed the rchan_oes_offset value for am654 to support
SR2.

Since the kernel now needs SYSFW API 3.0 to work because the merged irqchip
update, we need to also update the am654 rchan_oes_offset.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Vinod,

A series from Lokesh to support sysfw ABI 3.0 and newer is now in mainline
under v5.9-rc3 tag.
With his series Linux can not really boot into a usable state with older sysfw
and the ABI 3.0 have additional changes affecting UDMA on am654:
the rchan_oes_offset number is changed to better align with j72xx and to be able
to support both SR1 and SR2 of am654.

Can you send this patch for -rc4 to fix the regression now in mainline?
The regression is that one can not request TR mode channel to service a
peripheral.

We do not have users upstream depending on this, but I do have out of tree audio
support and cutomers might pick up 5.9 from mainline when it is released.

Thank you,
Peter

 drivers/dma/ti/k3-udma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 989998b6e078..9a7048bcf0f1 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3091,14 +3091,14 @@ static struct udma_match_data am654_main_data = {
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
 	.statictr_z_mask = GENMASK(11, 0),
-	.rchan_oes_offset = 0x2000,
+	.rchan_oes_offset = 0x200,
 };
 
 static struct udma_match_data am654_mcu_data = {
 	.psil_base = 0x6000,
 	.enable_memcpy_support = false,
 	.statictr_z_mask = GENMASK(11, 0),
-	.rchan_oes_offset = 0x2000,
+	.rchan_oes_offset = 0x200,
 };
 
 static struct udma_match_data j721e_main_data = {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

