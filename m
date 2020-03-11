Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92196181191
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 08:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgCKHQK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 03:16:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:37550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHQK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 03:16:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C302AF4E;
        Wed, 11 Mar 2020 07:16:08 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: ppc4xx: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:16:06 +0100
Message-Id: <20200311071606.4485-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/dma/ppc4xx/adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index fbabd2e88a18..4db000d5f01c 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4303,7 +4303,7 @@ static ssize_t devices_show(struct device_driver *dev, char *buf)
 	for (i = 0; i < PPC440SPE_ADMA_ENGINES_NUM; i++) {
 		if (ppc440spe_adma_devices[i] == -1)
 			continue;
-		size += snprintf(buf + size, PAGE_SIZE - size,
+		size += scnprintf(buf + size, PAGE_SIZE - size,
 				 "PPC440SP(E)-ADMA.%d: %s\n", i,
 				 ppc_adma_errors[ppc440spe_adma_devices[i]]);
 	}
-- 
2.16.4

