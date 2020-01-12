Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700EF138784
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbgALRc0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:32:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36121 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733152AbgALRbg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so5153666lfe.3;
        Sun, 12 Jan 2020 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfuSooXOkxJU0/VsQZ2ZGbsgKKy+nQ25m7jbl5DejHM=;
        b=TU4wcA6dES1E3c5DikAX5RTjfTAZDt++p3dfUk6koqvGT7aJcOMgP66k2vRwLjpkeV
         ogz4EWKuGcXhDZYNq55NsB26SkKU3K6jM87WGFl4eme3GSP6G2Sb4geiLP18Pu29Gjhu
         uWmyN+6G+t9XN6uESFmQHr0n2W5kevJBDgIA1j7oq58leYbTkKN2WFhA3uZ57rKvEgxM
         lqDINrg4ZhyTjljew0ULQWQ2GcM6njyusH9zi8MbLq30mZlMqfoQcqMq2jve2hfDLdnP
         cyYX9wziAbqmbFErQSC/LuChu8Z60/sPKm3h2Rj6/khk7tu3XE+z59bVgUJXqFKmAKAt
         LRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfuSooXOkxJU0/VsQZ2ZGbsgKKy+nQ25m7jbl5DejHM=;
        b=Px5TMBjtA442Snt5P4pM4nAk5KB2XRlo9TpcuzRVdPNwFQnCIny11g/yB4ZTHdJUCt
         D+VbKdFlKeSJVtnL5lOhM3JCXvmbufNWo/wXKDz1HJNumS+Qn4ff6tTiPBqiINWNtQFW
         UEzONxWQAFJ4iOzf7v1nGMtMIxEdR+FcseFefMGvPDjhjhsT5ChfVH2Ktu2CtzwckUAN
         ccKoSQw6z737VsSnKw15z/w905EjpETJHDsrbSxXSwdSUadkq+d86u13qj92IvHPnyIm
         /tinW8PDVa3W/rRGeoXOS/eqWKSVFkmYz+Ba1zq1ueJ9QGNlmvKkoKD/jw3P952UIfpt
         7Ifw==
X-Gm-Message-State: APjAAAV0f1gSFnTnOxHYu/np1TNQTeBmgdNkFuWrrEPaQxs+172YbB2Q
        Fv5rSvdvVQhWf/6uUWJi7nc=
X-Google-Smtp-Source: APXvYqwULa8/QnjzJ8ktnccpfzu7jYvhSJqzgEte3YBhequmV+ogCORMJn9TE5/4LXrlF7lPYudTnQ==
X-Received: by 2002:ac2:5f68:: with SMTP id c8mr5501762lfc.196.1578850294315;
        Sun, 12 Jan 2020 09:31:34 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/14] dmaengine: tegra-apb: Use devm_platform_ioremap_resource
Date:   Sun, 12 Jan 2020 20:29:58 +0300
Message-Id: <20200112173006.29863-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_platform_ioremap_resource to keep code cleaner a tad.

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

