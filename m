Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1D130B58
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jan 2020 02:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgAFBRf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jan 2020 20:17:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37832 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbgAFBRe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jan 2020 20:17:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id o13so37858961ljg.4;
        Sun, 05 Jan 2020 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hLaeTkiGQpndBzsnntj+Kt92MOlWlIIs3RhP31I+1g=;
        b=Xj6U3B6NTZGfvGHJ2926iwr8Kz7oH4NFoWBF2GZw5TNmS+uzOrgHabd00cq8gqhj2k
         cfrtJSD3izXx4Fm8uqeaivhie+Par8uBCDWJOivpwiOb5Ia4n9GMW4RE9y3SM3Pgx6uw
         Pc6gk6iIwo39TE6eKhqjaxRNRI/PPLRH0g+Tj3XYBv5X7xZ0P5+mwR541//UuaYUgjAX
         8luFrZ9z71ayDGw6BSb2cBCKV8RxlSDy99u/OMFPY4M9BydZubeH6MN1ZcpQ92g9KV/R
         P9q7AYU9JwysOfI20MlyraJTNJOt0h7/Hq+gGecBYoM7t7TyNYFmh/bR8xl9rD1lrai+
         6rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hLaeTkiGQpndBzsnntj+Kt92MOlWlIIs3RhP31I+1g=;
        b=r66OCAvQKEZlHpHnGPfKYUD1AZyZN1eQ0yqWZiLZ+QeR04oooAyoJTsZYkyw9NAZjU
         5mpMMcWfG2FWQHC1j5NywSiWxcnunFH8fNSQRFMUdFX5rqftr2hxnDfBbY1oS6glA9Mi
         Uw2/bHrtaYppPBL/zDgj7rBtvxqsq6diKHHJvPjUN8W/jQ7fX3Eb/xsEyJs4vR2rCCDE
         RRgBNsmaEcWxIvA59JaDqfE/xp5CRgHnUP61ozhAWp24qWpC1G/159/HsE1J7rd+/yKB
         xhSGcaBdfIiY19dSDn5WLpeGD1nmOe8kR+zG65eAvE3hcx6rBPXK7RwS3kLsbq6qRx2U
         vhVQ==
X-Gm-Message-State: APjAAAV3hJnQr4yZ3IBthQ2X3dlKGB8u1sRa6Rb3s2ndEmXjSwfiKHQ1
        8NML+5Pr91bC6BENMMzfGM9T7kuy
X-Google-Smtp-Source: APXvYqytlJ3Wis1nxErmmc82w/Yxm2zsqQgOLOra4E4Cwq37TLMppKN1NChShh128XAJOE0vxcPDKQ==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr56113438ljh.42.1578273451995;
        Sun, 05 Jan 2020 17:17:31 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] dmaengine: tegra-apb: Allow to compile as a loadable kernel module
Date:   Mon,  6 Jan 2020 04:17:07 +0300
Message-Id: <20200106011708.7463-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
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

