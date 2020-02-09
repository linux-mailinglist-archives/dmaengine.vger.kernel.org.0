Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2821D156B5D
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBIQlU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35192 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgBIQlT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id z18so2500593lfe.2;
        Sun, 09 Feb 2020 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIr+hEI5jiVDIpgzntOp1SJ5U4uzX7Mt42pGHqVvxOQ=;
        b=NunZwNi8jqSHedUzdE41W+JuiPPI6UoCKu9MBG1lzuIqpOm9r0YwxbsStsODf1aNQh
         es5AvyGSTCBijsA1ikZycPMt5En8xz0JcBLe0vv+rdm10/+842TraNQDjm6Nppb1T9iz
         U/JZIF4YhA75lmBEtyTkyS0obizOiHmU/6PNZWs6favPuRdKeDhFbJDF4mzvSxPxDOxB
         azjIvop3/Jo82q5GTGSi5nKO7DYtOF20CJnX2JyV6Vs4sJZ9ROPa+2s8A6rsQ632V44p
         ZOmXoV1/Au2Fo+jHl2wwpz1hXQThzCzcptfEviZMLW/rImCjYNNPHxLci1XPypAyXBtO
         T/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIr+hEI5jiVDIpgzntOp1SJ5U4uzX7Mt42pGHqVvxOQ=;
        b=U8tUehMv0lMynInVm4N+k3ilMZuIf++i7q+bK5NCo2o9N3ulzxkuIqgULhKesE+2nH
         6nmmJi38WJK74iyyVAXXp0gcxmsLeuVfBsDEoet0RtJ4WQsLYYNE//CIbhjHUDomgP9w
         jUmwu/Cy8F/DBhe7Y0po3hv2zjwvLkiWVmVY8r4WB+ABVK0kKfdpWen5D+S3BOPMXWsp
         0JvRe67hje6npT1XbqIYFo8BXbvjX8WDsDh0/2hswOdey82XbH4CP4mRod9WPzNqTUPl
         SpnXC9jdp71jGQ7MJS9VxMUUZHkRWgl153RhGu50pzaLcfcnibiqCotch0bBImmpf7qm
         srXA==
X-Gm-Message-State: APjAAAWIvHVO5mwVIX0NzxnKDZKG+Kgz+sZFnnOKfWNc01T/4oRIm6Qg
        kUJsYJwDdty0WeJKm8e5mcg=
X-Google-Smtp-Source: APXvYqySUlsdDslSk/IfFxU6LCFrS/eb2BbW+cx0+iGs6bPiNjSdDtTkTajzAGwG+vRKP+lqPahKPg==
X-Received: by 2002:a19:a07:: with SMTP id 7mr4078896lfk.66.1581266477509;
        Sun, 09 Feb 2020 08:41:17 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/19] dmaengine: tegra-apb: Fix use-after-free
Date:   Sun,  9 Feb 2020 19:33:38 +0300
Message-Id: <20200209163356.6439-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I was doing some experiments with I2C and noticed that Tegra APB DMA
driver crashes sometime after I2C DMA transfer termination. The crash
happens because tegra_dma_terminate_all() bails out immediately if pending
list is empty, and thus, it doesn't release the half-completed descriptors
which are getting re-used before ISR tasklet kicks-in.

 tegra-i2c 7000c400.i2c: DMA transfer timeout
 elants_i2c 0-0010: elants_i2c_irq: failed to read data: -110
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 142 at lib/list_debug.c:45 __list_del_entry_valid+0x45/0xac
 list_del corruption, ddbaac44->next is LIST_POISON1 (00000100)
 Modules linked in:
 CPU: 0 PID: 142 Comm: kworker/0:2 Not tainted 5.5.0-rc2-next-20191220-00175-gc3605715758d-dirty #538
 Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
 Workqueue: events_freezable_power_ thermal_zone_device_check
 [<c010e5c5>] (unwind_backtrace) from [<c010a1c5>] (show_stack+0x11/0x14)
 [<c010a1c5>] (show_stack) from [<c0973925>] (dump_stack+0x85/0x94)
 [<c0973925>] (dump_stack) from [<c011f529>] (__warn+0xc1/0xc4)
 [<c011f529>] (__warn) from [<c011f7e9>] (warn_slowpath_fmt+0x61/0x78)
 [<c011f7e9>] (warn_slowpath_fmt) from [<c042497d>] (__list_del_entry_valid+0x45/0xac)
 [<c042497d>] (__list_del_entry_valid) from [<c047a87f>] (tegra_dma_tasklet+0x5b/0x154)
 [<c047a87f>] (tegra_dma_tasklet) from [<c0124799>] (tasklet_action_common.constprop.0+0x41/0x7c)
 [<c0124799>] (tasklet_action_common.constprop.0) from [<c01022ab>] (__do_softirq+0xd3/0x2a8)
 [<c01022ab>] (__do_softirq) from [<c0124683>] (irq_exit+0x7b/0x98)
 [<c0124683>] (irq_exit) from [<c0168c19>] (__handle_domain_irq+0x45/0x80)
 [<c0168c19>] (__handle_domain_irq) from [<c043e429>] (gic_handle_irq+0x45/0x7c)
 [<c043e429>] (gic_handle_irq) from [<c0101aa5>] (__irq_svc+0x65/0x94)
 Exception stack(0xde2ebb90 to 0xde2ebbd8)

Cc: <stable@vger.kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 3a45079d11ec..319f31d27014 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -756,10 +756,6 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	bool was_busy;
 
 	spin_lock_irqsave(&tdc->lock, flags);
-	if (list_empty(&tdc->pending_sg_req)) {
-		spin_unlock_irqrestore(&tdc->lock, flags);
-		return 0;
-	}
 
 	if (!tdc->busy)
 		goto skip_dma_stop;
-- 
2.24.0

