Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380DE3DDED1
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHBR7V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 13:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhHBR7V (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 13:59:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFB8560F36;
        Mon,  2 Aug 2021 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627927151;
        bh=p2bimcFyooMiWfuzIHWPVSMsxEgQ3syfqjsJYTwa74A=;
        h=From:To:Cc:Subject:Date:From;
        b=rqSv6ZzS8Cy6wOzqsZ/uYMR0jdGwsihqbykoYF1QtAK98DMl7i1EJyW4QNWAt7ZRj
         G8QQjRbBROd6vkBUhcysKf1WWkkN6LMGfCtKriy3Tb3a/FQ78u8W4uHlcGCQvdnVcA
         qzKGmj48MDRY4Bs7jRy/js+rtZbCMamv6EQTsybHG1WSG3exz5zYGiiAtBs6skBOHK
         TGtQ2HEy3ZKwOPfmNd6QAQs98IIHsZ/ZoRJIXXydnDnu1p2lA6i/ziose3fS6CotGh
         QibgYeam0dq86HIv8LsGzPPzOx7Isy8VO6YgigGcxQ8vVazRGc0V/NDIAgU6AkUc2g
         mLTUQOsTIuudQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] dmaengine: idxd: Remove unused status variable in irq_process_work_list()
Date:   Mon,  2 Aug 2021 10:58:20 -0700
Message-Id: <20210802175820.3153920-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.264.g75ae10bc75
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

status is no longer used within this block:

drivers/dma/idxd/irq.c:255:6: warning: unused variable 'status'
[-Wunused-variable]
                u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
                   ^
1 warning generated.

Fixes: b60bb6e2bfc1 ("dmaengine: idxd: fix abort status check")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/dma/idxd/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 65dc7bbb0a13..91e46ca3a0ad 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -252,8 +252,6 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 	spin_unlock_irqrestore(&irq_entry->list_lock, flags);
 
 	list_for_each_entry(desc, &flist, list) {
-		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
-
 		/*
 		 * Check against the original status as ABORT is software defined
 		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.

base-commit: e9c5b0b53ccca81dd0a35c62309e243a57c7959d
-- 
2.32.0.264.g75ae10bc75

