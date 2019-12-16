Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25592121994
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 20:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLPTBZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 14:01:25 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34940 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfLPTBZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 14:01:25 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1igvcR-0005jC-3e; Mon, 16 Dec 2019 12:01:24 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1igvcQ-0005ZY-2x; Mon, 16 Dec 2019 12:01:22 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Kit Chow <kchow@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 16 Dec 2019 12:01:15 -0700
Message-Id: <20191216190120.21374-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH 0/5] Support hot-unbind in IOAT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hey,

This patchset creates some common infrastructure which I will use in the
next version of the PLX driver. It adds a reference count to the
dma_device struct which is taken and released every time a channel
is allocated or freed. A call back is used to allow the driver to
free the underlying memory and do any final cleanup.

For a use-case, I've adjusted the ioat driver to properly support
hot-unbind. The driver was already pretty close as it already had
a shutdown state; so it mostly only required freeing the memory
correctly and calling ioat_shutdown at the correct time.

This patchset is based on v5.5-rc2 and a git branch is available here:

https://github.com/sbates130272/linux-p2pmem/ ioat-hot-unbind

Thanks,

Logan

--

Logan Gunthorpe (5):
  dmaengine: Store module owner in dma_device struct
  dmaengine: Call module_put() after device_free_chan_resources()
  dmaengine: Move dma_channel_rebalance() infrastructure up in code
  dmaengine: Add reference counting to dma_device struct
  dmaengine: ioat: Support in-use unbind

 drivers/dma/dmaengine.c   | 352 +++++++++++++++++++++-----------------
 drivers/dma/ioat/init.c   |  38 ++--
 include/linux/dmaengine.h |  10 +-
 3 files changed, 233 insertions(+), 167 deletions(-)

--
2.20.1
