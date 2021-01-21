Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EAD2FE891
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbhAULS4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 06:18:56 -0500
Received: from mail.v3.sk ([167.172.186.51]:48624 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbhAULPN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 06:15:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9EF19E0A6E;
        Thu, 21 Jan 2021 11:00:05 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rX5yPAj5mEVu; Thu, 21 Jan 2021 11:00:04 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 29787E0AA4;
        Thu, 21 Jan 2021 11:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XDLSgjwL17bo; Thu, 21 Jan 2021 11:00:03 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A4D81E0A82;
        Thu, 21 Jan 2021 11:00:03 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/3] dmaengine: mmp_tdma: Allow building as a module
Date:   Thu, 21 Jan 2021 12:03:56 +0100
Message-Id: <20210121110356.1768635-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121110356.1768635-1-lkundrak@v3.sk>
References: <20210121110356.1768635-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no reason the Marvell MMP two-channel audio DMA driver would hav=
e
to be built-in.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 04effa065527b..978b2f526c5df 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -385,7 +385,7 @@ config MMP_PDMA
 	  Support the MMP PDMA engine for PXA and MMP platform.
=20
 config MMP_TDMA
-	bool "MMP Two-Channel DMA support"
+	tristate "MMP Two-Channel DMA support"
 	depends on ARCH_MMP || COMPILE_TEST
 	select DMA_ENGINE
 	select GENERIC_ALLOCATOR
--=20
2.29.2

