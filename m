Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54938D14E
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhEUWWr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:22:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:17505 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEUWWr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:22:47 -0400
IronPort-SDR: H1CFBZn81M7wXCw8ehmtpiRWvQ4V3sCn/uaTOof7g8myQhBszbw0W4UvOLPZ+w+0V1mZxBnWC5
 6Mct7CTSKhww==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201295414"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201295414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:23 -0700
IronPort-SDR: EI9d8LdI2J5IIRtBh0hj4K2y5nT6c1SpNm/4ctvbhSTDXfogKb23kvB5ox5ye1ia63Hv9OyZZt
 aUSvXmxMxJKg==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="434466112"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:23 -0700
Subject: [PATCH 00/18] Fix idxd sub-drivers setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dan Willliams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:21:22 -0700
Message-ID: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,
Please consider this series for the 5.14 merge window. Thank you!

The original dsa_bus_type did not use idiomatic mechanisms for attaching
dsa-devices to dsa-drivers. Switch to the idiomatic style. Once this
cleanup is in place it will ease the addition of the VFIO mdev driver
as another dsa-driver.

---

Dave Jiang (18):
      dmaengine: idxd: add driver register helper
      dmaengine: idxd: add driver name
      dmaengine: idxd: add 'struct idxd_dev' as wrapper for conf_dev
      dmaengine: idxd: remove IDXD_DEV_CONF_READY
      dmaengine: idxd: move wq_enable() to device.c
      dmaengine: idxd: move wq_disable() to device.c
      dmaengine: idxd: remove bus shutdown
      dmaengine: idxd: remove iax_bus_type prototype
      dmaengine: idxd: fix bus_probe() and bus_remove() for dsa_bus
      dmaengine: idxd: move probe() bits for idxd 'struct device' to device.c
      dmaengine: idxd: idxd: move remove() bits for idxd 'struct device' to device.c
      dmanegine: idxd: open code the dsa_drv registration
      dmaengine: idxd: add type to driver in order to allow device matching
      dmaengine: idxd: create idxd_device sub-driver
      dmaengine: idxd: create dmaengine driver for wq 'device'
      dmaengine: idxd: create user driver for wq 'device'
      dmaengine: dsa: move dsa_bus_type out of idxd driver to standalone
      dmaengine: idxd: move dsa_drv support to compatible mode


 drivers/dma/Kconfig       |  21 ++
 drivers/dma/Makefile      |   2 +-
 drivers/dma/idxd/Makefile |   8 +
 drivers/dma/idxd/bus.c    |  92 +++++++
 drivers/dma/idxd/cdev.c   |  65 ++++-
 drivers/dma/idxd/compat.c | 114 ++++++++
 drivers/dma/idxd/device.c | 207 +++++++++++++-
 drivers/dma/idxd/dma.c    |  82 +++++-
 drivers/dma/idxd/idxd.h   | 129 +++++++--
 drivers/dma/idxd/init.c   | 132 ++++-----
 drivers/dma/idxd/irq.c    |   2 +-
 drivers/dma/idxd/sysfs.c  | 553 +++++++-------------------------------
 12 files changed, 868 insertions(+), 539 deletions(-)
 create mode 100644 drivers/dma/idxd/bus.c
 create mode 100644 drivers/dma/idxd/compat.c

--

