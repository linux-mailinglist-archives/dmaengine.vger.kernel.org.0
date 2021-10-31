Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDACB440C9D
	for <lists+dmaengine@lfdr.de>; Sun, 31 Oct 2021 04:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhJaD0s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 30 Oct 2021 23:26:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49294 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJaD0s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 30 Oct 2021 23:26:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19V3OFJD018070;
        Sat, 30 Oct 2021 22:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635650655;
        bh=mDiH3KIIJnrJ4m8eBhF/73VpP13wJusqmGq7QXE/f2k=;
        h=From:To:CC:Subject:Date;
        b=y7W0G2AQ7pZQDwkGSrbKqlHA5aAfvjrOba1vLvcXqAMqKw4Meo4h7KIgifHtckY3C
         /68Vkk9Djy9WkTu7YYtHfmLZ6eQjaiSEhY/YEuw09rkhngLTzj4qwiguLzvB8I511e
         7c+camqSd40PK1xeJM+VrinlHaUTeDIgplPjFV5s=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19V3OFBW108783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Oct 2021 22:24:15 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 30
 Oct 2021 22:24:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 30 Oct 2021 22:24:15 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19V3OCwK084685;
        Sat, 30 Oct 2021 22:24:12 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 0/2] dmaengine: ti: k3-udma: Fix NULL pointer dereference error
Date:   Sun, 31 Oct 2021 08:54:09 +0530
Message-ID: <20211031032411.27235-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

NULL pointer de-reference error was observed when all the PCIe endpoint
functions (22 function in J721E) request a DMA channel. The issue was
specfically observed when using mem-to-mem copy.

Changes from v3:
1) Fix commit subject
2) Add "Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>" and cc'ed
stable

Changes from v2:
1) Fix commit subject and commit log to mention bchan/rchan/tchan to NULL
   suggested by Peter.

Changes from v1:
1) Split the patch for BCDMA and PKTDMA separately
2) Fixed the return value of udma_get_rflow() to 0.
3) Removed the fixes tag as the patches does not directly apply to the
commits.

v1 => https://lore.kernel.org/r/20210209090036.30832-1-kishon@ti.com
v2 => https://lore.kernel.org/r/20211027055625.11150-1-kishon@ti.com
v3 => https://lore.kernel.org/r/20211029151251.26421-1-kishon@ti.com

Kishon Vijay Abraham I (2):
  dmaengine: ti: k3-udma: Set bchan to NULL if a channel request fail
  dmaengine: ti: k3-udma: Set r/tchan or rflow to NULL if request fail

 drivers/dma/ti/k3-udma.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.17.1

