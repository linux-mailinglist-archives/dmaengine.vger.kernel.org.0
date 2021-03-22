Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C7E345306
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCVXbi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:31:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:15003 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhCVXbR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:31:17 -0400
IronPort-SDR: QREYydKZs69GtfsmGM6XVLujkZZgv9tN6A7+9Zb5NqgJIJNFcMbZUJlmF4wqna54WaMhzK9Cc9
 he6mgxYoxTGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210442855"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210442855"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:31:16 -0700
IronPort-SDR: PennFzePV6WKFFHdi8RMYFwwgldDwhWpB7h4iwmMSG0zFfaPqKPjt+6OWHtzfAEMlrgVmTZdtz
 06/mW6yWSKxQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="442314197"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:31:15 -0700
Subject: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, jgg@nvidia.com, dan.j.williams@intel.com
Date:   Mon, 22 Mar 2021 16:31:14 -0700
Message-ID: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

v7:
- Fix up the 'struct device' setup in char device code (Jason)
- Split out the char dev fixes (Jason)
- Split out the DMA dev fixes (Dan)
- Split out the each of the conf_dev fixes
- Split out removal of the pcim_* calls
- Split out removal of the devm_* calls
- Split out the fixes for interrupt config calls
- Reviewed by Dan.

v6:
- Fix char dev initialization issues (Jason)
- Fix other 'struct device' initialization issues.

v5:
- Rebased against 5.12-rc dmaengine/fixes
v4:
- fix up the life time of cdev creation/destruction (Jason)
- Tested with KASAN and other memory allocation leak detections. (Jason)

v3:
- Remove devm_* for irq request and cleanup related bits (Jason)
v2:
- Remove all devm_* alloc for idxd_device (Jason)
- Add kref dep for dma_dev (Jason)

Vinod,
The series fixes the various 'struct device' lifetime handling in the
idxd driver. The devm managed lifetime is incompatible with 'struct device'
objects that resides in the idxd context. Tested with
CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.

Please consider for damengine/fixes for the 5.12-rc.

---

Dave Jiang (8):
      dmaengine: idxd: fix dma device lifetime
      dmaengine: idxd: cleanup pci interrupt vector allocation management
      dmaengine: idxd: removal of pcim managed mmio mapping
      dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime
      dmaengine: idxd: fix wq conf_dev 'struct device' lifetime
      dmaengine: idxd: fix engine conf_dev lifetime
      dmaengine: idxd: fix group conf_dev lifetime
      dmaengine: idxd: fix cdev setup and free device lifetime issues


 drivers/dma/idxd/cdev.c   | 131 +++++++-----------
 drivers/dma/idxd/device.c |  20 +--
 drivers/dma/idxd/idxd.h   |  54 ++++++--
 drivers/dma/idxd/init.c   | 284 +++++++++++++++++++++++++++-----------
 drivers/dma/idxd/irq.c    |  10 +-
 drivers/dma/idxd/sysfs.c  | 239 ++++++++++++++++----------------
 6 files changed, 437 insertions(+), 301 deletions(-)

--

