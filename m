Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33DF2FE88F
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 12:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbhAULSs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 06:18:48 -0500
Received: from mail.v3.sk ([167.172.186.51]:48628 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729880AbhAULPQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 06:15:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 23E39E0AA6;
        Thu, 21 Jan 2021 11:00:05 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TSxSPddukWRu; Thu, 21 Jan 2021 11:00:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8F41FE09F4;
        Thu, 21 Jan 2021 11:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gMGN_G7E0cR2; Thu, 21 Jan 2021 11:00:03 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 30E25E0A82;
        Thu, 21 Jan 2021 11:00:03 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/3] dmaengine: mmp_pdma: Allow building as a module
Date:   Thu, 21 Jan 2021 12:03:55 +0100
Message-Id: <20210121110356.1768635-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121110356.1768635-1-lkundrak@v3.sk>
References: <20210121110356.1768635-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no reason the Marvell MMP peripheral DMA driver would have
to be built-in.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d242c76326217..04effa065527b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -378,7 +378,7 @@ config MILBEAUT_XDMAC
 	  XDMAC device.
=20
 config MMP_PDMA
-	bool "MMP PDMA support"
+	tristate "MMP PDMA support"
 	depends on ARCH_MMP || ARCH_PXA || COMPILE_TEST
 	select DMA_ENGINE
 	help
--=20
2.29.2

