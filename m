Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7B475727
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhLOLBW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24908 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhLOLBW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566082; x=1671102082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7qxF1rA3WXG5vGkMtaJGRRx4q17WASpZMPPVSSKMp4E=;
  b=t/tNp10IIAbSmRtbZslGHuqde/cVJC7x7IA29W5aCuHF5T52rql3MKJH
   q7DhJFNw5c4DYR5CmDmZUiFi/N1xp54mlmDJQOuEHNihxW0DkQT7/413G
   kNG/uHggY5rvO8qeLWHyWnNL4D3LXu7VCA72bPJ69Zr8Uw2oE1WauNt2x
   dc/sHMsg03a2pLxtfio/AhSWwsyj66MFLq05Cq4Yjca8mSCnlMPVDw1pV
   aJbZr5guepGlf1A9J8hHCLMPPAHPdN1KWkWbb7vPDCqHkiG5bFSiSZMBm
   vsimWsD0Op18rM8iQl5cYjaqdShVar+A7SlwQkiqIPW4TfEgVNNmJlVzs
   Q==;
IronPort-SDR: rt0MniAA6+tOR8zkPgA15sOR02cmfmIJBrTMU11WBH8riBw6+s4phEY9z+gqRBdm6K8fL1vIqX
 P+wlRdTlH9x3fw6+pmVFZ3umjBbWFZY7mJNxq4rXLrzRKoV5skOFtgO+GxJNH0yWAtWpWDJfaK
 041INyAJy7orwm6JNIJiM+kQRadfzl8X4XwDpDrO5SHDJAyQEKyzcOVhlmm3w6zzE5tOzIZqdB
 a5vBxb/CRBNUw8u57yN1/LosRNFulfDVhKdPBIuUQalhMEXCxQeekkL+1zybc04hYpl+SZnRfE
 xZqN1CggSikst3QcO1U+EpUK
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="147304249"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:20 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:18 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 00/12] dmaengine: at_xdmac: Various fixes
Date:   Wed, 15 Dec 2021 13:01:03 +0200
Message-ID: <20211215110115.191749-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Bugs identified when debugging a hang encountered when operating
an octal DTR SPI NOR memory. The culprit was the flash, not the
DMA driver, so all these bugs are not experienced in real life,
they are all theoretical fixes. Nevertheless the bugs are there
and I think they should be squashed.

Tested the serial with DMA on sama5d2_xplained. Tested QSPI with DMA on
sama7g5ek. All went well.

v3:
- drop tty patches, they were applied by Greg.
- improve all commit descriptions
- split v2's patch 13/13 in two: one removing a level of indentation
  and one fixing the race.

v2:
- drop local chan_rx local variable in patch 3/13, focus just on fixes
for now.
- collect Richard's Acked-by tag.
- add details in the cover letter about what tests were performed.

Tudor Ambarus (12):
  dmaengine: at_xdmac: Don't start transactions at tx_submit level
  dmaengine: at_xdmac: Start transfer for cyclic channels in
    issue_pending
  dmaengine: at_xdmac: Print debug message after realeasing the lock
  dmaengine: at_xdmac: Fix concurrency over chan's completed_cookie
  dmaengine: at_xdmac: Fix race for the tx desc callback
  dmaengine: at_xdmac: Move the free desc to the tail of the desc list
  dmaengine: at_xdmac: Fix concurrency over xfers_list
  dmaengine: at_xdmac: Remove a level of indentation in
    at_xdmac_advance_work()
  dmaengine: at_xdmac: Fix lld view setting
  dmaengine: at_xdmac: Fix at_xdmac_lld struct definition
  dmaengine: at_xdmac: Remove a level of indentation in
    at_xdmac_tasklet()
  dmaengine: at_xdmac: Fix race over irq_status

 drivers/dma/at_xdmac.c | 186 ++++++++++++++++++++---------------------
 1 file changed, 89 insertions(+), 97 deletions(-)

-- 
2.25.1

