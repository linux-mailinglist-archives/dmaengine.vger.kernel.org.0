Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255E72FE882
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 12:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbhAULPN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 06:15:13 -0500
Received: from mail.v3.sk ([167.172.186.51]:48626 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729925AbhAULPF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 06:15:05 -0500
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 06:15:03 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 076D3E0A3E;
        Thu, 21 Jan 2021 11:00:05 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kgz-mrCZGcSb; Thu, 21 Jan 2021 11:00:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2374CE0A6E;
        Thu, 21 Jan 2021 11:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W4t210P6rbBw; Thu, 21 Jan 2021 11:00:02 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B9E90E09F4;
        Thu, 21 Jan 2021 11:00:02 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/3] dmaengine: mmp_pdma: Remove mmp_pdma_filter_fn()
Date:   Thu, 21 Jan 2021 12:03:54 +0100
Message-Id: <20210121110356.1768635-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121110356.1768635-1-lkundrak@v3.sk>
References: <20210121110356.1768635-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's not used anywhere -- drop it.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_pdma.c       | 14 --------------
 include/linux/dma/mmp-pdma.h | 16 ----------------
 2 files changed, 30 deletions(-)
 delete mode 100644 include/linux/dma/mmp-pdma.h

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index b84303be8edf5..89f1814ff27a0 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -18,7 +18,6 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/of.h>
-#include <linux/dma/mmp-pdma.h>
=20
 #include "dmaengine.h"
=20
@@ -1148,19 +1147,6 @@ static struct platform_driver mmp_pdma_driver =3D =
{
 	.remove		=3D mmp_pdma_remove,
 };
=20
-bool mmp_pdma_filter_fn(struct dma_chan *chan, void *param)
-{
-	struct mmp_pdma_chan *c =3D to_mmp_pdma_chan(chan);
-
-	if (chan->device->dev->driver !=3D &mmp_pdma_driver.driver)
-		return false;
-
-	c->drcmr =3D *(unsigned int *)param;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(mmp_pdma_filter_fn);
-
 module_platform_driver(mmp_pdma_driver);
=20
 MODULE_DESCRIPTION("MARVELL MMP Peripheral DMA Driver");
diff --git a/include/linux/dma/mmp-pdma.h b/include/linux/dma/mmp-pdma.h
deleted file mode 100644
index 25cab62a28c45..0000000000000
--- a/include/linux/dma/mmp-pdma.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _MMP_PDMA_H_
-#define _MMP_PDMA_H_
-
-struct dma_chan;
-
-#ifdef CONFIG_MMP_PDMA
-bool mmp_pdma_filter_fn(struct dma_chan *chan, void *param);
-#else
-static inline bool mmp_pdma_filter_fn(struct dma_chan *chan, void *param=
)
-{
-	return false;
-}
-#endif
-
-#endif /* _MMP_PDMA_H_ */
--=20
2.29.2

