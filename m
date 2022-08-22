Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9BA59BED2
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiHVLtK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 07:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiHVLst (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 07:48:49 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07630140A5
        for <dmaengine@vger.kernel.org>; Mon, 22 Aug 2022 04:48:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x10so10335205ljq.4
        for <dmaengine@vger.kernel.org>; Mon, 22 Aug 2022 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JvWkrZCHWaZg0B4fxrggJpcKlzsXeXTjMFTXm2G7Ln0=;
        b=ntDl1WxU9/IUGVBIzGbRcPLYqrhAQsz+Epif8d5cKLduGObeiWeA+h2oQrWj4VfwJY
         3us3dedr0/iRRja4d/vUR9gyixjlX1+X4SY4lGD+9XJVyYj13nJnyiRIaRQ7O4tr/kKz
         yVwDWJQ59ycGmvBy501WrN4nlF0J8cNfqJW4pkP4jSiHUfd/NQx61qUkncqhc1Zd9XS2
         6XexzVqLwQZ6WKD2g/2YnZ2kC28NrSkKDev5OkONAM5CRDnSAODI1zTzKxS/XGp7EiGG
         6x7c1Gh1p+bf6fEeksc92jtUlNdaagTzBLFPYGJrwU3U2MqG6L8NzqLbNKvAdaf2aUHF
         ErQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JvWkrZCHWaZg0B4fxrggJpcKlzsXeXTjMFTXm2G7Ln0=;
        b=WBU7/EXoJHUPx4Ycy4I8h+2LjfitxcMfpF5U415k4KVH92eIujYGvJdja9yVHlii37
         axVF4faJB+y+jB25GneToasQQ4PxdL3BAGMDijfcMdG+PLfuYn/VXl9l53kLNanuynM2
         Dvk7Elqp9V66CB5m9NBZo/vl4PXgdMsg1w9OJqc6KPXxuYH3sgqQpn6G8PGKk7UqSI9a
         3Jt/qJ07aftnEjoaHCXhOapx/Q4TOOIBjM24U0arebxkoFNxQccNvdXrXBBHtGZtOIMZ
         SSCLL70PiM4bchu6oTCth2SVKcrUyDN+XLK3AEF2lElEQfW+45uSECAKCATf405fQbky
         u9kQ==
X-Gm-Message-State: ACgBeo1XepljrxxOalOtseekQvgVIcmHKEfdDd545Mm2aWolBeFqlDqH
        TI1r7V8B25rqKgqDthvzqX+00i9BuCYp1g==
X-Google-Smtp-Source: AA6agR4fIfbHU9sQN9gJYIMhUAZyI5YxjG0VfzrmyjddRUTPs/HW/kNhis6A88PpJ6e6VUtpkSe7+A==
X-Received: by 2002:a2e:952:0:b0:261:d128:142b with SMTP id 79-20020a2e0952000000b00261d128142bmr803620ljj.50.1661168907193;
        Mon, 22 Aug 2022 04:48:27 -0700 (PDT)
Received: from localhost.localdomain ([188.244.36.106])
        by smtp.googlemail.com with ESMTPSA id u34-20020a05651c142200b00261b32f1548sm1744559lje.100.2022.08.22.04.48.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2022 04:48:26 -0700 (PDT)
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     dmaengine@vger.kernel.org
Cc:     linux@yadro.com, Vinod Koul <vkoul@kernel.org>,
        Alexander Fomichev <a.fomichev@yadro.com>
Subject: [PATCH] dmatest: add CPU binding parameter
Date:   Mon, 22 Aug 2022 14:48:04 +0300
Message-Id: <20220822114804.95751-1-fomichev.ru@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Alexander Fomichev <a.fomichev@yadro.com>

Introduce "on_cpu" module parameter for dmatest.
By default, its value is -1 which means no binding implies.
Positive values or zero cause the next "channel" assignment(s) to bind
channel's thread to certain CPU. Thus, it is possible to bind different
DMA channels' threads to different CPUs.

This is useful for the cases when cold cache (because of task migrating
between CPUs) significantly impacts DMA Engine performance. Such
situation was analyzed in [1].

[1] Scheduler: DMA Engine regression because of sched/fair changes
https://lore.kernel.org/all/20220128165058.zxyrnd7nzr4hlks2@yadro.com/

Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
---
 drivers/dma/dmatest.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index f696246f57fd..c91cbc9e5d1a 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -89,6 +89,10 @@ static bool polled;
 module_param(polled, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
 
+static int on_cpu = -1;
+module_param(on_cpu, int, 0644);
+MODULE_PARM_DESC(on_cpu, "Bind CPU to run threads on (default: auto scheduled (-1))");
+
 /**
  * struct dmatest_params - test parameters.
  * @buf_size:		size of the memcpy test buffer
@@ -237,6 +241,7 @@ struct dmatest_thread {
 struct dmatest_chan {
 	struct list_head	node;
 	struct dma_chan		*chan;
+	int					cpu;
 	struct list_head	threads;
 };
 
@@ -602,6 +607,7 @@ static int dmatest_func(void *data)
 	ret = -ENOMEM;
 
 	smp_rmb();
+
 	thread->pending = false;
 	info = thread->info;
 	params = &info->params;
@@ -1010,6 +1016,7 @@ static int dmatest_add_channel(struct dmatest_info *info,
 	struct dmatest_chan	*dtc;
 	struct dma_device	*dma_dev = chan->device;
 	unsigned int		thread_count = 0;
+	char	cpu_str[20];
 	int cnt;
 
 	dtc = kmalloc(sizeof(struct dmatest_chan), GFP_KERNEL);
@@ -1018,6 +1025,13 @@ static int dmatest_add_channel(struct dmatest_info *info,
 		return -ENOMEM;
 	}
 
+	memset(cpu_str, 0, sizeof(cpu_str));
+	if (on_cpu >= nr_cpu_ids || on_cpu < -1)
+		on_cpu = -1;
+	dtc->cpu = on_cpu;
+	if (dtc->cpu != -1)
+		snprintf(cpu_str, sizeof(cpu_str) - 1, " on CPU #%d", dtc->cpu);
+
 	dtc->chan = chan;
 	INIT_LIST_HEAD(&dtc->threads);
 
@@ -1050,8 +1064,8 @@ static int dmatest_add_channel(struct dmatest_info *info,
 		thread_count += cnt > 0 ? cnt : 0;
 	}
 
-	pr_info("Added %u threads using %s\n",
-		thread_count, dma_chan_name(chan));
+	pr_info("Added %u threads using %s%s\n",
+		thread_count, dma_chan_name(chan), cpu_str);
 
 	list_add_tail(&dtc->node, &info->channels);
 	info->nr_channels++;
@@ -1125,6 +1139,11 @@ static void run_pending_tests(struct dmatest_info *info)
 
 		thread_count = 0;
 		list_for_each_entry(thread, &dtc->threads, node) {
+			if (dtc->cpu != -1) {
+				if (!thread->pending)
+					continue;
+				kthread_bind(thread->task, dtc->cpu);
+			}
 			wake_up_process(thread->task);
 			thread_count++;
 		}
-- 
2.37.1

