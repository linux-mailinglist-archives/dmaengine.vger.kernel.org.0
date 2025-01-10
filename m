Return-Path: <dmaengine+bounces-4097-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FDCA089E3
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B127166C8E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7120897B;
	Fri, 10 Jan 2025 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W5UM5Od/"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FFA2080F5;
	Fri, 10 Jan 2025 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497371; cv=none; b=Rj064DlgCx5l+AdtGgwWBYdkpyjjmZeV3airsrVMlgmnHUYg6/iOPgD1HGpvKHVexKFvsQcvWF07p9ypHo3T6d8FCpQNtHHZxh7wBeSSV/VlLW4kbOF27DWNCKVT73HdFE+k3MjE/dU0diiDcTJatvHZzDBXAu+JV1JhFm5npOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497371; c=relaxed/simple;
	bh=6ynP5QCemGa7ciqesmiSqlv75Ch+kPi8NjIPF5qgKgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWNx3JL1LO+9dyjDVN5zjTKe2gAuIwrbOXX2ysqbowbS8Sth+LPpfRKQHuJ1dnI0anffvSAIM5+ugQcJrm+CmYZu+BrVsGGnxhD/yZtFx4++ovDYYBxGpd/TGLfqp1mEZeZwSKa1jyRKyEz7dc6Llkp5cyeJ+bKvMarSgTZ18JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W5UM5Od/; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736497361; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YK9ONjM2RkwwA5jSpeWYcpHTJVS9yzZfconXO/4rrbI=;
	b=W5UM5Od/PY2oS2hJ4BPHQgKI91ZEUioWa+MbrEH06qqh5Hs+QsbSK8kNgFBhzP/T6MsOOevSsKiBr+lXZG8G90dNLc66Y8f7LfD5iqLGGJMgVY4OX/1DmFh6XomlDdihxY0Q0k3NiZVSFDWTsz1DhI88os4T9MW2pWubmxwiqcc=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNKKAxz_1736497359 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 16:22:40 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines
Date: Fri, 10 Jan 2025 16:22:34 +0800
Message-ID: <20250110082237.21135-3-xueshuai@linux.alibaba.com>
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

Memory allocated for engines is not freed if an error occurs during
idxd_setup_engines(). To fix it, free the allocated memory in the
reverse order of allocation before exiting the function in case of an
error.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 6772d9251cd7..12df895dcbe9 100644
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
2.39.3


