Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819093DC54A
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jul 2021 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhGaJUA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 31 Jul 2021 05:20:00 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:44534 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232371AbhGaJUA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 31 Jul 2021 05:20:00 -0400
Received: from MTA-14-3.privateemail.com (mta-14-1.privateemail.com [198.54.122.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 11EF580517;
        Sat, 31 Jul 2021 05:19:54 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
        by mta-14.privateemail.com (Postfix) with ESMTP id 612B41800217;
        Sat, 31 Jul 2021 05:19:52 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.223])
        by mta-14.privateemail.com (Postfix) with ESMTPA id 0DA29180021A;
        Sat, 31 Jul 2021 05:19:50 -0400 (EDT)
From:   Jordy Zomer <jordy@pwning.systems>
To:     dmaengine@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: usb-dmac: make usb_dmac_get_current_residue unsigned
Date:   Sat, 31 Jul 2021 11:19:38 +0200
Message-Id: <20210731091939.510816-1-jordy@pwning.systems>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The usb_dmac_get_current_residue function used to
take a signed integer as a pos parameter.
The only callers of this function passes an unsigned integer to it.
Therefore to make it obviously safe, let's just make this an unsgined
integer as this is used in pointer arithmetics.

Signed-off-by: Jordy Zomer <jordy@pwning.systems>
---
 drivers/dma/sh/usb-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 8f7ceb698226..a5e225c15730 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -466,7 +466,7 @@ static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
 
 static unsigned int usb_dmac_get_current_residue(struct usb_dmac_chan *chan,
 						 struct usb_dmac_desc *desc,
-						 int sg_index)
+						 unsigned int sg_index)
 {
 	struct usb_dmac_sg *sg = desc->sg + sg_index;
 	u32 mem_addr = sg->mem_addr & 0xffffffff;
-- 
2.27.0

