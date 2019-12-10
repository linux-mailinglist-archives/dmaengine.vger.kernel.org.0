Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD6117C62
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 01:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfLJAZB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 19:25:01 -0500
Received: from ale.deltatee.com ([207.54.116.67]:38038 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfLJAYo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Dec 2019 19:24:44 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ieTKS-0002Cu-6g; Mon, 09 Dec 2019 17:24:43 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ieTKQ-0000lh-TX; Mon, 09 Dec 2019 17:24:38 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Kit Chow <kchow@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  9 Dec 2019 17:24:32 -0700
Message-Id: <20191210002437.2907-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v2 0/5] PLX Switch DMA Engine Driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is v2 of the patchset. The discussion for v1 was mostly resolving
a confusion of how this new driver fixes the problems with unbinds
while in use and how this is not solved by the existing module reference.
The first two patches fix bugs in the core code to support this.

This patchset is based off of v5.5-rc1 and a git branch is available
here:

https://github.com/sbates130272/linux-p2pmem/ plx-dma-v2

Changes for v2:

* Rebased onto v5.5-rc1 (no changes)
* Pushed the plx_dma_isr() routine into the patch that uses it (per
  Vinod's feedback)

--

The following patches introduce a driver to use the DMA hardware inside
PLX ExpressLane PEX Switches. The DMA devices appear as one or more
PCI virtual functions per channel and can serve similar use cases as
Intel's IOAT driver.

The first two patches in this series fix some bugs that are required to
support cases where the driver is unbound while the DMA engine is in
use. Without these patches the kernel will panic when that happens.

The final three patches implement the driver itself.

--

Logan Gunthorpe (5):
  dmaengine: Store module owner in dma_device struct
  dmaengine: Call module_put() after device_free_chan_resources()
  dmaengine: plx-dma: Introduce PLX DMA engine PCI driver skeleton
  dmaengine: plx-dma: Implement hardware initialization and cleanup
  dmaengine: plx-dma: Implement descriptor submission

 MAINTAINERS               |   5 +
 drivers/dma/Kconfig       |   9 +
 drivers/dma/Makefile      |   1 +
 drivers/dma/dmaengine.c   |   7 +-
 drivers/dma/plx_dma.c     | 658 ++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |   2 +
 6 files changed, 680 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/plx_dma.c

--
2.20.1
