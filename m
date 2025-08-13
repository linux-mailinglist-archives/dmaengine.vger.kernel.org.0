Return-Path: <dmaengine+bounces-6008-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB431B250F3
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 19:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2773A5A3162
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F8294A17;
	Wed, 13 Aug 2025 17:01:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77792291864;
	Wed, 13 Aug 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104492; cv=none; b=CEIc7Z39d00PYVLfX+UgZCArNxaDqi6IALNWYXTLeMgDA246lN7Mfp6zfHGWs5yIulFqIHsrdzONxoeuj2PiktXoZ4EjZaYfqf6n4+R13oo0xFL0X2m0qojSGzIL/htg0UhdoH9DiZnLoA3DvOhkmRoyVZDop1ALgMHCJgKe/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104492; c=relaxed/simple;
	bh=nvDCjI8G+B+H5gCrY6OJ5M1oTNHiic2SypXf3MT+n2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Om6o1in8HrtjIE4jS4SWeg0OI+sgPVVtPJtLGwROr5fI7LoeA2ku4dZEq5nZ+6IM2DOHIwHZck6rgT6qyp8uPf71oUKqW8scqtfeccQmPNTja6WZZEdiMiqgtC73+prGA/0kGmmKL3cp7dZDfajKzEA8wJ/7JdBzAPEFdYsb2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8977914BF;
	Wed, 13 Aug 2025 10:01:21 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 704653F738;
	Wed, 13 Aug 2025 10:01:25 -0700 (PDT)
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
Subject: [PATCH 01/19] perf/arm-cmn: Fix event validation
Date: Wed, 13 Aug 2025 18:00:53 +0100
Message-Id: <0716da3e77065f005ef6ea0d10ddf67fc53e76cb.1755096883.git.robin.murphy@arm.com>
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

In the hypothetical case where a CMN event is opened with a software
group leader that already has some other hardware sibling, currently
arm_cmn_val_add_event() could try to interpret the other event's data
as an arm_cmn_hw_event, which is not great since we dereference a
pointer from there... Thankfully the way to be more robust is to be
less clever - stop trying to special-case software events and simply
skip any event that isn't for our PMU.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 11fb2234b10f..f8c9be9fa6c0 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1652,7 +1652,7 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 	enum cmn_node_type type;
 	int i;
 
-	if (is_software_event(event))
+	if (event->pmu != &cmn->pmu)
 		return;
 
 	type = CMN_EVENT_TYPE(event);
@@ -1693,9 +1693,6 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 	if (leader == event)
 		return 0;
 
-	if (event->pmu != leader->pmu && !is_software_event(leader))
-		return -EINVAL;
-
 	val = kzalloc(sizeof(*val), GFP_KERNEL);
 	if (!val)
 		return -ENOMEM;
-- 
2.39.2.101.g768bb238c484.dirty


