Return-Path: <dmaengine+bounces-6011-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844EDB2512A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD74317C7A0
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873B29BD9D;
	Wed, 13 Aug 2025 17:01:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA01347DD;
	Wed, 13 Aug 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104505; cv=none; b=mpzc3zMEtyfFdSqvasP+nB3AZrTUicn+DILEjWDI6hCmDOEchCErOMNNIBxSrT95nP00qBtVh/GJ05TGlLzWhFRw3nTDS7ZYIrGl3ausGIYhzrYuoZLGYNGoXl1SizbhWLYgJDGP8D6a9a+yezuOVkAAUM6sk4quH1QmXURpi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104505; c=relaxed/simple;
	bh=6B7Ig2he8h1DunIQRPtrUtaFSZoDHwwhvvZ2HnE/EpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSggcVys1a7NUkV+InsLpPRrzWfJIBZYXuY5tTU6z9rgUzXhZGXWuUy8JTJ5IB0XPj9+lBplSI1g8rs5tDIUC49feSlIg3eeFiHbKN6QkHHyst6bTu2h9xjwBY7hbaxtAkCJnP+9+Gj5kfmkBdKFRpBr0QBd40btClEJpomTpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17EBF1BF3;
	Wed, 13 Aug 2025 10:01:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 002723F738;
	Wed, 13 Aug 2025 10:01:38 -0700 (PDT)
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
Subject: [PATCH 04/19] perf/starfive: Fix group validation
Date: Wed, 13 Aug 2025 18:00:56 +0100
Message-Id: <6b9c9cf887c102c9154a1f28aea643a66787858f.1755096883.git.robin.murphy@arm.com>
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

The group validation code here is superficially the right shape, but
is failing to count the group leader, while also erroneously counting
software siblings. Just correctly count the events which belong to our
PMU, and let perf core worry about the rest.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/starfive_starlink_pmu.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
index 5e5a672b4229..e185f307e639 100644
--- a/drivers/perf/starfive_starlink_pmu.c
+++ b/drivers/perf/starfive_starlink_pmu.c
@@ -347,19 +347,15 @@ static bool starlink_pmu_validate_event_group(struct perf_event *event)
 	struct perf_event *sibling;
 	int counter = 1;
 
-	/*
-	 * Ensure hardware events in the group are on the same PMU,
-	 * software events are acceptable.
-	 */
-	if (event->group_leader->pmu != event->pmu &&
-	    !is_software_event(event->group_leader))
-		return false;
+	if (leader == event)
+		return true;
+
+	if (leader->pmu == event->pmu)
+		counter++;
 
 	for_each_sibling_event(sibling, leader) {
-		if (sibling->pmu != event->pmu && !is_software_event(sibling))
-			return false;
-
-		counter++;
+		if (sibling->pmu == event->pmu)
+			counter++;
 	}
 
 	return counter <= STARLINK_PMU_NUM_COUNTERS;
-- 
2.39.2.101.g768bb238c484.dirty


