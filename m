Return-Path: <dmaengine+bounces-4490-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A830A36C2C
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 06:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F1B1892DE7
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 05:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7244D190472;
	Sat, 15 Feb 2025 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="On5Vxi8S"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72134158D8B;
	Sat, 15 Feb 2025 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739598281; cv=none; b=UjtR+2bx6KeSJQzOm0oPca/rYaSQT71f1qcSbYvsfBZIthqKacbOI5BKANa5MMKnxmhQWem5Fiw45PdQumHxXXvXbD7zLMXoE8d+9EWah53JczVeR75Z2s7sJNIN1tK78p3wQx/HiBaMrH2j2xCqT30TKvk2VJUYOWTK1Clmvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739598281; c=relaxed/simple;
	bh=kNrbFcj4cpsPTOptFX/x1HhuyqO99srfA6H4nXAHOMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JawrQf1WOzxM24LATKN771vJHWM5yVXgZAKHC58hz3/GongC8KhzU7SvH5VZ7F0hL0RC5CkF5Ck3XFr1bbO65gvhxARE/RvRxLNTs7hxbyJwx588k4ClCa0+XQLF4AMFli5lZIDSCgMlE6s7gJwnrxueEN7EH7X35xVLGuTSNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=On5Vxi8S; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739598275; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+MVbKIezpcfCtllaZ2ooZF6RIq3YcQ+WJC5+YDPcqIk=;
	b=On5Vxi8SMCIYleTz0FfZHWSwRFxtKnewN1igt/YCFdi7if40hqfkMiXhEy15U89bZ88P7yv/ll7QOq3J2eWZf7/C11rEAHuCz70be+g5oOzZtobtwCJo+frT2p14ZJriNJgdYNXpeBKDSecfpWPIgvCKH3PY61qufi0jYDlQMAE=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSysNs_1739598274 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 13:44:34 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: nikhil.rao@intel.com,
	xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups
Date: Sat, 15 Feb 2025 13:44:27 +0800
Message-ID: <20250215054431.55747-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
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

Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 4e47075c5bef..a2da68e6144d 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -328,6 +328,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(group);
 			goto err;
 		}
 
@@ -352,7 +353,10 @@ static int idxd_setup_groups(struct idxd_device *idxd)
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


