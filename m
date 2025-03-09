Return-Path: <dmaengine+bounces-4661-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B49A58107
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 07:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14C7188B9E5
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011215533F;
	Sun,  9 Mar 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iF8fSaBs"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3F74C08;
	Sun,  9 Mar 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741501273; cv=none; b=SPjpQ5gfzyVGw/9K4orixsjfsIw0jLpeS4/VdZPdlVlQ5DJIcuqvz8H3fGMTYUYQmYDOJpRUyMnJ69zBD0NCYmOTQE8cxOssUYeEP3zp9cckU/n9gVmyoyHuDc7U+Iw4FjnGloM5vFqeyYi54Xw7ihovJ7RxWKjPPEMDK29E7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741501273; c=relaxed/simple;
	bh=9JjsKNe/pTa5cFCny47dxTFyZwHbupfDEUMLHd+FxF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjnML9/KAjc8GVRNxPiqxmlr7LVYw+NtzeuTlIPpwpzKFb+Lg9HGfCBGOdxNdg9+5g3XEvH79ns7IYma9ShaSvfDzR2XUOC01QgrPMVpdpQoXcS9Xyq+gZae4aLBxmdrLOal4nDYK48g+R9D3x5nTJOCnP2n2t/oo3flOMvEkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iF8fSaBs; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741501265; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wBGjXbp0GM+4ADvXVy22yPr21ukUvRX6OJkgDMndLeE=;
	b=iF8fSaBsEAAfRWR5RrXgFRCSuxB7PqxhA46+WpcWkRTtAQZbXoPFSA9BJ+4X+PPnPdpoHxr5CYUE3mkLTr0T9ycPFZZUHH6T8bvYoSeylSDzmuBOz0QjWK25bTge3MI/Bxr2u2PeKpyukrEdpRHbOuT+mEyI3m0vfDl62M/d9gk=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQwVykp_1741501264 cluster:ay36)
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
Subject: [PATCH v3 8/9] dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call
Date: Sun,  9 Mar 2025 14:20:57 +0800
Message-ID: <20250309062058.58910-9-xueshuai@linux.alibaba.com>
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

The remove call stack is missing idxd cleanup to free bitmap, ida and
the idxd_device. Call idxd_free() helper routines to make sure we exit
gracefully.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Cc: stable@vger.kernel.org
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 890b2bbd2c5e..ecb8d534fac4 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1337,6 +1337,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {
-- 
2.39.3


