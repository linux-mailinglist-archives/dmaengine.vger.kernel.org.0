Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84C45302F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhKPLXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:23:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:43909 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhKPLXk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061643; x=1668597643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KKV9s2wWkbYBXwDnRmwrOzmBUy6suQwiKl818kfU+yE=;
  b=tmwhAdef1W7o8UyhCYUm/L1rUu6mQC9FyyNLLAbhJoYL2ZQK4W3JeaDx
   IOzZnFb+gssy2kTn5LOorRuMMhSd9pvmvQQ1SP1Q+ctG1BlxtWX/7OGe/
   Wt+Myt4JEVDwRALT+yrid3IGGN6E8qZxhmVCqEIHdA0rd8Z+nm882X2aw
   Kn3DiE20blNXhkkpENO5B2D30yAGp79E+kYC+syFt7hwsrZjj5L60MgsK
   baw/j+OEf/L13LzijBcAqfB3o3r5a8KxWgwnznu8nQ5BibpwWkMBklo6b
   Jv/pSFX4/LmIlDBRaZbC0hhb8jVjxNtG1trrGFLdRVmhw6XZ+j73HM5z8
   g==;
IronPort-SDR: gXYL1uHOLXxJlFcZvXDh8U9aCbGTlv/vXAryWf3uO6qgFykYyfoQJ0kOO/6ptI2VHoVoElUvNr
 rjN4+QFzkWOzBtiWYoHATAWdmdU6Bvk1SQZ0nC8E6OVa3ELBWDeW6O+chcwfrLNPdjF4nG5nrF
 XRhMRR0gOCi3ocTTias5v8+149/YmVIgO2mloXSUv+gQqozLaoF5CWhy67qLKOwA2kIo5JIWh7
 nDpyHit0Vh6fyFDyQ80e3BabYVWO9YphmOMdxl1fXyMMgpTJ93ZF+Kw0eACb2lyOwOleKPK0WF
 7pKvtWHZ9bcNgJFzkHDvkbFF
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="136715909"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:20:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:20:41 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:20:38 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 00/13] dmaengine: at_xdmac: Various fixes
Date:   Tue, 16 Nov 2021 13:20:23 +0200
Message-ID: <20211116112036.96349-1-tudor.ambarus@microchip.com>
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
are started at tx_submit() level and never called dma_async_issue_pending().
Applying first patch, but not the atmel_serial patches will break
atmel_serial when using DMA.

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
 drivers/tty/serial/atmel_serial.c |  30 +++--
 2 files changed, 110 insertions(+), 106 deletions(-)

-- 
2.25.1

