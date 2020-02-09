Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BAB156B89
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBIQl7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32780 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgBIQlf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so4439613lji.0;
        Sun, 09 Feb 2020 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LEQBc7KTSu78YIgLtGrWKgS6uNh01RCVuGt61iLvic=;
        b=k4A3GBkaKt/z/ZylzUsMq4lJ/jHNzeLiDzhmTevZaQocMkfZuO+t2rISvNiVtx4Nri
         uHYD8AMmOAe4phPOqHtgw8dQ2sKzB0Eyx34s1CxKj7PnvFMSop1haFd2uDAg7t0NgB1L
         xfxlZRqu1S1DjcamYzYTeWE79aoCdbJ+ZtZ9i4L3HvGn3mVAht3JbAl/K2I78zhxMf1J
         0Na1yZC2wBDazoCkGvHQE+v6VjvXUgTbSnP/TwMTsrcdMbkijKxGqDKos6QSHpZJS+mp
         /RGtrA5cPI5U/qH9asncCPXHXRQ3NbvIwQOaOFgIyVNaRWCb8RATp4eVz4P8Hg4CHR9e
         7aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LEQBc7KTSu78YIgLtGrWKgS6uNh01RCVuGt61iLvic=;
        b=DrhioxfywjM9UwPbS8K7JggenSHSoRRbET9wzeTLYQjQV9RzRdMT1YmYlVAmhZwNeE
         s6GydS36pekjQ6ourY+WPA3UEMLCA+INwgT9n1CHu4f9V/uaavQY1IvEWIbgXeqe2ylT
         ju4M+kQwVCyOVdQkyK5gyzPCExaEMGui4pOUgEVpfGtS8715TuLypGzcSDQFHHD4pBj9
         1EJ7cXcS6/8BMUeoOFLVDcfdVAeXvXKAvNqZJEVIFSXqK9QLrIUQIc+bGUVRLDIFGxZ8
         /e5sx199hIi4qB9v0HL8Qpyr3JkgsXrL5qo+sW+C7F5vTj26LstRIOKPsr1xIvyVJaf8
         j7Dw==
X-Gm-Message-State: APjAAAW+IuVdIIFMwwMGSKisLa0ufH3VGjWwI/jiNdfiALU2POnmtjAK
        cS+kiJIzOhIUCgLXyIN9Yk8=
X-Google-Smtp-Source: APXvYqxccbVpQt+x2FQxqF4GtAyS5ZURP8TYIFbUBig7J1934sk+0FtlolbUrjN3RE2ZwySZbUgUEQ==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr5593324ljk.245.1581266493232;
        Sun, 09 Feb 2020 08:41:33 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 17/19] dmaengine: tegra-apb: Support COMPILE_TEST
Date:   Sun,  9 Feb 2020 19:33:54 +0300
Message-Id: <20200209163356.6439-18-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
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

