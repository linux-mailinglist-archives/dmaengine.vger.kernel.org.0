Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 196C913875F
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbgALRbd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39877 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732972AbgALRbc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so7438104lja.6;
        Sun, 12 Jan 2020 09:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3aEWiKiUIKlnyGDWrJTtogZVkNTJgIo6DWcgGLcpCo=;
        b=rnVhNxqCfDE+XLWYc6q2yJ8rtxAYQKDTrumUj7JLMXqMQ1NyPnHHtoxUBvBLvICeXQ
         Malqt2Rn3Gb4Jf4Z/sPTDHpKL4U5Ad5kBB5F2wcFA2ExuLvpBAdpi7XDbRkQh+gkFEfY
         fQvjvkpTOTW+ubBmTIkQZGhzb/9N27FPB8LkvS82HP223GAxLan+ZzPtuRnm/oL/BPso
         zpxcQpy7/OLbfoVZIoevFx/HTTy3hmx+RWscG9ebQvcTu8K25rdyFf2cHDRirmO39vnb
         3Ff8Zk9kARvUE70FRyuAFTdAkKm1xc8RTeTbm+HuRTMfgu21+hXCoHkKw7Ecb/D4mWVX
         jk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3aEWiKiUIKlnyGDWrJTtogZVkNTJgIo6DWcgGLcpCo=;
        b=kEhogkqTUwqEis9pJCvctB1/2G68Y/nN22048DQyTfSz1TQjAbzkos4bMbjd6S3BvF
         FJ+qo6KYNKe9Pn4ffq21lGEzZTna4rBqrx1UEQ2850b2dc/3G4wLJuEmQwwiRamGNX0i
         Efq1dlIz7gMB3q5FmjmQmuWmv1+Z+3EUeTPYKuPihBAlZCxBjfpF5yYNQk7CAGF36I6D
         AX7WjalWcVpHLl41wbE5UHbh7r2OdkAiVfu3mTiiP89sknmMZMgY74smrVlJC9Um7hzj
         gPIQtO49+ShVAYCYzgLFUGBThZy+RKOZ1XZ16X0+S+W1idG2nvnqO1gkKpXmgBMBovaq
         dkJg==
X-Gm-Message-State: APjAAAWWjVnFpeZ1CEGXCCDqoRAOyw8f5nW7izuIs7pSJ9Y24/pfjyXg
        ywOoUfjeurgq2w0efRWfLxDn7bkK
X-Google-Smtp-Source: APXvYqxJOOnnEe+TT/kaxiDI0CySBUJuqn6U8+sEPnyhnWtqT37vwWichFveYRRMS5pkAlEoacw7MA==
X-Received: by 2002:a2e:9592:: with SMTP id w18mr8415393ljh.98.1578850289846;
        Sun, 12 Jan 2020 09:31:29 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/14] dmaengine: tegra-apb: Fix use-after-free
Date:   Sun, 12 Jan 2020 20:29:53 +0300
Message-Id: <20200112173006.29863-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I was doing some experiments with I2C and noticed that Tegra APB DMA
driver crashes sometime after I2C DMA transfer termination. The crash
happens because tegra_dma_terminate_all() bails out immediately if pending
list is empty, thus it doesn't release the half-completed descriptors
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

