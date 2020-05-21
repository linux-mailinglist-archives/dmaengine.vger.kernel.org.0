Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6B1DCC55
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2020 13:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgEULq0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 May 2020 07:46:26 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:59267 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729064AbgEULqZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 May 2020 07:46:25 -0400
X-IronPort-AV: E=Sophos;i="5.73,417,1583161200"; 
   d="scan'208";a="47677965"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 May 2020 20:46:24 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 96AE14004BA8;
        Thu, 21 May 2020 20:46:24 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] dma: sh: usb-dmac: Fix residue after the commit 24461d9792c2
Date:   Thu, 21 May 2020 20:46:13 +0900
Message-Id: <1590061573-12576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This driver assumed that freed descriptors have "done_cookie".
But, after the commit 24461d9792c2 ("dmaengine: virt-dma: Fix
access after free in vchan_complete()"), since the desc is freed
after callback function was called, this driver could not
match any done_cookie when a client driver (renesas_usbhs driver)
calls dmaengine_tx_status() in the callback function.
So, add to check both descriptor types (freed and got) to fix
the issue.

Reported-by: Hien Dang <hien.dang.eb@renesas.com>
Fixes: 24461d9792c2 ("dmaengine: virt-dma: Fix access after free in vchan_complete()")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/usb-dmac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index b218a01..c0adc1c8 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -488,16 +488,17 @@ static u32 usb_dmac_chan_get_residue_if_complete(struct usb_dmac_chan *chan,
 						 dma_cookie_t cookie)
 {
 	struct usb_dmac_desc *desc;
-	u32 residue = 0;
 
+	list_for_each_entry_reverse(desc, &chan->desc_got, node) {
+		if (desc->done_cookie == cookie)
+			return desc->residue;
+	}
 	list_for_each_entry_reverse(desc, &chan->desc_freed, node) {
-		if (desc->done_cookie == cookie) {
-			residue = desc->residue;
-			break;
-		}
+		if (desc->done_cookie == cookie)
+			return desc->residue;
 	}
 
-	return residue;
+	return 0;
 }
 
 static u32 usb_dmac_chan_get_residue(struct usb_dmac_chan *chan,
-- 
2.7.4

