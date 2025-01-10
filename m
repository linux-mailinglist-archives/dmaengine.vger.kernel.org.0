Return-Path: <dmaengine+bounces-4096-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11773A089E2
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 09:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACF016534C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 08:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80320208978;
	Fri, 10 Jan 2025 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fYSP68zh"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF52080F4;
	Fri, 10 Jan 2025 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497371; cv=none; b=J76u7weLe3WH/Cw+wXDDFOp3a9Fo7QsOluYR2MuA1rzLg+Z8FvUJrRZGAguWnxd2MyZRmrcDci2jXxoYb5s+/JLSBISciRT+Km7RbZNaim58353X2E2xbKOkT81SpOdABedJDgmJx/lvFY+8skAt8JyqWmRgLQ6BjcDUK/jrUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497371; c=relaxed/simple;
	bh=H4QyKG/CIPygzjcUse2kBVn446AYwzUzYW4wUkNpEbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcm5aotbW851mmRq9dW2NvAKp69q4v4IdqQX2v1seqdgi7soZhIx5SGXPU74/9QqrqyBAj+03hCik2988oJwHPWcy7A8cESamBSMsPFTl7SnlW7kdAsPYyFXZR4fC/aYK2SOTXGo4Y8jX4EwdTr8MJzy8G+svKDs9ij9zDS/PNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fYSP68zh; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736497361; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gyz7gxL8sTioSa9ZkEFHWicCkHY5IqxE613ISdg8wqY=;
	b=fYSP68zhiOIN+SSOf614CCesrLPjpqax15QMA2JxVtukWO9eULKKGqqt96Bh5G9SmheqhpmanJe7UTG1WozlkofNzK4VhoNfOu2fmWvHr4eC6q3c97eXE1SjBxMTbpYAsQ1BBv87zBdZuve6/emoetKsoGebHPWZdVz/rSnXLU8=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNKKAyC_1736497360 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 16:22:40 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups
Date: Fri, 10 Jan 2025 16:22:35 +0800
Message-ID: <20250110082237.21135-4-xueshuai@linux.alibaba.com>
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

Memory allocated for groups is not freed if an error occurs during
idxd_setup_groups(). To fix it, free the allocated memory in the reverse
order of allocation before exiting the function in case of an error.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 12df895dcbe9..04a7d7706e53 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -326,6 +326,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(group);
 			goto err;
 		}
 
@@ -350,7 +351,10 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	while (--i >= 0) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
+		kfree(group);
 	}
+	kfree(idxd->groups);
+
 	return rc;
 }
 
-- 
2.39.3


