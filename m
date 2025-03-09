Return-Path: <dmaengine+bounces-4660-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EE1A58106
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 07:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631683ACA9F
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8AE155312;
	Sun,  9 Mar 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xrVwu400"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66358C2FD;
	Sun,  9 Mar 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741501273; cv=none; b=rrzT14HURuSO5cs76uw++aZ1CawMpzwwhKSmBOP/xIz7cFWjfgmNo9Zut9tztxZT5jEOV/Kt9mp94RGm+gSoOtvjxuRkdGxRu9L8oFaNqzP8iFbFSLQCrc9SqWfZQo0wdlUV3PlQ/cbfca/HDvi0uNsu9XyX7VnySssmpNAWGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741501273; c=relaxed/simple;
	bh=a3LZEOWgt30roXlarkggTK85wHwSTl/6fC4nr3tez8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/mD3JMqbdAgDPqHWzHEXDuoXYA/TAS+GjGTAjb+8/d9hp6EliGwLtYxCRscaOLK2x/k/wVoleOquHZSEUSzIdEgpCQUTuHJ/O06IyPrawQvI/sjsPpIzGF4ga3J2tm33o/lVKqlJIh4KdhhZpzmX5rI9nV8590QJvVVztfzgVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xrVwu400; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741501264; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g8FIaFRSVIzx4OWuvnOoGuSSy2PvyTV5ohpHNn/0M8Y=;
	b=xrVwu400NBSMOCe1eXGJ3DGRzp8bjk6xMCXHGE5XGYKVH8LxWaTLqh0GJxV3pnX7djbdum4c8teFWImoDTq2vzCAFn/qLILTWVF29cdkM8ADp9ICbUPtXJ6mbDuqmH7H6nmCWPBDdbKrPgr12OrHqUbDhdAf1QdER3PS84RJP20=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQwVyjq_1741501262 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Mar 2025 14:21:03 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	Markus.Elfring@web.de,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] dmaengine: idxd: Add missing cleanups in cleanup internals
Date: Sun,  9 Mar 2025 14:20:54 +0800
Message-ID: <20250309062058.58910-6-xueshuai@linux.alibaba.com>
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

The idxd_cleanup_internals() function only decreases the reference count
of groups, engines, and wqs but is missing the step to release memory
resources.

To fix this, use the cleanup helper to properly release the memory
resources.

Fixes: ddf742d4f3f1 ("dmaengine: idxd: Add missing cleanup for early error out in probe call")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 7334085939dc..cf5dc981be32 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -408,14 +408,9 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 
 static void idxd_cleanup_internals(struct idxd_device *idxd)
 {
-	int i;
-
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_groups(idxd);
+	idxd_clean_engines(idxd);
+	idxd_clean_wqs(idxd);
 	destroy_workqueue(idxd->wq);
 }
 
-- 
2.39.3


