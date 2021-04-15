Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4436165A
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 01:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhDOXha (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 19:37:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:30972 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237906AbhDOXh3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Apr 2021 19:37:29 -0400
IronPort-SDR: yDR898r4+d79VaGaKLKCO4zBC2klj1ugVUi6Z8nR+DgLYPCm/ArtWfJnCHSFz4c7Pl6zU2IkXb
 7ac8BGJm8+Kg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="182458451"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="182458451"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:05 -0700
IronPort-SDR: luMCNY/9mx5qSes/Cbj3zJol+eRBshI6sCrgJmSl6mO6iIJXGtL11vW2rWUi4dNntjZuNTt3FV
 8BfnF6sCsKyg==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="399737569"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:04 -0700
Subject: [PATCH v10 00/11] idxd 'struct device' lifetime handling fixes
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:37:04 -0700
Message-ID: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

v10:
- Fix txd initialization location due to dma_chan being dynamically allocated.

v9:
- Fill in details for commit messages (Jason)
- Fix wrong indentation (Jason)
- Move stray change to the right patch (Jason)
- Remove idxd_free() and refactor 'struct device' setup so we can use
  ->release() calls to clean up. (Jason)
- Change idr to ida. (Jason)
- Remove static type detection for each device type (Dan)

v8:
- Do not emit negative value for sysfs 'minor' attrib (Dan)
- Use sysfs_emit() to emit sysfs 'minor' attrib (Jason)
- Fix interation of unwind cleanup of various allocation. (DanC)

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
idxd driver. The devm managed lifetime is incompatible with 'struct
device' objects that resides in the idxd context. Tested with
CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.

Please consider for damengine/fixes for the 5.13-rc.

---

Dave Jiang (11):
      dmaengine: idxd: fix dma device lifetime
      dmaengine: idxd: cleanup pci interrupt vector allocation management
      dmaengine: idxd: removal of pcim managed mmio mapping
      dmaengine: idxd: use ida for device instance enumeration
      dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime
      dmaengine: idxd: fix wq conf_dev 'struct device' lifetime
      dmaengine: idxd: fix engine conf_dev lifetime
      dmaengine: idxd: fix group conf_dev lifetime
      dmaengine: idxd: fix cdev setup and free device lifetime issues
      dmaengine: idxd: iax bus removal
      dmaengine: idxd: remove detection of device type


 drivers/dma/idxd/cdev.c   | 132 +++++-------
 drivers/dma/idxd/device.c |  36 ++--
 drivers/dma/idxd/idxd.h   |  83 +++++---
 drivers/dma/idxd/init.c   | 383 ++++++++++++++++++++++-------------
 drivers/dma/idxd/irq.c    |  10 +-
 drivers/dma/idxd/submit.c |   2 +-
 drivers/dma/idxd/sysfs.c  | 410 ++++++++++++++------------------------
 7 files changed, 525 insertions(+), 531 deletions(-)

--

