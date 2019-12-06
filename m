Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3F1150FB
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2019 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLFNYk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Dec 2019 08:24:40 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:43190 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLFNYk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Dec 2019 08:24:40 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id adQd2100T5USYZQ01dQdbe; Fri, 06 Dec 2019 14:24:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1idDb3-0006CQ-QG; Fri, 06 Dec 2019 14:24:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1idDb3-0007ai-Ow; Fri, 06 Dec 2019 14:24:37 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: Remove spaces before TABs
Date:   Fri,  6 Dec 2019 14:24:35 +0100
Message-Id: <20191206132435.29139-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8fcdee1c0cf9559f..dfd2d35b64af822a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -481,7 +481,7 @@ struct dmaengine_unmap_data {
  * @cookie: tracking cookie for this transaction, set to -EBUSY if
  *	this tx is sitting on a dependency list
  * @flags: flags to augment operation preparation, control completion, and
- * 	communicate status
+ *	communicate status
  * @phys: physical address of the descriptor
  * @chan: target channel for this operation
  * @tx_submit: accept the descriptor, assign ordered cookie and mark the
-- 
2.17.1

