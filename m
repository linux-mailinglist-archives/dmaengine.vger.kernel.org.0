Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836CB4882A1
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jan 2022 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiAHIxn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 8 Jan 2022 03:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAHIxn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 8 Jan 2022 03:53:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD7C061574;
        Sat,  8 Jan 2022 00:53:43 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id oa15so6401953pjb.4;
        Sat, 08 Jan 2022 00:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7kXCs28W66sTjdWSN/kGCXx/YzaMyVz/KostDbMYDNo=;
        b=XYUtRnSqZLyCfMJsjZiPZ6h/tM6wDNm3I9gT0fv2sqsgH+HHPZS83umFpLfZcbkZA6
         YtBJInOUEnA9DtoRjmHquuxagajzQT97tqjhwPiJvWaOuRVOIDF6t+0c9aRxLr9ofA6e
         +RvNPW6lDhE+/Cj0eC1X2R857mHky757FYqJGlizehwvgNdRG0jTzbNeBOZpLwnVBaEs
         clDEN4YXe3ULyy5kQEq1q4lUeeeaHKysiMbLuH8XK567CFvyq6oIal2zRKmeKH3xlUHb
         hUkmru9s0pH0grqTZ8nDUV7+JvDsRrMJreX4CM4zEPFY0tEcEheoInx0xPu8p5s+LRjq
         go0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7kXCs28W66sTjdWSN/kGCXx/YzaMyVz/KostDbMYDNo=;
        b=658qEP2tMhTP/emXrLpOkLi+7Rkrh3mICiRomCdP8/3mFAj0RvkFr98KIM4Gw2M/wD
         jZza3UWJzI86OiA99jZrdgD3EYxcdkPnUcKSk7q5mnwbr/FlINEtzvyxb5/KHjvQvdz1
         H34m8zKZLEjFePYOjQvRhgJ+70ZHnidr8d3dPRJlmHkubShMwCbGYiwvOUENlBGSPxNR
         mAzT/JIZGZW48umgkhv2+Jd6vFfGzeKY8+ziFW+g4MMfHAWNvNNF1F5z4lz89LW1Ub5/
         npjOXz/PiLQ06PgnMP3COXXfQzZny7PJJXYGUPr14rVw//foOQ0sNGMDTASHaF557XY5
         RlyA==
X-Gm-Message-State: AOAM533s+zq57Cg70jXSc/moB31axvhvNfwfz7+KCoqiyXEBahl//8n5
        3gcLPon0AtlMrRQPXMQiH7U=
X-Google-Smtp-Source: ABdhPJxRGudJlEubQRa6AT+BqCt57yVyLI5cKLsapEtYJ/lqs2rRTAfk7sN5HbiEu0UTf+5GGsAlTA==
X-Received: by 2002:a17:902:a505:b0:149:b646:a173 with SMTP id s5-20020a170902a50500b00149b646a173mr29701788plq.64.1641632022784;
        Sat, 08 Jan 2022 00:53:42 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ot7sm1427048pjb.12.2022.01.08.00.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 00:53:42 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: stm32-dmamux: Fix PM disable depth imbalance in stm32_dmamux_probe
Date:   Sat,  8 Jan 2022 08:53:36 +0000
Message-Id: <20220108085336.11992-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 4f3ceca254e0 ("dmaengine: stm32-dmamux: Add PM Runtime support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/stm32-dmamux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index a42164389ebc..d5d55732adba 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -292,10 +292,12 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	ret = of_dma_router_register(node, stm32_dmamux_route_allocate,
 				     &stm32_dmamux->dmarouter);
 	if (ret)
-		goto err_clk;
+		goto pm_disable;
 
 	return 0;
 
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
 err_clk:
 	clk_disable_unprepare(stm32_dmamux->clk);
 
-- 
2.17.1

