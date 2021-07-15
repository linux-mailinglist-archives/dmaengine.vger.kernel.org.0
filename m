Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48E03CA610
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhGOSqB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:46:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:57216 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231633AbhGOSp7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:45:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="232438228"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="232438228"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="495601413"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:04 -0700
Subject: [PATCH v3 00/18] Fix idxd sub-drivers setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Willliams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:43:03 -0700
Message-ID: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,
The series did not encounter any issues pushed on top of the latest 'next'
branch.

v3:
- Fix 0-day report on idxd_dev_set_type() type conversion
v2:
- Rebase

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
 drivers/dma/idxd/device.c | 194 +++++++++++++-
 drivers/dma/idxd/dma.c    |  82 +++++-
 drivers/dma/idxd/idxd.h   | 129 +++++++--
 drivers/dma/idxd/init.c   | 140 +++++-----
 drivers/dma/idxd/irq.c    |   2 +-
 drivers/dma/idxd/sysfs.c  | 541 ++++++++------------------------------
 12 files changed, 858 insertions(+), 532 deletions(-)
 create mode 100644 drivers/dma/idxd/bus.c
 create mode 100644 drivers/dma/idxd/compat.c

--

