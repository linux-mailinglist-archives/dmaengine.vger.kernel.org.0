Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE643FF2D
	for <lists+dmaengine@lfdr.de>; Fri, 29 Oct 2021 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhJ2PPZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Oct 2021 11:15:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33624 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhJ2PPY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Oct 2021 11:15:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19TFCs9A110707;
        Fri, 29 Oct 2021 10:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635520374;
        bh=gjHCN9lL4wOgJbm6UyjmgsutSc3XFZJF96HsDLCrINM=;
        h=From:To:CC:Subject:Date;
        b=PEO3YiaX5HLZwsEUFSF380norWWgU1XBbRIstKbsemmCtcWxUQ9F3QwNemyOuXR7i
         MoDiDE4DHWVCRBq3i9BICiZFIpTXL5Ihyh1GE8pqbOJWTaGlVrtKWfDtDnziQkDHnP
         AoTPKCLU1xp7lW1swSV7U71XmNS16RdrIqKDbPNA=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19TFCsWv055216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Oct 2021 10:12:54 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 29
 Oct 2021 10:12:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 29 Oct 2021 10:12:54 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19TFCpTY114593;
        Fri, 29 Oct 2021 10:12:52 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 0/2] dmaengine: ti: k3-udma: Fix NULL pointer dereference error
Date:   Fri, 29 Oct 2021 20:42:49 +0530
Message-ID: <20211029151251.26421-1-kishon@ti.com>
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

Kishon Vijay Abraham I (2):
  dmaengine: ti: k3-udma: Set bchan to NULL if a channel request fail
  dmaengine: ti: k3-udma: Set rchan/tchan to NULL if a channel request
    fail

 drivers/dma/ti/k3-udma.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.17.1

