Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24F221686F
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 10:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgGGIgW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 04:36:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60505 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgGGIgW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 04:36:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jsj5M-0003IS-SP; Tue, 07 Jul 2020 08:36:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Leonid Ravich <Leonid.Ravich@emc.com>,
        dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: ioat: fix spelling mistake "idel" -> "idle"
Date:   Tue,  7 Jul 2020 09:36:16 +0100
Message-Id: <20200707083616.573910-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the module parameter description for
idle_timeout. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/ioat/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index fd782aee02d9..863e2ddba75b 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -33,7 +33,7 @@ MODULE_PARM_DESC(completion_timeout,
 int idle_timeout = 2000;
 module_param(idle_timeout, int, 0644);
 MODULE_PARM_DESC(idle_timeout,
-		"set ioat idel timeout [msec] (default 2000 [msec])");
+		"set ioat idle timeout [msec] (default 2000 [msec])");
 
 #define IDLE_TIMEOUT msecs_to_jiffies(idle_timeout)
 #define COMPLETION_TIMEOUT msecs_to_jiffies(completion_timeout)
-- 
2.27.0

