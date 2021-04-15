Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F083607FB
	for <lists+dmaengine@lfdr.de>; Thu, 15 Apr 2021 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhDOLHU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 07:07:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43972 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbhDOLHU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Apr 2021 07:07:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lWzpm-0004Eh-8H; Thu, 15 Apr 2021 11:06:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix potential null dereference on pointer status
Date:   Thu, 15 Apr 2021 12:06:54 +0100
Message-Id: <20210415110654.1941580-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are calls to idxd_cmd_exec that pass a null status pointer however
a recent commit has added an assignment to *status that can end up
with a null pointer dereference.  The function expects a null status
pointer sometimes as there is a later assignment to *status where
status is first null checked.  Fix the issue by null checking status
before making the assignment.

Addresses-Coverity: ("Explicit null dereferenced")
Fixes: 89e3becd8f82 ("dmaengine: idxd: check device state before issue command")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/idxd/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 31c819544a22..78d2dc5e9bd8 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -451,7 +451,8 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 
 	if (idxd_device_is_halted(idxd)) {
 		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
-		*status = IDXD_CMDSTS_HW_ERR;
+		if (status)
+			*status = IDXD_CMDSTS_HW_ERR;
 		return;
 	}
 
-- 
2.30.2

