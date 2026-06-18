Return-Path: <dmaengine+bounces-11599-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 80FGJr17M2qTCgYAu9opvQ
	(envelope-from <dmaengine+bounces-11599-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772669D9F0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GNEM9pI4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11599-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11599-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A7A9307DD2F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3837D133;
	Thu, 18 Jun 2026 05:01:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1E37E2E5;
	Thu, 18 Jun 2026 05:01:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758895; cv=none; b=HhbBypVPXxsHrF81PD7bLNZqTUznhRJgY0g6iqmc2IUiGfIf04vWKvU9OEhPDRlnXW3jDjqLiqYwXh2qfIjZI0+7m+xU5l6k+2wiFnj5hKl3VVnAWjM4CljNEXLqbfYRaHexyKCN9vXtRoC05Myvj9WajBaBhrEssaWl3XM1Yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758895; c=relaxed/simple;
	bh=5AjlbY4SbkMb7fbMWpuVkm96aV7hqIHZVKSqclwXJ4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USMbRkJdVK/djRmNJ6gtFymxC2dvhK0SpocAAJ80knBeZFUlOSm0j8GO/mQ6jbbcjUU/PXi8cOnYzfP4qFjpRV5LNOMl+EpTkRoHTFng6l6zX76SA3F3eoGDjPoxTMbisMJBrFnPfVu16xVZnODcHecJwZy5JmX8hUDtDxctqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNEM9pI4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7E41F00A3D;
	Thu, 18 Jun 2026 05:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758893;
	bh=xVsjwzcpSI7/5pgEWBoKEUAtlsJxQMV54Dm23nnwVDA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GNEM9pI4J2A3W8ITg/JMJiDAThJD/dNOhXXWcPRnZtJnt9OJpCYOTMfuxoiroLTER
	 UYVvmCpGDRGo+Wj5MI04AI3Mg+OQQ+S0o40zreJDWCnNRbOEhKnx6off6lOJckpPIF
	 ymkVht+rLdOlwJAG1nuu7u/rjUQ77cY3e2M4zpwJTZoonL65N/XY61VkV2WxvQZVo6
	 /F1UjGpkvk01FfHlyjEUGQjieOZa4NjpbgZ7nIPNcviJu5m/ik5DcyWehP1OdKM+jI
	 2lXtcHC3QKw7vM6i0ajuppvilWmGutCdf3SZmP5YgesHpBzrtqfd281EDa487u7nDP
	 NhWEP7B1Hteew==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:55 +0200
Subject: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-11599-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2772669D9F0

Remove the obsolete DB8500 PRCMU regulator drivers.

Drop the regulator build hooks now that EPODs are power domains.

Keep the MFD cell around because a later patch reuses it for a
small compatibility regulator driver.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mfd/db8500-prcmu.c             | 239 +---------------
 drivers/regulator/Kconfig              |  12 -
 drivers/regulator/Makefile             |   2 -
 drivers/regulator/db8500-prcmu.c       | 501 ---------------------------------
 drivers/regulator/dbx500-prcmu.c       | 155 ----------
 drivers/regulator/dbx500-prcmu.h       |  55 ----
 include/linux/regulator/db8500-prcmu.h |  38 ---
 7 files changed, 1 insertion(+), 1001 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 21e68a382b11..f1eeab3e6270 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -34,8 +34,6 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/regulator/db8500-prcmu.h>
-#include <linux/regulator/machine.h>
 #include "db8500-prcmu-regs.h"
 
 /* Index of different voltages to be used when accessing AVSData */
@@ -2704,248 +2702,13 @@ static void init_prcm_registers(void)
 	writel(val, (PRCM_A9PL_FORCE_CLKEN));
 }
 
