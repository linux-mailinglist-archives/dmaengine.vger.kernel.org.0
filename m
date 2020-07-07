Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E78C216A15
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGKWz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 06:22:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49020 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGKWy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 06:22:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 067AMqEv100838;
        Tue, 7 Jul 2020 05:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594117372;
        bh=p55srPkiWShQ/y3GHNa9zh+BxMez95V447YS/4kxZHI=;
        h=From:To:CC:Subject:Date;
        b=CbiUg8mRKPktppE3dxnSQgYEnFIqlD0di21+RLxcSrqFb6j4pBa6lHv7MDB2VRaC3
         gHxIXuB9Rm+aEQuOI924Xsy4apTn8bIst8y/B6gNOeeKKo5Bcp2nOn95SywFWla9uv
         z7Zv1yqPoW9M50gbNaumyYj3z5Mj9Z8NZ2BlLeDo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 067AMqXs057425
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 05:22:52 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 05:22:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 05:22:50 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067AMmab054798;
        Tue, 7 Jul 2020 05:22:49 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 0/5] dmaengine: ti: k3-udma: cleanups for 5.8
Date:   Tue, 7 Jul 2020 13:23:47 +0300
Message-ID: <20200707102352.28773-1-peter.ujfalusi@ti.com>
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

Changes since v1:
- drop the check against NULL for uc in the IO functions as pointed out by
  Grygorii

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

