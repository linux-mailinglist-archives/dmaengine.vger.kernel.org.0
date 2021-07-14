Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66DC3C9461
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhGNXXQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:23:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:18936 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhGNXXQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:23:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210487775"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="210487775"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:20:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="655008389"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:20:23 -0700
Subject: [PATCH v2 00/18] Fix idxd sub-drivers setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Willliams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:20:22 -0700
Message-ID: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,
This has been rebased against dmaengine/next tree per request. Please
consider merge. Thanks.

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

