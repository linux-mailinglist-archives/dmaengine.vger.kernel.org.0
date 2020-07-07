Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC9E2168CE
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgGGJJk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 05:09:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46858 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGJJk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 05:09:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06799YHB094475;
        Tue, 7 Jul 2020 04:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594112974;
        bh=1pEkq9lcm1nmEGFZf1V7QdmJ1cOmyipDaGn41XAZsbU=;
        h=From:To:CC:Subject:Date;
        b=xO5NoNADH9k5e8tJ2SPcB1CgvT6kmxeyyXtW822wjFABoLyEX/9AZsnsmgBc25Y17
         kI6Gdt4wChiFODQ5L2KNh3rbfCGkac+cPFUC553kIcHG514WeiTH7uVXn1EuhyS5ry
         9ac4qI7O058BuglsY360zTg2WmNqnrYr8V4ytnLw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06799Y62023105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 04:09:34 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 04:09:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 04:09:34 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06799RGl052457;
        Tue, 7 Jul 2020 04:09:33 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH 0/5] dmaengine: ti: k3-udma: cleanups for 5.8
Date:   Tue, 7 Jul 2020 12:10:26 +0300
Message-ID: <20200707091031.10411-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Tested on top of linux-next, but they apply (with offsets) on top of
dmaengine/next.

Few patches to clean up the code mostly with the exception of removing the use
of ring_get_occ() from udma_pop_from_ring().

This series should not conflict with Grygorii's ringacc update patch, they touch
the code in different areas.

Regards,
Peter
---
Peter Ujfalusi (5):
  dmaengine: ti: k3-udma: Remove dma_sync_single calls for descriptors
  dmaengine: ti: k3-udma: Do not use ring_get_occ in udma_pop_from_ring
  dmaengine: ti: k3-udma: Use common defines for TCHANRT/RCHANRT
    registers
  dmaengine: ti: k3-udma-private: Use udma_read/write for register
    access
  dmaengine: ti: k3-udma: Use udma_chan instead of tchan/rchan for IO
    functions

 drivers/dma/ti/k3-udma-glue.c    |  79 +++++------
 drivers/dma/ti/k3-udma-private.c |   8 +-
 drivers/dma/ti/k3-udma.c         | 236 +++++++++++++------------------
 drivers/dma/ti/k3-udma.h         |  61 +++-----
 4 files changed, 161 insertions(+), 223 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

