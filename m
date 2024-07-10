Return-Path: <dmaengine+bounces-2663-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B7B92C8EF
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 05:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637081C21676
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBF11B809;
	Wed, 10 Jul 2024 03:08:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94ADDB3;
	Wed, 10 Jul 2024 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580934; cv=none; b=G7dZo/T+Jq5jRg5xZTSVeHI+EljPsR8iqzu/DcqmjOiLBaBKSi0N5dAbvMqr5O9F2BOq/AMWeuIs7Xczf9DuPN3eUfwOKMRhn2LBHLV4FTCqDuhIzYE8fc3nugb8i4QQEVOrjq1bjOKcfR+lbm9eUv0nT7vczwePnNuJqATlnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580934; c=relaxed/simple;
	bh=ylkz+9Tkq82rryJiTWCBdgAMbN1mSobjqfR6mr6/pMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVJN50jHvX/KzuVg+I+ayJTIq202f4/fNjrILOxAT4pLm+NFnwnvLBXBhrreCPK/FSQvdxODlprSoL2ePoKkZcuKMd218gJaCSV1kp3KFZRa6yt4R4yQHU2BQ5HWiT21Mtzam6YLo3Q6kYIHpEMc7oh+ItEtLGesDsmmeutXmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXX1s9+41mnYL3FA--.47159S2;
	Wed, 10 Jul 2024 11:08:46 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] dmaengine: idxd: Convert comma to semicolon
Date: Wed, 10 Jul 2024 11:07:25 +0800
Message-Id: <20240710030725.1960882-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXX1s9+41mnYL3FA--.47159S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GryktryUGFg_yoWDCFb_Xa
	47JrZIgFnrZ3ZIkF1j9w45Ary5Kw42q3WkWas3K3yIvrWfGw45ZrWDZr93Gr9rC3y0kFyq
	gr4DZr9xury7XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
	6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjC385UUUU
	U==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/dma/idxd/perfmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index 5e94247e1ea7..e596ea60ed3c 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -480,8 +480,8 @@ static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
 	idxd_pmu->pmu.attr_groups	= perfmon_attr_groups;
 	idxd_pmu->pmu.task_ctx_nr	= perf_invalid_context;
 	idxd_pmu->pmu.event_init	= perfmon_pmu_event_init;
-	idxd_pmu->pmu.pmu_enable	= perfmon_pmu_enable,
-	idxd_pmu->pmu.pmu_disable	= perfmon_pmu_disable,
+	idxd_pmu->pmu.pmu_enable	= perfmon_pmu_enable;
+	idxd_pmu->pmu.pmu_disable	= perfmon_pmu_disable;
 	idxd_pmu->pmu.add		= perfmon_pmu_event_add;
 	idxd_pmu->pmu.del		= perfmon_pmu_event_del;
 	idxd_pmu->pmu.start		= perfmon_pmu_event_start;
-- 
2.25.1


