Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE010156B90
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBIQmH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:42:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33773 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgBIQle (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so2509999lfl.0;
        Sun, 09 Feb 2020 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YE/6SujoMtBQw5TsOKXfnXfn8cgsnxZly1At/7rxoI4=;
        b=ADlI5Na6gupA/UpBx2k+d7B302t9PyaC/lsfEmhItFMntja7O5AFzIBDBf5ATZSOnf
         Mlkx834Mq5AT6F9O9b5WYVIHPIErsNqYheKCTQDVby7f0W1GLI3KlD6E7e+gaN13ACOS
         cBf9+XJMDOMf1V68+G9lvoAuU/CUttNWt5B/MPJYa9z1BcUTchFTRAjIT6fLNFyYkYls
         TBm+VfuCX4mpr909knwI3vGc3B8j3zE3tfYbYYFIWokwUTZa9Yejw7oN/1vmQk9X2n+y
         lSMejoXv9Uw/pahPaYQ9nCZp4PzDfxfxdYvS4vFRvvZvIqEep3QTWit4PaKPOHhKz88O
         VKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YE/6SujoMtBQw5TsOKXfnXfn8cgsnxZly1At/7rxoI4=;
        b=BUugV930K8YYBfb+nGr7M48VXHwHGf4h13ce90veAlTvNaQqyNaBL8W/yqe74aivYl
         /JXceVxTAJokvYnjK4E/wIlwLhHwTVn059iB+aZwy7NSVESHIx6oMtXOrbo11+aKw7ay
         V9yhifxGP7tXW+1/lnWHfMQ3Sl+4EMS4spsDNmIwPd8c6T/U4VI00g41kye6pB02ATwR
         Hwy9WwaYddhNaBp146xVG8xBd1chH26kKmWYq4tsoYBpokgXrH+5HG5/nlkBkuMerBZT
         ZWP3auABGNHHLOVFAt3G9dkhhSaeE1WrCvmVKOojyISgk27G9qX11ePpIYk7foQkvvOy
         bHxA==
X-Gm-Message-State: APjAAAUVXjI9znv7AClV8PZG9eOIQgySSwDdYhJkFouDJ8GEIYVCAwMU
        XqyiCr4rGhvJhPQF8T7V/chqI/t0
X-Google-Smtp-Source: APXvYqzPvHTJkoAAwyDktVU7O+YdtdOSF67IUeLGRXXQSLl6Fa5UeKVw7BnBSZUNss76O4UvOgRv5A==
X-Received: by 2002:a19:94d:: with SMTP id 74mr4051068lfj.144.1581266492275;
        Sun, 09 Feb 2020 08:41:32 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 16/19] dmaengine: tegra-apb: Remove MODULE_ALIAS
Date:   Sun,  9 Feb 2020 19:33:53 +0300
Message-Id: <20200209163356.6439-17-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra APB DMA driver is an Open Firmware driver, so it uses OF alias
naming scheme which overrides MODULE_ALIAS, meaning that MODULE_ALIAS
does nothing and could be removed safely.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 370c3f2d68a5..7b9d59bbd2c1 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1666,7 +1666,6 @@ static struct platform_driver tegra_dmac_driver = {
 
 module_platform_driver(tegra_dmac_driver);
 
-MODULE_ALIAS("platform:tegra20-apbdma");
 MODULE_DESCRIPTION("NVIDIA Tegra APB DMA Controller driver");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

