Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7143BC7C
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 23:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhJZVig (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 17:38:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:59186 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239664AbhJZViW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Oct 2021 17:38:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="217190843"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="217190843"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:35:57 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="537297232"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:35:57 -0700
Subject: [PATCH v2 0/7] dmaengine: idxd: Add interrupt handle revoke support
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 26 Oct 2021 14:35:56 -0700
Message-ID: <163528412413.3925689.7831987824972063153.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

v2:
- Fix comment header typo (Vinod)
- Declare and init struct w/o memset (Vinod)

The series adds support to refresh the interrupt handles when they become
invalid. Typically this happens during a VM live migration where a VM moves
from one machine to another. The driver will receive an interrupt to
indicate that interrupt handles need to be changed. The driver blocks the
current submissions and acquires new interrupt handles. All submissions
will be held off until the handle is refreshed. Already submitted
descriptor
will error with status of "incorrect interrupt handle" and be resubmitted
by the
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
 drivers/dma/idxd/init.c      |  87 +++++++-------
 drivers/dma/idxd/irq.c       | 226 +++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/registers.h |   1 +
 drivers/dma/idxd/submit.c    |  26 ++--
 drivers/dma/idxd/sysfs.c     |   1 -
 8 files changed, 331 insertions(+), 65 deletions(-)

--

