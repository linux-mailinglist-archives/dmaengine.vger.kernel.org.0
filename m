Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5D156B81
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBIQli (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34557 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgBIQlh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so2502244lfc.1;
        Sun, 09 Feb 2020 08:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcf0gJptkOIkfvTjG31/qLysvKtVLp1ja+Srz6ndwWs=;
        b=fATQj5GXrFgbfFr6CUNWZ5g6BAUrh/QE1VKNU+ltqFm4f+cXliSu1FimiGcZkTZcuO
         pkqgcFUcyKU8ANB9T2+8LVxu/H3aNC5EJG1Jzahczy9YzLxxYEdqS4OoAq0bbvDPbvJ1
         zmnfTzjmiMUxXY3le22Jff5twa0fVmt35Ay/AfCp8vUHN+bnQI1UPdZlFx1Y6HEqQ+yT
         5RcUOr/Ni+spoJ6tu2YPuOI7uHX/Jv1kCtdJhtw6iwWSR6f9D4z6B7mjJ5Y1ABsk1B7k
         8EhJsTuRAKZKKuf8wjmul3yATcj8w+FN1RBOoeBS3u8Wolc3NDwfQYKYmPSZEaiNpgA+
         SKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcf0gJptkOIkfvTjG31/qLysvKtVLp1ja+Srz6ndwWs=;
        b=nApiXg6JiQI/S4rtqXkv2ximxyf366X4OO5rob4obuUyygSL3bXGpzBZ/KPL87UzsO
         nd8af8rXfRMU7w96SLjiNKgLk+EMhbnLYVHuV4eRTJUv+cNbCRDhJV9m6dqnQNCruO0v
         J6R8iWrPh3qRWgDLYDpF++eCHHCP1OTD4Tm+XWeFIHosjCWaJ1kElpvD/annfsnkx/aD
         k7HxWE9wjHTspTJlgDnJcfSF9XJtuqIKYZFaC7PyVA3hukniAd6mqtfVS0P+4HO4PgZB
         srMNZWOCQ4P6ZYEjVDdBFDdv7zz/pX6GWgtpMOFbriYHl26dyBKxY+T2EsEQGkfYT9QY
         I6Eg==
X-Gm-Message-State: APjAAAWZic77IfCJWxtb/TgbtfWv+6ttsFTe1Yhrk4Aec86AjyEEBDnS
        wqDW2u4yeaVrm7U/5o86PxI=
X-Google-Smtp-Source: APXvYqyDVK7ohW2g2VLA/i1SiYKZxOLC2/LMbilFUK71tCCCqbSnOFGMD3DoygbY3SczP4JRLxA/8A==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr4152741lfp.162.1581266495070;
        Sun, 09 Feb 2020 08:41:35 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 19/19] dmaengine: tegra-apb: Improve error message about DMA underflow
Date:   Sun,  9 Feb 2020 19:33:56 +0300
Message-Id: <20200209163356.6439-20-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Technically it is possible that DMA could be misconfigured in a way that
cyclic DMA transfer is processed slower than it takes to complete the
cycle and in this case the DMA is getting aborted with a not very
informative message about the problem, let's improve it.

Suggested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 3e0373b89195..1a9b37c102ba 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -566,7 +566,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
 	if (!hsgreq->configured) {
 		tegra_dma_stop(tdc);
 		pm_runtime_put(tdc->tdma->dev);
-		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
+		dev_err(tdc2dev(tdc), "DMA transfer underflow, aborting DMA\n");
 		tegra_dma_abort_all(tdc);
 		return false;
 	}
-- 
2.24.0

