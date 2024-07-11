Return-Path: <dmaengine+bounces-2672-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1D392DE18
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 03:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EF9282682
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 01:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA1B3D66;
	Thu, 11 Jul 2024 01:42:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9B23CE;
	Thu, 11 Jul 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720662171; cv=none; b=aXUyxr/Mkt6t72TjzNirZYV1XFXtkAdccIlH5zU/Q0he3ZnNwa0GG+Q3D8/ylbLHGDNooOprRTMRFbEAud3RD/mE3IVh3jcyli+rMyrNfD07DktD/IGdYmD26W8hnREkK9A9vglUsy22E6LHFfKdgYR3wdTqZej+22xu32292Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720662171; c=relaxed/simple;
	bh=+hFiLHKKR4zOZDA5egQpf/ujQyKFEbbwJra9p30L0U0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hNSlWe+LmFrIXoATpXONHiOgaSjIdsQsWwCZsbAXhMPyGxSHvRbPye9LAb22ctbuTqmBJGDOlkPwvQAl41KS+PRgKzUmcXCqPiOuaS3zhPiv9cKGYuUYJSKccyKY5w0VWsPyRF2qZKa6Z00aAD7zebkwyoj9hAInFLa32mBcBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAAHDsqROI9moDm9Ag--.1206S2;
	Thu, 11 Jul 2024 09:42:42 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] dmaengine: idxd: Convert comma to semicolon
Date: Thu, 11 Jul 2024 09:34:36 +0800
Message-Id: <20240711013436.2655373-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHDsqROI9moDm9Ag--.1206S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZrWfWw1DXw15Xr17GFg_yoWkGFb_Xa
	47JrZ8KF1qvwnIkF1Uur45Ary5Kw42q3WDWas3KrWIvrZ3Gr45ZryDZrZ3Gr9ru3yUKFyq
	grWDZr9xury7XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6w4l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5oGQDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon for
more readability.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Update commit message.
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


