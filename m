Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1093E75BFDA
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 09:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGUHgH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGUHf5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 03:35:57 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F663588
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 00:35:50 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6hDf3WP8zBRDtT
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 15:35:46 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689924946; x=1692516947; bh=ghmjDEgtqSRRrbuHI35x1NA5O8r
        aUUrCSsPuWid/CrM=; b=OBDKR9/3guE/3AvYaX7be3eVrexxmVW/fy1fOEvKaxf
        Cmlb5oDCMaWgK0MCWAsjVO5a1yyfap9uIaXluG/HYOYNJ9sV/8PWNXK/5HQdc0Hu
        O5lN8xD3RtioXQbra5QR+GlflzmuHpT3du7wamZVm2uiYnAiGXaBOCXXV5AAT0MY
        8VjvRF3QvmzTyvVfoAnffGsiUqEtdumKu4s2uCWSHQUEYi7dSE5TG8ai4vgfcZbq
        t1xbOHWHGV+KPpdzw67XSpS9JoLL8ak8bPH0BlNQVkzYlF0wm5KDvYig1gP9KIm1
        A/CEaMed0YfYFpICYNTCRYpWs+ItdWo0JZ0a1TnrWZA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 08Gr9juXMkb9 for <dmaengine@vger.kernel.org>;
        Fri, 21 Jul 2023 15:35:46 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6hDf1184zBRDt0;
        Fri, 21 Jul 2023 15:35:46 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 07:35:46 +0000
From:   sunran001@208suo.com
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: No need to clear memory after a
 dma_alloc_coherent() call
In-Reply-To: <20230721073440.5402-1-xujianghui@cdjrlc.com>
References: <20230721073440.5402-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <0bd20a5f09b3419e1d4d8c2b6786e886@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dma_alloc_coherent() already clear the allocated memory, there is no 
need
to explicitly call memset().

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/dma/idxd/device.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 7c74bc60f582..72330876d40a 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -792,7 +792,6 @@ static int idxd_device_evl_setup(struct idxd_device 
*idxd)
  	evl->log_size = size;
  	evl->bmap = bmap;

-	memset(&evlcfg, 0, sizeof(evlcfg));
  	evlcfg.bits[0] = dma_addr & GENMASK(63, 12);
  	evlcfg.size = evl->size;
