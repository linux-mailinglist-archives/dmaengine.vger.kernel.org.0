Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF924BC4
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 11:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEUJgj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 05:36:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52228 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUJgj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 May 2019 05:36:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4L9aYQR117162;
        Tue, 21 May 2019 04:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558431394;
        bh=vFAhDSNNkXEYynswuT8sjkQA9F9wkTULaULTfnghYnI=;
        h=From:To:CC:Subject:Date;
        b=g2mrfx9GLTDl6SeaAJprj5Kn7TNakloLF7MnVDGBomOQXuQcX8d4TE/5MOqNsxy79
         L2L6xAz4yjbksPFwWTrH+dSzT9/qxW7lXU138p2Ej5e6jt7Itfyg5d8cmIOjk/7M1q
         Wl0+zuEvXOAOjiVQHk2SwMd2U6dDIspptG8IFX3s=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4L9aYru016816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 May 2019 04:36:34 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 21
 May 2019 04:36:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 21 May 2019 04:36:32 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4L9aUgZ018934;
        Tue, 21 May 2019 04:36:31 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v3 0/2] dmaengine: ti: edma: Polled completion support
Date:   Tue, 21 May 2019 12:36:44 +0300
Message-ID: <20190521093646.21836-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Changes since v2:
- Fix typo in the comment for patch 0

Changes since v1:
- Cleanup patch for the array register handling
- typo fixed in patch2 commit message

The code around the array register access was pretty confusing for the first
look, so clean them up first then use the cleaner way in the polled handling.

When a DMA client driver decides that it is not providing callback for
completion of a transfer (and/or does not set the DMA_PREP_INTERRUPT) but
it will poll the status of the transfer (in case of short memcpy for
example) we will not get interrupt for the completion of the transfer and
will not mark the transaction as done.

Check the event registers (ER and EER) and if the channel is inactive then
return wioth DMA_COMPLETE to let the client know that the transfer is
completed.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: ti: edma: Clean up the 2x32bit array register accesses
  dmaengine: ti: edma: Enable support for polled (memcpy) completion

 drivers/dma/ti/edma.c | 129 ++++++++++++++++++++++++++----------------
 1 file changed, 81 insertions(+), 48 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

