Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2284211407B
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2019 13:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfLEMD1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Dec 2019 07:03:27 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:53339 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfLEMD1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Dec 2019 07:03:27 -0500
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 07:03:26 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 3A438101E6845;
        Thu,  5 Dec 2019 12:55:01 +0100 (CET)
Received: from localhost (pd95be530.dip0.t-ipconnect.de [217.91.229.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C877561A257C;
        Thu,  5 Dec 2019 12:55:00 +0100 (CET)
X-Mailbox-Line: From ca92998ccc054b4f2bfd60ef3adbab2913171eac Mon Sep 17 00:00:00 2001
Message-Id: <ca92998ccc054b4f2bfd60ef3adbab2913171eac.1575546234.git.lukas@wunner.de>
In-Reply-To: <201912051630.Cb4fFTp2%lkp@intel.com>
References: <201912051630.Cb4fFTp2%lkp@intel.com>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 5 Dec 2019 12:54:49 +0100
Subject: [PATCH] dmaengine: Fix access to uninitialized dma_slave_caps
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dmaengine_desc_set_reuse() allocates a struct dma_slave_caps on the
stack, populates it using dma_get_slave_caps() and then accesses one
of its members.

However dma_get_slave_caps() may fail and this isn't accounted for,
leading to a legitimate warning of gcc-4.9 (but not newer versions):

   In file included from drivers/spi/spi-bcm2835.c:19:0:
   drivers/spi/spi-bcm2835.c: In function 'dmaengine_desc_set_reuse':
>> include/linux/dmaengine.h:1370:10: warning: 'caps.descriptor_reuse' is used uninitialized in this function [-Wuninitialized]
     if (caps.descriptor_reuse) {

Fix it, thereby also silencing the gcc-4.9 warning.

The issue has been present for 4 years but surfaces only now that
the first caller of dmaengine_desc_set_reuse() has been added in
spi-bcm2835.c. Another user of reusable DMA descriptors has existed
for a while in pxa_camera.c, but it sets the DMA_CTRL_REUSE flag
directly instead of calling dmaengine_desc_set_reuse(). Nevertheless,
tag this commit for stable in case there are out-of-tree users.

Fixes: 272420214d26 ("dmaengine: Add DMA_CTRL_REUSE")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.3+
---
 include/linux/dmaengine.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8fcdee1c0cf9..dad4a68fa009 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1364,8 +1364,11 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
 static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
 {
 	struct dma_slave_caps caps;
+	int ret;
 
-	dma_get_slave_caps(tx->chan, &caps);
+	ret = dma_get_slave_caps(tx->chan, &caps);
+	if (ret)
+		return ret;
 
 	if (caps.descriptor_reuse) {
 		tx->flags |= DMA_CTRL_REUSE;
-- 
2.24.0

