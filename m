Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2766B30DBB9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhBCNsk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 08:48:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37455 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhBCNrl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 08:47:41 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l7IUe-0008KI-Ao; Wed, 03 Feb 2021 13:46:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: dw-axi-dmac: remove redundant null check on desc
Date:   Wed,  3 Feb 2021 13:46:52 +0000
Message-Id: <20210203134652.22618-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer desc is being null checked twice, the second null check
is redundant because desc has not been re-assigned between the
checks. Remove the redundant second null check on desc.

Addresses-Coverity: ("Logically dead code")
Fixes: ef6fb2d6f1ab ("dmaengine: dw-axi-dmac: simplify descriptor management")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index ac3d81b72a15..d9e4ac3edb4e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -919,10 +919,6 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 		num++;
 	}
 
-	/* Total len of src/dest sg == 0, so no descriptor were allocated */
-	if (unlikely(!desc))
-		return NULL;
-
 	/* Set end-of-link to the last link descriptor of list */
 	set_desc_last(&desc->hw_desc[num - 1]);
 	/* Managed transfer list */
-- 
2.29.2

