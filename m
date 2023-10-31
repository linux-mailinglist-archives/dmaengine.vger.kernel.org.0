Return-Path: <dmaengine+bounces-20-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6427DC488
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 03:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7823CB20DE0
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 02:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0815A1;
	Tue, 31 Oct 2023 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED480A
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 02:37:09 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7AA118;
	Mon, 30 Oct 2023 19:37:05 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvFmIuE_1698719821;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VvFmIuE_1698719821)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:37:02 +0800
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
Subject: [PATCH v3 0/2] Some fixes for idxd driver
Date: Tue, 31 Oct 2023 10:36:58 +0800
Message-Id: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

Hi Dave, Fenghua,
As we talked in v1 and v2, I add fixes tag in patch 0 and change some
descriptions in patch 1.
If there are no other issues, please queue it up.

Thanks,
Guanjun

Guanjun (2):
  dmaengine: idxd: Protect int_handle field in hw descriptor
  dmaengine: idxd: Fix incorrect descriptions for GRPCFG register

 drivers/dma/idxd/registers.h | 12 +++++++-----
 drivers/dma/idxd/submit.c    | 14 +++++++-------
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.39.3


