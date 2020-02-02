Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608F414FFC1
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgBBW34 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:29:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33009 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgBBW34 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:29:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so8399886lfl.0;
        Sun, 02 Feb 2020 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfyyd1gAYNfQRVTzzie9M6MUShefAhN4x9LLDsJ6WIA=;
        b=NLHV/wiPfZzmPrjZ1UyodOf2ossRUjX/7bposBEtIXVb6CA0pF8w6INGEI8OcJ07fr
         OARfQNa2FTBLSgWGhTTP4vSuTG9VLOjGIbMruLYJ9R5GMXCeJ+fDYhRaos/0nh8XVLMm
         KIL0Zud/paO0xVGkS+/477OJO4GiUOzpyptVdRQm7ESQgMeb5uzjNndXc2OExGFATXmY
         Y83fwcj74H/0Roiopun2TvvYV4juWdnjxN/rU78V/GE8YK76+wLoQbSsog936sY721VO
         srbKk1PgeLZixc9RT0EvdbP6c5ZeuiIShp/On8rcM2e4zd1M+e6mHB+YOMLyGu9M1XTB
         c55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfyyd1gAYNfQRVTzzie9M6MUShefAhN4x9LLDsJ6WIA=;
        b=YXchHGkO1jMwfyieXbX6Krt1M8lzgaNwLCYDS3X8ABIe9GXxsdnBa8n8OEGI6rq/Hr
         cLY4NE6J++e6p1SOE1QZHEbnLQqfX9mImwl1cgIc8BUfDux7LwaI7rJve4Zq3gAfw1p0
         oadJQd54CB6OHGfpnkv1BUQsZVWx2dRoqxB2vjOqipLXiLb+c9F258W1OfmnOyyLh9w8
         Gbe4xOg4J3e/l0fvDiyjSz6jEm+DyHnB2v2F8TO6iCx+20ihjGXqJgUIK8tQQJ8dB4PL
         tggUIjAuaG0ppzSWy01KXqdkveb/5PFd3IIUnTlojDHCKTuCsAAjgNFCcsPRhXkkI1Xk
         3zMA==
X-Gm-Message-State: APjAAAWSIU6Cc2bXVa7Z3mBUBu7hqWq91kOCWMIzYVE7MuycgJWIDZrk
        uTfn5E18UXMDzqP32mA104s=
X-Google-Smtp-Source: APXvYqz/Kq8S6eLWP0lHLgJKcP5oQESWIj/ZoJu9Ky6H6wxILPV/RTvgQ6kf/894RJRKrsAVKbQgJA==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr10303996lfy.11.1580682594100;
        Sun, 02 Feb 2020 14:29:54 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:53 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/19] dmaengine: tegra-apb: Use devm_platform_ioremap_resource
Date:   Mon,  3 Feb 2020 01:28:41 +0300
Message-Id: <20200202222854.18409-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_platform_ioremap_resource to keep code cleaner a tad.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index aafad50d075e..f44291207928 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1402,8 +1402,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->chip_data = cdata;
 	platform_set_drvdata(pdev, tdma);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tdma->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-- 
2.24.0

