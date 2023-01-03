Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4CE65C404
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjACQf2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbjACQfT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B1FF1
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763718; x=1704299718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4e+Yu0GJ5koOwVk9zv2FGtGEfB9W21gLp61PSzE5ouM=;
  b=LP9462zff5GCeyPItopuOxKPaVugsdkMl1z2Utkr9G3tOqyWACziPDYB
   p9K9Av6BblGFrWe36Ik8g7oG66mDGtswPj9gKWN0Zk2H9yRzi12OcLlRH
   EUM3tFjtFHyt2VX/wik0Nmg7opS3KbACy4S/PrCHSAC/xqeuCObgzV9d5
   soCX3l3Src9DyjCB1EuwvNh/ub8gfu8O+ukITCqM31R/aBMKM8Xqha2YF
   imX+TROIl8kJXWVVHiyTxN0VB1nnkQhdO83j7v09FUSMmPQLJ6u3yedvs
   15J++faY4e5Ub2+MvBCRNGwB7IW8I2K1kfB6a+ucApvNQeNIBXc1aevAs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072327"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072327"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858519"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858519"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:14 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 09/17] mm: export access_remote_vm() symbol
Date:   Tue,  3 Jan 2023 08:34:57 -0800
Message-Id: <20230103163505.1569356-10-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103163505.1569356-1-fenghua.yu@intel.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
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

From: Dave Jiang <dave.jiang@intel.com>

Export access_remote_vm() symbol for driver usage. The idxd driver would
like to use it to write the user's completion record that the hardware
device is not able to write to due to user page fault.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory.c b/mm/memory.c
index aad226daf41b..caae4deff987 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5579,6 +5579,7 @@ int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 {
 	return __access_remote_vm(mm, addr, buf, len, gup_flags);
 }
+EXPORT_SYMBOL_GPL(access_remote_vm);
 
 /*
  * Access another process' address space.
-- 
2.32.0

