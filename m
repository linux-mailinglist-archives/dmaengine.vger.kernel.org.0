Return-Path: <dmaengine+bounces-4099-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24952A089EE
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 09:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA403A37B6
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B8209F3B;
	Fri, 10 Jan 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WnJ8kU0n"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10650209F42;
	Fri, 10 Jan 2025 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497376; cv=none; b=kZk8XDTCAED8YLJbMETZgjyeIJ0/19CNoL1rocuguDmhTe3aCKKpfM1bC7w9KegmbX8XAf43Pe+v7anZ2fHtgKRn6gfI/qtc/W+tK1g4l4ytWVt4DMQrqu02yUt0hPlah7vANDKyQCHreR0o9HdyxWoXtifeNdB5ud2E2Gb9ZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497376; c=relaxed/simple;
	bh=jAXyNdGpLusIMcN0H/AcL5jBYzQPf6ZZaDI5zT7gpcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjpxpBN1NBLsVj3+gnwcZHLaKZCL1jbEC4qhu+wuB2wW8dzmWHOnveDPCH/jmMWYEt/N8tr8Bmu/4mm3AfroFEb8X4cpPS1mPIWFlsyXVCpqWzoPPIlVTlItHTM37lco04x/hQPSAtLs3fEbjg26LSuePUGZT2eIrn7lZfam3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WnJ8kU0n; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736497362; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=d9edESLYCYiUNjixE+f/sSXJEX3fsz5wEeQXrpg40es=;
	b=WnJ8kU0nkl+1GpVKWIQgi7dJLa5mZ2O9+kovgv3RFDl9/saYwW1KSAhJp3xbIy1TRz6xtgMUfT4quoQZ++ezOfMd2FCpOj5vBlHou9r1IgB/ffvhDCoHRNwrnuwoUyvtSHL/oHzjcUcOCiF8tSUyjvMFwoeidotr+nMGIBOia0Y=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNKKAyo_1736497361 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 16:22:41 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe
Date: Fri, 10 Jan 2025 16:22:37 +0800
Message-ID: <20250110082237.21135-6-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory allocated for idxd is not freed if an error occurs during
idxd_pci_probe(). To fix it, free the allocated memory in the reverse
order of allocation before exiting the function in case of an error.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f0e3244d630d..9b44f5d38d3a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -548,6 +548,14 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
 }
 
+static void idxd_free(struct idxd_device *idxd)
+{
+	put_device(idxd_confdev(idxd));
+	bitmap_free(idxd->opcap_bmap);
+	ida_free(&idxd_ida, idxd->id);
+	kfree(idxd);
+}
+
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
 {
 	struct device *dev = &pdev->dev;
@@ -820,7 +828,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
-	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;
-- 
2.39.3


