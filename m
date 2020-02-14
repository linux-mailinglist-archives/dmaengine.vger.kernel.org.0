Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81BB15D46D
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgBNJOn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 04:14:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57602 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgBNJOn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 04:14:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01E9EeVZ117357;
        Fri, 14 Feb 2020 03:14:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581671680;
        bh=votoJopeUiOFmQ8b9bopvSn/QhK/lyTDFPpmbqA+rLo=;
        h=From:To:CC:Subject:Date;
        b=O7VDv3jzQl4OzEzK4VqTi8zHUNbdDXtHQNubfUVOqUHH3JI4Whp3QBE13rUHeemzw
         MJK42IdH0cMjc+VsHUmhw75P4CdSfnDZd/dJTNoptOnaIF+vDELggqJvFL/f8AaazU
         ZpvvfLDQi1ySPbdRlWe38KeNZ20VgMQ/FidNMhMA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01E9Ed9g117904
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Feb 2020 03:14:40 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 03:14:38 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 03:14:38 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01E9Ea3u043021;
        Fri, 14 Feb 2020 03:14:36 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH v2 0/6] dmaengine: ti: k3-udma: Fixes for 5.6
Date:   Fri, 14 Feb 2020 11:14:35 +0200
Message-ID: <20200214091441.27535-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Recently we have uncovered silicon and driver issues which was not addressed in
the initial driver:

1. RX channel teardown will lock up the channel if we have stale data
in the DMA FIFOs and we don't have active transfer (no descriptor for UDMA).
The workaround is to use a dummy drain packet in these cases.

2. Early TX completion handling
The delayed work approach was not working efficiently causing the UART, SPI
performance to degrade, with the patch from Vignesh we see 10x performance
increase

3. TR setup for slave_sg
It was possible that the sg_len() was not multiple of 'burst * dev_width' and
because of this we ended up with incorrect TR setups.
Using a single function for TR setup makes things simpler and error prone among
slave_sg, cyclic and memcpy

4. Pause/Resume causes kernel crash
if it was called when we did not had active transfer the uc->desc was NULL.

5. The terminated cookie was never marked as completed
client will think that it is still in progress, which is not the case.
Also adding back the check for running channel in tx_status since if the channel
is not running then it implies that it has been terminated, so no transfer is
running.

Regards,
Peter
---
Peter Ujfalusi (5):
  dmaengine: ti: k3-udma: Workaround for RX teardown with stale data in
    peer
  dmaengine: ti: k3-udma: Move the TR counter calculation to helper
    function
  dmaengine: ti: k3-udma: Use the TR counter helper for slave_sg and
    cyclic
  dmaengine: ti: k3-udma: Use the channel direction in pause/resume
    functions
  dmaengine: ti: k3-udma: Fix terminated transfer handling

Vignesh Raghavendra (1):
  dmaengine: ti: k3-udma: Use ktime/usleep_range based TX completion
    check

 drivers/dma/ti/k3-udma.c | 493 ++++++++++++++++++++++++++++-----------
 1 file changed, 361 insertions(+), 132 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

