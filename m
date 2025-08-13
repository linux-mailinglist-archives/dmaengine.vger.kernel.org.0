Return-Path: <dmaengine+bounces-6012-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D8B250C7
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 19:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7CD7BAA2A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65472BCF7F;
	Wed, 13 Aug 2025 17:01:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2564F242927;
	Wed, 13 Aug 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104509; cv=none; b=RVxnQU+/F5C/YW1N3ob7Sxsa/deicsL4/3/iQI8sS9yVXK7zbt0U/1AgZMmShvxllun8KS0lHThaPgDs09lKoRDRyRJruPMCvMydHfSakC//NePXBpNZlQF+nx4gESNkkGPhvI3AXQcTp4UOkXACeocdRRvGzG9aEuAwLxJyKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104509; c=relaxed/simple;
	bh=xhd+T4zZccQK+ZVtI7yALpBdwFrYaFDIIq0aIZk/RoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrY0o2ej5+9ZD5AxTGyIFYF+kRlC/kDwCs2GJqm8uTp6j2r/GcHekWv33kEb7jH3gTmU6/9oMGrSxSWgvIdh9v8L4CQAkha2dTbnqr7QUXmMPvRui9EcZp7jZC4IAovenCllzXkMKgpyYIB+AZFQB/icWSsUH2++xAyiEl5w6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93BEC1C00;
	Wed, 13 Aug 2025 10:01:39 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CB223F738;
	Wed, 13 Aug 2025 10:01:43 -0700 (PDT)
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
Subject: [PATCH 05/19] iommu/vt-d: Fix perfmon group validation
Date: Wed, 13 Aug 2025 18:00:57 +0100
Message-Id: <fcc4a9091ff02606df9495fd16b00094216a933e.1755096883.git.robin.murphy@arm.com>
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

The group validation here has a few issues to fix: firstly, failing to
count the group leader or the event being opened itself. Secondly it
appears wrong not to count disabled sibling events given that they could
be enabled later. Finally there's the subtlety that we should avoid racy
access to the sibling list when the event is its own group leader.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/perfmon.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 75f493bcb353..c3a1ac14cb2b 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -258,21 +258,25 @@ static int iommu_pmu_validate_group(struct perf_event *event)
 {
 	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
 	struct perf_event *sibling;
-	int nr = 0;
+	int nr = 1;
 
+	if (event == event->group_leader)
+		return 0;
 	/*
 	 * All events in a group must be scheduled simultaneously.
 	 * Check whether there is enough counters for all the events.
 	 */
-	for_each_sibling_event(sibling, event->group_leader) {
-		if (!is_iommu_pmu_event(iommu_pmu, sibling) ||
-		    sibling->state <= PERF_EVENT_STATE_OFF)
-			continue;
+	if (is_iommu_pmu_event(iommu_pmu, event->group_leader))
+		++nr;
 
-		if (++nr > iommu_pmu->num_cntr)
-			return -EINVAL;
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (is_iommu_pmu_event(iommu_pmu, sibling))
+			++nr;
 	}
 
+	if (nr > iommu_pmu->num_cntr)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.39.2.101.g768bb238c484.dirty


