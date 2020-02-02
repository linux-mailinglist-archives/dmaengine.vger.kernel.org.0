Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8B14FFCD
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBBW3v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:29:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34381 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgBBW3v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:29:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so12652355ljc.1;
        Sun, 02 Feb 2020 14:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIr+hEI5jiVDIpgzntOp1SJ5U4uzX7Mt42pGHqVvxOQ=;
        b=jzZ9q2KMJmouDEZbcdN00RjfC/PXjwhT4TmtiW7J42rS2MEHcKIScPd9Y0ORk95AJy
         PxYEElGLVUDJiRpYNmkz3fIIzoa/Akt4CHjOUiMSK6xo+GNcOx+caWi3KN4jsEwxmIac
         B7le2/u3AaYhum9IRbWB5mVmbS5hRtHTiwsuW/Omorkfb+/hnCW+QdyK1hekz2jlTj4h
         ELkXuGVqIO9aMcev96bpWaHzTByqePNA2Pc3LhCLr5oS7FzWvoDWd9JvaaX6Rki0fvvx
         /liKmuD2St21iBj52CXv1LSvYDZcu9AgH6qsufLo7sLeWPlahCxmVWNmDJVDjBoP1unP
         F1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIr+hEI5jiVDIpgzntOp1SJ5U4uzX7Mt42pGHqVvxOQ=;
        b=riwbi3ok38uVaLRNvMaS4JLEDBKFiBaCMcmAMbKNwCZReFQuZtkbm64cchYKpJvitT
         j5MDDxGeqdZoVapf7/VJAnvlu3kM0SEaHAX4JkEmsRfT5qtTcKnA+jBx9G2GAATLP8kV
         kyTSRwhFpP/DS5REysmpe9ebN2VunAoc4HxCMp4Bvt2DD3YzEjc3nlrCZegMitxcX2uY
         Kw7jDWNzsUkFI0Nm5udObN9AmCPkvTc5zwYwPHROGDOT/MG92Z2TQzqmDvFjv3/Q1LHY
         dwk4FsqquGet/R60nlMhnGaKtrlR8Q78QZi5DwBOwwKw3dHlDl6/PJe/d/Qqq5h5FwGZ
         IEkQ==
X-Gm-Message-State: APjAAAX85PzR25F/UQlxL/wDGWwf7fU5jYASBetT5w0RdgMvE0e+MzV0
        TFCIIF4tbxgXbiW0GcPgNmE=
X-Google-Smtp-Source: APXvYqyHvhQscqat+8sWrjPwl3MB67ecQ11g38sjzPkkZRRFvgRzby3QJz1PyX4eMOyLq859q6JYTA==
X-Received: by 2002:a05:651c:1bb:: with SMTP id c27mr12522033ljn.277.1580682589492;
        Sun, 02 Feb 2020 14:29:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/19] dmaengine: tegra-apb: Fix use-after-free
Date:   Mon,  3 Feb 2020 01:28:36 +0300
Message-Id: <20200202222854.18409-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
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

