Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE014FF9F
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBBWaC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44421 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgBBWaC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so12580582ljj.11;
        Sun, 02 Feb 2020 14:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oV29kakgRgYYyDRbHczEOv6xyT6QVwpRMqzYCQR5kaM=;
        b=Wg340Ay3uYAb1EmgfeQg34Kf9wHf0k8rvo5n4ZXj85FweoZYj2fY6V2rFesF/ig5ui
         MLE299cKNy6AOBJInzCS6k3JoJp4teQSdzLeidppi3mq5esoyGTkY80RwL7vIjNSDcwf
         GBMG1qwMkNdnjGDXhaBfzUW/mWrCcaj6TOhhPAhbSIWnppNM1vg14bxVnamjPtfvQKA5
         uOHKOXlDiDyRNMPdz+5yai29JhemgD9CmAYOI19hHxlsRmxenRqxE7RR8iqeVyNaAN6O
         WzWZkxLXvjkbTF1l1hOAY6i0ACUSVPtGihGkXxRbeII9rKyPwYCwRniHU5HaT11dtLjp
         B4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oV29kakgRgYYyDRbHczEOv6xyT6QVwpRMqzYCQR5kaM=;
        b=AggPoo5fpVwzrbnIK4ne5szC3jV2rPPQk4uZGk1xlotj6DHQmwDEiIDxHGj8QxnIr3
         V4wjX4hpwsNE1cqgeF1JWPxTvRFDaOAectJF9vaBHxM1ay4F4mTxx0U0jZ///2sm1BuP
         7FHxFMNWYk4fiujxdIWJah507pvaxExDpb9EfSnN8Hq03khXMyV++r9B6rZH+sHZN/gm
         +hoGnq9Z0q8JfO/fi3iTg1p4pZUc+2y3H7lb7oh1hwx9LRlJIe+p+x3CYh/RaHcIPPg2
         1G+7RAaIN2h1nHChALnkTSCOTAMFhhJQcxuGCRyVraChEsL6+SBaYIgQQL/cqMzGwzB3
         Sb9Q==
X-Gm-Message-State: APjAAAWwkMR6UP1qT6tjOStrAKcxWFIcVMMORiXg7DZ2cJlp+OFRrYot
        FS/Qp0E0f3aZrZDbmo7Yxf8=
X-Google-Smtp-Source: APXvYqzqXNPeS/zTglgjyVmBjf9m59MEtfDozO+pfjw8vruqJ714sLeGVPeB2m5EN6M7tXlo/2sBiQ==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr12022595ljn.40.1580682600000;
        Sun, 02 Feb 2020 14:30:00 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:59 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/19] dmaengine: tegra-apb: Remove handling of unrealistic error condition
Date:   Mon,  3 Feb 2020 01:28:47 +0300
Message-Id: <20200202222854.18409-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pending_sg_req list can't ever be empty because:

1. If it was empty, then handle_cont_sngl_cycle_dma_done() shall crash
   before of handle_continuous_head_request() invocation.

2. The handle_cont_sngl_cycle_dma_done() can't happen after stopping DMA.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 62d181bd5e62..c7dc27ef1856 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -564,12 +564,6 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
 {
 	struct tegra_dma_sg_req *hsgreq;
 
-	if (list_empty(&tdc->pending_sg_req)) {
-		dev_err(tdc2dev(tdc), "DMA is running without req\n");
-		tegra_dma_stop(tdc);
-		return false;
-	}
-
 	/*
 	 * Check that head req on list should be in flight.
 	 * If it is not in flight then abort transfer as
-- 
2.24.0

