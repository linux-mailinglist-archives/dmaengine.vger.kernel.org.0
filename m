Return-Path: <dmaengine+bounces-6071-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607CB2CB73
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 19:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A653B9F9B
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55D30DD1C;
	Tue, 19 Aug 2025 17:49:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737C02206B8;
	Tue, 19 Aug 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625757; cv=none; b=TWHBLcq0Gx3x8clSJkLLPfNmgS5SG1v/cwwScY4/JJeAS5u9WreIdTfcAXkgKa5NuDubaY65bbq2f4zjD+IyfKLqLeQb2U2wnmfcwTYg8arXHQ4lAXfzFiIQQv1lws1ktlc0TaUHdHon1b94GVnm0R7KRDw3jvN5zavjoDPwFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625757; c=relaxed/simple;
	bh=yfhPbDJoc+6CdAo/HUDbAHjm5EOHsprDS0bgOVBPTUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1ggeva+JSjhmo79XKXV92uGsDx2Tdb8tuc4mz+mpH+ImeqLDAPjyuBirabjGLv44dFqqLANceqyhF4DxjP72whhJ+U9T2aEbizeuZrAWMJAbT6xkzIpg4oyVAazkCowyJKO8xToNxIFDhibYKPFUXzL/oWUVdYGz1k3gngk5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E877152B;
	Tue, 19 Aug 2025 10:49:06 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 475103F738;
	Tue, 19 Aug 2025 10:49:10 -0700 (PDT)
Message-ID: <cdb7b1e7-6e51-4c0e-bffb-b0d4b654a623@arm.com>
Date: Tue, 19 Aug 2025 18:49:08 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] perf: Garbage-collect event_init checks
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, coresight@lists.linaro.org,
 iommu@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, mark.rutland@arm.com, acme@kernel.org, namhyung@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 imx@lists.linux.dev, linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org
References: <202508190403.33c83ece-lkp@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <202508190403.33c83ece-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 3:44 am, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:
> 
> commit: 1ba20479196e5af3ebbedf9321de6b26f2a0cdd3 ("[PATCH 19/19] perf: Garbage-collect event_init checks")
> url: https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/perf-arm-cmn-Fix-event-validation/20250814-010626
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 91325f31afc1026de28665cf1a7b6e157fa4d39d
> patch link: https://lore.kernel.org/all/ace3532a8a438a96338bf349a27636d8294c7111.1755096883.git.robin.murphy@arm.com/
> patch subject: [PATCH 19/19] perf: Garbage-collect event_init checks

OK, after looking a bit more deeply at x86 and PowerPC, I think it
probably is nicest to solve this commonly too. Below is what I've cooked
up for a v2 (I'll save reposting the whole series this soon...)

Thanks,
Robin.

----->8-----
Subject: [PATCH 18.5/19] perf: Add common uncore-CPU check

Many uncore drivers depend on event->cpu being valid in order to look
up various data in their event_init call. Since we've now factored out
common PMU identification, we can factor out this check in the correct
order too. While it might technically be possible to hoist the general
task/cgroup check up here now, that would be horribly messy, so for
clarity let's keep these as distinct (albeit related) concerns.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508190403.33c83ece-lkp@intel.com
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  kernel/events/core.c | 12 +++++++++++-
  1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f7eb526d87c..ddf045ad4d83 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12562,6 +12562,11 @@ static bool is_raw_pmu(const struct pmu *pmu)
  	       pmu->capabilities & PERF_PMU_CAP_RAW_EVENTS;
  }
  
+static bool is_uncore_pmu(const struct pmu *pmu)
+{
+	return pmu->task_ctx_nr == perf_invalid_context;
+}
+
  static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
  {
  	struct perf_event_context *ctx = NULL;
@@ -12571,11 +12576,16 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
  	 * Before touching anything, we can safely skip:
  	 * - any event for a specific PMU which is not this one
  	 * - any common event if this PMU doesn't support them
+	 * - non-CPU-bound uncore events (so drivers can assume event->cpu is
+	 *   valid; we'll check the actual task/cgroup attach state later)
  	 */
  	if (event->attr.type != pmu->type &&
  	    (event->attr.type >= PERF_TYPE_MAX || !is_raw_pmu(pmu)))
  		return -ENOENT;
  
+	if (is_uncore_pmu(pmu) && event->cpu < 0)
+		return -EINVAL;
+
  	if (!try_module_get(pmu->module))
  		return -ENODEV;
  
@@ -12990,7 +13000,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
  	 * events (they don't make sense as the cgroup will be different
  	 * on other CPUs in the uncore mask).
  	 */
-	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1))
+	if (is_uncore_pmu(pmu) && (task || cgroup_fd != -1))
  		return ERR_PTR(-EINVAL);
  
  	if (event->attr.aux_output &&
-- 

