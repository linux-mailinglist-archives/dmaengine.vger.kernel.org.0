Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9857C43C26D
	for <lists+dmaengine@lfdr.de>; Wed, 27 Oct 2021 07:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhJ0F7C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Oct 2021 01:59:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46446 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhJ0F7A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Oct 2021 01:59:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19R5uYYG105836;
        Wed, 27 Oct 2021 00:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635314194;
        bh=g92cF+PG1Y8ft/dPCWjVaGnIySgCFpdj/dtBjMg5QSA=;
        h=From:To:CC:Subject:Date;
        b=Rpc+Aw+2iZ5dXMpDvawSE4h1+h5+1i+caYpA48iQo+UxoSE4Odnbf3V5D9VwD2JJc
         8SKO4pwsfJeUcPi6PeULQAcYBbdSb1rL9OJ+ZG6dFBF3CJBQ3venDBLegUcHOFA4B8
         A2zI9X844kFBzQDojQN/sjp/N9hKeBiqFgrzei0Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19R5uY2C003978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 00:56:34 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Oct 2021 00:56:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Oct 2021 00:56:34 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19R5uRPK126251;
        Wed, 27 Oct 2021 00:56:31 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH v2 0/2] dmaengine: ti: k3-udma: Fix NULL pointer dereference error
Date:   Wed, 27 Oct 2021 11:26:23 +0530
Message-ID: <20211027055625.11150-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

NULL pointer de-reference error was observed when all the PCIe endpoint
functions (22 function in J721E) request a DMA channel. The issue was
specfically observed in BCDMA (Block copy DMA) but the issue is
applicable in PKTDMA as well.

Changes from v1:
1) Split the patch for BCDMA and PKTDMA separately
2) Fixed the return value of udma_get_rflow() to 0.
3) Removed the fixes tag as the patches does not directly apply to the
commits.

v1 => https://lore.kernel.org/r/20210209090036.30832-1-kishon@ti.com

Kishon Vijay Abraham I (2):
  dmaengine: ti: k3-udma: Fix NULL pointer dereference error for BCDMA
  dmaengine: ti: k3-udma: Fix NULL pointer dereference error for PKTDMA

 drivers/dma/ti/k3-udma.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.17.1

