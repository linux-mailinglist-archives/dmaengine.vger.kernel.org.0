Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D845210F18C
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2019 21:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLBUbo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Dec 2019 15:31:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40426 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBUbo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Dec 2019 15:31:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB2KVS18016993;
        Mon, 2 Dec 2019 14:31:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575318688;
        bh=5Z6pCiRczTsYgQn5fCzOc5mk4+KH6wL16PymQnDr8y8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eYXPYGYH7sO4YJnmAcvQhTGPUN1O4mVzP8PHJtTZBPYxLilbfXy0n2A8QTFXbgCdK
         Pse+gKeoZmZ++iXKXMreChEq7j++1GDk33ldUV/53wN9EXMGXe7CJnktOO+Ucp6JqF
         cFAyAZpA+kSGvQDrcqBqUkEe5iGcDXAUlmZZto58=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB2KVRwN090288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Dec 2019 14:31:28 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Dec
 2019 14:31:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Dec 2019 14:31:27 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB2KVOPl106889;
        Mon, 2 Dec 2019 14:31:25 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <vigneshr@ti.com>
Subject: [PATCH 0/3] dmaengine: ti: k3-udma: Fixes against v6 series
Date:   Mon, 2 Dec 2019 22:31:25 +0200
Message-ID: <20191202203128.14348-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <0191128105945.13071-1-peter.ujfalusi@ti.com>
References: <0191128105945.13071-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

When I thought that all corner cases are handled I got report of a failure on a
miss-configured setup:
UART without lines connected
Enable HW flow control (nothing is connected)
Do a small tx like "dd if=/dev/urandom of=/dev/ttyS1 bs=128 count=1"

The result is an interrupt flood caused by constant TDCM reception.

The explanation comes from the DMA split design and explained in patch 3:

"If the peripheral is disabled (or it is not able to send out data) the
UDMAP will complete a 'short' transfer. In other words: if the amount of
data can fit into PSI-L and PDMA (and peripheral FIFO) then UDMAP will
send out the data and return as the transfer is completed, however the
peripheral did not actually received all the data.

It was wrong to issue a normal teardown on the channel for several reasons:
UDMAP is not processing any packet so it will just return the TDCM and if
the peripheral is not consuming data from PDMA then we will have constant
flood of TDCMs (interrupts).
After the teardown the channel will be in reset state and we would need to
reset the rings as well, but it can not be done in interrupt context.
If the peripheral is just slow to consume data or even there is a delay
between starting the DMA then we will have again issues detecting the
state.

We could set force teardown, but that will make PDMA to discard the data
which is not correct in case of slow or delayed transfer start on the
peripheral.

The only solution is to use a work and check the progress in there after
the descriptor is returned and the UDMA and PDMA counters are not showing
the same number of bytes processed."

I'll squash these to v7, but I thought that this change is better to be visible
alone as it is kind of a big one on handling the early TX completion.

Regards,
Peter
---
Peter Ujfalusi (3):
  dmaengine: ti: k3-udma: Correct completed descriptor's residue value
  dmaengine: ti: k3-udma: Workaround for stale transfers
  dmaengine: ti: k3-udma: Fix early TX completion against PDMAs

 drivers/dma/ti/k3-udma.c | 89 +++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 23 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

