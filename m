Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50B349623
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCYPyq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Mar 2021 11:54:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:6378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCYPyc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Mar 2021 11:54:32 -0400
IronPort-SDR: CeHQrDwYNDtt3k1UQfeFfSh91PZZ2MapWSHQSjODYborKa26xnkGQfUAZFPXKUpEqTp31/SkjZ
 GFSqYt05Jm2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="178512096"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="178512096"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:54:32 -0700
IronPort-SDR: 3He17XBj/y5pi1s610nr/31Ip4DEByfhkjKHM8yLmdgBz8gZgWIhn0ELKOJx5BXS1Pz/Dpi1bX
 TNgU3qlye6Hg==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="416062400"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:54:31 -0700
Subject: [PATCH v8 0/8] idxd 'struct device' lifetime handling fixes
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org,
        dan.carpenter@oracle.com
Date:   Thu, 25 Mar 2021 08:54:31 -0700
Message-ID: <161668743322.2670112.2302120522403482843.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
 drivers/dma/idxd/sysfs.c  | 241 ++++++++++++++++----------------
 6 files changed, 439 insertions(+), 301 deletions(-)

--

