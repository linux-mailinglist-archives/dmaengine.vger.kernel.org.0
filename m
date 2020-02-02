Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9567114FFBC
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgBBWam (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38682 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBBWaA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so8363318lfm.5;
        Sun, 02 Feb 2020 14:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVyPwwbkLVlQVChdUAgWIuplnsUu4TqO1h0F/ALyeGY=;
        b=BT6NBPWDT9XXx3I7JWAbZfF/MldaBwHEh6FrGINT3JMqTn6ZXwosU0S6PU/b7OtLkp
         ILhTaeVxByGOzMRyBhMQe+hSLjZR6clmW0S6RrFnpYId2GzK8fnl3E81MBt55BDsyhDW
         33T55HeiYOJZDBUsz9TD/eJeBrGljTMAE1FC11GGsu1Xc7GY3PKC5sAnvG7NQXSnoX/J
         TRe1JK0o5HnHbICXHENOuOJhSbBBPWXdyS7tLLdMGUsWubLbWagqG9jRiutZvJ2Swyme
         oib3l9Ee9hYGcCiXw3PlvyfrVZmbZZvhU1izAq5JYeA4mr3R4MqFJ1uSXuH9HdH61Agi
         RWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVyPwwbkLVlQVChdUAgWIuplnsUu4TqO1h0F/ALyeGY=;
        b=OdmA9pzWVgrK8UYzj6Yl8rK4MO2e8wxFoEVCd/Egn2JBYAJU38mlSG4mt3HdTCLs3f
         F4PzjSVujt5in0kFY2j+VhMD5CFdCRjvXYVEmM272OoEv2AJ6JOLswPx+8E/xZMZS4/0
         lqRK7i3ZCVIDT2dA02Sj4ypEBQUrJFDpbWKyF9n5+cROgvsdzi/lLMm8DsbCz0leNR3y
         UBCTp4RT6ilPW46iCs80oyMKQiEryN2jUWbpDSHteaVWkIDUV2rm1oTg8fxj6SoyV6Sf
         iYQZJUX+K9c3wfNJSJhlMBJAjFGpAMCr4YdHMzaqqHOsA8LZ7HqJIA4usIlnFGRV1T++
         TtSg==
X-Gm-Message-State: APjAAAVQT7Og2MyvJDLt81ium1UZ5xPx7darc6CsOWcGNGhdqbAqz31i
        PSJlxcNqOVGGLqtNKs7FveQ=
X-Google-Smtp-Source: APXvYqyhjv6RYvQnsapfrQLG6Ipzr1HVKlrPEc1HWgpwwUac17cMcdoS8yF/RHoYDHcw7mTWsoA+PA==
X-Received: by 2002:a19:c307:: with SMTP id t7mr10545318lff.166.1580682597227;
        Sun, 02 Feb 2020 14:29:57 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/19] dmaengine: tegra-apb: Remove unneeded initialization of tdc->config_init
Date:   Mon,  3 Feb 2020 01:28:44 +0300
Message-Id: <20200202222854.18409-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to re-initialize the already initialized variables.
The tdc->config_init=false after driver's probe and after channel's
freeing, so there is no need to re-initialize it on the channel's
allocation.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index b4535b3a07ce..7158bd3145c4 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1284,7 +1284,6 @@ static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
 	int ret;
 
 	dma_cookie_init(&tdc->dma_chan);
-	tdc->config_init = false;
 
 	ret = pm_runtime_get_sync(tdma->dev);
 	if (ret < 0)
-- 
2.24.0

