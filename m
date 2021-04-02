Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D3352FFE
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhDBT46 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:56:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:48139 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236090AbhDBT45 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:56:57 -0400
IronPort-SDR: 4pNml3UH7Mg7uKBF2ma8shLBYHHaVErcoY+CavHYoe6AkO4z83qVc776YJCWqr5WE7aXgDieP9
 PFXWfwyBJ3+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="212803320"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="212803320"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:56:55 -0700
IronPort-SDR: ctlW85EBsOiKhGIc+PztC6CdEFNsW8CwU+bJ1/vOOhOdEAk4HA8Ng25fWk2r4pspfI7LbdI9zI
 oB6r701IrYKg==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="446925442"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:56:54 -0700
Subject: [PATCH v9 00/11] idxd 'struct device' lifetime handling fixes
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:56:54 -0700
Message-ID: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
idxd driver. The devm managed lifetime is incompatible with 'struct device'
objects that resides in the idxd context. Tested with
CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.

Please consider for damengine/fixes for the 5.12-rc.

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

