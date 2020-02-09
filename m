Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F532156B61
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBIQlV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36432 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgBIQlU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so2495322lfh.3;
        Sun, 09 Feb 2020 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQvpC9Xx1OhKhnLZoMg+HnSAUjrYIEp03EqAINcI86Q=;
        b=PkS1uON+ubWLvTKhsbL+5N/bLK7+A8BP1AajdOOGPNRR0JCeeq0KcfTgvJ+oW+SMWi
         sUU87YVuVor1IvO2acfZqdZefwWAT4k8qTHePe6eBYo80DWNqthIWDlSi2F0F36x3UR9
         Q0sOvbsXwztfAzqA2m4zNz6dcx64EDeN07MF1s3aSdkgtBz5mtaIeaQpCg73qXSuZS/X
         Rn8bG8YBUIE1ITWtOHIba9V6xOgMllpXSlMv89+c58SmnUfrVNOrrdxu3REmOuUb5TOW
         +8iiI6mfpJvcLEcty50YYMaN1sZrhzHQywf3il6dt6k6594fPwZ61swse7d9XRB1PDWg
         0nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQvpC9Xx1OhKhnLZoMg+HnSAUjrYIEp03EqAINcI86Q=;
        b=dXM4R4K81KGawNK68sD0Aibqivjq2zcRLEXWJYLsLNylp0fpqCKV18SNJCGwKoaC3k
         4JbgU5LFJExLu9JBPQP+9YQx0wYxwvpMEoaO6V2+uC3vM8Nkh5E1fHRqCKAMv4+8SQaj
         1LQwGrvJsbWOEV9Ki2mO9SABKO8ikKpe2BiHsEOtQprIIqAZwjiGaELWJB9129pE8stG
         H12Ty4XTs0aOq+r+dJ0zT0GKUmUOHv9Umu/Q7SVkvo5P4XmPZylSKhSzBfetj2HEeCga
         WQowOb60aPoyaWaknDBIy0bq8TLi0xuKxF7Q9FutjlPo8VjzIU04FJAmUdqrftdLAw9/
         dv3g==
X-Gm-Message-State: APjAAAUIyI90oCdfugEAH+IelTlo34rhx8zolHJ600qwhofT9r+LYpGK
        dxSttTT9mfEVstS4ehHReh0=
X-Google-Smtp-Source: APXvYqy3BpP/MtfvWdKeggyXl4APay8oLO8qehofYzHw9tvW5oBe9ywRaGkV8/FNit1loAnyMrLV/w==
X-Received: by 2002:a19:850a:: with SMTP id h10mr4170518lfd.89.1581266478488;
        Sun, 09 Feb 2020 08:41:18 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:18 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/19] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Sun,  9 Feb 2020 19:33:39 +0300
Message-Id: <20200209163356.6439-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The interrupt handler puts a half-completed DMA descriptor on a free list
and then schedules tasklet to process bottom half of the descriptor that
executes client's callback, this creates possibility to pick up the busy
descriptor from the free list. Thus, let's disallow descriptor's re-use
until it is fully processed.

Cc: <stable@vger.kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 319f31d27014..4a750e29bfb5 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -281,7 +281,7 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
 
 	/* Do not allocate if desc are waiting for ack */
 	list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
-		if (async_tx_test_ack(&dma_desc->txd)) {
+		if (async_tx_test_ack(&dma_desc->txd) && !dma_desc->cb_count) {
 			list_del(&dma_desc->node);
 			spin_unlock_irqrestore(&tdc->lock, flags);
 			dma_desc->txd.flags = 0;
-- 
2.24.0

