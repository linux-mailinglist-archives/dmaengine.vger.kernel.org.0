Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80087138777
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbgALRcH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:32:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35701 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733188AbgALRbl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so7450041lja.2;
        Sun, 12 Jan 2020 09:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9IXhdptGbj8V+x0JmFieXnr8n7z3VnobTAkrJvX9AgA=;
        b=ann733o969SVKkuM2kLDUJ90Jy/SVYXHWa/x/Lzcbo01xoHXV9NugtFAa88D4la3IJ
         JKPp2+I0K725Abe238DsAseQhJ3tKTee3g4tnHZhwHw2273bkjqr+NfAenxy6Z05agbx
         pw6khn8dM9Xug8qJ1EQjluA5svQxtgMj9ieHOZKDZqBXcQAd0cwkf/iX0Jk915Wx2fGR
         jTU3tXfCbL0+Sha90+ljVHWotmg7V5exRpMXokyEAVVWNESU+Bz0XYqry4uYiU+KKR3X
         I1uUq/aN+4JSma9HMOMkKjRRNo/+ugzypM55H+l/ZopyJpGo0i6cCGdlr3GCB0yS501W
         5J+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9IXhdptGbj8V+x0JmFieXnr8n7z3VnobTAkrJvX9AgA=;
        b=r/gAFZJpsnncVqML4ujljgJpTXqgrSHXbIPcXZEChkyg9YuTGf5GdKEPsUce+tDRmC
         34kQBUSgr2QKy9Ukm2uTL8WdABpjVmnKS+YXGKsPL85lhIwU1l5EEF1ypTZMgZaK2mFe
         4Q2JXBWut+zOgCS8svomnkhDpazjACUIfEZmGsGzZbmt4QyT5Xd6Wq+sUmgg0C/MjhmD
         EPNL4P12fBul4Ll92tBtWs3iJcK+8TFKysWZczdrvis64Hmz/diY6BLDZt3e6p5JTPnn
         zH3Kmo53JFtuGlccgXUBzAT+euoTVFXioRZDsX+uUluPTZGkBaOq7YOJkTZpN7/ON8dP
         PBFg==
X-Gm-Message-State: APjAAAXuLmZgGgqaePk825+1le6Qe0frwVkvIll7LKPuzMZLul5NVGlo
        D5ltpBx0ScE+FtO8mV6jnkmfrlEH
X-Google-Smtp-Source: APXvYqy9vc00AnShkNJiCueI9QV4rvL4IYaf3ELS0w09VSsNmljokkg76UhRunH8ZgrEg8WRr23IDA==
X-Received: by 2002:a2e:9708:: with SMTP id r8mr8563766lji.92.1578850299873;
        Sun, 12 Jan 2020 09:31:39 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/14] dmaengine: tegra-apb: Add missing of_dma_controller_free
Date:   Sun, 12 Jan 2020 20:30:04 +0300
Message-Id: <20200112173006.29863-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controller shall be released on driver's removal.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 398a0e1d6506..fbbb6a60901e 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1586,6 +1586,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 
 	if (!pm_runtime_enabled(&pdev->dev))
-- 
2.24.0

