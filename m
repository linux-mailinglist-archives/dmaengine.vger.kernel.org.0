Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD02640D18
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiLBSZY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 13:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiLBSZS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 13:25:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A2D968D;
        Fri,  2 Dec 2022 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670005517; x=1701541517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5266xyF/LFxCgrkq7dAhZybGHEHKugBc6nB+jPB2tiI=;
  b=d3Xq0edgciOqb0iHLrzJDO95zaabJgnzR6hio7rGZ2ZVI0XQzrwucHW3
   YaMUzW86KyYssB78sMDmaAJdNztFaFcgf3KbMkdGXEXVgwaobsBSWuCrs
   ildcg3tKEHg3oPzXodfbIU0vxm74fk+zUN5Aro2e+PuIUimnQ5xv0T6NR
   qjjotW1KG63VukCctSz0VZ7uSGf9oJA2OqeS4qSwTC83e4vZJCZhKIlBm
   QDP+yrY6HqhQQqfkxIfgSoT2fIBJnKT68t+lJsWhwa0JDpSvqoSpYY1UO
   kpiRDJIRTRkZsrN4iIA63F3aUWDVOCYvd88boovaf4/MAkYiPOGBiJ0vc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378166722"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378166722"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:25:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="622786441"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="622786441"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:25:15 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     fenghua.yu@intel.com, dave.jiang@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dmaengine: idxd: Error path fixes
Date:   Fri,  2 Dec 2022 10:25:03 -0800
Message-Id: <cover.1670005163.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
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

Dear Maintainers,

I have been using the IDXD driver to experiment with the upcoming core
changes in support of IMS ([1], [2], [3]). As part of this work I
happened to exercise the error paths within IDXD and encountered
a few issues that are addressed in this series. These changes are
independent from IMS and just aims to make the IDXD driver more
robust against errors.

It is not clear to me if these are appropriate for stable so I am
not including the stable team. Please let me know if you think
otherwise and I can add the necessary Cc. With the refactoring
through the history of the driver I was not able to
identify a Fixes: candidate for all. Patch #3 does look to be a
potentially complicated backport.

Your feedback is greatly appreciated.

Reinette

[1] https://lore.kernel.org/lkml/20221111132706.104870257@linutronix.de
[2] https://lore.kernel.org/lkml/20221111131813.914374272@linutronix.dexo
[3] https://lore.kernel.org/lkml/20221111133158.196269823@linutronix.de

Reinette Chatre (3):
  dmaengine: idxd: Let probe fail when workqueue cannot be enabled
  dmaengine: idxd: Prevent use after free on completion memory
  dmaengine: idxd: Do not call DMX TX callbacks during workqueue disable

 drivers/dma/idxd/device.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


base-commit: a4412fdd49dc011bcc2c0d81ac4cab7457092650
-- 
2.34.1

