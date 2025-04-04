Return-Path: <dmaengine+bounces-4822-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A32CA7BC41
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CFD3BCA1C
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5F1EFFBC;
	Fri,  4 Apr 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cZBPEYzU"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333E1E1020;
	Fri,  4 Apr 2025 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768152; cv=none; b=Jk8Xcdf4OKWPTcdkxsw8Uxm6xAJYe7AjKRnOtIe3koRxOzFG3kZNK2wVvWLhnwdXwM2sKWrgp1sEcfeRoUuYIpQESVrt5em8RBqVNer+TcXYxQc0yLdVxvDPLXdeC21Jrqh1eNc2Oom7HiBATo2jxIYx2TgetpESC/sXGWY6uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768152; c=relaxed/simple;
	bh=KAyEV8BTleWW1dzXEcTbbOThEjffpdF7ikqrRRQ/Nzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOGnEHJNLVpEWk5ICbQIvNKr2LLUiscPG+QFeRMSxswt6Jo1m0h3VaoNDbHs4W+aIbdx1zJClhclp7NZam8oiBK6LBY1RA+4Vq7/s0EvFFfBLjGLOYN1fVX0wOfdQ8A8fWbkLr+uSlMwC00fBt1nSiKWQ+5N2QeEl1Op4j26OSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cZBPEYzU; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743768140; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bHrE7lpbUgz12wfwjxk2eHqBwsJF0K53E2iCqsP2ONE=;
	b=cZBPEYzU5FKBfy6Xc6OQzR+vNIItc/+6D2QKJ1WwRafS+t3vegUsIHkMPVl9+k5Sn0UtEbOqrVE52k9OF7wT78DUsnEl2ugKlVqyAzZoGrjAGVBGCK0j5dOLyGffk6Qrly8Z3sC5/sTLvU1F/cq12wSg9NkX9Yk4Ho2Ol7+u0/0=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUyld47_1743768140 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Apr 2025 20:02:20 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines
Date: Fri,  4 Apr 2025 20:02:10 +0800
Message-ID: <20250404120217.48772-3-xueshuai@linux.alibaba.com>
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

Memory allocated for engines is not freed if an error occurs during
idxd_setup_engines(). To fix it, free the allocated memory in the
reverse order of allocation before exiting the function in case of an
error.

Fixes: 75b911309060 ("dmaengine: idxd: fix engine conf_dev lifetime")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 drivers/dma/idxd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 80fb189c9624..ff6ec3c0f604 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -275,6 +275,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(engine);
 			goto err;
 		}
 
@@ -288,7 +289,10 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		engine = idxd->engines[i];
 		conf_dev = engine_confdev(engine);
 		put_device(conf_dev);
+		kfree(engine);
 	}
+	kfree(idxd->engines);
+
 	return rc;
 }
 
-- 
2.43.5


