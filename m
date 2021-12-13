Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC7947205E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhLMFV7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhLMFV7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:21:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716BC06173F;
        Sun, 12 Dec 2021 21:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A550FB80DA9;
        Mon, 13 Dec 2021 05:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4D7C00446;
        Mon, 13 Dec 2021 05:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639372916;
        bh=4s3RUAH5E2QnR7ThNfpf83V3GwFtlQv3STlNvfQ3E/c=;
        h=From:To:Cc:Subject:Date:From;
        b=eaJzQaqTGAAMQrJbhPE+nJdZUt/sTKENukVLD49R6DuBqTtPAj54hucK5R8FyRN4b
         tdZlmNQNwcNhMZHgQFX6x5Bn9tmhwFvXIeiH/xrOGg7pBHw1Lp58YtRTlaS0C79WHg
         rFEa7w82x9DQR+4D0/dXRq82nxmCDSb5YAufdQLKlwcy0qwMletOcDaORK6b4UsjwC
         Lm4pqOC2ngfGMxAw69IjcJSgzdjkbSVTzRMYMBgk6sMMvpi6R/B/7IeKwt0RGlIo7p
         zGNiJU0K7lOus2DWmHGbJdpVeZTDX4Of4UnUOvEcpvvG39LL4g8rEqOAPf0p2T2Lwz
         XsW7J6beamKPA==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: xilinx_dpdma: use correct SDPX tag for header file
Date:   Mon, 13 Dec 2021 10:51:41 +0530
Message-Id: <20211213052141.850807-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit 188c310bdd5d ("dmaengine: xilinx_dpdma: stop using slave_id
field") add the header file with incorrect format for SPDX tag, fix that

WARNING: Improper SPDX comment style for 'include/linux/dma/xilinx_dpdma.h', please use '/*' instead
#1: FILE: include/linux/dma/xilinx_dpdma.h:1:
+// SPDX-License-Identifier: GPL-2.0

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#1: FILE: include/linux/dma/xilinx_dpdma.h:1:
+// SPDX-License-Identifier: GPL-2.0

Fixes: 188c310bdd5d ("dmaengine: xilinx_dpdma: stop using slave_id field")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/dma/xilinx_dpdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma/xilinx_dpdma.h b/include/linux/dma/xilinx_dpdma.h
index 83a1377f03f8..02a4adf8921b 100644
--- a/include/linux/dma/xilinx_dpdma.h
+++ b/include/linux/dma/xilinx_dpdma.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_DMA_XILINX_DPDMA_H
 #define __LINUX_DMA_XILINX_DPDMA_H
 
-- 
2.31.1

