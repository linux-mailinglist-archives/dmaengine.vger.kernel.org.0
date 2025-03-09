Return-Path: <dmaengine+bounces-4668-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA2AA58116
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 07:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB6D16A50F
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 06:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCAC1A08B1;
	Sun,  9 Mar 2025 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UpKr4eUQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2ED189B8D;
	Sun,  9 Mar 2025 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741501278; cv=none; b=C5qRE21sE1OxNx8veJ2JP0e0tLyYlA9oiVhAyvNBW15lHb53K3+CxbUJs3Sxkt2GpDT3AfVDtpSi85CaMsgAVY2PTVBIZd/GIJRagSiuUFCG3bQiC5ZnHq5KGOJ/K0tLoudLTK29FWCavl5nhecLA7M3BnKOEkJqntdkisybFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741501278; c=relaxed/simple;
	bh=rFJg6wX+4DM5TwYS6r8tr1DJyb+oo7EumjnC/NyCmXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SX1VtPUJAgc6jvKXKYWIDE11y/YjTRlVOkz73OtUjvDVcOD5sSIO9+IkPH1oDX/+7ftBKXJTigQHNK8sSQPRQCCaLqMrMqIZtsI8CwiCVzjPp09qhx6NaUhNMddidHyjfXZyTHhitjB7M5PiSsJ8P6uPhyzPDJdMZGsdCyX5bDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UpKr4eUQ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741501266; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GnnFGqjb+BGHMl8EqY9dK4ejKzhYXIwh/TR7Rbf7cvs=;
	b=UpKr4eUQ+jjVnA1x9JOC1p0jmYQWYBIA+DS5HV+75+DDZ75VLnHid2rkYFUnFVSeYjQcdaUFiUSi7cXBoybnFsUzWhVvM64KeOMN0G0muDFOPCVYp+dZW1j0kHbjFlNcBsNsE6UatEIk05hlrOOJw+Fk6ziw8D1mcPcy1NcIhGc=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQwVyl5_1741501265 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Mar 2025 14:21:05 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	Markus.Elfring@web.de,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] dmaengine: idxd: Refactor remove call with idxd_cleanup() helper
Date: Sun,  9 Mar 2025 14:20:58 +0800
Message-ID: <20250309062058.58910-10-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
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
---
 drivers/dma/idxd/init.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index ecb8d534fac4..22b411b470be 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1310,7 +1310,6 @@ static void idxd_shutdown(struct pci_dev *pdev)
 static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
-	struct idxd_irq_entry *irq_entry;
 
 	idxd_unregister_devices(idxd);
 	/*
@@ -1323,21 +1322,12 @@ static void idxd_remove(struct pci_dev *pdev)
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
2.39.3


