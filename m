Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446DA31D345
	for <lists+dmaengine@lfdr.de>; Wed, 17 Feb 2021 01:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBQAOx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Feb 2021 19:14:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:5423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhBQAOg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:36 -0500
IronPort-SDR: +GgmclksLsWa66QlgloLkzR7Ly1uGdIs5P8Or57BE/QGgVL7tlNvtJ6oFPbgsvf8nuLjQenTyO
 3uY6FqXu4hhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="179551229"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="179551229"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 16:13:53 -0800
IronPort-SDR: ruci5gFoBqykUi3stcpY0xjmjKzL3il1sbCL6HHr2Pdf+Qy/BC3zmue6Jc5aj2RJEtNOXB9QAN
 0TKcU7L7FY8w==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="399728535"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 16:13:48 -0800
Subject: [PATCH] dmaengine: idxd: Fix clobbering of SWERR overflow bit on
 writeback
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 16 Feb 2021 17:13:42 -0700
Message-ID: <161352082229.3511254.1002151220537623503.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Current code blindly writes over the SWERR and the OVERFLOW bits. Write
back the bits actually read instead so the driver avoids clobbering the
OVERFLOW bit that comes after the register is read.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index a60ca11a5784..f1463fc58112 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -124,7 +124,9 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 		for (i = 0; i < 4; i++)
 			idxd->sw_err.bits[i] = ioread64(idxd->reg_base +
 					IDXD_SWERR_OFFSET + i * sizeof(u64));
-		iowrite64(IDXD_SWERR_ACK, idxd->reg_base + IDXD_SWERR_OFFSET);
+
+		iowrite64(idxd->sw_err.bits[0] & IDXD_SWERR_ACK,
+			  idxd->reg_base + IDXD_SWERR_OFFSET);
 
 		if (idxd->sw_err.valid && idxd->sw_err.wq_idx_valid) {
 			int id = idxd->sw_err.wq_idx;


