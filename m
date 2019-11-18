Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547BEFFFA4
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 08:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfKRHiN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 02:38:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42318 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfKRHiM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Nov 2019 02:38:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so9950704pfh.9;
        Sun, 17 Nov 2019 23:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIM6IXRnSxbx7vbbSZ24HqMj6ByTjI4AKAea6u3wZSY=;
        b=H7q9s83v1qdkEy2VUJmsAMturo6ZKk11J/dTHKeaf3v6FhlU520xsD12CfcS8b7dVT
         DJiTShyto5IJXqC9v4uZoLNHQHqj8OWgIVjrR0Zu0tPFtYH7X5ah7CDyvL7ATUDkkEwb
         KAzknfNcYKfTQkBwK5VYnYmGDeQ+LLsgY5/uoaC3cv9ZKZN6RIkAj7AQ4uoJeN1ftJ31
         F8q1XcZTl8rbHI7jWGWiMSH9Ha4Yt6VpZ3mejMrHdaRpL7eUsgWxYGMVy4Q06ph0UzvE
         EUkVRFyecbUh2SMHhGOWSYo6cdGSDMiTnwUf09zHwdRG2+gHUjfCnohHQWXjhF6PQW6A
         liqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIM6IXRnSxbx7vbbSZ24HqMj6ByTjI4AKAea6u3wZSY=;
        b=N+wx6WJEmJRVnXvwUZgf1Y7Lk4ubXFv50ro+CTAUd89N/jRPa+MoCqfFPF//bLeDhX
         T3jv5taDT94S6CLyAvyx+GO/oSwkTkaLbvR1LRJoMfMaiV9jboA6S9LThFgqKFtBsTwQ
         eaMJCIsVL5ifYkv9OXfDLVsT61cgxsxtNddoXUO9c+rovzB/u+UOgwiOXgnKuXifKpCU
         WILlfL5jCKrDhXkueV4nNygZy6o6IOMnSaQPYKv8lwjzHirDTHwWfBMriKGLcVTyy0In
         PBe3VE06l0YozNhTvRtIdTzYMpjck1MGqi9IJOJP3QzIBB8WGJkhH1SQDmDXSUwLIQT2
         /dDg==
X-Gm-Message-State: APjAAAWl1rp60jBEipkzEEIIS24qMRB/p8WTxYHwxjidBn7Nn1xwIcje
        APmdjArKWcqNypFMyttb59s=
X-Google-Smtp-Source: APXvYqyLuf7/B7U7H2n7DvK597Wu55o4DpuWiaJQay5ukzRAnuAQ2Kw2UWT4V04eu00gc1JfY6NkCA==
X-Received: by 2002:aa7:8b47:: with SMTP id i7mr33085677pfd.226.1574062692250;
        Sun, 17 Nov 2019 23:38:12 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id f24sm17239479pjp.12.2019.11.17.23.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 23:38:11 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 2/2] dmaengine: ti: edma: fix missed failure handling
Date:   Mon, 18 Nov 2019 15:38:02 +0800
Message-Id: <20191118073802.28424-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When devm_kcalloc fails, it forgets to call edma_free_slot.
Replace direct return with failure handler to fix it.

Fixes: 1be5336bc7ba ("dmaengine: edma: New device tree binding")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/dma/ti/edma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 8be32fd9f762..79bc8503cf32 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2413,8 +2413,10 @@ static int edma_probe(struct platform_device *pdev)
 
 		ecc->tc_list = devm_kcalloc(dev, ecc->num_tc,
 					    sizeof(*ecc->tc_list), GFP_KERNEL);
-		if (!ecc->tc_list)
-			return -ENOMEM;
+		if (!ecc->tc_list) {
+			ret = -ENOMEM;
+			goto err_reg1;
+		}
 
 		for (i = 0;; i++) {
 			ret = of_parse_phandle_with_fixed_args(node, "ti,tptcs",
-- 
2.24.0

