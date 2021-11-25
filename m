Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9A45D6A8
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352490AbhKYJFp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:05:45 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17335 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352552AbhKYJDp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830834; x=1669366834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yntWQq2s6rENg52cXI2UmyUNFuqMzu+tM7bIw/XQ7wA=;
  b=rxFMF1KfgQVzHbBDJkQqvC//LDAk7UIOwRFfkgQ8GcR9Ubj5WEQQh7l4
   UoGPRkvUT+qkLYwSJQmUxSOxYJivDnCtdOeZ3PtuKllvaIaSS1Ytb5hsF
   rOuOfokiy9+uR9FMS2wh/YuK+DM14wbFyJwecF9fVrf5307ro0LvJYGDf
   k14KypA27cOvAnTdW9zP9guA91SXiSQWmwXNEruNZLzuCRxVjZzzlKoFN
   8QU8W8RA4baVH43BIfSolrux5HsxDLCNZkGUlmsTJ72Oyw1solg7onA/O
   XEleAwC6uO6WHVmZBDinBPl/BpjaJDfplNf5Is//iQeA/Hd/qvXtwkm31
   w==;
IronPort-SDR: H4eKI2SZC2nbwsnpXCQzQ1Rndu2kSZ5psdi64tcWeGFA4k6DWjrSmRXFB+Vcl5LMF9TWz4FE2t
 1hgro89K5rEjiFa/AvvlUOXNXSzKWX7w8z1VSjxXXIfB+oDL11owqRZm3ppCwnzXEpr5GYlHgV
 Sc/EfZZCWCPJlHSr1ZDVU3YesAFV9j95n/vDTxLr+3bvXtW8snPxdZxFT93IS7ukAKJP5aCdyc
 LGDX96PjXgy55gIEmfVLc5fyY71mTuSUVyd+L0NeImY7Jxz4tTj2b8u0an1aS/BNFkdwcxG5H5
 U8E6G/IpBOjstFwqYYO3yOTB
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="137700169"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:00:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:00:32 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:29 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 00/13] dmaengine: at_xdmac: Various fixes
Date:   Thu, 25 Nov 2021 11:00:15 +0200
Message-ID: <20211125090028.786832-1-tudor.ambarus@microchip.com>
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

If all of you consider that all these are worthy to be applied,
I would suggest that all the patches to be taken via an immutable
branch of the DMA tree. The serial patches depend on the first patch
in the series. The DMA transactions are no longer started at tx_submit()
level, but at device_issue_pending() level, as the DMA API requires.
The atmel serial driver wrongly assumed that the DMA transactions
are started at tx_submit() level and never called
dma_async_issue_pending(). Applying first patch, but not the atmel_serial
patches will break atmel_serial when using DMA.

Tested the serial with DMA on sama5d2_xplained. Tested QSPI with DMA on
sama7g5ek. All went well.

v2:
- drop local chan_rx local variable in patch 3/13, focus just on fixes
for now.
- collect Richard's Acked-by tag.
- add details in the cover letter about what tests were performed.

Tudor Ambarus (13):
  dmaengine: at_xdmac: Don't start transactions at tx_submit level
  tty: serial: atmel: Check return code of dmaengine_submit()
  tty: serial: atmel: Call dma_async_issue_pending()
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
  dmaengine: at_xdmac: Fix race over irq_status

 drivers/dma/at_xdmac.c            | 186 ++++++++++++++----------------
 drivers/tty/serial/atmel_serial.c |  14 +++
 2 files changed, 101 insertions(+), 99 deletions(-)

-- 
2.25.1

