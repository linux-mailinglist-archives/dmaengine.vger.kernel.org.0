Return-Path: <dmaengine+bounces-11596-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HLPYGqh7M2p/CgYAu9opvQ
	(envelope-from <dmaengine+bounces-11596-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C469D9A6
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fpq0JtnN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11596-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11596-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8B3430060B3
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3637C0E1;
	Thu, 18 Jun 2026 05:01:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1236C0D6;
	Thu, 18 Jun 2026 05:01:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758881; cv=none; b=tjtjzOS5CE953De4IjWtdkSnXSwDpdyAjeb2dO0oLKSlYJt1oP2P8xVnBR6u2G7ot/ABrVbyVn9Bx8HDe/s7oGpXh+APYPOHfS8xEBrJq1UwiMBI3xk8XwgITKSRaOBBDQruQckuwZInSaYRdskWU7ditpBgk7dQ8W7rsAVMvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758881; c=relaxed/simple;
	bh=0lqcc/Ea6MHBOdvatgBr8P5g9uJHskhC+L8P3W4p0/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsuqZzyWA2dh/qY99rVRMmEAgOgF8NBE5dxAGfqUmVEVLmihdFS3JZZuVwnGu5ZrrQjAgitrGpu5Ks/oJysvhkd392AVyUVEP/EFvsOzOgVs/KTCmImR/6pFrbXaYKf5rbgLWk5NUOKiBUwu6mTRlmZdLsqhIPHsq3VADiQC6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpq0JtnN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59941F000E9;
	Thu, 18 Jun 2026 05:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758879;
	bh=O00ahtY31q/Yh0pXBYZxwb2qKDX5MN4WE8gGlzZjxZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fpq0JtnNBow7av9tFWeMaJ5iIRcK9srf+24POTq4XbPT16Dk5iMCBkO1LO++v+qG6
	 f9NjVqIO2O3K7CEv54UJVtYmpI+xud1ahV5PUegQ4fqtoI2A3+xiX3QNcYm6RLfzmw
	 /f2ag8RT5E9wFXuoTYxeT1hO5UecnUvG/uBTASV3Hk4cndfqNuGUreSXagjPlU+uPV
	 q30xYgfwiMFBS7IRU6GjMb49QWX7wYa2KUbrnoNn39rFjGVxr+M2FDXesllIzRfy6+
	 nxLL95K5HxCLgYzRt3CkrgrpTaXGTTHwvurhGYygfRiGBQ0KeMBVznH98GD+/UiqS9
	 ajkW/5+YKYdzQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:52 +0200
Subject: [PATCH 06/11] pmdomain: st: ux500: Control DB8500 EPODs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lee@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:linusw@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11596-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A12C469D9A6

Move the DB8500 EPOD state handling into the Ux500 power-domain driver.

Keep the old regulator driver mutually exclusive with the pmdomain driver.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/mach-ux500/Kconfig               |   2 +-
 drivers/pmdomain/st/ste-ux500-pm-domain.c | 380 ++++++++++++++++++++++--------
 drivers/regulator/Kconfig                 |   1 +
 3 files changed, 282 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c18def269137..56636c993f49 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -26,7 +26,7 @@ menuconfig ARCH_U8500
 	select PL310_ERRATA_753970 if CACHE_L2X0
 	select PM_GENERIC_DOMAINS if PM
 	select REGULATOR
-	select REGULATOR_DB8500_PRCMU
+	select UX500_PM_DOMAIN
 	select REGULATOR_FIXED_VOLTAGE
 	select SOC_BUS
 	select RESET_CONTROLLER
diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain/st/ste-ux500-pm-domain.c
index 723001004690..1cd5b4985db0 100644
--- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
+++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
@@ -6,172 +6,315 @@
  *
  * Implements PM domains using the generic PM domain for ux500.
  */
+#include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/mfd/dbx500-prcmu.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/of.h>
-#include <linux/pm_domain.h>
 
 #include <dt-bindings/arm/ux500_pm_domains.h>
 
-static int pd_power_off(struct generic_pm_domain *domain)
+#define UX500_EPOD_NONE		NUM_EPOD_ID
+
+/**
+ * struct dbx500_powerdomain_info - dbx500 power domain information
+ * @genpd: generic power domain
+ * @epod_id: id for EPOD (power domain)
+ * @is_ramret: RAM retention switch for EPOD (power domain)
+ * @exclude_from_power_state: exclude domain from power state count
+ */
+struct dbx500_powerdomain_info {
+	struct generic_pm_domain genpd;
+	u16 epod_id;
+	bool is_ramret;
+	bool exclude_from_power_state;
+};
+
+static DEFINE_MUTEX(ux500_pd_lock);
+static int power_state_active_cnt;
+static bool epod_on[NUM_EPOD_ID];
+static bool epod_ramret[NUM_EPOD_ID];
+
+static void power_state_active_enable(void)
+{
+	power_state_active_cnt++;
+}
+
+static int power_state_active_disable(void)
 {
-	/*
-	 * Handle the gating of the PM domain regulator here.
-	 *
-	 * Drivers/subsystems handling devices in the PM domain needs to perform
-	 * register context save/restore from their respective runtime PM
-	 * callbacks, to be able to enable PM domain gating/ungating.
-	 */
+	if (power_state_active_cnt <= 0) {
+		pr_err("power state: unbalanced enable/disable calls\n");
+		return -EINVAL;
+	}
+
+	power_state_active_cnt--;
 	return 0;
 }
 
-static int pd_power_on(struct generic_pm_domain *domain)
+static int enable_epod(u16 epod_id, bool ramret)
 {
-	/*
-	 * Handle the ungating of the PM domain regulator here.
-	 *
-	 * Drivers/subsystems handling devices in the PM domain needs to perform
-	 * register context save/restore from their respective runtime PM
-	 * callbacks, to be able to enable PM domain gating/ungating.
-	 */
+	int ret;
+
+	if (ramret) {
+		if (!epod_on[epod_id]) {
+			ret = prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);
+			if (ret < 0)
+				return ret;
+		}
+		epod_ramret[epod_id] = true;
+	} else {
+		ret = prcmu_set_epod(epod_id, EPOD_STATE_ON);
+		if (ret < 0)
+			return ret;
+		epod_on[epod_id] = true;
+	}
+
+	return 0;
+}
+
+static int disable_epod(u16 epod_id, bool ramret)
+{
+	int ret;
+
+	if (ramret) {
+		if (!epod_on[epod_id]) {
+			ret = prcmu_set_epod(epod_id, EPOD_STATE_OFF);
+			if (ret < 0)
+				return ret;
+		}
+		epod_ramret[epod_id] = false;
+	} else {
+		if (epod_ramret[epod_id]) {
+			ret = prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);
+			if (ret < 0)
+				return ret;
+		} else {
+			ret = prcmu_set_epod(epod_id, EPOD_STATE_OFF);
+			if (ret < 0)
+				return ret;
+		}
+		epod_on[epod_id] = false;
+	}
+
 	return 0;
 }
 