-/*
- * Power domain switches (ePODs) modeled as regulators for the DB8500 SoC
- */
-static struct regulator_consumer_supply db8500_vape_consumers[] = {
-	REGULATOR_SUPPLY("v-ape", NULL),
-	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.0"),
-	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.1"),
-	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.2"),
-	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.3"),
-	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.4"),
-	/* "v-mmc" changed to "vcore" in the mainline kernel */
-	REGULATOR_SUPPLY("vcore", "sdi0"),
-	REGULATOR_SUPPLY("vcore", "sdi1"),
-	REGULATOR_SUPPLY("vcore", "sdi2"),
-	REGULATOR_SUPPLY("vcore", "sdi3"),
-	REGULATOR_SUPPLY("vcore", "sdi4"),
-	REGULATOR_SUPPLY("v-dma", "dma40.0"),
-	REGULATOR_SUPPLY("v-ape", "ab8500-usb.0"),
-	/* "v-uart" changed to "vcore" in the mainline kernel */
-	REGULATOR_SUPPLY("vcore", "uart0"),
-	REGULATOR_SUPPLY("vcore", "uart1"),
-	REGULATOR_SUPPLY("vcore", "uart2"),
-	REGULATOR_SUPPLY("v-ape", "nmk-ske-keypad.0"),
-	REGULATOR_SUPPLY("v-hsi", "ste_hsi.0"),
-	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
-};
-
-static struct regulator_consumer_supply db8500_vsmps2_consumers[] = {
-	REGULATOR_SUPPLY("musb_1v8", "ab8500-usb.0"),
-	/* AV8100 regulator */
-	REGULATOR_SUPPLY("hdmi_1v8", "0-0070"),
-};
-
-static struct regulator_consumer_supply db8500_b2r2_mcde_consumers[] = {
-	REGULATOR_SUPPLY("vsupply", "b2r2_bus"),
-	REGULATOR_SUPPLY("vsupply", "mcde"),
-};
-
-/* SVA MMDSP regulator switch */
-static struct regulator_consumer_supply db8500_svammdsp_consumers[] = {
-	REGULATOR_SUPPLY("sva-mmdsp", "cm_control"),
-};
-
-/* SVA pipe regulator switch */
-static struct regulator_consumer_supply db8500_svapipe_consumers[] = {
-	REGULATOR_SUPPLY("sva-pipe", "cm_control"),
-};
-
-/* SIA MMDSP regulator switch */
-static struct regulator_consumer_supply db8500_siammdsp_consumers[] = {
-	REGULATOR_SUPPLY("sia-mmdsp", "cm_control"),
-};
-
-/* SIA pipe regulator switch */
-static struct regulator_consumer_supply db8500_siapipe_consumers[] = {
-	REGULATOR_SUPPLY("sia-pipe", "cm_control"),
-};
-
-static struct regulator_consumer_supply db8500_sga_consumers[] = {
-	REGULATOR_SUPPLY("v-mali", NULL),
-};
-
-/* ESRAM1 and 2 regulator switch */
-static struct regulator_consumer_supply db8500_esram12_consumers[] = {
-	REGULATOR_SUPPLY("esram12", "cm_control"),
-};
-
-/* ESRAM3 and 4 regulator switch */
-static struct regulator_consumer_supply db8500_esram34_consumers[] = {
-	REGULATOR_SUPPLY("v-esram34", "mcde"),
-	REGULATOR_SUPPLY("esram34", "cm_control"),
-	REGULATOR_SUPPLY("lcla_esram", "dma40.0"),
-};
-
-static struct regulator_init_data db8500_regulators[DB8500_NUM_REGULATORS] = {
-	[DB8500_REGULATOR_VAPE] = {
-		.constraints = {
-			.name = "db8500-vape",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-			.always_on = true,
-		},
-		.consumer_supplies = db8500_vape_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_vape_consumers),
-	},
-	[DB8500_REGULATOR_VARM] = {
-		.constraints = {
-			.name = "db8500-varm",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_VMODEM] = {
-		.constraints = {
-			.name = "db8500-vmodem",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_VPLL] = {
-		.constraints = {
-			.name = "db8500-vpll",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_VSMPS1] = {
-		.constraints = {
-			.name = "db8500-vsmps1",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_VSMPS2] = {
-		.constraints = {
-			.name = "db8500-vsmps2",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_vsmps2_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_vsmps2_consumers),
-	},
-	[DB8500_REGULATOR_VSMPS3] = {
-		.constraints = {
-			.name = "db8500-vsmps3",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_VRF1] = {
-		.constraints = {
-			.name = "db8500-vrf1",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_SWITCH_SVAMMDSP] = {
-		/* dependency to u8500-vape is handled outside regulator framework */
-		.constraints = {
-			.name = "db8500-sva-mmdsp",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_svammdsp_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_svammdsp_consumers),
-	},
-	[DB8500_REGULATOR_SWITCH_SVAMMDSPRET] = {
-		.constraints = {
-			/* "ret" means "retention" */
-			.name = "db8500-sva-mmdsp-ret",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_SWITCH_SVAPIPE] = {
-		/* dependency to u8500-vape is handled outside regulator framework */
-		.constraints = {
-			.name = "db8500-sva-pipe",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_svapipe_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_svapipe_consumers),
-	},
-	[DB8500_REGULATOR_SWITCH_SIAMMDSP] = {
-		/* dependency to u8500-vape is handled outside regulator framework */
-		.constraints = {
-			.name = "db8500-sia-mmdsp",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_siammdsp_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_siammdsp_consumers),
-	},
-	[DB8500_REGULATOR_SWITCH_SIAMMDSPRET] = {
-		.constraints = {
-			.name = "db8500-sia-mmdsp-ret",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_SWITCH_SIAPIPE] = {
-		/* dependency to u8500-vape is handled outside regulator framework */
-		.constraints = {
-			.name = "db8500-sia-pipe",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_siapipe_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_siapipe_consumers),
-	},
-	[DB8500_REGULATOR_SWITCH_SGA] = {
-		.supply_regulator = "db8500-vape",
-		.constraints = {
-			.name = "db8500-sga",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_sga_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_sga_consumers),
-
-	},
-	[DB8500_REGULATOR_SWITCH_B2R2_MCDE] = {
-		.supply_regulator = "db8500-vape",
-		.constraints = {
-			.name = "db8500-b2r2-mcde",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_b2r2_mcde_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_b2r2_mcde_consumers),
-	},
-	[DB8500_REGULATOR_SWITCH_ESRAM12] = {
-		/*
-		 * esram12 is set in retention and supplied by Vsafe when Vape is off,
-		 * no need to hold Vape
-		 */
-		.constraints = {
-			.name = "db8500-esram12",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_esram12_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_esram12_consumers),
-	},
-	[DB8500_REGULATOR_SWITCH_ESRAM12RET] = {
-		.constraints = {
-			.name = "db8500-esram12-ret",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-	[DB8500_REGULATOR_SWITCH_ESRAM34] = {
-		/*
-		 * esram34 is set in retention and supplied by Vsafe when Vape is off,
-		 * no need to hold Vape
-		 */
-		.constraints = {
-			.name = "db8500-esram34",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.consumer_supplies = db8500_esram34_consumers,
-		.num_consumer_supplies = ARRAY_SIZE(db8500_esram34_consumers),
-	},
-	[DB8500_REGULATOR_SWITCH_ESRAM34RET] = {
-		.constraints = {
-			.name = "db8500-esram34-ret",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-	},
-};
-
 static const struct mfd_cell common_prcmu_devs[] = {
 	MFD_CELL_NAME("db8500_wdt"),
 	MFD_CELL_NAME("db8500-cpuidle"),
 };
 
 static const struct mfd_cell db8500_prcmu_devs[] = {
-	MFD_CELL_OF("db8500-prcmu-regulators", NULL,
-		    &db8500_regulators, sizeof(db8500_regulators), 0,
+	MFD_CELL_OF("db8500-prcmu-regulators", NULL, NULL, 0, 0,
 		    "stericsson,db8500-prcmu-regulator"),
 	MFD_CELL_OF("db8500-thermal",
 		    NULL, NULL, 0, 0, "stericsson,db8500-thermal"),
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 35d1b191462c..acc698c17bd2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -408,18 +408,6 @@ config REGULATOR_DA9211
 	  step down converter 12A or 16A DC-DC Buck controlled through an I2C
 	  interface.
 
-config REGULATOR_DBX500_PRCMU
-	bool
-
-config REGULATOR_DB8500_PRCMU
-	bool "ST-Ericsson DB8500 Voltage Domain Regulators"
-	depends on MFD_DB8500_PRCMU
-	depends on !UX500_PM_DOMAIN
-	select REGULATOR_DBX500_PRCMU
-	help
-	  This driver supports the voltage domain regulators controlled by the
-	  DB8500 PRCMU
-
 config REGULATOR_FAN53555
 	tristate "Fairchild FAN53555 Regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 35639f3115fd..96a02063b843 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -48,8 +48,6 @@ obj-$(CONFIG_REGULATOR_DA9063)	+= da9063-regulator.o
 obj-$(CONFIG_REGULATOR_DA9121) += da9121-regulator.o
 obj-$(CONFIG_REGULATOR_DA9210) += da9210-regulator.o
 obj-$(CONFIG_REGULATOR_DA9211) += da9211-regulator.o
-obj-$(CONFIG_REGULATOR_DBX500_PRCMU) += dbx500-prcmu.o
-obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
 obj-$(CONFIG_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_REGULATOR_FAN53880) += fan53880.o
 obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
deleted file mode 100644
index 1ec2e1348891..000000000000
--- a/drivers/regulator/db8500-prcmu.c
+++ /dev/null
@@ -1,501 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Authors: Sundar Iyer <sundar.iyer@stericsson.com> for ST-Ericsson
- *          Bengt Jonsson <bengt.g.jonsson@stericsson.com> for ST-Ericsson
- *
- * Power domain regulators on DB8500
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/dbx500-prcmu.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/db8500-prcmu.h>
-#include <linux/regulator/of_regulator.h>
-#include <linux/of.h>
-#include <linux/module.h>
-#include "dbx500-prcmu.h"
-
-static int db8500_regulator_enable(struct regulator_dev *rdev)
-{
-	struct dbx500_regulator_info *info = rdev_get_drvdata(rdev);
-
-	if (info == NULL)
-		return -EINVAL;
-
-	dev_vdbg(rdev_get_dev(rdev), "regulator-%s-enable\n",
-		info->desc.name);
-
-	if (!info->is_enabled) {
-		info->is_enabled = true;
-		if (!info->exclude_from_power_state)
-			power_state_active_enable();
-	}
-
-	return 0;
-}
-
-static int db8500_regulator_disable(struct regulator_dev *rdev)
-{
-	struct dbx500_regulator_info *info = rdev_get_drvdata(rdev);
-	int ret = 0;
-
-	if (info == NULL)
-		return -EINVAL;
-
-	dev_vdbg(rdev_get_dev(rdev), "regulator-%s-disable\n",
-		info->desc.name);
-
-	if (info->is_enabled) {
-		info->is_enabled = false;
-		if (!info->exclude_from_power_state)
-			ret = power_state_active_disable();
-	}
-
-	return ret;
-}
-
-static int db8500_regulator_is_enabled(struct regulator_dev *rdev)
-{
-	struct dbx500_regulator_info *info = rdev_get_drvdata(rdev);
-
-	if (info == NULL)
-		return -EINVAL;
-
-	dev_vdbg(rdev_get_dev(rdev), "regulator-%s-is_enabled (is_enabled):"
-		" %i\n", info->desc.name, info->is_enabled);
-
-	return info->is_enabled;
-}
-
-/* db8500 regulator operations */
-static const struct regulator_ops db8500_regulator_ops = {
-	.enable			= db8500_regulator_enable,
-	.disable		= db8500_regulator_disable,
-	.is_enabled		= db8500_regulator_is_enabled,
-};
-
-/*
- * EPOD control
- */
-static bool epod_on[NUM_EPOD_ID];
-static bool epod_ramret[NUM_EPOD_ID];
-
-static int enable_epod(u16 epod_id, bool ramret)
-{
-	int ret;
-
-	if (ramret) {
-		if (!epod_on[epod_id]) {
-			ret = prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);
-			if (ret < 0)
-				return ret;
-		}
-		epod_ramret[epod_id] = true;
-	} else {
-		ret = prcmu_set_epod(epod_id, EPOD_STATE_ON);
-		if (ret < 0)
-			return ret;
-		epod_on[epod_id] = true;
-	}
-
-	return 0;
-}
-
-static int disable_epod(u16 epod_id, bool ramret)
-{
-	int ret;
-
-	if (ramret) {
-		if (!epod_on[epod_id]) {
-			ret = prcmu_set_epod(epod_id, EPOD_STATE_OFF);
-			if (ret < 0)
-				return ret;
-		}
-		epod_ramret[epod_id] = false;
-	} else {
-		if (epod_ramret[epod_id]) {
-			ret = prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);
-			if (ret < 0)
-				return ret;
-		} else {
-			ret = prcmu_set_epod(epod_id, EPOD_STATE_OFF);
-			if (ret < 0)
-				return ret;
-		}
-		epod_on[epod_id] = false;
-	}
-
-	return 0;
-}
-
-/*
- * Regulator switch
- */
-static int db8500_regulator_switch_enable(struct regulator_dev *rdev)
-{
-	struct dbx500_regulator_info *info = rdev_get_drvdata(rdev);
-	int ret;
-
-	if (info == NULL)
-		return -EINVAL;
-
-	dev_vdbg(rdev_get_dev(rdev), "regulator-switch-%s-enable\n",
-		info->desc.name);
-
-	ret = enable_epod(info->epod_id, info->is_ramret);
-	if (ret < 0) {
-		dev_err(rdev_get_dev(rdev),
-			"regulator-switch-%s-enable: prcmu call failed\n",
-			info->desc.name);
-		goto out;
-	}
-
-	info->is_enabled = true;
-out:
-	return ret;
-}
-
-static int db8500_regulator_switch_disable(struct regulator_dev *rdev)
-{
-	struct dbx500_regulator_info *info = rdev_get_drvdata(rdev);
-	int ret;
-
-	if (info == NULL)
-		return -EINVAL;
-
-	dev_vdbg(rdev_get_dev(rdev), "regulator-switch-%s-disable\n",
-		info->desc.name);
-
-	ret = disable_epod(info->epod_id, info->is_ramret);
-	if (ret < 0) {
-		dev_err(rdev_get_dev(rdev),
-			"regulator_switch-%s-disable: prcmu call failed\n",
-			info->desc.name);
-		goto out;
-	}
-
-	info->is_enabled = false;
-out:
-	return ret;
-}
-
-static int db8500_regulator_switch_is_enabled(struct regulator_dev *rdev)
-{
-	struct dbx500_regulator_info *info = rdev_get_drvdata(rdev);
-
-	if (info == NULL)
-		return -EINVAL;
-
-	dev_vdbg(rdev_get_dev(rdev),
-		"regulator-switch-%s-is_enabled (is_enabled): %i\n",
-		info->desc.name, info->is_enabled);
-
-	return info->is_enabled;
-}
-
-static const struct regulator_ops db8500_regulator_switch_ops = {
-	.enable			= db8500_regulator_switch_enable,
-	.disable		= db8500_regulator_switch_disable,
-	.is_enabled		= db8500_regulator_switch_is_enabled,
-};
-
-/*
- * Regulator information
- */
-static struct dbx500_regulator_info
-dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
-	[DB8500_REGULATOR_VAPE] = {
-		.desc = {
-			.name	= "db8500-vape",
-			.of_match = of_match_ptr("db8500_vape"),
-			.id	= DB8500_REGULATOR_VAPE,
-			.ops	= &db8500_regulator_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-	},
-	[DB8500_REGULATOR_VARM] = {
-		.desc = {
-			.name	= "db8500-varm",
-			.of_match = of_match_ptr("db8500_varm"),
-			.id	= DB8500_REGULATOR_VARM,
-			.ops	= &db8500_regulator_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-	},
-	[DB8500_REGULATOR_VMODEM] = {
-		.desc = {
-			.name	= "db8500-vmodem",
-			.of_match = of_match_ptr("db8500_vmodem"),
-			.id	= DB8500_REGULATOR_VMODEM,
-			.ops	= &db8500_regulator_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-	},
-	[DB8500_REGULATOR_VPLL] = {
-		.desc = {
-			.name	= "db8500-vpll",
-			.of_match = of_match_ptr("db8500_vpll"),
-			.id	= DB8500_REGULATOR_VPLL,
-			.ops	= &db8500_regulator_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-	},
-	[DB8500_REGULATOR_VSMPS1] = {
-		.desc = {
-			.name	= "db8500-vsmps1",
-			.of_match = of_match_ptr("db8500_vsmps1"),
-			.id	= DB8500_REGULATOR_VSMPS1,
-			.ops	= &db8500_regulator_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-	},
-	[DB8500_REGULATOR_VSMPS2] = {
-		.desc = {
-			.name	= "db8500-vsmps2",
-			.of_match = of_match_ptr("db8500_vsmps2"),
-			.id	= DB8500_REGULATOR_VSMPS2,
-			.ops	= &db8500_regulator_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-			.fixed_uV = 1800000,
-			.n_voltages = 1,
-		},
-		.exclude_from_power_state = true,
-	},
-	[DB8500_REGULATOR_VSMPS3] = {
-		.desc = {
-			.name	= "db8500-vsmps3",
-			.of_match = of_match_ptr("db8500_vsmps3"),
-			.id	= DB8500_REGULATOR_VSMPS3,
-			.ops	= &db8500_regulator_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-	},
-	[DB8500_REGULATOR_VRF1] = {
-		.desc = {
-			.name	= "db8500-vrf1",
-			.of_match = of_match_ptr("db8500_vrf1"),
-			.id	= DB8500_REGULATOR_VRF1,
-			.ops	= &db8500_regulator_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-	},
-	[DB8500_REGULATOR_SWITCH_SVAMMDSP] = {
-		.desc = {
-			.name	= "db8500-sva-mmdsp",
-			.of_match = of_match_ptr("db8500_sva_mmdsp"),
-			.id	= DB8500_REGULATOR_SWITCH_SVAMMDSP,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_SVAMMDSP,
-	},
-	[DB8500_REGULATOR_SWITCH_SVAMMDSPRET] = {
-		.desc = {
-			.name	= "db8500-sva-mmdsp-ret",
-			.of_match = of_match_ptr("db8500_sva_mmdsp_ret"),
-			.id	= DB8500_REGULATOR_SWITCH_SVAMMDSPRET,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_SVAMMDSP,
-		.is_ramret = true,
-	},
-	[DB8500_REGULATOR_SWITCH_SVAPIPE] = {
-		.desc = {
-			.name	= "db8500-sva-pipe",
-			.of_match = of_match_ptr("db8500_sva_pipe"),
-			.id	= DB8500_REGULATOR_SWITCH_SVAPIPE,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_SVAPIPE,
-	},
-	[DB8500_REGULATOR_SWITCH_SIAMMDSP] = {
-		.desc = {
-			.name	= "db8500-sia-mmdsp",
-			.of_match = of_match_ptr("db8500_sia_mmdsp"),
-			.id	= DB8500_REGULATOR_SWITCH_SIAMMDSP,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_SIAMMDSP,
-	},
-	[DB8500_REGULATOR_SWITCH_SIAMMDSPRET] = {
-		.desc = {
-			.name	= "db8500-sia-mmdsp-ret",
-			.of_match = of_match_ptr("db8500_sia_mmdsp_ret"),
-			.id	= DB8500_REGULATOR_SWITCH_SIAMMDSPRET,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_SIAMMDSP,
-		.is_ramret = true,
-	},
-	[DB8500_REGULATOR_SWITCH_SIAPIPE] = {
-		.desc = {
-			.name	= "db8500-sia-pipe",
-			.of_match = of_match_ptr("db8500_sia_pipe"),
-			.id	= DB8500_REGULATOR_SWITCH_SIAPIPE,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_SIAPIPE,
-	},
-	[DB8500_REGULATOR_SWITCH_SGA] = {
-		.desc = {
-			.name	= "db8500-sga",
-			.of_match = of_match_ptr("db8500_sga"),
-			.id	= DB8500_REGULATOR_SWITCH_SGA,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_SGA,
-	},
-	[DB8500_REGULATOR_SWITCH_B2R2_MCDE] = {
-		.desc = {
-			.name	= "db8500-b2r2-mcde",
-			.of_match = of_match_ptr("db8500_b2r2_mcde"),
-			.id	= DB8500_REGULATOR_SWITCH_B2R2_MCDE,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_B2R2_MCDE,
-	},
-	[DB8500_REGULATOR_SWITCH_ESRAM12] = {
-		.desc = {
-			.name	= "db8500-esram12",
-			.of_match = of_match_ptr("db8500_esram12"),
-			.id	= DB8500_REGULATOR_SWITCH_ESRAM12,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id	= EPOD_ID_ESRAM12,
-		.is_enabled	= true,
-	},
-	[DB8500_REGULATOR_SWITCH_ESRAM12RET] = {
-		.desc = {
-			.name	= "db8500-esram12-ret",
-			.of_match = of_match_ptr("db8500_esram12_ret"),
-			.id	= DB8500_REGULATOR_SWITCH_ESRAM12RET,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_ESRAM12,
-		.is_ramret = true,
-	},
-	[DB8500_REGULATOR_SWITCH_ESRAM34] = {
-		.desc = {
-			.name	= "db8500-esram34",
-			.of_match = of_match_ptr("db8500_esram34"),
-			.id	= DB8500_REGULATOR_SWITCH_ESRAM34,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id	= EPOD_ID_ESRAM34,
-		.is_enabled	= true,
-	},
-	[DB8500_REGULATOR_SWITCH_ESRAM34RET] = {
-		.desc = {
-			.name	= "db8500-esram34-ret",
-			.of_match = of_match_ptr("db8500_esram34_ret"),
-			.id	= DB8500_REGULATOR_SWITCH_ESRAM34RET,
-			.ops	= &db8500_regulator_switch_ops,
-			.type	= REGULATOR_VOLTAGE,
-			.owner	= THIS_MODULE,
-		},
-		.epod_id = EPOD_ID_ESRAM34,
-		.is_ramret = true,
-	},
-};
-
-static int db8500_regulator_probe(struct platform_device *pdev)
-{
-	struct regulator_init_data *db8500_init_data;
-	struct dbx500_regulator_info *info;
-	struct regulator_config config = { };
-	struct regulator_dev *rdev;
-	int err, i;
-
-	db8500_init_data = dev_get_platdata(&pdev->dev);
-
-	for (i = 0; i < ARRAY_SIZE(dbx500_regulator_info); i++) {
-		/* assign per-regulator data */
-		info = &dbx500_regulator_info[i];
-
-		config.driver_data = info;
-		config.dev = &pdev->dev;
-		if (db8500_init_data)
-			config.init_data = &db8500_init_data[i];
-
-		rdev = devm_regulator_register(&pdev->dev, &info->desc,
-					       &config);
-		if (IS_ERR(rdev)) {
-			err = PTR_ERR(rdev);
-			dev_err(&pdev->dev, "failed to register %s: err %i\n",
-				info->desc.name, err);
-			return err;
-		}
-		dev_dbg(&pdev->dev, "regulator-%s-probed\n", info->desc.name);
-	}
-
-	ux500_regulator_debug_init(pdev, dbx500_regulator_info,
-				   ARRAY_SIZE(dbx500_regulator_info));
-	return 0;
-}
-
-static void db8500_regulator_remove(struct platform_device *pdev)
-{
-	ux500_regulator_debug_exit();
-}
-
-static struct platform_driver db8500_regulator_driver = {
-	.driver = {
-		.name = "db8500-prcmu-regulators",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
-	.probe = db8500_regulator_probe,
-	.remove = db8500_regulator_remove,
-};
-
-static int __init db8500_regulator_init(void)
-{
-	return platform_driver_register(&db8500_regulator_driver);
-}
-
-static void __exit db8500_regulator_exit(void)
-{
-	platform_driver_unregister(&db8500_regulator_driver);
-}
-
-arch_initcall(db8500_regulator_init);
-module_exit(db8500_regulator_exit);
-
-MODULE_AUTHOR("STMicroelectronics/ST-Ericsson");
-MODULE_DESCRIPTION("DB8500 regulator driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
deleted file mode 100644
index a45c1e1ac7ef..000000000000
--- a/drivers/regulator/dbx500-prcmu.c
+++ /dev/null
@@ -1,155 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Authors: Sundar Iyer <sundar.iyer@stericsson.com> for ST-Ericsson
- *          Bengt Jonsson <bengt.g.jonsson@stericsson.com> for ST-Ericsson
- *
- * UX500 common part of Power domain regulators
- */
-
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/regulator/driver.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-
-#include "dbx500-prcmu.h"
-
-/*
- * power state reference count
- */
-static int power_state_active_cnt; /* will initialize to zero */
-static DEFINE_SPINLOCK(power_state_active_lock);
-
-void power_state_active_enable(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&power_state_active_lock, flags);
-	power_state_active_cnt++;
-	spin_unlock_irqrestore(&power_state_active_lock, flags);
-}
-
-int power_state_active_disable(void)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&power_state_active_lock, flags);
-	if (power_state_active_cnt <= 0) {
-		pr_err("power state: unbalanced enable/disable calls\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	power_state_active_cnt--;
-out:
-	spin_unlock_irqrestore(&power_state_active_lock, flags);
-	return ret;
-}
-
-#ifdef CONFIG_REGULATOR_DEBUG
-
-static int power_state_active_get(void)
-{
-	unsigned long flags;
-	int cnt;
-
-	spin_lock_irqsave(&power_state_active_lock, flags);
-	cnt = power_state_active_cnt;
-	spin_unlock_irqrestore(&power_state_active_lock, flags);
-
-	return cnt;
-}
-
-static struct ux500_regulator_debug {
-	struct dentry *dir;
-	struct dbx500_regulator_info *regulator_array;
-	int num_regulators;
-	u8 *state_before_suspend;
-	u8 *state_after_suspend;
-} rdebug;
-
-static int ux500_regulator_power_state_cnt_show(struct seq_file *s, void *p)
-{
-	/* print power state count */
-	seq_printf(s, "ux500-regulator power state count: %i\n",
-		   power_state_active_get());
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(ux500_regulator_power_state_cnt);
-
-static int ux500_regulator_status_show(struct seq_file *s, void *p)
-{
-	int i;
-
-	/* print dump header */
-	seq_puts(s, "ux500-regulator status:\n");
-	seq_printf(s, "%31s : %8s : %8s\n", "current", "before", "after");
-
-	for (i = 0; i < rdebug.num_regulators; i++) {
-		struct dbx500_regulator_info *info;
-		/* Access per-regulator data */
-		info = &rdebug.regulator_array[i];
-
-		/* print status */
-		seq_printf(s, "%20s : %8s : %8s : %8s\n",
-			   info->desc.name,
-			   info->is_enabled ? "enabled" : "disabled",
-			   rdebug.state_before_suspend[i] ? "enabled" : "disabled",
-			   rdebug.state_after_suspend[i] ? "enabled" : "disabled");
-	}
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(ux500_regulator_status);
-
-int
-ux500_regulator_debug_init(struct platform_device *pdev,
-	struct dbx500_regulator_info *regulator_info,
-	int num_regulators)
-{
-	/* create directory */
-	rdebug.dir = debugfs_create_dir("ux500-regulator", NULL);
-
-	/* create "status" file */
-	debugfs_create_file("status", 0444, rdebug.dir, &pdev->dev,
-			    &ux500_regulator_status_fops);
-
-	/* create "power-state-count" file */
-	debugfs_create_file("power-state-count", 0444, rdebug.dir,
-			    &pdev->dev, &ux500_regulator_power_state_cnt_fops);
-
-	rdebug.regulator_array = regulator_info;
-	rdebug.num_regulators = num_regulators;
-
-	rdebug.state_before_suspend = kzalloc(num_regulators, GFP_KERNEL);
-	if (!rdebug.state_before_suspend)
-		goto exit_destroy_power_state;
-
-	rdebug.state_after_suspend = kzalloc(num_regulators, GFP_KERNEL);
-	if (!rdebug.state_after_suspend)
-		goto exit_free;
-
-	return 0;
-
-exit_free:
-	kfree(rdebug.state_before_suspend);
-exit_destroy_power_state:
-	debugfs_remove_recursive(rdebug.dir);
-	return -ENOMEM;
-}
-
-int ux500_regulator_debug_exit(void)
-{
-	debugfs_remove_recursive(rdebug.dir);
-	kfree(rdebug.state_after_suspend);
-	kfree(rdebug.state_before_suspend);
-
-	return 0;
-}
-#endif
diff --git a/drivers/regulator/dbx500-prcmu.h b/drivers/regulator/dbx500-prcmu.h
deleted file mode 100644
index 2fb3aaef9dbb..000000000000
--- a/drivers/regulator/dbx500-prcmu.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Bengt Jonsson <bengt.jonsson@stericsson.com> for ST-Ericsson,
- *	   Jonas Aaberg <jonas.aberg@stericsson.com> for ST-Ericsson
- */
-
-#ifndef DBX500_REGULATOR_H
-#define DBX500_REGULATOR_H
-
-#include <linux/platform_device.h>
-
-/**
- * struct dbx500_regulator_info - dbx500 regulator information
- * @desc: regulator description
- * @is_enabled: status of the regulator
- * @epod_id: id for EPOD (power domain)
- * @is_ramret: RAM retention switch for EPOD (power domain)
- *
- */
-struct dbx500_regulator_info {
-	struct regulator_desc desc;
-	bool is_enabled;
-	u16 epod_id;
-	bool is_ramret;
-	bool exclude_from_power_state;
-};
-
-void power_state_active_enable(void);
-int power_state_active_disable(void);
-
-
-#ifdef CONFIG_REGULATOR_DEBUG
-int ux500_regulator_debug_init(struct platform_device *pdev,
-			       struct dbx500_regulator_info *regulator_info,
-			       int num_regulators);
-
-int ux500_regulator_debug_exit(void);
-#else
-
-static inline int ux500_regulator_debug_init(struct platform_device *pdev,
-			     struct dbx500_regulator_info *regulator_info,
-			     int num_regulators)
-{
-	return 0;
-}
-
-static inline int ux500_regulator_debug_exit(void)
-{
-	return 0;
-}
-
-#endif
-#endif
diff --git a/include/linux/regulator/db8500-prcmu.h b/include/linux/regulator/db8500-prcmu.h
deleted file mode 100644
index d58ff273157e..000000000000
--- a/include/linux/regulator/db8500-prcmu.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Bengt Jonsson <bengt.g.jonsson@stericsson.com> for ST-Ericsson
- *
- * Interface to power domain regulators on DB8500
- */
-
-#ifndef __REGULATOR_H__
-#define __REGULATOR_H__
-
-/* Number of DB8500 regulators and regulator enumeration */
-enum db8500_regulator_id {
-	DB8500_REGULATOR_VAPE,
-	DB8500_REGULATOR_VARM,
-	DB8500_REGULATOR_VMODEM,
-	DB8500_REGULATOR_VPLL,
-	DB8500_REGULATOR_VSMPS1,
-	DB8500_REGULATOR_VSMPS2,
-	DB8500_REGULATOR_VSMPS3,
-	DB8500_REGULATOR_VRF1,
-	DB8500_REGULATOR_SWITCH_SVAMMDSP,
-	DB8500_REGULATOR_SWITCH_SVAMMDSPRET,
-	DB8500_REGULATOR_SWITCH_SVAPIPE,
-	DB8500_REGULATOR_SWITCH_SIAMMDSP,
-	DB8500_REGULATOR_SWITCH_SIAMMDSPRET,
-	DB8500_REGULATOR_SWITCH_SIAPIPE,
-	DB8500_REGULATOR_SWITCH_SGA,
-	DB8500_REGULATOR_SWITCH_B2R2_MCDE,
-	DB8500_REGULATOR_SWITCH_ESRAM12,
-	DB8500_REGULATOR_SWITCH_ESRAM12RET,
-	DB8500_REGULATOR_SWITCH_ESRAM34,
-	DB8500_REGULATOR_SWITCH_ESRAM34RET,
-	DB8500_NUM_REGULATORS
-};
-
-#endif

-- 
2.54.0


