Return-Path: <dmaengine+bounces-6022-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C68B25187
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E609A0CD4
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D303093D0;
	Wed, 13 Aug 2025 17:02:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52A305E3F;
	Wed, 13 Aug 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104555; cv=none; b=ok8l/bjBdeX0K1dJODoh9zA4v5aFYObfUSdchJEU02xARv74X7723M4NJSHDzAmaYUNkocRo5kIs3a/Ciq3NUQFQeEd/YaUcGRWSiTf8sS5fp6cyaCXUpLHiWKVBSwAcKEykscSsg5GDf2xhS77WRZklmF3GDuPwpsxJVsWsSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104555; c=relaxed/simple;
	bh=cNU0+Ft73J9+/wdNsELvJ8P6OEhz81JO5gVf7RQ3254=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snxOcNarVOMz6MdHbVem3NqpTc9pg80KUCuDoz2RHw8UoQ+lASJmF57xtTg8gmYlPH798t+74oO0C4jFNbSYhN6tnA7GBwblkLShsWxxwKUQEieMWzcCD2PcrHLoJPvEGP430aiajwkyUBxxt94kZCSUvkPZoEG4qENYcJnfSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF4931E7D;
	Wed, 13 Aug 2025 10:02:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A75D43F738;
	Wed, 13 Aug 2025 10:02:28 -0700 (PDT)
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
Subject: [PATCH 15/19] perf: Simplify group validation
Date: Wed, 13 Aug 2025 18:01:07 +0100
Message-Id: <8e86d5021812c720219c8843e5179fe03e5c4de4.1755096883.git.robin.murphy@arm.com>
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

All of these drivers copy a pattern of actively policing cross-PMU
groups, which is redundant since commit bf480f938566 ("perf/core: Don't
allow grouping events from different hw pmus"). Clean up these checks to
simplfy matters, especially for thunderx2 which can reduce right down to
trivial counting.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c |  7 ++-----
 drivers/perf/arm_dsu_pmu.c         |  6 ++----
 drivers/perf/arm_pmu.c             | 11 ++---------
 drivers/perf/thunderx2_pmu.c       | 30 +++++++-----------------------
 4 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index efa9b229e701..7f5ea749b85c 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -561,12 +561,9 @@ static bool arm_cspmu_validate_event(struct pmu *pmu,
 				 struct arm_cspmu_hw_events *hw_events,
 				 struct perf_event *event)
 {
-	if (is_software_event(event))
-		return true;
-
-	/* Reject groups spanning multiple HW PMUs. */
+	/* Ignore grouped events that aren't ours */
 	if (event->pmu != pmu)
-		return false;
+		return true;
 
 	return (arm_cspmu_get_event_idx(hw_events, event) >= 0);
 }
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index cb4fb59fe04b..7480fd6fe377 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -492,11 +492,9 @@ static bool dsu_pmu_validate_event(struct pmu *pmu,
 				  struct dsu_hw_events *hw_events,
 				  struct perf_event *event)
 {
-	if (is_software_event(event))
-		return true;
-	/* Reject groups spanning multiple HW PMUs. */
+	/* Ignore grouped events that aren't ours */
 	if (event->pmu != pmu)
-		return false;
+		return true;
 	return dsu_pmu_get_event_idx(hw_events, event) >= 0;
 }
 
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index e8a3c8e99da0..2c1af3a0207c 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -375,16 +375,9 @@ validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
 {
 	struct arm_pmu *armpmu;
 
-	if (is_software_event(event))
-		return 1;
-
-	/*
-	 * Reject groups spanning multiple HW PMUs (e.g. CPU + CCI). The
-	 * core perf code won't check that the pmu->ctx == leader->ctx
-	 * until after pmu->event_init(event).
-	 */
+	/* Ignore grouped events that aren't ours */
 	if (event->pmu != pmu)
-		return 0;
+		return 1;
 
 	armpmu = to_arm_pmu(event->pmu);
 	return armpmu->get_event_idx(hw_events, event) >= 0;
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 6ed4707bd6bb..472eb4494fd1 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -519,19 +519,6 @@ static enum tx2_uncore_type get_tx2_pmu_type(struct acpi_device *adev)
 	return (enum tx2_uncore_type)id->driver_data;
 }
 
-static bool tx2_uncore_validate_event(struct pmu *pmu,
-				  struct perf_event *event, int *counters)
-{
-	if (is_software_event(event))
-		return true;
-	/* Reject groups spanning multiple HW PMUs. */
-	if (event->pmu != pmu)
-		return false;
-
-	*counters = *counters + 1;
-	return true;
-}
-
 /*
  * Make sure the group of events can be scheduled at once
  * on the PMU.
@@ -539,23 +526,20 @@ static bool tx2_uncore_validate_event(struct pmu *pmu,
 static bool tx2_uncore_validate_event_group(struct perf_event *event,
 		int max_counters)
 {
-	struct perf_event *sibling, *leader = event->group_leader;
-	int counters = 0;
+	struct perf_event *sibling;
+	int counters = 1;
 
 	if (event->group_leader == event)
 		return true;
 
-	if (!tx2_uncore_validate_event(event->pmu, leader, &counters))
-		return false;
+	if (event->group_leader->pmu == event->pmu)
+		++counters;
 
-	for_each_sibling_event(sibling, leader) {
-		if (!tx2_uncore_validate_event(event->pmu, sibling, &counters))
-			return false;
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (sibling->pmu == event->pmu)
+			++counters;
 	}
 
-	if (!tx2_uncore_validate_event(event->pmu, event, &counters))
-		return false;
-
 	/*
 	 * If the group requires more counters than the HW has,
 	 * it cannot ever be scheduled.
-- 
2.39.2.101.g768bb238c484.dirty


