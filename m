Return-Path: <dmaengine+bounces-6014-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E45B25100
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC19E1C2654F
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5302D7392;
	Wed, 13 Aug 2025 17:01:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8347C296BDC;
	Wed, 13 Aug 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104518; cv=none; b=abhdjVRjYDyKVlhE5gPvOl1T3MYbeJIb21DyYy5/vHzPTtcrcTb6uH7m9xNTIt9hjgSilo7ygk48Eg2A1GDCNifbkh3nl0fXMOKhRTQiZ8LErYsZ1pP33G6Pr7KAdH4PJRslgxc8fRtTT63vammgQFalT2SsVf85i/gcK1awYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104518; c=relaxed/simple;
	bh=V4SASwxGPhUSUPyQKSxrF1qMcQpxHm88dZMwSEogb5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTgqDxPtV5W62YogA4ht1JjM2ChHEXMMKdp1cUmMrLZOM0SC73/5geMpBlQRmTMLx+31n3YhgixT2+ahk7Hc4dvSRxTYeaPpmCJZOL5CivVFzZaRC7UrtbJ/qMPgsu6UueZKTgAcm2x0PxlWj+Dv18HfZoFA0pZk2eTIQg0tHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7DB41C14;
	Wed, 13 Aug 2025 10:01:48 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F4993F738;
	Wed, 13 Aug 2025 10:01:52 -0700 (PDT)
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
Subject: [PATCH 07/19] ARM: imx: Fix MMDC PMU group validation
Date: Wed, 13 Aug 2025 18:00:59 +0100
Message-Id: <12766b2e16939ed97df8c410a994c730bede8298.1755096883.git.robin.murphy@arm.com>
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

The group validation here gets the event and its group leader mixed up,
such that if the group leader belongs to a different PMU, the set_bit()
may go wildly out of bounds. While we fix that, also adopt the standard
pattern to avoid racy access the sibling list and drop checks that are
redundant with core code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/mach-imx/mmdc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 94e4f4a2f73f..f9d432b385a2 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -238,11 +238,8 @@ static bool mmdc_pmu_group_event_is_valid(struct perf_event *event,
 {
 	int cfg = event->attr.config;
 
-	if (is_software_event(event))
-		return true;
-
 	if (event->pmu != pmu)
-		return false;
+		return true;
 
 	return !test_and_set_bit(cfg, used_counters);
 }
@@ -260,12 +257,12 @@ static bool mmdc_pmu_group_is_valid(struct perf_event *event)
 	struct perf_event *sibling;
 	unsigned long counter_mask = 0;
 
-	set_bit(leader->attr.config, &counter_mask);
+	if (event == leader)
+		return true;
 
-	if (event != leader) {
-		if (!mmdc_pmu_group_event_is_valid(event, pmu, &counter_mask))
-			return false;
-	}
+	set_bit(event->attr.config, &counter_mask);
+	if (!mmdc_pmu_group_event_is_valid(leader, pmu, &counter_mask))
+		return false;
 
 	for_each_sibling_event(sibling, leader) {
 		if (!mmdc_pmu_group_event_is_valid(sibling, pmu, &counter_mask))
-- 
2.39.2.101.g768bb238c484.dirty


