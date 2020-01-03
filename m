Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A5A12FE48
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jan 2020 22:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgACVU0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jan 2020 16:20:26 -0500
Received: from ale.deltatee.com ([207.54.116.67]:53040 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgACVU0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jan 2020 16:20:26 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1inUMq-00053G-OV; Fri, 03 Jan 2020 14:20:25 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1inUMo-0000lF-NW; Fri, 03 Jan 2020 14:20:22 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jiasen Lin <linjiasen@hygon.cn>, Kit Chow <kchow@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  3 Jan 2020 14:20:18 -0700
Message-Id: <20200103212021.2881-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, linjiasen@hygon.cn, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v3 0/3]  PLX Switch DMA Engine Driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is v3 of the patchset. The in-use unbind bits have been sent and
accepted as a separate patch set. This patchset just includes the new
driver which has been updated to use the common reference counting.

This patchset is based off of vkoul/slave-dma.git/next and a git branch is
available here:

https://github.com/sbates130272/linux-p2pmem/ plx-dma-v3

Changes for v3:
* Common in-use unbind bits were submitted as a separate patch set
* Rebased onto vkoul/slave-dma.git/next (as of Jan 3rd 2020)

Changes for v2:

* Rebased onto v5.5-rc1 (no changes)
* Pushed the plx_dma_isr() routine into the patch that uses it (per
  Vinod's feedback)

Logan Gunthorpe (3):
  dmaengine: plx-dma: Introduce PLX DMA engine PCI driver skeleton
  dmaengine: plx-dma: Implement hardware initialization and cleanup
  dmaengine: plx-dma: Implement descriptor submission

 MAINTAINERS           |   5 +
 drivers/dma/Kconfig   |   9 +
 drivers/dma/Makefile  |   1 +
 drivers/dma/plx_dma.c | 639 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 654 insertions(+)
 create mode 100644 drivers/dma/plx_dma.c

--
2.20.1
