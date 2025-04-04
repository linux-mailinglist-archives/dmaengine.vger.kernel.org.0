Return-Path: <dmaengine+bounces-4817-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B97A7BC20
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6F67A523E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C071B87F2;
	Fri,  4 Apr 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iTinSIAq"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B0199FC1;
	Fri,  4 Apr 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768145; cv=none; b=Mya1/1/C2tEUdZjQMywljKIwsQKvpgB4nDeKKiYAaWibMvWqY5X7XDJTtJDxO4pdSOSmxzTpgMxmas6DQN/0f7aGht4Or0LQXaYpIRsEjI8l9RK78RdzxDzOHuqgR2cj3Dd06JUl5Md88W2gDtSAByCGksSlWALgfFPLK95f1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768145; c=relaxed/simple;
	bh=hf1nUoBxIUkyIsDCr6cE4xMcCUwG5afMeqtD/lwPvdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2D5WRmAwSYC4f5Ifge8AsbWXQ4+MmrCnl+33vlzOujUGmt/VlnDmsAPo+TsrUds+sWYbrR319Vg03E3Qq4xVjdgEgv5+8bZFrgMbhOFUKLCmh6xWTzFyGKShoEa7UMm/rqjQzOtUBZsLkEs3YFxwxY6bM9DUaIpZy3qjKDR5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iTinSIAq; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743768139; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DXqhybVw42vr+Uzpbj9gZAigGXTns6QEeApQhjx7zik=;
	b=iTinSIAqclvLRXx84yw3rQ67Je4P9B0Yx40+m05zYKPCC1wYyR4QSm0oy1GSOMeeO5AlEJGy4A/Wjl5qx97rJt1toX5KkxT4OX7/kiKel5lcmLMTIScnN7r1V6hFwx27F6W1CWC7g5PSp0BDxJWUH7b36vkGS007dNWIMMxCH10=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUyld3Z_1743768138 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Apr 2025 20:02:19 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] dmaengine: idxd: fix memory leak in error handling path
Date: Fri,  4 Apr 2025 20:02:08 +0800
Message-ID: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v3:
- remove a blank line to fix checkpatch warning per Fenghua
- collect Reviewed-by tags from Fenghua


changes since v2:
- add to cc stable per Markus
- add patch 4 to fix memory leak in idxd_setup_internals per Fenghua
- collect Reviewed-by tag for patch 2 from Fenghua
- fix reference cnt in remove() per Fenghua

changes since v1:
- add Reviewed-by tag for patch 1-5 from Dave Jiang
- add fixes tag
- add patch 6 and 7 to fix memory leak in remove call per Vinicius

Shuai Xue (9):
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_wqs
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_engines
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_groups
  dmaengine: idxd: Add missing cleanup for early error out in
    idxd_setup_internals
  dmaengine: idxd: Add missing cleanups in cleanup internals
  dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_pci_probe
  dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove
    call
  dmaengine: idxd: Refactor remove call with idxd_cleanup() helper

 drivers/dma/idxd/init.c | 159 ++++++++++++++++++++++++++++------------
 1 file changed, 113 insertions(+), 46 deletions(-)

-- 
2.43.5


