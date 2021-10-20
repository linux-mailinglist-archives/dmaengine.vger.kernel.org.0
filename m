Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703C94350C4
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 18:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJTQ47 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 12:56:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:40913 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJTQ47 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 12:56:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="228704029"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="228704029"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:36 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="463261205"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:35 -0700
Subject: [PATCH 0/7] dmaengine: idxd: Add interrupt handle revoke support
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 20 Oct 2021 09:53:35 -0700
Message-ID: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,
I know this series came in late. If possible, can this be included for the 5.16
merge window please? If not possible, totally understand. Thanks!

The series adds support to refresh the interrupt handles when they become
invalid. Typically this happens during a VM live migration where a VM moves
from one machine to another. The driver will receive an interrupt to
indicate that interrupt handles need to be changed. The driver blocks the
current submissions and acquires new interrupt handles. All submissions
will be held off until the handle is refreshed. Already submitted descriptor
will error with status of "incorrect interrupt handle" and be resubmitted by the
driver.

---

Dave Jiang (7):
      dmaengine: idxd: rework descriptor free path on failure
      dmaengine: idxd: int handle management refactoring
      dmaengine: idxd: move interrupt handle assignment
      dmaengine: idxd: add helper for per interrupt handle drain
      dmaengine: idxd: create locked version of idxd_quiesce() call
      dmaengine: idxd: handle invalid interrupt handle descriptors
      dmaengine: idxd: handle interrupt handle revoked event


 drivers/dma/idxd/device.c    |  24 +++-
 drivers/dma/idxd/dma.c       |  18 ++-
 drivers/dma/idxd/idxd.h      |  13 +-
 drivers/dma/idxd/init.c      |  87 ++++++-------
 drivers/dma/idxd/irq.c       | 228 +++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/registers.h |   1 +
 drivers/dma/idxd/submit.c    |  26 ++--
 drivers/dma/idxd/sysfs.c     |   1 -
 8 files changed, 333 insertions(+), 65 deletions(-)

--

