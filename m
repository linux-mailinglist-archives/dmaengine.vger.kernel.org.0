Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1476AA143
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjCCVeW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCCVeV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:34:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0971027A;
        Fri,  3 Mar 2023 13:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879259; x=1709415259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BFx/BonqsYo1C3/u+njro1uet8ELdDIBMmvGwJWswZM=;
  b=DdjOK6xwpTG6HomDeezi4CXLvOO7InDV6/8qcedW5uph3hy0WMWpjirt
   vAHuSzPDE/yrRh80Ba8miykPTxottrD+D0vlx0ILmy+nRt9db0MmRghCS
   JB6CrDsdFn6vcArijKxaFhYWtkmQllf8wAX3iZS+qn5wf+Z1qeHa+E00r
   aOPXoeWyytCGP+xeSBwcWMSLVxpYjkG2DYtcQKeUOuzsqeZUdgohvM0sR
   99xE5H34xVYXgoMMzAxHGVnrxa7UygMtJaLht8nFaZwQYBD5NKVTi52el
   2gTeQrve8BLJcKtxkQJkExuphluVvEHFToTg4ZojRyd2hMHh6L7twGNSt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399976464"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="399976464"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="675508696"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="675508696"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2023 13:34:19 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/3] Add descriptor definitions for a few new DSA operations
Date:   Fri,  3 Mar 2023 13:34:10 -0800
Message-Id: <20230303213413.3357431-1-fenghua.yu@intel.com>
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

A few new DSA operations are introduced [1]:
1. Memory fill with 16 bytes of pattern.
2. Translation fetch.
3. Data Integrity Extension (DIX) generate.

This series adds descriptor definitions for the new DSA operations.
With the definitions, user can issue the DSA operations to optimize
corresponding transactions.

Change log:
v2:
- Change anonymous struct to uint64_t for pattern_upper (Dave Jiang)
v1:
https://lore.kernel.org/dmaengine/20221108003944.2095567-1-fenghua.yu@intel.com/

Reference:
1. DSA 2.0 spec: https://software.intel.com/content/www/us/en/develop/articles/intel-data-streaming-accelerator-architecture-specification.html

Fenghua Yu (3):
  dmaengine: idxd: Add descriptor definitions for 16 bytes of pattern in
    memory fill operation
  dmaengine: idxd: Add descriptor definitions for DIX generate operation
  dmaengine: idxd: Add descriptor definitions for translation fetch
    operation

 include/uapi/linux/idxd.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.37.1

