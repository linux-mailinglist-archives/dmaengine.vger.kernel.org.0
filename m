Return-Path: <dmaengine+bounces-4494-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D29A36C39
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 06:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67929189637B
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 05:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF83B19F436;
	Sat, 15 Feb 2025 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f1PtebCd"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D9199249;
	Sat, 15 Feb 2025 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739598284; cv=none; b=LylNZo3OILwOSfC7ybZZwA5lmQpTnffnX7oEpn4LeFlbEeqLBpCr6RXBkhmP+Dnrox/ElHq/wivRRWK1Wrr8ZKempRTGpKxUm3lfDHpbL4J7zKPBq+3t6NS9hVs9Lgakygf88ks9UarG4Hv1zCPNcB8wXWGRp/4EzuqAFv57Vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739598284; c=relaxed/simple;
	bh=NCSdWgAyB9GwA2YCGu135x1XWwxq+kEerYZhAyuyT48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIWlO8qwdURGWQCyw0tb6PxWhv0XqBCIofgcyCZdlaxUngT1RNTaCo1M1M44jm+VC1Ve19HE7xzEOADOvLw0yvQpTMKWmCVfdrzxtFCgOAw2jpDZ3nb0Yz3czcfASFt0g37RRNKHfhvxMH2z5wioU+IO+YEZJJVMblTGzkn+eqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f1PtebCd; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739598273; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gaohxVqLnwihnfcqEQStSwIObC4TyJYGXBI1LEh0Ans=;
	b=f1PtebCdJEFRM0mdS5P0uOb2jLghG7bGY/5t/dAFyYxUoYgVQNRv1fwITUmyuoIiWOVOl7aJUeC/UM/J6mjYkivR3vf4nuygzoHQsT+Sl7bmrjwCLtSQMtwszfDCVPT6TU/wVdXDfTkKL7WQPJnauzkSbf1eNCshynRqjG6hJB8=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSysMy_1739598272 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 13:44:33 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: nikhil.rao@intel.com,
	xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] dmaengine: idxd: fix memory leak in error handling path
Date: Sat, 15 Feb 2025 13:44:24 +0800
Message-ID: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v1:
- add Reviewed-by tag for patch 1-5 from Dave Jiang
- add fixes tag
- add patch 6 and 7 to fix memory leak in remove call per Vinicius

Shuai Xue (7):
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_wqs
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_engines
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_groups
  dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_pci_probe
  dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove
    call
  dmaengine: idxd: Refactor remove call with idxd_cleanup() helper

 drivers/dma/idxd/init.c | 75 ++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 24 deletions(-)

-- 
2.39.3


