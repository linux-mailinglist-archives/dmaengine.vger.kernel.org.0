Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A912C2E0
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfL2O4r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:56:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44634 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfL2O4r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id u71so31089333lje.11;
        Sun, 29 Dec 2019 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDAf62ZTY71vcxUcl3aWo7Qq3pJ8TaeUpJZpeGFMx9A=;
        b=W5IgD7NwYdoKrQneXW/fUNS3XMQyU6MGOhFKevROqWqFcxnlYsbuwfROI80gTHT0yz
         YOlWkyZXSRh+mf9h8Q+Q8uoB7FJo1xR6NSUwRx1Vt5TG6BdeGbDHbK50/gg5WUhCFGyb
         JNjThdzqwBiz3mROWZAdWCBoFTb9AKE29rh+8TmCXnAGiCIzPzKEh+wzBAhZlXVbvyHk
         h/xL2vrc1h9FhpnuBZh0JGUXnrrHKyQ6+2Vyhxgv9RJlBPuVo5c0Mx/7aMWJNLfisQOi
         EcAN3nnwDj3cZ2rDQryvza0pwzNLqMEDefyiHod+fkpl7N2akNHMKBZx6Vzk39Dkk1tp
         odiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDAf62ZTY71vcxUcl3aWo7Qq3pJ8TaeUpJZpeGFMx9A=;
        b=P4l26aEgR/Wkl9wSP2wC5gtJ4BNE2YAmdlQ3vjHksZMBXdp55QNH6Gi+pTY2xxLHue
         r/mcZ0Kd5tbBCW1A6s2es6rFXaa+u8xTrBfsqqOHuSp5ofhZozq4cyeij+4H2SRIC0q1
         Z/7asDQbsADdzm4uizSpyNpnbRslZL9E/6sgx0w0TliOfwBgiKFsackmtLS+qNgoIqcL
         ZC36iBYigZkuaigNpyNlJmXVCQIhXfrx0+dCntqzKVyvOU3h4Siycub+wVn2kW9x9zn6
         OxyJ9ItC+l5nSPt8K6JvrE1+MH2JLTjzk1vhs4Ik+oudXVyJ+4E9VKtXU4vQ2cc7bqOj
         osEA==
X-Gm-Message-State: APjAAAW5zUgzLW6AsntpgXM69vyC9JclyTNRSVmjmCd3s607Uk0ZsxG2
        epxG0yUknnWTxq5oNcvQg/o=
X-Google-Smtp-Source: APXvYqxK+TlO3YHpbABanIx8RnP1mfhM4IbQrEcsqYgGjItTyBjsck4vw/ME3y2oS22IimtkPrCe9A==
X-Received: by 2002:a05:651c:1b0:: with SMTP id c16mr33954198ljn.236.1577631405327;
        Sun, 29 Dec 2019 06:56:45 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] dmaengine: tegra-apb: Fix use-after-free
Date:   Sun, 29 Dec 2019 17:55:14 +0300
Message-Id: <20191229145525.533-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
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

