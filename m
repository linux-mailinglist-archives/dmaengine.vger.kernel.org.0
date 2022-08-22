Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BC59B77F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 04:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiHVCRB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Aug 2022 22:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiHVCQn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 Aug 2022 22:16:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6C22BE5;
        Sun, 21 Aug 2022 19:16:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so8679027plo.3;
        Sun, 21 Aug 2022 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xB76u9yqtIZ+mSa30ADibl4N4bymJ9Dh7UlLFPT7o98=;
        b=HRSBxEVCt3rvrI/7lmMMzAo0rRbfGOgqEC67o825HvHiARvDrjB8+tDVoRpWMePXYp
         9oQI+id67tHzlJ/A1v+NZiooV2Ufdbed57m4RPzeWT4HTWQ3q2I+/Pe+oeuuLSkGr3sH
         OFGxMUhrOnPgyl+8PJjFb2VlRGBH65CMs+CTIcK33IedsTj91WJy8qIYPkCyA3YhPpbN
         xDCCgOZKQ5Y1aN3JjfMjYvKZvr6vDO7+ZcRdt9uyjXkR87MKlV9+WnblT5SVy92eqfSx
         w3yN/jWsdSyvHft8Zf3G5N2NxPQml5tWr62cry/lKZIDETPbgI06U3OybrR+Eaet25zB
         MNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xB76u9yqtIZ+mSa30ADibl4N4bymJ9Dh7UlLFPT7o98=;
        b=8HTec5PKe3qNIodA8+yUymOr1kqtqer4mcRv6RSpygHXfAWmuHpvMJzKtn4TcI1uwg
         zlfaCE/GOg1M3Tff9mf1JFEI8o1qpxFJ84zY8twMkOnTEWR16ZDC3FSowSSBCs8NXmA+
         Pa9D6z/iMCZUpG4ryP4xajmsjBysnj9bzzq7aaGGgJl5+pkdxy6dJtWmyxkTOR8an//T
         1yZU0tmzbJyZMpJO4g2mtlcUfaABTeq+n26BJSIbUwwdj0lyaonOGPnlURM+vxOl6CHO
         nj1blI06Un713sWZAof80W7zmttoEUs4z/+8kXWD3oriB7GnKdH1rGSO8PxxJD1NAhw/
         24Lg==
X-Gm-Message-State: ACgBeo1cK40iG/0rQfPTbxfNf6jDO9GVXQ3jxODlOOt+RNbGdX4D3zM4
        ldaUrG0OFGwuCIV9bT3fJg==
X-Google-Smtp-Source: AA6agR522vRbRjKGj/9trWnx6g9g6lhC9pFTs134FCjBnfDght6iTV00F7UnaCUQri0jee4v1rjxPQ==
X-Received: by 2002:a17:90b:33ce:b0:1fb:1aec:ffac with SMTP id lk14-20020a17090b33ce00b001fb1aecffacmr5850314pjb.137.1661134594615;
        Sun, 21 Aug 2022 19:16:34 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:16:34 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-fpga@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Li <Frank.li@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Li Yang <leoyang.li@nxp.com>, Yury Norov <yury.norov@gmail.com>
Subject: [RFC 08/10] cpuhp: Replace cpumask_any_but(cpu_online_mask, cpu)
Date:   Mon, 22 Aug 2022 10:15:18 +0800
Message-Id: <20220822021520.6996-9-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In a kexec quick reboot path, the dying cpus are still on
cpu_online_mask. During the teardown of cpu, a subsystem needs to
migrate its broker to a real online cpu.

