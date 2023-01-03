Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE6765C3FD
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbjACQfT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjACQfQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B41FF0
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763716; x=1704299716;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UAVVfoE1GW4PU09NZIQswZGTyDBJnhzbG3IKP1UUpww=;
  b=Hd5JyMc7fyPAWj5qxERYRHRad5ow2UDZtHV3voSGmBibhmPBXFmhgf4U
   lr5qpsr+ARtb7VP22VT3fgYRXop18uub3tZVyS0+qdsQPBJcEsoy3IpRH
   Qyum8Hfll6xcLQG42CdDxQUb+RgeJDl4lORJIGaMRcTSye2PqsQx7VWpb
   hdH6BoQsJF2/A9YndKaL6SenOQDbNTNFcI9qcgGDEOciHsgJ/EIslNZx2
   AroJV9D02hHAohLRWVIRLg1aObeR8gPK17suhWQLPfvd6JDlz4eDQzL5N
   0dCD8KUshK1CwbgUicTmdYNwJA73Hr6WPjNNDYxnwhQdFr1a6JlPM1UJW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072285"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072285"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858445"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858445"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:09 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org
Subject: [PATCH 00/17] Enable DSA 2.0 Event Log and completion record faulting features
Date:   Tue,  3 Jan 2023 08:34:48 -0800
Message-Id: <20230103163505.1569356-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
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

Applications can send 64B descriptors to the DSA device via CPU instructions
MOVDIR64B or ENQCMD. The application can choose to have the device write
back a completion record (CR) in system memory to indicate the status of the
descriptor submitted on completion.

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
2. Patches 2-16: Enable Event Log and Completion Record faulting.
3. Patch 17: Configure PRS disable per WQ.

[1] DSA 2.0 spec: https://cdrdv2-public.intel.com/671116/341204-intel-data-streaming-accelerator-spec.pdf

Dave Jiang (17):
  dmaengine: idxd: make misc interrupt one shot
  dmaengine: idxd: add event log size sysfs attribute
  dmaengine: idxd: setup event log configuration
  dmaengine: idxd: add interrupt handling for event log
  dmanegine: idxd: add debugfs for event log dump
  dmaengine: idxd: add per DSA wq workqueue for processing cr faults
  dmaengine: idxd: create kmem cache for event log fault items
  iommu: expose iommu_sva_find() to common header
  mm: export access_remote_vm() symbol
  dmaengine: idxd: process user page faults for completion record
  dmaengine: idxd: add descs_completed field for completion record
  dmaengine: idxd: process batch descriptor completion record faults
  dmaengine: idxd: add per file user counters for completion record
    faults
  dmaengine: idxd: add a device to represent the file opened
  dmaengine: idxd: expose fault counters to sysfs
  dmaengine: idxd: add pid to exported sysfs attribute for opened file
  dmaengine: idxd: add per wq PRS disable

 .../ABI/stable/sysfs-driver-dma-idxd          |  43 +++
 drivers/dma/Kconfig                           |   1 +
 drivers/dma/idxd/Makefile                     |   2 +-
 drivers/dma/idxd/cdev.c                       | 264 ++++++++++++++++--
 drivers/dma/idxd/debugfs.c                    | 138 +++++++++
 drivers/dma/idxd/device.c                     | 113 +++++++-
 drivers/dma/idxd/idxd.h                       |  63 +++++
 drivers/dma/idxd/init.c                       |  53 ++++
 drivers/dma/idxd/irq.c                        | 207 ++++++++++++--
 drivers/dma/idxd/registers.h                  | 105 ++++++-
 drivers/dma/idxd/sysfs.c                      | 112 +++++++-
 drivers/iommu/iommu-sva.h                     |   1 -
 include/linux/iommu.h                         |   7 +
 include/uapi/linux/idxd.h                     |  15 +-
 mm/memory.c                                   |   1 +
 15 files changed, 1059 insertions(+), 66 deletions(-)
 create mode 100644 drivers/dma/idxd/debugfs.c

-- 
2.32.0

