Return-Path: <dmaengine+bounces-1963-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83318B21D6
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 14:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F351C21EF8
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BEE1494BC;
	Thu, 25 Apr 2024 12:46:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4363215AF6;
	Thu, 25 Apr 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049188; cv=none; b=VMzLbKPdg9Kxaxh0ecnvIUtjiRxTTgbv7MobT+EU6v89G9YbkpU+xk/HyXchT71Jb+S7ELWplq1cb6ciuoF6TpM34/qR9AuDOMIYv2MUf8VILyQ/ffmIX0HaJRX85Pta9fi+i7oKTin4zfd7D1p9VguXNwIp5CGaQfSpAGSg2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049188; c=relaxed/simple;
	bh=r+Z9koNtsDY67WD++3sL7yViEG6jpEca9X4OmjWZ+u8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7g3IkkFg5NMUaig9tJL6zey6M7JCgnqRUGEIHjnuU3HK1vgOi1S345hCEcIs7DCBoNbmC5AHs+I+Ya4Amve5ToLyzzE3q1+e6ggosPhOZfP2u4Si4QIEviSk2DhKiHRt34+elcfUvDIySRweusXL0jW7rfEMRoTgbFQvbu0ZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQFrX2X7HzwRtQ;
	Thu, 25 Apr 2024 20:43:08 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B8DC18007F;
	Thu, 25 Apr 2024 20:46:20 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 25 Apr 2024 20:46:19 +0800
From: Jie Hai <haijie1@huawei.com>
To: <vkoul@kernel.org>, "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
	<dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dmaengine: dmatest: fix timeout caused by kthread_stop
Date: Thu, 25 Apr 2024 20:40:38 +0800
Message-ID: <20240425124038.3096368-1-haijie1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230720114102.51053-1-haijie1@huawei.com>
References: <20230720114102.51053-1-haijie1@huawei.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500004.china.huawei.com (7.202.181.242)

The change introduced by commit a7c01fa93aeb ("signal: break
out of wait loops on kthread_stop()") may cause dmatest aborts
any ongoing tests and possible failure on the tests.

The operations are as follows:
  modprobe hisi_dma
  modprobe dmatest
  echo 0 > /sys/module/dmatest/parameters/iterations
  echo "dma0chan0" > /sys/module/dmatest/parameters/channel
  echo "dma0chan1" > /sys/module/dmatest/parameters/channel
  echo "dma0chan2" > /sys/module/dmatest/parameters/channel
  echo 1 > /sys/module/dmatest/parameters/run
  echo 0 > /sys/module/dmatest/parameters/run

And the failed dmesg logs are:
  [52575.636992] dmatest: Added 1 threads using dma0chan0
  [52575.637555] dmatest: Added 1 threads using dma0chan1
  [52575.638044] dmatest: Added 1 threads using dma0chan2
  [52581.020355] dmatest: Started 1 threads using dma0chan0
  [52581.020585] dmatest: Started 1 threads using dma0chan1
  [52581.020814] dmatest: Started 1 threads using dma0chan2
  [52587.705782] dmatest: dma0chan0-copy0: result #57691: 'test \
    timed out' with src_off=0xfe6 dst_off=0x89 len=0x1d9a (0)
  [52587.706527] dmatest: dma0chan0-copy0: summary 57691 tests, \
    1 failures 51179.98 iops 411323 KB/s (0)
  [52587.707028] dmatest: dma0chan1-copy0: result #63178: 'test \
    timed out' with src_off=0xdf dst_off=0x6ab len=0x389e (0)
  [52587.707767] dmatest: dma0chan1-copy0: summary 63178 tests, \
    1 failures 62851.60 iops 503835 KB/s (0)
  [52587.708376] dmatest: dma0chan2-copy0: result #60527: 'test \
    timed out' with src_off=0x10e dst_off=0x58 len=0x3ea4 (0)
  [52587.708951] dmatest: dma0chan2-copy0: summary 60527 tests, \
    1 failures 52403.78 iops 420014 KB/s (0)

The test 57691 of dma0chan0-copy0 does not time out, it is the
signal brought by kthread_stop() interrupted the function
wait_event_freezable_timeout() waiting for test completing.
The timeout log is misleading and the ongoing test can be
completed if wait_event_freezable_timeout() is replaced by
wait_event_timeout().

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
v2:
1. Add more details in commit log.
---
 drivers/dma/dmatest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a4f608837849..854165f55e7b 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -841,7 +841,7 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_freezable_timeout(thread->done_wait,
+			ret = wait_event_timeout(thread->done_wait,
 					done->done,
 					msecs_to_jiffies(params->timeout));
 
-- 
2.30.0


