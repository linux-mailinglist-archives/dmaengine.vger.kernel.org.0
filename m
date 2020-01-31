Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8D14EA28
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2020 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgAaJiV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jan 2020 04:38:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46410 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgAaJiV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jan 2020 04:38:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00V9cDiP053693;
        Fri, 31 Jan 2020 03:38:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580463493;
        bh=WP6XzFHxhcx79wYspVykJWrDTxn03RSvvCmcK8MHA6o=;
        h=From:To:CC:Subject:Date;
        b=mbDMS6Zdwm3BPhECIkZsEFQOxtWqG2bNTyyxeDsNfnhEv/s56l7JgdYQmiXWELlTn
         +cTliDNRaxKKWvRpB4lFUbIQvYsrCE+M2H7zyhAk5/0QsS1hbmY41Pi74LYZnpjs3E
         /Kl25Vigl5y3WFNNzccJuMLw8fi7/5r5ZAQ+usAs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00V9cD5q129435;
        Fri, 31 Jan 2020 03:38:13 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 03:38:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 03:38:12 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00V9cAGj054689;
        Fri, 31 Jan 2020 03:38:11 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH v2 0/2] dmaengine: Cleanups for symlink handling and debugfs support
Date:   Fri, 31 Jan 2020 11:38:57 +0200
Message-ID: <20200131093859.3311-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Changes since v1:
- Removed dev_warn() for kasprintf in both patch
- Added Reviewed-by from Geert to the first patch
- Use much more simplified fops for the debugfs file (via DEFINE_SHOW_ATTRIBUTE)
- do not allow modification to dma_device_list while the debugfs file is read
- rename the slave_name to dbg_client_name (it is only for debugging)
- print information about dma_router if it is used by the channel
- Formating of the output slightly changed

As I have mentioned on the symlink patch earlier I like how the gpio's debugfs
shows in one place information.

These patches are on top of Vinod's next (with the v2 fix for the symlink
support).

The first patch fixes and cleans up the symlink handling code a bit and the
second adds support for debugfs file:

On my board with audio and after a run with dmatest on 6 channels this is how
the information is presented about the DMA drivers:

# cat /sys/kernel/debug/dmaengine 
dma0 (285c0000.dma-controller): number of channels: 96

dma1 (31150000.dma-controller): number of channels: 267
 dma1chan0   | 2b00000.mcasp:tx
 dma1chan1   | 2b00000.mcasp:rx
 dma1chan2   | in-use
 dma1chan3   | in-use
 dma1chan4   | in-use
 dma1chan5   | in-use
 dma1chan6   | in-use
 dma1chan7   | in-use

On dra7-evm after boot:
# cat /sys/kernel/debug/dmaengine 
dma0 (43300000.edma): number of channels: 64
 dma0chan0   | 48468000.mcasp:tx (via router: 4a002c78.dma-router)
 dma0chan1   | 48468000.mcasp:rx (via router: 4a002c78.dma-router)

dma1 (4a056000.dma-controller): number of channels: 127
 dma1chan0   | in-use
 dma1chan1   | in-use

It shows the users (device name + channel name) of the channels. If it is not a
slave channel, then it only prints 'in-use' as no other information is
available for non save channels.

DMA drivers can implement the dbg_show callback to provide custom information
for their channels if needed.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: Cleanups for the slave <-> channel symlink support
  dmaengine: Add basic debugfs support

 drivers/dma/dmaengine.c   | 84 ++++++++++++++++++++++++++++++++++-----
 include/linux/dmaengine.h | 12 +++++-
 2 files changed, 86 insertions(+), 10 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

