Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1447572B
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbhLOLBc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23495 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241890AbhLOLBb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566091; x=1671102091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJoZ3/X+f//Ot1xushVx/AGt8XPLPpyGKxiMYuKplkY=;
  b=aT5OfyNJTw7npMjIQvp8t0BPM0LytgaNKqixVypMKjJZIGLqEBQycEXS
   EqCiic8dNP8O/29VhR542qnRGYRoerEQkyRCTEg7EnHQc/igKWE8g2Rq1
   NksbYHZ6Ox7DyyPkJoJvj7OIt/vMzaze/QW92hSptnUMp81zUwf0uKcC8
   5a5kccyWmToIxc3Oy6uvRmpT8It2KELUacUDd4dhAhNeGTmhSHBXTdo1X
   5s/g3lYC4N4/ZadGynC5F3szNuZPHc3jpd5/EEl8MU2/az4OvEHnO1Zsz
   HKt1si4ywWUzJ9HfoAF6OzNPyXYRuuHvefyJ5jKyIVwDiydxjYPNDbns4
   A==;
IronPort-SDR: 24p0OL/8SfbTQ6kN8CmBXbEEVngV9Osvo3Uv1duiYezK5pv7arGf1cUL96S0edQE4+rGr3srVR
 3OvYEQnhfi+pjwoEvD68U/xbR/E/IfoIYzhXbzSzVrJpl2IpoLrjXk28XA/Sme2R4rZXxf7kDj
 yZ+eij7TsRxr0HMwS/hgcZ3ItTD6jA2Cu8lRlETil4V31kVSBJnVn7pMpwqWemjrYHma1oHXCs
 olq4Zl8413xYqc7LkHWDz5KMWmf+srwLnRpsz4mmMsW92LaDNSnrTawdMutV/jSVbJdGDUKAjd
 zeB7zto0Te1izo6CYDef5WQm
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="142483350"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:25 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:23 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 02/12] dmaengine: at_xdmac: Start transfer for cyclic channels in issue_pending
Date:   Wed, 15 Dec 2021 13:01:05 +0200
Message-ID: <20211215110115.191749-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Cyclic channels must too call issue_pending in order to start a transfer.
Start the transfer in issue_pending regardless of the type of channel.
This wrongly worked before, because in the past the transfer was started
at tx_submit level when only a desc in the transfer list.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 4ff12b083136..c3d3e1270236 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1778,11 +1778,9 @@ static void at_xdmac_issue_pending(struct dma_chan *chan)
 
 	dev_dbg(chan2dev(&atchan->chan), "%s\n", __func__);
 
-	if (!at_xdmac_chan_is_cyclic(atchan)) {
-		spin_lock_irqsave(&atchan->lock, flags);
-		at_xdmac_advance_work(atchan);
-		spin_unlock_irqrestore(&atchan->lock, flags);
-	}
+	spin_lock_irqsave(&atchan->lock, flags);
+	at_xdmac_advance_work(atchan);
+	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	return;
 }
-- 
2.25.1

