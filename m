Return-Path: <dmaengine+bounces-25-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84577DC4A7
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 03:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD8A1C20AA7
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 02:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF3EED6;
	Tue, 31 Oct 2023 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3D15A1
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 02:55:19 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD62A6;
	Mon, 30 Oct 2023 19:55:16 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvFpMtA_1698720911;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VvFpMtA_1698720911)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:55:12 +0800
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
Subject: [PATCH v4 0/2] Some fixes for idxd driver
Date: Tue, 31 Oct 2023 10:55:09 +0800
Message-Id: <20231031025511.1516342-1-guanjun@linux.alibaba.com>
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


