Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ABF6B7EAD
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCMRFV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCMREz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:04:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFCE6A40A;
        Mon, 13 Mar 2023 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678727054; x=1710263054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Q7EgTFqE29R+y9PHzZyxRRsO1s5UbLhd1WJBpHJ1uM=;
  b=UzJuEdEgCvf05SrA3K5MMoSroebPL4P1Z8/pAQn7lR1IYrFHME98Gw21
   MIm6Hnq87eY0mAeYNAS42CbpEdl8oOkS3nx6r8wYv7BzVGjt5MLfoqxkY
   WpbvVu0qwyCwLG/9SJaqtWfVlJT/zUMZN3ohZR+pIQCcoBV6uLEyzaoUq
   orylO5SrIIPiBA1kDy/uSu94laBkeh4bKm1jaVuQCsxfCi95pC22cOxtg
   BrlRwBnqB0bfEeModV+/LXXxE7JDOYGBiE74/UGz9kmc9cJgtac3Z7qsL
   wkBH6xQNLcg+60BWRkCgMxN7hf6OVg29bjY/6HkTYQhj/qjtJdv6A0ToH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334679609"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334679609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708950881"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708950881"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 10:02:39 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 00/16] Enable DSA 2.0 Event Log and completion record faulting features
Date:   Mon, 13 Mar 2023 10:02:03 -0700
Message-Id: <20230313170219.1956012-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Applications can send 64B descriptors to the DSA device via CPU
instructions MOVDIR64B or ENQCMD. The application can choose to have
the device write back a completion record (CR) in system memory to
indicate the status of the descriptor submitted on completion.

With the DSA hardware, the device is able to do on demand paging through
the hardware by faulting in the user pages that do not have physical memory
page backing with assistance from IOMMU. In the spec this was designated as
the block on fault feature. While this hardware feature made operation
simpler, it also stalls the device engines while the memory pages are being
faulted in through Page Request Service (PRS). For applications sharing the
same workqueue (wq) or wqs in the same group, operations are stalled if
there are no free engines. To avoid slowing the performance of all other
running applications sharing the same device engine(s), PRS can to be
disabled and software can deal with partial completion.

The block on fault feature on DSA 1.0 can be disabled for the wq. However,
PRS is not completely disabled for the whole path. It is not disabled for
CRs or batch list for a batch operation.

The other issue is the DSA 1.0 error reporting mechanism, SWERROR register.
The SWERROR register can only report a single error at a time until the
driver reads and acknowledges the error. The follow on errors cannot be
reported until the current error is "cleared" by the software by writing
a bit to the SWERR register. If a large number of faults arrive and the
software cannot clear them fast enough, overflowed errors will be dropped
by the device.

A CR is the optional 32 bytes (DSA) or 64 bytes (IAA) status that is
written back for a submitted descriptor. If the address for the CR faults,
the error is reported to the SWERROR register instead.

With DSA 2.0 hardware [1], the event log feature is added. All errors are
reported as an entry in a circular buffer reside in the system memory.
The system admin is responsible to configure the size of the circular
buffer large enough per device to handle the potential errors that may be
reported. If the buffer is full and another error needs to be reported,
the device engine will block until there's a free slot in the buffer.
An event log entry for a faulted CR will contain the error information,
the CR address that faulted, and the expected CR content the device had
originally intended to write.

DSA 2.0 also introduces per wq PRS disable knob. This will disable all PRS
operations for the specific wq. The device will still have Address
Translation Service (ATS) on. When ATS fails on a memory address for a CR,
an eventlog entry will be written by the hardware into the event log
ring buffer. The driver software is expected to parse the event log entry,
fault in the address of the CR, and the write the content of the CR to
the memory address.

