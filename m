Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120576A3C4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 10:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfGPI0K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 04:26:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37934 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfGPI0K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Jul 2019 04:26:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6G8PwWi074208;
        Tue, 16 Jul 2019 03:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563265558;
        bh=RsPF870WF8479WJ6GVCkPNaNd+0N7S3578PK0r/prRQ=;
        h=From:To:CC:Subject:Date;
        b=DSpvd3PlWIovlzkPNA2mcIM3pKW/Zt3aBqPQ8XsuVjNACtBIa14vCKjJ/ypSkS9l8
         fXlcA0xVM2cF0MNXqAN6HehEA5qms5Bo9GGUhB4fztk0WNMU3oP5dhzXNaZOvhNTjS
         L6i5a6Tfqo9m6LEkREb5Gtjk7ATb7eS7LtH5kvlo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6G8PwAm021053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jul 2019 03:25:58 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Jul 2019 03:25:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Jul 2019 03:25:58 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6G8PuBn103858;
        Tue, 16 Jul 2019 03:25:56 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v5 0/3] dmaengine: ti: edma: Polled completion support
Date:   Tue, 16 Jul 2019 11:26:52 +0300
Message-ID: <20190716082655.1620-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Changes since v4:
- Split the DMA_COMPLETE and !txstate check as Vinod suggested

Change since v3:
- fix DMA pointer tracking for memcpy
- completion polling is only done when it is asked by not providing
  DMA_PREP_INTERRUPT for memcpy

Changes since v2:
- Fix typo in the comment for patch 0

Changes since v1:
- Cleanup patch for the array register handling
- typo fixed in patch2 commit message

The code around the array register access was pretty confusing for the first
look, so clean them up first then use the cleaner way in the polled handling.

When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
does not want to use interrupts for DMA completion or because it can not
rely on DMA interrupts due to executing the memcpy when interrupts are
disabled it will poll the status of the transfer.

Since we can not tell from any EDMA register that the transfer is
completed, we can only know that the paRAM set has been sent to TPTC for
processing we need to check the residue of the transfer, if it is 0 then
the transfer is completed.

The polled completion can bve tested by applying:
https://patchwork.kernel.org/patch/10966499/

Enabling the memcpy for EDMA and run the dmatest with polled = 1.

Or, enable the EDMA memcpy support and boot up any dra7 family device with
display enabled. The workaround for DMM errata i878 uses polled DMA memcpy.

Regards,
Peter
---
Peter Ujfalusi (3):
  dmaengine: ti: edma: Clean up the 2x32bit array register accesses
  dmaengine: ti: edma: Correct the residue calculation (fix for memcpy)
  dmaengine: ti: edma: Support for polled (memcpy) completion

 drivers/dma/ti/edma.c | 174 ++++++++++++++++++++++++++++--------------
 1 file changed, 117 insertions(+), 57 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

