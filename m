Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF59A14746E
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgAWXLD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:11:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53268 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbgAWXLC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:11:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so4371364wmc.3;
        Thu, 23 Jan 2020 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pEfxv5F227uxTmA12bCuYEhDZgC2pnQDO7/dlyP837c=;
        b=vM1CawSycwRtXeau556BXaDTNQ8OGUpN8c86vrQDEP2xpw/5VTEtfQLN95dXxUiANH
         JlZ0XNF9hI+UYkUC2kcHq5AYQT2p2FywWL2VyOq8NDXxsj+eGI89F0KA24ukogLzo8F8
         C+bqolttYQOjoGMRc+vKWgsON/YvCIM/+Sfk9b4kr0tzkVW/UMqX/iEhhQLJ3r45UaHd
         kBhiQI2lv+Vu3ozM6+nKeapQTeZeIo8/iiVFXNJZf6o90T0g7Hj1CZ1RdCbiDeD5bYt1
         GJrb+/rjnShPFS/I6b64vRUgDmpgNki5i/vmysAXXUJekhHEjXh+W5nsoklNhtwPLdNe
         FFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pEfxv5F227uxTmA12bCuYEhDZgC2pnQDO7/dlyP837c=;
        b=QJa+maFiPbDTTO41U3c8hrQ6IyLrMc2oF29lV/Nqes+1OTnZaxZ6Bfdb1+OkpDDDmy
         kosNvbXs5/uJJJ0oAoqv/IUZyyk71LStU8RI5V4bxRarCi0ca5/yuVSXL9aUb+feb0Yv
         OO4fvlU8rLLsoXx2VO15Sm0YytLJuew+NDfNRDjFZMDqtqIs+2OM5H7yJVKG47jc4kmZ
         P1jCux1eGln6fQ7Ptfq8zZfm3eJNBmOHtxe99OQYU/y6aoD8P06z5QqNZvAivhTPFthB
         4xUZKBgjSwwvVg02QkrJHnD5aSPDzFXoueLNr9qDDfJ5ZNfaNfA/xYtiEAvHlzIgImcs
         f9uw==
X-Gm-Message-State: APjAAAU1ebyWl6UqubKPfHz0MbxlCrCEZ6+Q9yOShzaur/Od3N5cEj88
        D9A7FgdPiUQyHJ3rJMV5/lw=
X-Google-Smtp-Source: APXvYqzJb91qU53DHz2FkvqpCsJEamUD9/WrHBIKKy9BNJZsqb5Xi7ozeuKH9O8uo7tKXg07foLenQ==
X-Received: by 2002:a1c:1b42:: with SMTP id b63mr292378wmb.16.1579821060389;
        Thu, 23 Jan 2020 15:11:00 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:59 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/14] dmaengine: tegra-apb: Allow to compile as a loadable kernel module
Date:   Fri, 24 Jan 2020 02:03:24 +0300
Message-Id: <20200123230325.3037-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver's removal was fixed by a recent commit and module load/unload
is working well now, tested on Tegra30.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 312a6cc36c78..d765db9b7b21 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -595,7 +595,7 @@ config TXX9_DMAC
 	  integrated in chips such as the Toshiba TX4927/38/39.
 
 config TEGRA20_APB_DMA
-	bool "NVIDIA Tegra20 APB DMA support"
+	tristate "NVIDIA Tegra20 APB DMA support"
 	depends on ARCH_TEGRA
 	select DMA_ENGINE
 	help
-- 
2.24.0

