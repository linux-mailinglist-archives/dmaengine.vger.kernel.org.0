Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B632E12BC1C
	for <lists+dmaengine@lfdr.de>; Sat, 28 Dec 2019 02:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL1BY0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 20:24:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:41107 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfL1BYZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 20:24:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 17:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600"; 
   d="scan'208";a="300782392"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2019 17:24:22 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1il0q6-000CXw-9T; Sat, 28 Dec 2019 09:24:22 +0800
Date:   Sat, 28 Dec 2019 09:24:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     kbuild-all@lists.01.org, vkoul@kernel.org,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        Gary.Hook@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Shyam-sundar.S-k@amd.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [RFC PATCH] dmaengine: ptdma: pt_present() can be static
Message-ID: <20191228012413.rinqeaetsufcwdkf@4978f4969bb8>
References: <1577458112-109734-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577458112-109734-1-git-send-email-Sanju.Mehta@amd.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Fixes: ea65c60183d6 ("dmaengine: ptdma: Add debugfs entries for PTDMA information")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ptdma-dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 1cb47bbdbd3e1..6df0d5049aa26 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -136,7 +136,7 @@ static void pt_del_device(struct pt_device *pt)
  *
  * Returns zero if a PTDMA device is present, -ENODEV otherwise.
  */
-int pt_present(void)
+static int pt_present(void)
 {
 	unsigned long flags;
 	int ret;
