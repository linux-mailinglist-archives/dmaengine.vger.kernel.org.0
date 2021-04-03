Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8492C3534C4
	for <lists+dmaengine@lfdr.de>; Sat,  3 Apr 2021 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhDCQpj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Apr 2021 12:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236735AbhDCQpi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 3 Apr 2021 12:45:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ED4761287;
        Sat,  3 Apr 2021 16:45:34 +0000 (UTC)
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     vkoul@kernel.org
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v2 0/1] dmaengine: idxd: IDXD pmu support
Date:   Sat,  3 Apr 2021 11:45:30 -0500
Message-Id: <cover.1617467772.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Hi,

This is v2 of the IDXD pmu support patch, which is the same as v1 but
removes a few assigned-but-unused variables reported by kernel test
robot <lkp@intel.com>.

Thanks,

Tom


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

Tom Zanussi (1):
  dmaengine: idxd: Add IDXD performance monitor support

 drivers/dma/Kconfig          |  13 +
 drivers/dma/idxd/Makefile    |   2 +
 drivers/dma/idxd/idxd.h      |  45 +++
 drivers/dma/idxd/init.c      |   9 +
 drivers/dma/idxd/irq.c       |   5 +-
 drivers/dma/idxd/perfmon.c   | 653 +++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/perfmon.h   | 119 +++++++
 drivers/dma/idxd/registers.h | 108 ++++++
 include/linux/cpuhotplug.h   |   1 +
 9 files changed, 951 insertions(+), 4 deletions(-)
 create mode 100644 drivers/dma/idxd/perfmon.c
 create mode 100644 drivers/dma/idxd/perfmon.h

-- 
2.17.1

