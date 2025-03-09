Return-Path: <dmaengine+bounces-4669-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA6A58118
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 07:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05648188B9C3
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF31624C3;
	Sun,  9 Mar 2025 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gTLT4JlQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD31A8F74;
	Sun,  9 Mar 2025 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741501282; cv=none; b=EPOzXlsRVedlh/oJxjtG/eUrM5w4nvk0/IgrnkJZ9MGtMDo3vwAhYR0l7PWvLOoxztXRj6KMVrq12U4ZHJGEk1xhTvTSnje/Y6gAxTQqONFkfoqlbY/NzwyAxKdmaNVJVzGjVs47UE9XGOpRH1D+CfrjbnIsw88uCBj79zPbZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741501282; c=relaxed/simple;
	bh=Vp01ITNOOkGnwN1qWqwbUpN6t0VXYSyEKmvcuktiah8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZsdhDbU7sR/8cCP13/FveRSyQTE2pvNuI9eaDOxUpP+syVNrJxAJaDHlRWHQOLqFhQb2IvuDCbzRqQicMR40spLfgVKtmo6gGjdsslxA7OwjdT0QUZgfwuCXXUl4AzgC2FcsTVkzDorHNiWuFsf2qYETg1PdogqNcZcgg3JO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gTLT4JlQ; arc=none smtp.client-ip=47.90.199.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741501261; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=84BSTPKsEHNbHHLF0j35JxpV2jRI56UR1rHEdPtI3Eg=;
	b=gTLT4JlQr3mgg++RKBJZf7DkNrPByO5aDD1Cwapy7iFGsg2A8qsu24zobY8ckBnu6jX9VivRmn9jMivZgW92+14GqNLdHfyt0TMX6JuQ1SJxZzWfVW/MwvaexXbCe7GhyQruznVMmwm0sRKbBkceWr+q30mP59C7PfObp4P046M=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQwVyiJ_1741501259 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Mar 2025 14:21:00 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	Markus.Elfring@web.de,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] dmaengine: idxd: fix memory leak in error handling path
Date: Sun,  9 Mar 2025 14:20:49 +0800
Message-ID: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/dma/idxd/init.c | 160 ++++++++++++++++++++++++++++------------
 1 file changed, 114 insertions(+), 46 deletions(-)

-- 
2.39.3