This patch replaces cpumask_any_but(cpu_online_mask, cpu) in a teardown
procedure with cpumask_not_dying_but(cpu_online_mask, cpu).

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Frank Li <Frank.li@nxp.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Qi Liu <liuqi115@huawei.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Khuong Dinh <khuong@os.amperecomputing.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Yury Norov <yury.norov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
To: dmaengine@vger.kernel.org
To: linux-fpga@vger.kernel.org
To: intel-gfx@lists.freedesktop.org
To: dri-devel@lists.freedesktop.org
To: linux-arm-msm@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
To: linux-kernel@vger.kernel.org
---
 arch/arm/mach-imx/mmdc.c                 | 2 +-
 arch/arm/mm/cache-l2x0-pmu.c             | 2 +-
 drivers/dma/idxd/perfmon.c               | 2 +-
 drivers/fpga/dfl-fme-perf.c              | 2 +-
 drivers/gpu/drm/i915/i915_pmu.c          | 2 +-
 drivers/perf/arm-cci.c                   | 2 +-
 drivers/perf/arm-ccn.c                   | 2 +-
 drivers/perf/arm-cmn.c                   | 4 ++--
 drivers/perf/arm_dmc620_pmu.c            | 2 +-
 drivers/perf/arm_dsu_pmu.c               | 2 +-
 drivers/perf/arm_smmuv3_pmu.c            | 2 +-
 drivers/perf/fsl_imx8_ddr_perf.c         | 2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
 drivers/perf/marvell_cn10k_tad_pmu.c     | 2 +-
 drivers/perf/qcom_l2_pmu.c               | 2 +-
 drivers/perf/qcom_l3_pmu.c               | 2 +-
 drivers/perf/xgene_pmu.c                 | 2 +-
 drivers/soc/fsl/qbman/bman_portal.c      | 2 +-
 drivers/soc/fsl/qbman/qman_portal.c      | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index af12668d0bf5..a109a7ea8613 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -220,7 +220,7 @@ static int mmdc_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	if (!cpumask_test_and_clear_cpu(cpu, &pmu_mmdc->cpu))
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..1b0037ef7fa5 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -428,7 +428,7 @@ static int l2x0_pmu_offline_cpu(unsigned int cpu)
 	if (!cpumask_test_and_clear_cpu(cpu, &pmu_cpu))
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index d73004f47cf4..f3f1ccb55f73 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -528,7 +528,7 @@ static int perf_event_cpu_offline(unsigned int cpu, struct hlist_node *node)
 	if (!cpumask_test_and_clear_cpu(cpu, &perfmon_dsa_cpu_mask))
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 
 	/* migrate events if there is a valid target */
 	if (target < nr_cpu_ids)
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 587c82be12f7..57804f28357e 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -948,7 +948,7 @@ static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	if (cpu != priv->cpu)
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 958b37123bf1..f866f9223492 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1068,7 +1068,7 @@ static int i915_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	if (cpumask_test_and_clear_cpu(cpu, &i915_pmu_cpumask)) {
-		target = cpumask_any_but(topology_sibling_cpumask(cpu), cpu);
+		target = cpumask_not_dying_but(topology_sibling_cpumask(cpu), cpu);
 
 		/* Migrate events if there is a valid target */
 		if (target < nr_cpu_ids) {
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 03b1309875ae..481da937fb9d 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1447,7 +1447,7 @@ static int cci_pmu_offline_cpu(unsigned int cpu)
 	if (!g_cci_pmu || cpu != g_cci_pmu->cpu)
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 728d13d8e98a..573d6906ec9b 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1205,7 +1205,7 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 	if (cpu != dt->cpu)
 		return 0;
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 	perf_pmu_migrate_context(&dt->pmu, cpu, target);
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 80d8309652a4..1847182a1ed3 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1787,9 +1787,9 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
 	node = dev_to_node(cmn->dev);
 	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
 	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
-		target = cpumask_any(&mask);
+		target = cpumask_not_dying_but(&mask, cpu);
 	else
-		target = cpumask_any_but(cpu_online_mask, cpu);
+		target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target < nr_cpu_ids)
 		arm_cmn_migrate(cmn, target);
 	return 0;
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 280a6ae3e27c..3a0a2bb92e12 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -611,7 +611,7 @@ static int dmc620_pmu_cpu_teardown(unsigned int cpu,
 	if (cpu != irq->cpu)
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index aa9f4393ff0c..e19ce0406b02 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -236,7 +236,7 @@ static int dsu_pmu_get_online_cpu_any_but(struct dsu_pmu *dsu_pmu, int cpu)
 
 	cpumask_and(&online_supported,
 			 &dsu_pmu->associated_cpus, cpu_online_mask);
-	return cpumask_any_but(&online_supported, cpu);
+	return cpumask_not_dying_but(&online_supported, cpu);
 }
 
 static inline bool dsu_pmu_counter_valid(struct dsu_pmu *dsu_pmu, u32 idx)
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 00d4c45a8017..827315d31056 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -640,7 +640,7 @@ static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	if (cpu != smmu_pmu->on_cpu)
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 8e058e08fe81..4e0276fc1548 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -664,7 +664,7 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	if (cpu != pmu->cpu)
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index fbc8a93d5eac..8c39da8f4b3c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -518,7 +518,7 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	/* Choose a new CPU to migrate ownership of the PMU to */
 	cpumask_and(&pmu_online_cpus, &hisi_pmu->associated_cpus,
 		    cpu_online_mask);
-	target = cpumask_any_but(&pmu_online_cpus, cpu);
+	target = cpumask_not_dying_but(&pmu_online_cpus, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 69c3050a4348..268e3288893d 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -387,7 +387,7 @@ static int tad_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	if (cpu != pmu->cpu)
 		return 0;
 
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 30234c261b05..8823d0bb6476 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -822,7 +822,7 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	/* Any other CPU for this cluster which is still online */
 	cpumask_and(&cluster_online_cpus, &cluster->cluster_cpus,
 		    cpu_online_mask);
-	target = cpumask_any_but(&cluster_online_cpus, cpu);
+	target = cpumask_not_dying_but(&cluster_online_cpus, cpu);
 	if (target >= nr_cpu_ids) {
 		disable_irq(cluster->irq);
 		return 0;
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 1ff2ff6582bf..ba26b2fa0736 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -718,7 +718,7 @@ static int qcom_l3_cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *no
 
 	if (!cpumask_test_and_clear_cpu(cpu, &l3pmu->cpumask))
 		return 0;
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 	perf_pmu_migrate_context(&l3pmu->pmu, cpu, target);
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0c32dffc7ede..069eb0a0d3ba 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1804,7 +1804,7 @@ static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 	if (!cpumask_test_and_clear_cpu(cpu, &xgene_pmu->cpu))
 		return 0;
-	target = cpumask_any_but(cpu_online_mask, cpu);
+	target = cpumask_not_dying_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 
diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 4d7b9caee1c4..8ebcf87e7d06 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -67,7 +67,7 @@ static int bman_offline_cpu(unsigned int cpu)
 		return 0;
 
 	/* use any other online CPU */
-	cpu = cpumask_any_but(cpu_online_mask, cpu);
+	cpu = cpumask_not_dying_but(cpu_online_mask, cpu);
 	irq_set_affinity(pcfg->irq, cpumask_of(cpu));
 	return 0;
 }
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e23b60618c1a..3807a8285ced 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -148,7 +148,7 @@ static int qman_offline_cpu(unsigned int cpu)
 		pcfg = qman_get_qm_portal_config(p);
 		if (pcfg) {
 			/* select any other online CPU */
-			cpu = cpumask_any_but(cpu_online_mask, cpu);
+			cpu = cpumask_not_dying_but(cpu_online_mask, cpu);
 			irq_set_affinity(pcfg->irq, cpumask_of(cpu));
 			qman_portal_update_sdest(pcfg, cpu);
 		}
-- 
2.31.1

