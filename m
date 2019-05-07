Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2948F15D1E
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 08:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEGGKS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 02:10:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43688 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfEGGKR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 02:10:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so7715823pgi.10
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 23:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fegqHJdxTxrNP4emVZDAfoflYxMDA5HIYSCVsGvvNyk=;
        b=gpuzGeOzJL+S9gtU42ApMv5X8chVRN0hkaUIvi7zD8VoJwnOqdqmXq7dtEBURIpA7j
         G/9Ev+cBM6PV3Go/z0mD8a8YNo5qNaDn0y4C4vJmag/YvzNjrhKByuxYlaoJr0TbQ5eo
         2nfWjzDy/wFJLus92xSxL6b1c35GEBUadXry11rD/4luRTR0OTnpL1BvwojJFoJbTZ3q
         qWa5bLbGM9gj9Fx9aaKvHXZ3P3VInHnxnX37d6LK/Ysm/eB1ph8aMLSOBxn6e7x3Zz1j
         uw+pixeKEBnvOiks2g0sUhhj+flFxFWtez0II53gaB23VlKlK7kIVnWRfR8jUkae/ejN
         WMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fegqHJdxTxrNP4emVZDAfoflYxMDA5HIYSCVsGvvNyk=;
        b=Sm08tcqjTwYpVvHKWJe/4H5wisW1XR4h9LDzgOGchr4W/UDq+uX+ZROaOzFx3D73Ah
         xlFMtLohXwdUxktc/+py/vuDOHgaZQDdE/8SuioK9iYUxRSDuSjw3fyDVKNvqTWleMCK
         rhLp4iyk0Y5fS6NGs+ZE1UeYK5/fSOAKFmsPvYpOTVB6UkecGSXafk1xh6Rbm5zP8GI5
         I6IYnN7wG9dFokbLgplz5vao+PBM+YXo48Rid74OB2XHIJakMrfIcpEE+w7WqAMsOlT8
         Q3/nKL1gF7tbrqeDm4xR4+/gp9orSNdvrFRCSIv/63f2+pS4/72kTXmS7eWdHkCc4Yte
         bCPg==
X-Gm-Message-State: APjAAAW0tjp/7zJ9zrrngo8tVu7NebRLEJPWkOwec1VZG2CMrJ+qmnCW
        3NoDHcexQdpv+8eWzuK+uf7nzw==
X-Google-Smtp-Source: APXvYqzTNghUUH/vAVAHLtApBnwfwTv9iOi8rSX6GEZxoSO4Ljp5Aibele+BPHXO5ocKnwntiyTY2w==
X-Received: by 2002:a65:5184:: with SMTP id h4mr37881601pgq.109.1557209417270;
        Mon, 06 May 2019 23:10:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/8] soc: tegra: fuse: Change to the correct __dma_request_channel() prototype
Date:   Tue,  7 May 2019 14:09:39 +0800
Message-Id: <1ddb1abe8722154dd546d265d5c4536480a24a87.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since we've introduced one device node parameter for __dma_request_channel(),
thus change to the correct function prototype.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/soc/tegra/fuse/fuse-tegra20.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 49ff017..e2571b6 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -110,7 +110,7 @@ static int tegra20_fuse_probe(struct tegra_fuse *fuse)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	fuse->apbdma.chan = __dma_request_channel(&mask, dma_filter, NULL);
+	fuse->apbdma.chan = __dma_request_channel(&mask, dma_filter, NULL, NULL);
 	if (!fuse->apbdma.chan)
 		return -EPROBE_DEFER;
 
-- 
1.7.9.5

