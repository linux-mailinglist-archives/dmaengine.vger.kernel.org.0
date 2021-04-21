Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB13B36748E
	for <lists+dmaengine@lfdr.de>; Wed, 21 Apr 2021 23:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbhDUVFd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Apr 2021 17:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240539AbhDUVFd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Apr 2021 17:05:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7781161430;
        Wed, 21 Apr 2021 21:04:58 +0000 (UTC)
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     vkoul@kernel.org
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v3 0/2] dmaengine: idxd: IDXD pmu support
Date:   Wed, 21 Apr 2021 16:04:53 -0500
Message-Id: <cover.1619033785.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

This is v3 of the IDXD pmu support patch, which addresses the comments
from Vinod:

 - Removed the default line for INTEL_IDXD_PERFMON making it default 'n'

 - Replaced #ifdef CONFIG_INTEL_IDXD_PERFMON with IS_ENABLED()

 - Split the patch into two separate patches, the perfmon
   implementation and the code that uses it in the IDXD driver.

 - Added a new file,
   Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa that
   documents the new format and cpumask attributes, and added better
   comments for those in the code.

 - Changed 'dogrp' to 'do_group' in perfmon_collect_events()

 - Moved 'int idx' inside the loop in perfmon_validate_group() to the
   top of function.

 - In perfmon_pmu_read_counter(), return ioread64() directly and get
   rid of cntrdata.

I also fixed some erroneous code in perfmon_counter_overflow() that
because of my misreading of the spec caused unintended clearing of
wrong bits.  According to the spec you need to write 1 rather than 0
to an OVFSTATUS bit to clear it.

Thanks,

Tom

 -- original v2 text --

Hi,

This is v2 of the IDXD pmu support patch, which is the same as v1 but
removes a few assigned-but-unused variables reported by kernel test
robot <lkp@intel.com>.

 -- original v1 text --

Hi,

This patchset implements initial pmu support for the Intel DSA (Data
Streaming Accelerator [1]), which I'm hoping can go into 5.13.

I'm also hoping to supply a couple follow-on patches in the near
future, but I'm not yet sure how much sense they make, so I thought
I'd throw a couple ideas out there and maybe get some opinions before
going forward with them:

  - The perf userspace interface for this isn't exactly user-friedly,
    in that you currently need to specify numeric values for field
    values:

     # perf stat -e dsa0/filter_wq=0x1,filter_tc=0x1,filter_sz=0x7,
                    filter_eng=0x1,event=0x8,event_category=0x3/

    It would be nicer to be able to specify those values symbolically
    instead, and the way to do that seems to be via some JSON files in
    perf userspace.

  - Some of the DSA pmu support is patterned after existing uncore
    code, and there seems to be at least some opportunity to
    consolidate some of the things they both do into common code, such
    as the cpumask device attributes and related cpu hotplug support.
    At this point I'm not sure how much sense it makes to put any
    effort into that, but would be willing to try if there would be
    some interest in it, especially considering there will probably be
    future pmu support added that could benefit from it.

Thanks,

Tom

Tom Zanussi (2):
  dmaengine: idxd: Add IDXD performance monitor support
  dmaengine: idxd: Enable IDXD performance monitor support

 .../sysfs-bus-event_source-devices-dsa        |  30 +
 drivers/dma/Kconfig                           |  12 +
 drivers/dma/idxd/Makefile                     |   2 +
 drivers/dma/idxd/idxd.h                       |  45 ++
 drivers/dma/idxd/init.c                       |   9 +
 drivers/dma/idxd/irq.c                        |   5 +-
 drivers/dma/idxd/perfmon.c                    | 662 ++++++++++++++++++
 drivers/dma/idxd/perfmon.h                    | 119 ++++
 drivers/dma/idxd/registers.h                  | 108 +++
 include/linux/cpuhotplug.h                    |   1 +
 10 files changed, 989 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa
 create mode 100644 drivers/dma/idxd/perfmon.c
 create mode 100644 drivers/dma/idxd/perfmon.h

-- 
2.17.1

