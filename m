Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BCA14FFA3
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBBWaJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34087 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgBBWaH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so8393221lfc.1;
        Sun, 02 Feb 2020 14:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VT2b3DIhkLrsXocDLVqwdbb9fFwHJxhRiEwuiWhammQ=;
        b=K0zzG3aa421/UtbmrOpJpNK+eddVN3a0ZR/9nRkZdTimhbXdf0vaUu3Ex+SustzPOh
         isVYug7s5uqHG6P8MIkQ401vMbAhoVSTJFX29nXNOM2TsuWLiB/xRe7PuvtebYf981jK
         6kDB2AEpszmYmr3VTxmYVSm7xPsxHwNpHfM6wKmy2Ib9yoRAGsK216qYvFgMgJHX+mTU
         nY4m60FHOlIXvz32aQswO4O56/eqxN/n39edH3lF5uutXkEOFVjKRolxCIiI8EKAk6NM
         iJJkXmQel7qMNX/vcxSvcm2wQbhhkErc7abwXpZPwSiLcTm8rYgY0VCcklW6zG8R4ntu
         qSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT2b3DIhkLrsXocDLVqwdbb9fFwHJxhRiEwuiWhammQ=;
        b=DVNy2balxpHIRHe0hEyLAC0T27EcwNL64mX43xr9a8OYcYsIiMm6+JDB9/hG4MGJqj
         s6ONS8wsmzGn3iz6OPj9tePntFX7WnjE86u340oDv0dei0XWvfM/j6Lc8TFMAbFWATnS
         ExtcunTeHa7mKjCCcRN9xgqKYmSq4TDYW+sPkZLSazKAIYcpbMdGK+Ko2M4sfzEgnqjO
         vIM/+x5lQYhAJREeoug/uEqcIDMnkyEP5iASaWwwhqtBFfRYA8bFiicjxtucnfSG40Tp
         4dwtg9dCz9krw7ywQznHSlyXYZebaGmfk4kbNCJx5t3oNNywVSaXkUHboYW3hS1MtzHJ
         fL3g==
X-Gm-Message-State: APjAAAX5frKqLpL+HJvzSgPPGRfxCWWL/zC5kMuMlzLETkxYPMH69c/d
        G3qOArZRUzOXT0/D0ts/P2Q=
X-Google-Smtp-Source: APXvYqxAfIHx2B1haLicEwi0YNfXLAV9LnEc/kK1ZzjxoNANQ1EkaR5rqgONny/GLxpvUVpk7NSUDg==
X-Received: by 2002:a19:5f05:: with SMTP id t5mr10655378lfb.149.1580682604787;
        Sun, 02 Feb 2020 14:30:04 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:30:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 17/19] dmaengine: tegra-apb: Allow to compile as a loadable kernel module
Date:   Mon,  3 Feb 2020 01:28:52 +0300
Message-Id: <20200202222854.18409-18-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
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
index 5142da401db3..98daf3aafdcc 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -616,7 +616,7 @@ config TXX9_DMAC
 	  integrated in chips such as the Toshiba TX4927/38/39.
 
 config TEGRA20_APB_DMA
-	bool "NVIDIA Tegra20 APB DMA support"
+	tristate "NVIDIA Tegra20 APB DMA support"
 	depends on ARCH_TEGRA
 	select DMA_ENGINE
 	help
-- 
2.24.0

