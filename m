Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75214FFAB
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgBBWaU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40954 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgBBWaI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so12589190ljo.7;
        Sun, 02 Feb 2020 14:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LEQBc7KTSu78YIgLtGrWKgS6uNh01RCVuGt61iLvic=;
        b=lISbZZnU00bjOcwK6lNgW9KFw92cIfNM3if8VKNZtXucp1xR1p+hyPn8C2qOPRm0ge
         1wrXq8YVv56Lba+CUMLxV5WHKyMOn/xz9TN1Ld7LW3ONV9B9RXtZZOl5DtgVspqQ7HCQ
         IbEmlQDXxu60wz4O5nRctRtfAwxb40oOn0Wpce3pdoBpKwUfDXnAXeqR2yNjyvqaPYFj
         Cu8HOoCOLDccgr45I/EGGOhTjxcqL+KfG7TyxFzEHmYrhCfkxxWibGIIchZm0OLeK3ya
         8e7RPPC9OQQnbJByhMP8FfqZzXEKqCI/46bqJpXBV3FV5NTZ4jF3jihJYtTESVoI0CNs
         B9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LEQBc7KTSu78YIgLtGrWKgS6uNh01RCVuGt61iLvic=;
        b=Osf+9CAA7//32TMc8aVBG3jXDIuAYbLAfVGuugc+Ro+D1Yd/PSYpPP+8SH9DXsD0Le
         aRKR8f6DkxEP4cnfQ/nwnkZn38RnfS715T6PJmt5ag9jX872PFG0wjw5nvLjOjvwUOlv
         4YfHd4TJ6QFCVCxh97dbqT7dbxFr4f59c7IOrvuDfMWy8aKbjFyGIm8ButPqnqTtz2Xd
         QLySXbyYYQZ9g0k+GWDWhEGkH5F0IvEMQaZwC9U8gYA3T5r+rYW9Fe7FNdblw9wq/vKO
         E7jEYitmKOfZKncYYGKFwa6tJDicC9AfdZYrtdzrt/uKXfphJ25f18PZi2lHAtRP3m3G
         3qYw==
X-Gm-Message-State: APjAAAU1QPzRj19MRmqjQANlfXP2vk2arq6d3R0mJAMDJB46ppJHQifc
        rySYBm4r6AbmqXzh+MvAJJE=
X-Google-Smtp-Source: APXvYqymT/4UFwSeWHKrSiy8uEFhmCxBIB0KVVlaYQ/aIjzvXG3nCjdIm9QuR7NkHZLCmR4mUy5neg==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr12363549ljg.108.1580682606502;
        Sun, 02 Feb 2020 14:30:06 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:30:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 19/19] dmaengine: tegra-apb: Support COMPILE_TEST
Date:   Mon,  3 Feb 2020 01:28:54 +0300
Message-Id: <20200202222854.18409-20-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is nothing arch-specific in the driver's code, so let's enable
compile-testing for the driver.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 98daf3aafdcc..7fc725d928b2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -617,7 +617,7 @@ config TXX9_DMAC
 
 config TEGRA20_APB_DMA
 	tristate "NVIDIA Tegra20 APB DMA support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support for the NVIDIA Tegra20 APB DMA controller driver. The
-- 
2.24.0

