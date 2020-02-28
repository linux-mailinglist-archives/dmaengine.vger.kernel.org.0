Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518F41737E3
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2020 14:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgB1NH5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Feb 2020 08:07:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55518 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1NH5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Feb 2020 08:07:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01SD7oNp092411;
        Fri, 28 Feb 2020 07:07:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582895270;
        bh=9IuRAp1wMaSf2kT39F2JerSrH1w8/KtNCnW151fDA7s=;
        h=From:To:CC:Subject:Date;
        b=v3wDl50JfZ+cN6tCkci8rP4aP6ysAsqG/ybdZOxIRtC6qKG+1aI6eNyq32fnpQ9VK
         Rx03YMClw1jlo2jbteAJKPpG1NXSEjeYnC3oJIiF0m8bGsmY8DHFHiwdVjdXDAbPK3
         I2zSG5z/Ww/ocByhfB59g7A4v7HKVn7Q4RAcsd4s=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01SD7o7j105524;
        Fri, 28 Feb 2020 07:07:50 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 07:07:49 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 07:07:49 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01SD7lcs037330;
        Fri, 28 Feb 2020 07:07:48 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH v4 0/2] dmaengine: Initial debugfs support
Date:   Fri, 28 Feb 2020 15:07:45 +0200
Message-ID: <20200228130747.22905-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Changes since v3:
- Create a directory for dmaengine and name the initial file as summary
- Function to get the debugfs root for DMA drivers if they want to place files
- Custom dbg_summary_show implementation for k3-udma

Changes since v2:
- Use dma_chan_name() for printing the channel's name

Changes since v1:
- Use much more simplified fops for the debugfs file (via DEFINE_SHOW_ATTRIBUTE)
- do not allow modification to dma_device_list while the debugfs file is read
- rename the slave_name to dbg_client_name (it is only for debugging)
- print information about dma_router if it is used by the channel
- Formating of the output slightly changed

The basic debugfs file (/sys/kernel/debug/dmaengine/summary) can be used to
query basic information about the DMAengine usage (am654-evm):

# cat /sys/kernel/debug/dmaengine/summary
dma0 (285c0000.dma-controller): number of channels: 96

dma1 (31150000.dma-controller): number of channels: 267
 dma1chan0    | 2b00000.mcasp:tx
 dma1chan1    | 2b00000.mcasp:rx
 dma1chan2    | in-use
 dma1chan3    | in-use
 dma1chan4    | in-use
 dma1chan5    | in-use

Drivers can implement custom dbg_summary_show to add extended information via
the summary file, like with the second patch for k3-udma (j721e-evm):

# cat /sys/kernel/debug/dmaengine/summary
dma0 (285c0000.dma-controller): number of channels: 24

dma1 (31150000.dma-controller): number of channels: 84
 dma1chan0    | 2b00000.mcasp:tx (MEM_TO_DEV, tchan16 [0x1010 -> 0xc400], PDMA[ ACC32 BURST ], TR mode)
 dma1chan1    | 2b00000.mcasp:rx (DEV_TO_MEM, rchan16 [0x4400 -> 0x9010], PDMA[ ACC32 BURST ], TR mode)
 dma1chan2    | 2ba0000.mcasp:tx (MEM_TO_DEV, tchan17 [0x1011 -> 0xc507], PDMA[ ACC32 BURST ], TR mode)
 dma1chan3    | 2ba0000.mcasp:rx (DEV_TO_MEM, rchan17 [0x4507 -> 0x9011], PDMA[ ACC32 BURST ], TR mode)
 dma1chan4    | in-use (MEM_TO_MEM, chan0 pair [0x1000 -> 0x9000], PSI-L Native, TR mode)
 dma1chan5    | in-use (MEM_TO_MEM, chan1 pair [0x1001 -> 0x9001], PSI-L Native, TR mode)
 dma1chan6    | in-use (MEM_TO_MEM, chan4 pair [0x1004 -> 0x9004], PSI-L Native, TR mode)
 dma1chan7    | in-use (MEM_TO_MEM, chan5 pair [0x1005 -> 0x9005], PSI-L Native, TR mode)
 
Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: Add basic debugfs support
  dmaengine: ti: k3-udma: Implement custom dbg_summary_show for debugfs

 drivers/dma/dmaengine.c   | 77 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/dmaengine.h   |  6 +++
 drivers/dma/ti/k3-udma.c  | 63 ++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h | 12 +++++-
 4 files changed, 157 insertions(+), 1 deletion(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

