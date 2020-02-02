Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83D14FFB9
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBBWah (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:37 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33013 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgBBWaB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:01 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so8399948lfl.0;
        Sun, 02 Feb 2020 14:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3P3Xm7krLErQ+kdYVou7oYRT/1iV81misjOxlroqdY=;
        b=EtlSw4Vzb963Z4sdrr9Hjxky46zygzXDvQ2t0LrlIyBwf0g41aHb4DlU0KdSxVss5T
         SdS83D67zbFEp51h/SCC4KMI+EPh3AnDgK6JvRCY9UnNlqdUn4ZVAd6IKaYa7MTYRh94
         6Zt/aMt6uzqFkfzoolew5Yc6rqUT/++D+qHIhdAjhWi952Q0aC28YR/LozAT1To1vbCH
         6jBQ7pdCYOjAWivgJe0fXVCX/lpTToxmjKjJFMZEhOmFkNN2PLx0qQZ2xUDg2wztjsDA
         kTD5n/fwbOfiW4/RdtwM03jpH3pKhG5W8xURuu6vEOi+ZtUe/PYdIVPJQOqzdSs29s+G
         G08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3P3Xm7krLErQ+kdYVou7oYRT/1iV81misjOxlroqdY=;
        b=sNlvwXD2PWUoFHXuQRBTmQett/qnfEl4Hkso+R231sSBbhocxIDCCDhlfjbA5Yh35S
         by5RcnD4X/ocYajTF5l4Lx/cU+LTr4hXP070XjTfPCnD+Ypr93ZXU+FE1eP/8OGDQ9YX
         mNobYH195UrzzrhAr9uvIhrG5SzPmTO5FPoYt+XewKp+DxBCppJxhitScAwJ8RCfgfHv
         R3d5gnCwj5R1r7aeJnpXr8MQi5kwB3VFZnVNyqc9JOam1xPgjQ+azD7kWxW0Vc/yHclK
         44isonIASiFCrRuKDNbn1+CZVVm2x1taX4Q5jXZjbIUXqJV5FhUf3urjekTdbYdUNJUi
         M+8w==
X-Gm-Message-State: APjAAAUASzfxce1mIpOaQbYQfZBQfqx+u1kso2MMumq0zyKN5fynbmgW
        P6x+o2dtq4VubJvm967GEDM=
X-Google-Smtp-Source: APXvYqy+YsqJZmFYyGEAwrGxPgGHTJEZ/x1eVS0e32A9zDmwBx/2UxeTG0j5uv5QMwMN3vJmyqP1RQ==
X-Received: by 2002:a19:9d0:: with SMTP id 199mr10596002lfj.110.1580682599120;
        Sun, 02 Feb 2020 14:29:59 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:58 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/19] dmaengine: tegra-apb: Remove pending_sg_req checking from tdc_start_head_req
Date:   Mon,  3 Feb 2020 01:28:46 +0300
Message-Id: <20200202222854.18409-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are only two places in the driver that use tdc_start_head_req()
and both these places check whether pending_sg_req list is empty before
invoking tdc_start_head_req().

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 22b88ccff05d..62d181bd5e62 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -504,9 +504,6 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
 {
 	struct tegra_dma_sg_req *sg_req;
 
-	if (list_empty(&tdc->pending_sg_req))
-		return;
-
 	sg_req = list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), node);
 	tegra_dma_start(tdc, sg_req);
 	sg_req->configured = true;
-- 
2.24.0

