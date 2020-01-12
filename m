Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B813876D
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbgALRbz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36128 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733197AbgALRbo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so5153822lfe.3;
        Sun, 12 Jan 2020 09:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVgvDl53i+vPBSkzgipL2f7yd+gUN+cTRTJ+9Dy9ATg=;
        b=WHMulbMfP+gG/qPUHdjCEhz9ZAuexs7xrWz+rt17nYhHsnTqWPqJy21hbbuPSXZZcX
         o76gVaCku4QL19yNdce4TpuPQpgNmRgFMsMd4XhDEXDOx8YWRITbGZE9s7SjtakHQfCs
         G6HsN3BbR2HYL9guNa0IimYuL1WSP6ki+O/FAJ78lB/Boc+8/wxGcIS3adV0XTfyPcXC
         xEjM6zOMnjICDNRw1eQUxW4g2UGoIdKOdaq7xwV8NSXcR6IjpwvL4WM6gzJq4fpnbDtR
         DYFLEZgUsd6bgj7qwhtxpnOB8xHHwUnOxiqvX6vhM7Kcf32NLkYuGu6kudXZzVhTmTwQ
         z8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVgvDl53i+vPBSkzgipL2f7yd+gUN+cTRTJ+9Dy9ATg=;
        b=a3yBmjeD7zZBZd/nM3kp+qaCtU0TvJvh+THvUzHg7UQDLChROLtZmv6Q/pS1cdWtND
         TFkRRa5osNemcsv6qrKLaK2i6kLn2tgdMeA74R8DOekryE2DOS/cpYtNvP8T3Bd+yzzZ
         QoUuqL2bXTVcgIdGOoFa0iZlJIyd/XJkyQtjTvs4FbfuUH86zVZltdBvAd5DLFokCUFt
         cCM8lIirLnzFSnp6vQEFJyzH82/cy3gMABqg6bENhjzSis9LTVusNCMz14IaRCKzbyIi
         fZaZ2gMwz7FhaA/PsSl8EarA1uh7qlCz88hBBmFi8tRvryhPaTYApfqtV2Ei0jY2jkq5
         qRHQ==
X-Gm-Message-State: APjAAAWZknMH6qjmvunhGEEQfDdpMSyO5lHoqANZgs+mbY6iaNhFvj05
        mliak8mC+wrbgmT/WTcpDJc=
X-Google-Smtp-Source: APXvYqxuvn1YNVbrHwYIIOff8+3bBu2pceXbSKOZlk5bGqBqAcwqGfCfN5KhgOSIWyiXKZHzXgpuuA==
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr5421763lfu.197.1578850301617;
        Sun, 12 Jan 2020 09:31:41 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/14] dmaengine: tegra-apb: Remove MODULE_ALIAS
Date:   Sun, 12 Jan 2020 20:30:06 +0300
Message-Id: <20200112173006.29863-15-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra APB DMA driver is an Open Firmware driver and thus it uses OF alias
naming scheme which overrides MODULE_ALIAS, meaning that MODULE_ALIAS does
nothing and could be removed safely.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index fbbb6a60901e..0a45dd77618c 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1688,7 +1688,6 @@ static struct platform_driver tegra_dmac_driver = {
 
 module_platform_driver(tegra_dmac_driver);
 
-MODULE_ALIAS("platform:tegra20-apbdma");
 MODULE_DESCRIPTION("NVIDIA Tegra APB DMA Controller driver");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

