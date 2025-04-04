Return-Path: <dmaengine+bounces-4825-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC11A7BC3A
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D95017C30E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAFE1F3BA4;
	Fri,  4 Apr 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wbZUWnls"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177EA1F0E33;
	Fri,  4 Apr 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768156; cv=none; b=H1mCE72yu4/D5j7HdzcbPgagOTr5gpZwx9aN3SQTjG9HP9TCmhKvG4tZ0psmkuX9UJZi1oqCx9Cyh/lWOvCd9o90V5vzDplwOAelP7uBiwXwpNNZcblaPxCJVEUblXmWQ7fURA0ZZemOxKA79E8PJAd0JTILn+QxMWEUhaLSlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768156; c=relaxed/simple;
	bh=t20dnQbl8Sv6KyVku6tQirwcP+wWaCcCuhQMzFuA4qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFDq6Z+/YwDhzfoY4EpEb6c4J8LvS2ENixfG5JNKl+/FnpMvmXRWpsl5XM0HX6N49IemMMWQsVmstNXOrri5CBhT9Fl5GBAMMHKIkP8pIBQIll9zppCbDZdbom6WeWugPJgZQKHa9lSRXBu6ljDgk9EFAan0WGPyfvWm/HoNLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wbZUWnls; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743768144; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Tmy+ZorzD11pKLZvBB/hJhvgTc4giBS+7kJVYCpQrMA=;
	b=wbZUWnlswoVsmdHJwptNcxx4fQi+W2ruWvqd/d4RGCjj7Y8Ra/3ekVCZkF0Qykm078YzRuOiXWK/Q3eScPF0NNEvoeXFBKASW+3iZUCdZovWycL8Pf5tW70D/9UVtQvyEHg8aQXZRjTAKzrs6VGfJZaKUdgOGADggQp4jUyisz8=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUyld6R_1743768143 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Apr 2025 20:02:24 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] dmaengine: idxd: Refactor remove call with idxd_cleanup() helper
Date: Fri,  4 Apr 2025 20:02:17 +0800
Message-ID: <20250404120217.48772-10-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The idxd_cleanup() helper cleans up perfmon, interrupts, internals and
so on. Refactor remove call with the idxd_cleanup() helper to avoid code
duplication. Note, this also fixes the missing put_device() for idxd
groups, enginces and wqs.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Cc: stable@vger.kernel.org
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 drivers/dma/idxd/init.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 974b926bd930..760b7d81fcd8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1308,7 +1308,6 @@ static void idxd_shutdown(struct pci_dev *pdev)
 static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
-	struct idxd_irq_entry *irq_entry;
 
 	idxd_unregister_devices(idxd);
 	/*
@@ -1321,21 +1320,12 @@ static void idxd_remove(struct pci_dev *pdev)
 	get_device(idxd_confdev(idxd));
 	device_unregister(idxd_confdev(idxd));
 	idxd_shutdown(pdev);
-	if (device_pasid_enabled(idxd))
-		idxd_disable_system_pasid(idxd);
 	idxd_device_remove_debugfs(idxd);
-
-	irq_entry = idxd_get_ie(idxd, 0);
-	free_irq(irq_entry->vector, irq_entry);
-	pci_free_irq_vectors(pdev);
+	idxd_cleanup(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(pdev);
-	pci_disable_device(pdev);
-	destroy_workqueue(idxd->wq);
-	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
 	idxd_free(idxd);
+	pci_disable_device(pdev);
 }
 
 static struct pci_driver idxd_pci_driver = {
-- 
2.43.5


