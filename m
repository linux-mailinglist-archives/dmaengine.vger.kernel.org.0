Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADFE147459
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgAWXKr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:10:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45333 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgAWXKq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so5147367wrj.12;
        Thu, 23 Jan 2020 15:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3aEWiKiUIKlnyGDWrJTtogZVkNTJgIo6DWcgGLcpCo=;
        b=fNhkObiSjJhnzK5SIwdLnHYXfNxS+e+5gd4Jp12j/u4Q6WPoAX/s1EBaCABGIoeDTG
         xaJD/AUJ7VARy/nUlYVTmE1VbJKY9M3GfOMrgQ3abqPohuQHqFYEd1eEmHHzvy2i2uAb
         tRD1yGEe/d+w2oEg5EsWjZqhCq6KLgKvo7TrA/iJtIJHwm5erUcz+WGwUDc9fzPJ7Lop
         zwsEJNfWs6Xobe60qBwk3nJuHjHv4hZ3LebJutyJ5PgJr50dY0+e1U6AFLt2Vv1KcPhB
         lMJ8g/l6k3WB8O3EG0IhC9y3zxv3QxVw8oFAb02HQtWhV1x6akLV89Bbwm/3uDQ6Y5rI
         Q5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3aEWiKiUIKlnyGDWrJTtogZVkNTJgIo6DWcgGLcpCo=;
        b=FBvtxh6oYxRJ9qmrugrQXddpnu5TCQI9f+Vs140vOhjA/Gw84CZpSBszv6mbJdHCFi
         1Z16uH4YmNt2PEtudW2m+qszYy7EeKvbU8I+o+sfppmFO3dKP1sOlfIdVhkcY8l3Uhq6
         ag9mkKRE5G+TXHXktXwXVAyaduD+/WwRlhoEDpQ1idnMch8trrJu+RmBsB8tnayrkrKv
         HhkAEQZ7aUnGvnyGNc2H14eSkHeEhcwzb1AuMlqYa0rVKZW86eXhVVZgCV369xnX1aJs
         pzv3VkUaLB6zYyEA6E9PWGgTD+AF5Qic9M3dBQ1SfHDCwiML5m+wR5my/Z8rNpEG3Wqe
         ZkbQ==
X-Gm-Message-State: APjAAAXnwk51qwAL8aaRKXCSbfzoK5aqrDZoWSm04le9LdsiSxHL7urK
        JXNhUjBmOTKTjsaNbN1aO9s=
X-Google-Smtp-Source: APXvYqz+62yqIUxusIadJGkOBozJ4OlPot3yyml+aaBeZ0EEj/V9RTEJVTnYhkfMhC5kRIaUEtIADA==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr447622wrn.384.1579821044601;
        Thu, 23 Jan 2020 15:10:44 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/14] dmaengine: tegra-apb: Fix use-after-free
Date:   Fri, 24 Jan 2020 02:03:12 +0300
Message-Id: <20200123230325.3037-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
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

