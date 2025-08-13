Return-Path: <dmaengine+bounces-6015-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D138B25158
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 19:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A0F887403
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6488D2EAB90;
	Wed, 13 Aug 2025 17:02:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B4298CAF;
	Wed, 13 Aug 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104523; cv=none; b=NcjIncdnIjYs1Ihy/p6PB/kAWao1PhkFYJI/ZVgJDwXVzTd/FHgVEeou66/YPrlpgN+l5qmndd4w27USNGZYsDPdoKArC9CBHmQhGq6E/GQBzHZtjp5CoH4q2WA3D33m/VdXQwwWyfbF2U1hE/tGzbZjLhxWUdR2OB7i4vxmHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104523; c=relaxed/simple;
	bh=tGc5odpAlI9Jc9rNn+CWgNgQ2EYb4lXXkwp3jGw2aKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R99qLJlja2rS49wxR2+fYzPDXo1CyBLjd4iwbsnL1/arvdzKkDEXGD0mXz/5nXMaAnVR+SMd9NRqpZlQiRxtdYQ38WbgufBheyisap0LKRac0U1nFNZUgy2bhY3L76I47ghkJIE80AFajyXn/yVFuHnhsK15De4bhDbt/6MFZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35A361CDD;
	Wed, 13 Aug 2025 10:01:53 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 181F03F738;
	Wed, 13 Aug 2025 10:01:56 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	mark.rutland@arm.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	coresight@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 08/19] perf/arm_smmu_v3: Improve group validation
Date: Wed, 13 Aug 2025 18:01:00 +0100
Message-Id: <c0e5e426b571a438a88adc8a9e16d2f066171cc2.1755096883.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1755096883.git.robin.murphy@arm.com>
References: <cover.1755096883.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The group validation here is OK, except for the benign issue that it
will double-count an event that is its own group leader. Even though
it's highly unlikely we'd ever have PMCG hardware with only one counter,
let's sort that out, cleaning up some reudundant checks in the process.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 621f02a7f43b..7cac380a3528 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -377,9 +377,6 @@ static int smmu_pmu_get_event_idx(struct smmu_pmu *smmu_pmu,
 static bool smmu_pmu_events_compatible(struct perf_event *curr,
 				       struct perf_event *new)
 {
-	if (new->pmu != curr->pmu)
-		return false;
-
 	if (to_smmu_pmu(new->pmu)->global_filter &&
 	    !smmu_pmu_check_global_filter(curr, new))
 		return false;
@@ -422,15 +419,6 @@ static int smmu_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* Don't allow groups with mixed PMUs, except for s/w events */
-	if (!is_software_event(event->group_leader)) {
-		if (!smmu_pmu_events_compatible(event->group_leader, event))
-			return -EINVAL;
-
-		if (++group_num_events > smmu_pmu->num_counters)
-			return -EINVAL;
-	}
-
 	/*
 	 * Ensure all events are on the same cpu so all events are in the
 	 * same cpu context, to avoid races on pmu_enable etc.
@@ -442,8 +430,16 @@ static int smmu_pmu_event_init(struct perf_event *event)
 	if (event->group_leader == event)
 		return 0;
 
+	if (event->group_leader->pmu == event->pmu) {
+		if (!smmu_pmu_events_compatible(event->group_leader, event))
+			return -EINVAL;
+
+		if (++group_num_events > smmu_pmu->num_counters)
+			return -EINVAL;
+	}
+
 	for_each_sibling_event(sibling, event->group_leader) {
-		if (is_software_event(sibling))
+		if (sibling->pmu != event->pmu)
 			continue;
 
 		if (!smmu_pmu_events_compatible(sibling, event))
-- 
2.39.2.101.g768bb238c484.dirty


