Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F6E2954
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2019 06:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfJXERB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Oct 2019 00:17:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36378 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJXERB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Oct 2019 00:17:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so13423947pgk.3;
        Wed, 23 Oct 2019 21:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rVoSkEoiW0A02D0b61rQ73aC77BYCFQlHEVry3ikvFc=;
        b=g+n1iyfw+Cj4Ge3KENXHS8LUtclvNu9BYcMuS+trEG/Mf7o5IiYpjVr1S9FMRaYuV6
         4SgJ4BdScwFK/uOytJ1/1kws+kg6WrVFt3Gp3yZEoEnh98XFlr23+eLVBQ7dH4G2iyWJ
         bBb1HUCcBtE4E7qOhY5bJjdwlIxA/E03uPI00nciG1EB+/mUDVh97VKz9BVI1+CGjJbE
         VdiscP5Ml+em9K2O6GuEv3trXMSurC+DnzUlhgz9I4NZ2u9sZezGL7Fxaat1QHsLEwyl
         tnnzPXr+i+k1gljr1papZ/T5YcKyT/JFtiAOOAkvtlT/NXJJH2/lDM1ZFqigHYh9G2QJ
         RjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rVoSkEoiW0A02D0b61rQ73aC77BYCFQlHEVry3ikvFc=;
        b=Sgw+0u7lhDiJwFPkgj0BHCcSTf+6s1Ajq+mad7Y1KsPw2p4f+szawuHLZ682ClOGj0
         yfyuXU6sQ6UJximivNM218y58zMNLXCMPQf7Ft9Aq5c6XiSTObWYUrvX42uVIclw8rv0
         FovtcPyaAtiHZ8IuM2wrj5dG9gEtsKaymUy8bXdKGJ3Hmy+paKS5xKwfLDqsAbh0rgVa
         ec6HrTU/GJAzfUVaFWHj91RFsZbBZKUKJ3oWcRqkOZp/iIkRqNK4czYzJpoqBadDDiWo
         xYXLZiznPi4S/yfs7j5RDab5l6FnDQ0jNjhPL8sKZZzt0Gygldck0c7AhB/Rrcw0BWp0
         YMOg==
X-Gm-Message-State: APjAAAWFaNHTWxsbDzfWwIec54G5B72rXoyvpyXotrv7ksfQVOeDZwbj
        dEi/CLUWkT5sBa0YZVxFD0c=
X-Google-Smtp-Source: APXvYqzcoRUdWKivEoF/gsoSPH7gGle3fBIKK1M80qJyLyEdwxYJmcOa9W2CV8Kj4vka6PZlgkF56w==
X-Received: by 2002:a63:4e13:: with SMTP id c19mr7366884pgb.225.1571890618395;
        Wed, 23 Oct 2019 21:16:58 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.60])
        by smtp.gmail.com with ESMTPSA id d69sm27351979pfd.175.2019.10.23.21.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 21:16:57 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Satendra Singh Thakur <sst2005@gmail.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma/zx/remove: Removed dmam_pool_destroy from remove method
Date:   Thu, 24 Oct 2019 09:46:23 +0530
Message-Id: <20191024041623.24658-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the probe method dmam_pool_create is used. Therefore, there is no
need to explicitly call dmam_pool_destroy in remove method as this
will be automatically taken care by devres

Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 drivers/dma/zx_dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 9f4436f7c914..7e4e457ac6d5 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -894,7 +894,6 @@ static int zx_dma_remove(struct platform_device *op)
 		list_del(&c->vc.chan.device_node);
 	}
 	clk_disable_unprepare(d->clk);
-	dmam_pool_destroy(d->pool);
 
 	return 0;
 }
-- 
2.17.1

