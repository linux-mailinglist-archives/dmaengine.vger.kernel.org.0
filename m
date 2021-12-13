Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB4473459
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 19:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbhLMSvT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 13:51:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:27537 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239853AbhLMSvT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Dec 2021 13:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639421479; x=1670957479;
  h=subject:from:to:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6YidgoZQJ+buaCUzm+Z5MkJVgkbVqll5hRVJ0NPxOWE=;
  b=a6cEa7SIsF/HJ902tjCcZp+V8K9CdzbvR/1SpTWLFBMvreFx92Qnnfrd
   ubZ0tzqkEjBWpP5q+IRRGseL++8qSNssbkdQQ6SqgJ0nQzWlhdvwX5IJD
   pS2UaWhIrV0E7PyCyEFblZkz+Idk+WfrorkXC3FABR9wsIPoPiRERCO/T
   DO0ytnYMdsLvBRwyBVnVTAAkGN8t2fvmh30mZk28YBE+xhodURLVhQ1pD
   tMO1E0CSsfzONl+2OIPqjPnw4VEMsXnZYXFTrdWXb6dMjYj1u8H5o0ZWd
   pdFCNoZlQN4n31TuZgVY5MDLxv3V0CNEknO8R0JZvlbQEOjthhuL2hPB/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302183517"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="302183517"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:51:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="613934067"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:51:18 -0800
Subject: [PATCH 0/3] refactor driver to only enable irq for wq enable
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Date:   Mon, 13 Dec 2021 11:51:17 -0700
Message-ID: <163942143944.2412839.16850082171909136030.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series refactors the code to enable irq on wq enable only
when necessary instead of allocation all msix vectors at probe. This saves
CPU irq vector allocation on x86 platforms.

MSIX vector 0 is special and remain being allocated at probe.
---

Dave Jiang (3):
      dmaengine: idxd: embed irq_entry in idxd_wq struct
      dmaengine: idxd: fix descriptor flushing locking
      dmaengine: idxd: change MSIX allocation based on per wq activation


 drivers/dma/idxd/device.c | 163 +++++++++++++++++++++-------------
 drivers/dma/idxd/dma.c    |  12 +++
 drivers/dma/idxd/idxd.h   |  29 +++---
 drivers/dma/idxd/init.c   | 181 ++++++--------------------------------
 drivers/dma/idxd/irq.c    |  13 +--
 drivers/dma/idxd/submit.c |   8 +-
 drivers/dma/idxd/sysfs.c  |   1 -
 include/uapi/linux/idxd.h |   1 +
 8 files changed, 168 insertions(+), 240 deletions(-)

--

