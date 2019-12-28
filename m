Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB71712BF3F
	for <lists+dmaengine@lfdr.de>; Sat, 28 Dec 2019 21:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfL1Urf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Dec 2019 15:47:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33121 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfL1Urf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 Dec 2019 15:47:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so22936072lfl.0;
        Sat, 28 Dec 2019 12:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDAf62ZTY71vcxUcl3aWo7Qq3pJ8TaeUpJZpeGFMx9A=;
        b=jioFFi89pBk9zb91Gbs374SGf0pLZAXb2FzjPMMg1+jG1GVqHFNKV+1o3i+80GrzGa
         2ga1yijBlOP8tWQ65/cQECsC8B2/8LyYupM9mQBbs7jA2at7uZWjly/0S9N5sxacFl9O
         WuTbR/eQo3QayLtVrLhscPzFJwzumm+w1pfMDSvJwlPRpquu+XvdfjbvFVkDvAO5xQuM
         Y3QMZF5YJZHXF1KQwXfM+6O8pb4+P5L8EQQT/C0vDCxG/FDR1ensftjU71JHtBjstg4h
         lIi/5ehTDWcErlKKaR5KdwmrfjLHuim2Maq1F/BFC/uDCtDLyZZ0EYLGHXDCOV1H0bKQ
         jeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDAf62ZTY71vcxUcl3aWo7Qq3pJ8TaeUpJZpeGFMx9A=;
        b=Z4hCrE70DDVxbrLrnbNBJfYTbhoirwdVuH9//qSYJUbCgPf5WdkCbZSzM1cBo9WrB9
         LBWLa3IAsRLJWHwzN95xze7BQcUFgLLVNS3bRS+V1AsCH3gsjlfSwfvLPiOZpqAXfLtQ
         WNTWMs48bEyQWRRDaIUkkvrtHbyV1cWBHKi4VMpxiBZFFTF3Z9sEH6aY8ztcvq/R24Ti
         t76XZa+rYAqFlcAqidgwj3md41lz////fY0ED8B+vn1fmsIV+BUoaJ+gsWrGZGuQkFlO
         xdPys1r1eYCoyd+rTAJ04JAl8zMeR/e56ZR5b4E4qUH4JFCbNKVThXXultZAYyZ9Hrvi
         WKEw==
X-Gm-Message-State: APjAAAXKA01f8I8eHMcpt3TlbEMVko3HlwyiQ31dgLuSk2fm4RHUH2bu
        ha98/e65jH8BIqltVtIOJVw=
X-Google-Smtp-Source: APXvYqw97z5b/W5LsK7Q5H8ywvRCnqNkQ85dYdx8D61oy9s3zvfu0sEUtmJpS+lVF2rMx4PpyShxgg==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr32108188lfp.190.1577566053115;
        Sat, 28 Dec 2019 12:47:33 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm10571219ljl.10.2019.12.28.12.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:47:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] dmaengine: tegra-apb: Fix use-after-free
Date:   Sat, 28 Dec 2019 23:46:34 +0300
Message-Id: <20191228204640.25163-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228204640.25163-1-digetx@gmail.com>
References: <20191228204640.25163-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I was doing some experiments with I2C and noticed that Tegra APB DMA
driver crashes sometime after I2C DMA transfer termination. The crash
happens because tegra_dma_terminate_all() bails out immediately if pending
list is empty, thus it doesn't stop hardware and doesn't release the
half-completed descriptors which are getting re-used before ISR tasklet
kicks-in.

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

