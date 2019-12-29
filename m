Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9F12C2F0
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfL2O5F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:57:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46664 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfL2O44 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so28649533ljc.13;
        Sun, 29 Dec 2019 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hLaeTkiGQpndBzsnntj+Kt92MOlWlIIs3RhP31I+1g=;
        b=Eh1dRrvxz8kK/TglzuPUhe0Y74P+h1G/MBTgM4Y9ELYCdHjeP9o9M52N07MeZhT3ed
         LxwVthtF+jFIBKReehE1dwYVvei3L7oZWr9nVgdkVWvh/w6jExokYiYBqycnTMOeI14b
         VA1QMnzHGON895VsOakCjJZUsbAS3URbnUFzimVBlQrewCaYD9fAm1lOwV4LzSwdqymm
         0tyth4+0SpOYah3G29IH8vqH2xi2w5MV1yIjn+TTKI6mYkFMe3iShnYg6YgBjFZeyYuK
         E7sRPc5bAyUbIRGnBjfZ9bCi1EjZIBO7b/6Kgc6nVR4cYAy9h/MidW5CLFzde01xKINY
         9cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hLaeTkiGQpndBzsnntj+Kt92MOlWlIIs3RhP31I+1g=;
        b=Fs2Q7Mb7EDoN9LJdjsdQBVRvd6wgzRPBkd/MUyWj6h/psi7ETiiHSOsSFhy4exEcyY
         yDLcWqs+ZqGv6Xdy2jZmOOInxjg5ZJto+qaaNH5bb9ZeyoB8aof+xoz5w5juFy6sPe0X
         nuU9kZugHBT22Jwi5y6K3ex7w1OLl7doZ6fcJ/xIKzt/HIJ7VZi1uA9Ve3Eu/4T3lph+
         UqpkkpafbCyJBzjvHYPD/Ex3nVN/WZ58cH2XK/1V58HIXquLUrTz6tZ8RNVYaR5YMiXk
         qkJA/aYc+FNVfxfHshqaBuubm8kU6lxs9dNV/uBVR1N4N14aVn3hPVST54p/8rA/woii
         kuSA==
X-Gm-Message-State: APjAAAWzP2Q5u6PpCrjZACxLtQmqjadI1cuBmkvGWB+oft5DepThSdiQ
        KCDxBeKwDbajbCS14TRncoY=
X-Google-Smtp-Source: APXvYqwV1kO6kX2KfXMDwGhOFM0j75VPLE/+4fgGg4Xx/thE3781NtkX836LcPQrpXEj6CQH9lzGXQ==
X-Received: by 2002:a2e:7005:: with SMTP id l5mr35617973ljc.230.1577631414283;
        Sun, 29 Dec 2019 06:56:54 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:53 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] dmaengine: tegra-apb: Allow to compile as a loadable kernel module
Date:   Sun, 29 Dec 2019 17:55:24 +0300
Message-Id: <20191229145525.533-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver's removal was fixed by a recent commit and module load/unload
is working well now, tested on Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6fa1eba9d477..9f43e2cae8b4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -586,7 +586,7 @@ config TXX9_DMAC
 	  integrated in chips such as the Toshiba TX4927/38/39.
 
 config TEGRA20_APB_DMA
-	bool "NVIDIA Tegra20 APB DMA support"
+	tristate "NVIDIA Tegra20 APB DMA support"
 	depends on ARCH_TEGRA
 	select DMA_ENGINE
 	help
-- 
2.24.0

