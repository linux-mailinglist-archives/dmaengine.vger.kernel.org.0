Return-Path: <dmaengine+bounces-6009-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D818B250FC
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE915A572F
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D63299A83;
	Wed, 13 Aug 2025 17:01:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B110522DF9E;
	Wed, 13 Aug 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104496; cv=none; b=UkZ1tGRFmozAYqDGdCdgv5hRDHGHRGydnfNul6Vp4fr9GYem5kobxZAsU3Sj0MCgc6YKLf8QHpnwNMTXbEFOn68eJITGK2PJaRz8ZdOmjR9WPSbQBaYLo22aGZcfOtaxXMMgt3plqSk9sKPGgWCQU2n/AGY2JjUWpYKyZ7PIydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104496; c=relaxed/simple;
	bh=0oyjzVYktsArPH0QHqPqYIaxRU0EWejtBLkJtie6tpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4SE5F6lSAidDFAmGK1ZLqJKeQsYzbi+650NeTAAOchornIBRBwq1AnHUEuOWtxMSfuVxOfSPpzuy/jmWXs/W2XMMC9Ci6w3vO0XWm9zTpjNmgW6DOiUlhilWHWq0ywCV2dW2RtSgE11F4Von7AZ3cc73IyRKy1O8yHEUJRO1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 128701BCB;
	Wed, 13 Aug 2025 10:01:26 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEB253F738;
	Wed, 13 Aug 2025 10:01:29 -0700 (PDT)
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
Subject: [PATCH 02/19] perf/hisilicon: Fix group validation
Date: Wed, 13 Aug 2025 18:00:54 +0100
Message-Id: <c7b877e66ba0d34d8558c5af8bbb620e8c0e47d9.1755096883.git.robin.murphy@arm.com>
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

The group validation logic shared by the HiSilicon HNS3/PCIe drivers is
a bit off, in that given a software group leader, it will consider that
event *in place of* the actual new event being opened. At worst this
could theoretically allow an unschedulable group if the software event
config happens to look like one of the hardware siblings.

The uncore framework avoids that particular issue, but all 3 also share
the common issue of not preventing racy access to the sibling list, and
some redundant checks which can be cleaned up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c   | 17 ++++++-----------
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 23 +++++++----------------
 drivers/perf/hisilicon/hns3_pmu.c        | 17 ++++++-----------
 3 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index c5394d007b61..3b0b2f7197d0 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -338,21 +338,16 @@ static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
 	int counters = 1;
 	int num;
 
-	event_group[0] = leader;
-	if (!is_software_event(leader)) {
-		if (leader->pmu != event->pmu)
-			return false;
+	if (leader == event)
+		return true;
 
-		if (leader != event && !hisi_pcie_pmu_cmp_event(leader, event))
-			event_group[counters++] = event;
-	}
+	event_group[0] = event;
+	if (leader->pmu == event->pmu && !hisi_pcie_pmu_cmp_event(leader, event))
+		event_group[counters++] = leader;
 
 	for_each_sibling_event(sibling, event->group_leader) {
-		if (is_software_event(sibling))
-			continue;
-
 		if (sibling->pmu != event->pmu)
-			return false;
+			continue;
 
 		for (num = 0; num < counters; num++) {
 			/*
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index a449651f79c9..3c531b36cf25 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -101,26 +101,17 @@ static bool hisi_validate_event_group(struct perf_event *event)
 	/* Include count for the event */
 	int counters = 1;
 
-	if (!is_software_event(leader)) {
-		/*
-		 * We must NOT create groups containing mixed PMUs, although
-		 * software events are acceptable
-		 */
-		if (leader->pmu != event->pmu)
-			return false;
+	if (leader == event)
+		return true;
 
-		/* Increment counter for the leader */
-		if (leader != event)
-			counters++;
-	}
+	/* Increment counter for the leader */
+	if (leader->pmu == event->pmu)
+		counters++;
 
 	for_each_sibling_event(sibling, event->group_leader) {
-		if (is_software_event(sibling))
-			continue;
-		if (sibling->pmu != event->pmu)
-			return false;
 		/* Increment counter for each sibling */
-		counters++;
+		if (sibling->pmu == event->pmu)
+			counters++;
 	}
 
 	/* The group can not count events more than the counters in the HW */
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index c157f3572cae..382e469257f9 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1058,21 +1058,16 @@ static bool hns3_pmu_validate_event_group(struct perf_event *event)
 	int counters = 1;
 	int num;
 
-	event_group[0] = leader;
-	if (!is_software_event(leader)) {
-		if (leader->pmu != event->pmu)
-			return false;
+	if (leader == event)
+		return true;
 
-		if (leader != event && !hns3_pmu_cmp_event(leader, event))
-			event_group[counters++] = event;
-	}
+	event_group[0] = event;
+	if (leader->pmu == event->pmu && !hns3_pmu_cmp_event(leader, event))
+		event_group[counters++] = leader;
 
 	for_each_sibling_event(sibling, event->group_leader) {
-		if (is_software_event(sibling))
-			continue;
-
 		if (sibling->pmu != event->pmu)
-			return false;
+			continue;
 
 		for (num = 0; num < counters; num++) {
 			/*
-- 
2.39.2.101.g768bb238c484.dirty


