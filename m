Return-Path: <dmaengine+bounces-3-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22B87DABB5
	for <lists+dmaengine@lfdr.de>; Sun, 29 Oct 2023 09:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB97F281703
	for <lists+dmaengine@lfdr.de>; Sun, 29 Oct 2023 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F030A8F5D;
	Sun, 29 Oct 2023 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950D1873
	for <dmaengine@vger.kernel.org>; Sun, 29 Oct 2023 08:00:58 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB47D3;
	Sun, 29 Oct 2023 01:00:55 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vv33MXt_1698566449;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0Vv33MXt_1698566449)
          by smtp.aliyun-inc.com;
          Sun, 29 Oct 2023 16:00:50 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: dave.jiang@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	tony.luck@intel.com,
	fenghua.yu@intel.com
Cc: jing.lin@intel.com,
	ashok.raj@intel.com,
	sanjay.k.kumar@intel.com,
	megha.dey@intel.com,
	jacob.jun.pan@intel.com,
	yi.l.liu@intel.com,
	tglx@linutronix.de
Subject: [PATCH v1 0/2] Some fixes for idxd driver
Date: Sun, 29 Oct 2023 16:00:47 +0800
Message-Id: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

This two patches fix the some issues for idxd driver.
Please help to review.

Thanks,
Guanjun

Guanjun (2):
  dmaengine: idxd: Protect int_handle field in hw descriptor
  dmaengine: idxd: Fix the incorrect descriptions

 drivers/dma/idxd/registers.h | 13 ++++++++-----
 drivers/dma/idxd/submit.c    | 14 +++++++-------
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.39.3