This patch series will implement the DSA 2 event log support. The support
for the handling of the faulted user CR is added. The driver is also
adding the same support for batch operation descriptors. With a batch
operation the handling of the event log entry is a bit more complex.
The faulting CR could be for the batch descriptor or any of the operation
descriptors within the batch. The hardware generates a batch identifier
that is used by the driver software to correlate the event log entries for
the relevant descriptors of that batch.

The faulting of source and destination addresses for the operation is not
handled by the driver. That is left to be handled by the user application
by faulting in the memory and re-submit the remaining operation.

This series consists of three parts:
1. Patch 1: Make misc interrupt one shot. Event Log interrupt depends on
   this patch. This patch was released before but is not in upstream yet:
   https://lore.kernel.org/dmaengine/165125374675.311834.10460196228320964350.stgit@djiang5-desk3.ch.intel.com/
2. Patches 2-15: Enable Event Log and Completion Record faulting.
3. Patch 16: Configure PRS disable per WQ.

This series is applied cleanly on top of "Expose IAA 2.0 device
capabilities" series:
https://lore.kernel.org/lkml/20230303213732.3357494-1-fenghua.yu@intel.com/

Change log:
v3:
- Since iommu_sva_find() will be removed in IOMMU and access_remote_vm()
  cannot be exported, the completion record copy function idxd_copy_cr()
  is rewritten by maintaining and finding mm in xarray and copy completion
  record to the mm.
  Please check discussion on iommu_sva_find() will be removed and
  access_remote_vm() cannot be exported:
  1. https://lore.kernel.org/lkml/ZAjSsm4%2FPDRqViwa@nvidia.com/
  2. https://lore.kernel.org/lkml/20230306163138.587484-1-fenghua.yu@intel.com/T/#m1fc97725a0e56ea269c8bdabacee447070d51846

v2:
- Define and export iommu_access_remote_vm() for IDXD driver to write
  completion record to user address space. This change removes
  patch 8 and 9 in v1 (Alistair Popple)
https://lore.kernel.org/lkml/20230306163138.587484-1-fenghua.yu@intel.com/

Dave Jiang (15):
  dmaengine: idxd: make misc interrupt one shot
  dmaengine: idxd: add event log size sysfs attribute
  dmaengine: idxd: setup event log configuration
  dmaengine: idxd: add interrupt handling for event log
  dmanegine: idxd: add debugfs for event log dump
  dmaengine: idxd: add per DSA wq workqueue for processing cr faults
  dmaengine: idxd: create kmem cache for event log fault items
  dmaengine: idxd: process user page faults for completion record
  dmaengine: idxd: add descs_completed field for completion record
  dmaengine: idxd: process batch descriptor completion record faults
  dmaengine: idxd: add per file user counters for completion record
    faults
  dmaengine: idxd: add a device to represent the file opened
  dmaengine: idxd: expose fault counters to sysfs
  dmaengine: idxd: add pid to exported sysfs attribute for opened file
  dmaengine: idxd: add per wq PRS disable

Fenghua Yu (1):
  dmaengine: idxd: define idxd_copy_cr()

 .../ABI/stable/sysfs-driver-dma-idxd          |  43 +++
 drivers/dma/Kconfig                           |   1 +
 drivers/dma/idxd/Makefile                     |   2 +-
 drivers/dma/idxd/cdev.c                       | 354 ++++++++++++++++--
 drivers/dma/idxd/debugfs.c                    | 138 +++++++
 drivers/dma/idxd/device.c                     | 113 +++++-
 drivers/dma/idxd/idxd.h                       |  65 ++++
 drivers/dma/idxd/init.c                       |  53 +++
 drivers/dma/idxd/irq.c                        | 202 ++++++++--
 drivers/dma/idxd/registers.h                  | 105 +++++-
 drivers/dma/idxd/sysfs.c                      | 112 +++++-
 include/uapi/linux/idxd.h                     |  15 +-
 12 files changed, 1139 insertions(+), 64 deletions(-)
 create mode 100644 drivers/dma/idxd/debugfs.c

-- 
2.37.1

