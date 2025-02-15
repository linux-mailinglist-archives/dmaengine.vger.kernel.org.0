Return-Path: <dmaengine+bounces-4491-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD578A36C2F
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 06:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDA23ABCF9
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 05:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D7C197A68;
	Sat, 15 Feb 2025 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hDcqs8xo"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960C1714CF;
	Sat, 15 Feb 2025 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739598282; cv=none; b=cRLb7fEZE2RqXIbBbvJ9N3njg1fuBjQOfLtrDpYqbaHEJo+Fxsh2eFnF9RdvYh9MdxxEY0x4dqaQF5Dd3loeqR9BBSHNYsiciAJFKA9xOuL0wH+biy0QGqGFTeDouatYgcWs6bgx6JM4zOb97a7hWZTRni4kux9o9//w2SFhikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739598282; c=relaxed/simple;
	bh=sXaN64ej2EoMki/lxw2I/rnnLCL7roUqvV1Jzzq6lSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdsbE0zVfPBj5P0UZLFC+TVz26l77dLEUaZfFGrY7OaMpJ7ubrtfo0pIsnLmzrXC3BI7kWg5Co8kEBDMU5r9sfhXyKakaax3tXpg4Hzax6h3OfJz1muVdsAsLMV23rdNJI2Y80kMMeMyzq6w8LWMrHuESXtD3BbV4ZCJ8SXuIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hDcqs8xo; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739598275; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wethGuIidRNpnCkYM6wgAu5bx2tackfeipFWL5/OdMA=;
	b=hDcqs8xo3nTjgGU+hj7O0rSyqW7utssDB1kcIhxBrML90jGCUDN3ROWgzSTO8eX34qr32AgVGbsOxK3lVbYgtgqXU+nazCaAKfIT5FrPSDw8B4zTjfsoSVkBXMFfopXOpGM7ZKaEyfUyXcY7433QYQ+2ss1iG+qKtD1rjilU5ZE=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSysNm_1739598274 cluster:ay36)
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
Subject: [PATCH v2 2/7] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines
Date: Sat, 15 Feb 2025 13:44:26 +0800
Message-ID: <20250215054431.55747-3-xueshuai@linux.alibaba.com>
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

Memory allocated for engines is not freed if an error occurs during
idxd_setup_engines(). To fix it, free the allocated memory in the
reverse order of allocation before exiting the function in case of an
error.

Fixes: 75b911309060 ("dmaengine: idxd: fix engine conf_dev lifetime")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index b85736fd25bd..4e47075c5bef 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -277,6 +277,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(engine);
 			goto err;
 		}
 
@@ -290,7 +291,10 @@ static int idxd_setup_engines(struct idxd_device *idxd)
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


