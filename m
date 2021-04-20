Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015E8365FAB
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhDTSqu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 14:46:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:46675 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbhDTSqu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 14:46:50 -0400
IronPort-SDR: NKsZlCwz0JzV3V1q3Qr6XS9rt4y+Rex0dWDgaWj6APijPo+/zL4XiZC1hFua231xYjJUpLvvvo
 fUS2R5iE/3hQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="256880483"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="256880483"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:17 -0700
IronPort-SDR: kw637bGKUEv51mc/t9yFDw3VlPGathmviZtv+bNbugMbMiTA1hqWVG6cbDRIOm3Ep8mh7rlhE1
 F0MUjLYp9WZA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="401163743"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:17 -0700
Subject: [PATCH 0/6] Ouststanding patches for 5.13 series
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 20 Apr 2021 11:46:17 -0700
Message-ID: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,
Here are the remaining outstanding patches for 5.13 merge window that has
been rebased against the latest dmaengine/next tree. Thanks!

---

Dave Jiang (6):
      dmaengine: idxd: add percpu_ref to descriptor submission path
      dmaengine: idxd: add support for readonly config mode
      dmaengine: idxd: add interrupt handle request and release support
      dmaengine: idxd: convert sprintf() to sysfs_emit() for all usages
      dmaengine: idxd: enable SVA feature for IOMMU
      dmaengine: idxd: support reporting of halt interrupt


 drivers/dma/idxd/device.c    | 202 +++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h      |  16 +++
 drivers/dma/idxd/init.c      |  95 ++++++++++++++--
 drivers/dma/idxd/irq.c       |   2 +
 drivers/dma/idxd/registers.h |  12 ++-
 drivers/dma/idxd/submit.c    |  35 ++++--
 drivers/dma/idxd/sysfs.c     | 139 ++++++++++++------------
 7 files changed, 416 insertions(+), 85 deletions(-)

--

