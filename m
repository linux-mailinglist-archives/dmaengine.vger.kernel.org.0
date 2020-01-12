Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A207138781
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbgALRbg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38623 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733130AbgALRbf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so7453864ljh.5;
        Sun, 12 Jan 2020 09:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqNp1UdCqeyiLALCUBHMvdBWRB+JgxkXykXZjY6I1uo=;
        b=jLYnfmpaDvagxToMteOAX02zqX3JdNkY1NNHBc2V5F5AdomTR+cE43o9jQF5NkfiT3
         zIJ6R3KAGRSEB55TbV/s00z+cspVPJu57SEXavK810Ltu/e7aTLBJv46aminE9dl2Xr4
         eIltzKsXZtcwwMQ8XUbJzG+VAjZZzguzhCU7MYTLrn1W+aMpWWeKJl5+rsWdMitZqm6Q
         bg8TIcM0sucYLne1Zpf+h0F512rbtXkfho1/Vo4ZR1mMzT9YXGoE4UsM3GJvoiXV8IR4
         +QUgA9pt4YDqFvUUg4KCxY1Qt8e0r6RXPrA1IZapuP2tsieeOummlM4APJrp6yVZQIYO
         XqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqNp1UdCqeyiLALCUBHMvdBWRB+JgxkXykXZjY6I1uo=;
        b=Zso5z+trE9JvTckMSarhzSHtcqHpNw4AodnGSb59lGbzMhvDteBmw5fB/bFCgBTFzC
         oUHEG/CfC5CJ7EeaCmALQY4eeExrUfftJYhNjgTkPJWvhhwJum88f3V9v8QxW1FB0OEF
         3gTcRsDYzzfhBwMH2oU5MnyWHD7myWP+sl8nVYGGQwcHVig5GYDekB19WUmnW7vWi7te
         7KTSQ1Yk/91xC6ej/LN+6wSNCAN9wBpUWk3wYbXS/ORFBC39LvX9Ze6sxSVCaKt9Vdro
         6RzodL4Z4fK+HN+AUj/ayYpgEWpWBJ4j2UGibiRqOSMC9Tj71Kd1+a0BC52bmFIO2Lev
         ujwA==
X-Gm-Message-State: APjAAAVQdEldWZd1h+HUUo6pjtc4EWXUXlcdwU1uo9bytOFLHh5pNuRh
        kPIguhPUOkEOyuk5KT7LZVM=
X-Google-Smtp-Source: APXvYqyk69gPnTU1szw7MirFqod0bsijIASrwmHqWCpYENr6jHmuA6nt+B6zXBSrYyGl34NYqcEkbQ==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr8281818ljl.83.1578850293432;
        Sun, 12 Jan 2020 09:31:33 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/14] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Sun, 12 Jan 2020 20:29:57 +0300
Message-Id: <20200112173006.29863-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The interrupt handler puts a half-completed DMA descriptor on a free list
and then schedules tasklet to process bottom half of the descriptor that
executes client's callback, this creates possibility to pick up the busy
descriptor from the free list. Thus let's disallow descriptor's re-use
until it is fully processed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 1b8a11804962..aafad50d075e 100644
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