+static int pd_power_off(struct generic_pm_domain *domain)
+{
+	struct dbx500_powerdomain_info *info =
+		container_of(domain, struct dbx500_powerdomain_info, genpd);
+	int ret = 0;
+
+	guard(mutex)(&ux500_pd_lock);
+	if (info->epod_id < NUM_EPOD_ID)
+		ret = disable_epod(info->epod_id, info->is_ramret);
+	else if (!info->exclude_from_power_state)
+		ret = power_state_active_disable();
+
+	return ret;
+}
+
+static int pd_power_on(struct generic_pm_domain *domain)
+{
+	struct dbx500_powerdomain_info *info =
+		container_of(domain, struct dbx500_powerdomain_info, genpd);
+	int ret = 0;
+
+	guard(mutex)(&ux500_pd_lock);
+	if (info->epod_id < NUM_EPOD_ID)
+		ret = enable_epod(info->epod_id, info->is_ramret);
+	else if (!info->exclude_from_power_state)
+		power_state_active_enable();
+
+	return ret;
+}
+
 /*
  * Apart from these voltage domains there is also VSAFE which is always
  * on. Vape_esram0_pwr for eSRAM0 is connected to VSAFE.
  */
-static struct generic_pm_domain ux500_pm_domain_vape = {
+static struct dbx500_powerdomain_info ux500_pm_domain_vape = {
 	/* Vape_pwr */
-	.name = "VAPE",  /* 0.95 .. 1.20 V */
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "VAPE",  /* 0.95 .. 1.20 V */
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_EPOD_NONE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_varm = {
-	.name = "VARM",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_varm = {
+	.genpd = {
+		.name = "VARM",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_EPOD_NONE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vmodem = {
-	.name = "VMODEM",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vmodem = {
+	.genpd = {
+		.name = "VMODEM",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_EPOD_NONE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vpll = {
-	.name = "VPLL", /* 1.8 V */
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vpll = {
+	.genpd = {
+		.name = "VPLL", /* 1.8 V */
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_EPOD_NONE,
 };
 
 /*
  * CHECKME: as these are used directly by peripherals as regulators,
  * perhaps they should stay in the regulator subsystem?
  */
-static struct generic_pm_domain ux500_pm_domain_vsmps1 = {
-	.name = "VSMPS1", /* Also called VIO (1.2V) */
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vsmps1 = {
+	.genpd = {
+		.name = "VSMPS1", /* Also called VIO (1.2V) */
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_EPOD_NONE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vsmps2 = {
-	.name = "VSMPS2", /* Also called VIO (1.8V) */
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vsmps2 = {
+	.genpd = {
+		.name = "VSMPS2", /* Also called VIO (1.8V) */
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_EPOD_NONE,
+	.exclude_from_power_state = true,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vsmps3 = {
-	.name = "VSMPS3",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vsmps3 = {
+	.genpd = {
+		.name = "VSMPS3",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_EPOD_NONE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vrf1 = {
-	.name = "VRF1",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vrf1 = {
+	.genpd = {
+		.name = "VRF1",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_EPOD_NONE,
 };
 
 /* The following are technically children of VAPE */
-static struct generic_pm_domain ux500_pm_domain_sva_mmdsp = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sva_mmdsp = {
 	/* Vape_SVA_MMDSP_pwr */
-	.name = "SVA_MMDSP",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SVA_MMDSP",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SVAMMDSP,
 };
 
-static struct generic_pm_domain ux500_pm_domain_sva_pipe = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sva_pipe = {
 	/* Vape_SVA_pwr */
-	.name = "SVA_PIPE",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SVA_PIPE",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SVAPIPE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_sia_mmdsp = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sia_mmdsp = {
 	/* Vape_SIA_MMDSP_pwr */
-	.name = "SIA_MMDSP",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SIA_MMDSP",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SIAMMDSP,
 };
 
-static struct generic_pm_domain ux500_pm_domain_sia_pipe = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sia_pipe = {
 	/* Vape_SIA_pwr */
-	.name = "SIA_PIPE",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SIA_PIPE",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SIAPIPE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_sga = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sga = {
 	/* Vape_SGA_pwr */
-	.name = "SGA",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SGA",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SGA,
 };
 
-static struct generic_pm_domain ux500_pm_domain_b2r2_mcde = {
+static struct dbx500_powerdomain_info ux500_pm_domain_b2r2_mcde = {
 	/* Vape_DSS_pwr DSS (display subsystem) */
-	.name = "B2R2_MCDE",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "B2R2_MCDE",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_B2R2_MCDE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_esram_12 = {
+static struct dbx500_powerdomain_info ux500_pm_domain_esram_12 = {
 	/* Vape_esram0_pwr, Vape_esram1_pwr */
-	.name = "ESRAM_12",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "ESRAM_12",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_ESRAM12,
 };
 
-static struct generic_pm_domain ux500_pm_domain_esram_34 = {
+static struct dbx500_powerdomain_info ux500_pm_domain_esram_34 = {
 	/* Vape_esram3_pwr, Vape_esram4_pwr */
-	.name = "ESRAM_34",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "ESRAM_34",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_ESRAM34,
 };
 
 static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
-	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
-	[DOMAIN_VARM] = &ux500_pm_domain_varm,
-	[DOMAIN_VMODEM] = &ux500_pm_domain_vmodem,
-	[DOMAIN_VPLL] = &ux500_pm_domain_vpll,
-	[DOMAIN_VSMPS1] = &ux500_pm_domain_vsmps1,
-	[DOMAIN_VSMPS2] = &ux500_pm_domain_vsmps2,
-	[DOMAIN_VSMPS3] = &ux500_pm_domain_vsmps3,
-	[DOMAIN_VRF1] = &ux500_pm_domain_vrf1,
-	[DOMAIN_SVA_MMDSP] = &ux500_pm_domain_sva_mmdsp,
-	[DOMAIN_SVA_PIPE] = &ux500_pm_domain_sva_pipe,
-	[DOMAIN_SIA_MMDSP] = &ux500_pm_domain_sia_mmdsp,
-	[DOMAIN_SIA_PIPE] = &ux500_pm_domain_sia_pipe,
-	[DOMAIN_SGA] = &ux500_pm_domain_sga,
-	[DOMAIN_B2R2_MCDE] = &ux500_pm_domain_b2r2_mcde,
-	[DOMAIN_ESRAM_12] = &ux500_pm_domain_esram_12,
-	[DOMAIN_ESRAM_34] = &ux500_pm_domain_esram_34,
+	[DOMAIN_VAPE] = &ux500_pm_domain_vape.genpd,
+	[DOMAIN_VARM] = &ux500_pm_domain_varm.genpd,
+	[DOMAIN_VMODEM] = &ux500_pm_domain_vmodem.genpd,
+	[DOMAIN_VPLL] = &ux500_pm_domain_vpll.genpd,
+	[DOMAIN_VSMPS1] = &ux500_pm_domain_vsmps1.genpd,
+	[DOMAIN_VSMPS2] = &ux500_pm_domain_vsmps2.genpd,
+	[DOMAIN_VSMPS3] = &ux500_pm_domain_vsmps3.genpd,
+	[DOMAIN_VRF1] = &ux500_pm_domain_vrf1.genpd,
+	[DOMAIN_SVA_MMDSP] = &ux500_pm_domain_sva_mmdsp.genpd,
+	[DOMAIN_SVA_PIPE] = &ux500_pm_domain_sva_pipe.genpd,
+	[DOMAIN_SIA_MMDSP] = &ux500_pm_domain_sia_mmdsp.genpd,
+	[DOMAIN_SIA_PIPE] = &ux500_pm_domain_sia_pipe.genpd,
+	[DOMAIN_SGA] = &ux500_pm_domain_sga.genpd,
+	[DOMAIN_B2R2_MCDE] = &ux500_pm_domain_b2r2_mcde.genpd,
+	[DOMAIN_ESRAM_12] = &ux500_pm_domain_esram_12.genpd,
+	[DOMAIN_ESRAM_34] = &ux500_pm_domain_esram_34.genpd,
 };
 
 static const struct of_device_id ux500_pm_domain_matches[] = {
@@ -179,11 +322,44 @@ static const struct of_device_id ux500_pm_domain_matches[] = {
 	{ },
 };
 
+static int ux500_pm_domain_add_subdomain(struct generic_pm_domain *domain)
+{
+	return pm_genpd_add_subdomain(&ux500_pm_domain_vape.genpd, domain);
+}
+
+static int ux500_pm_domains_add_subdomains(void)
+{
+	int ret;
+
+	ret = ux500_pm_domain_add_subdomain(&ux500_pm_domain_sva_mmdsp.genpd);
+	if (ret)
+		return ret;
+
+	ret = ux500_pm_domain_add_subdomain(&ux500_pm_domain_sva_pipe.genpd);
+	if (ret)
+		return ret;
+
+	ret = ux500_pm_domain_add_subdomain(&ux500_pm_domain_sia_mmdsp.genpd);
+	if (ret)
+		return ret;
+
+	ret = ux500_pm_domain_add_subdomain(&ux500_pm_domain_sia_pipe.genpd);
+	if (ret)
+		return ret;
+
+	ret = ux500_pm_domain_add_subdomain(&ux500_pm_domain_sga.genpd);
+	if (ret)
+		return ret;
+
+	return ux500_pm_domain_add_subdomain(&ux500_pm_domain_b2r2_mcde.genpd);
+}
+
 static int ux500_pm_domains_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct genpd_onecell_data *genpd_data;
 	int i;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -196,7 +372,11 @@ static int ux500_pm_domains_probe(struct platform_device *pdev)
 	genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
 
 	for (i = 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
-		pm_genpd_init(ux500_pm_domains[i], NULL, false);
+		pm_genpd_init(ux500_pm_domains[i], NULL, true);
+
+	ret = ux500_pm_domains_add_subdomains();
+	if (ret)
+		return ret;
 
 	of_genpd_add_provider_onecell(np, genpd_data);
 	return 0;
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 87554ab92801..35d1b191462c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -414,6 +414,7 @@ config REGULATOR_DBX500_PRCMU
 config REGULATOR_DB8500_PRCMU
 	bool "ST-Ericsson DB8500 Voltage Domain Regulators"
 	depends on MFD_DB8500_PRCMU
+	depends on !UX500_PM_DOMAIN
 	select REGULATOR_DBX500_PRCMU
 	help
 	  This driver supports the voltage domain regulators controlled by the

-- 
2.54.0


