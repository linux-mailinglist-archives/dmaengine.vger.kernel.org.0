Return-Path: <dmaengine+bounces-11597-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0XvJN6t7M2qCCgYAu9opvQ
	(envelope-from <dmaengine+bounces-11597-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE969D9AD
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Llk4R1ck;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11597-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11597-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28873301FCBF
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED337C0F3;
	Thu, 18 Jun 2026 05:01:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED837DEA9;
	Thu, 18 Jun 2026 05:01:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758885; cv=none; b=SUppNlcV11dKJQ+O53jUGyRj0STBmM0QBjPChgIA8C/kegFOnw9tCelI8uu6+HmcrRbBZ6BCRPniMmAm0wNx4Bf2oXcYIhYVkHetAMbopujOQJ9PetZOtmJJkRRK5ipG5h5rve//HU7I563C+/70AWinNQwmIDnTfEEv8KeJ79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758885; c=relaxed/simple;
	bh=A/kBLPp0R/udtlyn6GtEubLPaAZZzsgaN1S9o7z1kwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ql2Dihg5yttrFLujHlOC3ZFD7sKRiUrcRHrg6Se0HvZgqb8Vm82yiWcb6kTfhRr7g9sKi7vW+C9uXndRjp23Poxf0zydIrbtj8c+Bgtg5/RF8Kg3oWu3U6cQFa+ECRdpj1rQjCiVdIOJzUBJmNcz0SwDsePH03J42b/asIqRhqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Llk4R1ck; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D73B1F00A3A;
	Thu, 18 Jun 2026 05:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758884;
	bh=EGVZGRqbYVg0qMWaFvO5v2kQoyq33HfAez9HfwWpsGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Llk4R1ckDS6uaw0zNR7uDSwFsLe+p1ZQj9fzMAImypRCXN/ubv+2YNqgjJJpN9BlI
	 khpWPFkMUH4OZprw5L8sp+WQ3Q+sCjn/o9+bHLbFEa4w6jBpEGRQ4SSX7k30IjUw3w
	 YZn7T5kOSuFqxCB59Me798rdGlOHpb5Y6gnoORdRiMdi3sjBhuLvAdJlsStvZa+zMl
	 /Au8cqYHK8sF4zIBIT3nHz1K8FBKLB++xRnhkJ0q7TJjInTWNczo7LK3p+wG5E2TrB
	 46033dFpo8CboX0s1DXyaZD/froFcjQCkrDiJZiNJv8voeDTUgxVL3UfZmN8cIJxrt
	 kvMWw90pWy/UQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:53 +0200
Subject: [PATCH 07/11] drm/mcde: Use power domain for display power
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-7-eb5e50b1a588@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-11597-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05AE969D9AD

Replace explicit EPOD regulator handling with runtime PM.

Use the MCDE power domain and drop the regulator dependency.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_clk_div.c |  4 +--
 drivers/gpu/drm/mcde/mcde_display.c | 11 +++----
 drivers/gpu/drm/mcde/mcde_drm.h     |  2 --
 drivers/gpu/drm/mcde/mcde_drv.c     | 63 +++++++++++--------------------------
 drivers/gpu/drm/mcde/mcde_dsi.c     |  1 -
 5 files changed, 25 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_clk_div.c b/drivers/gpu/drm/mcde/mcde_clk_div.c
index 8c5af2677357..1a22e6233946 100644
--- a/drivers/gpu/drm/mcde/mcde_clk_div.c
+++ b/drivers/gpu/drm/mcde/mcde_clk_div.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 
 #include "mcde_drm.h"
 #include "mcde_display_regs.h"
@@ -95,7 +95,7 @@ static unsigned long mcde_clk_div_recalc_rate(struct clk_hw *hw,
 	 * It will come up with 0 in the divider register bits, which
 	 * means "divide by 2".
 	 */
-	if (!regulator_is_enabled(mcde->epod))
+	if (!pm_runtime_active(mcde->dev))
 		return DIV_ROUND_UP_ULL(prate, 2);
 
 	cr = readl(mcde->regs + cdiv->cr);
diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 257a6e84dd58..52f071bb347c 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -7,7 +7,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
-#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/media-bus-format.h>
 
 #include <drm/drm_device.h>
@@ -1168,16 +1168,15 @@ static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
 	int ret;
 
 	/* This powers up the entire MCDE block and the DSI hardware */
-	ret = regulator_enable(mcde->epod);
+	ret = pm_runtime_resume_and_get(mcde->dev);
 	if (ret) {
-		dev_err(drm->dev, "can't re-enable EPOD regulator\n");
+		dev_err(drm->dev, "can't enable MCDE power domain\n");
 		return;
 	}
 
 	dev_info(drm->dev, "enable MCDE, %d x %d format %p4cc\n",
 		 mode->hdisplay, mode->vdisplay, &format);
 
-
 	/* Clear any pending interrupts */
 	mcde_display_disable_irqs(mcde);
 	writel(0, mcde->regs + MCDE_IMSCERR);
@@ -1327,9 +1326,9 @@ static void mcde_display_disable(struct drm_simple_display_pipe *pipe)
 		spin_unlock_irq(&crtc->dev->event_lock);
 	}
 
-	ret = regulator_disable(mcde->epod);
+	ret = pm_runtime_put_sync_suspend(mcde->dev);
 	if (ret)
-		dev_err(drm->dev, "can't disable EPOD regulator\n");
+		dev_err(drm->dev, "can't disable MCDE power domain\n");
 	/* Make sure we are powered down (before we may power up again) */
 	usleep_range(50000, 70000);
 
diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
index ecb70b4b737c..d4ff7606d917 100644
--- a/drivers/gpu/drm/mcde/mcde_drm.h
+++ b/drivers/gpu/drm/mcde/mcde_drm.h
@@ -91,8 +91,6 @@ struct mcde {
 	/* Locks the MCDE FIFO control register A and B */
 	spinlock_t fifo_crx1_lock;
 
-	struct regulator *epod;
-	struct regulator *vana;
 };
 
 #define to_mcde(dev) container_of(dev, struct mcde, drm)
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5f2c462bad7e..3f966cccda5a 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -61,7 +61,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 
@@ -283,45 +283,25 @@ static int mcde_probe(struct platform_device *pdev)
 	mcde->dev = dev;
 	platform_set_drvdata(pdev, drm);
 
-	/* First obtain and turn on the main power */
-	mcde->epod = devm_regulator_get(dev, "epod");
-	if (IS_ERR(mcde->epod)) {
-		ret = PTR_ERR(mcde->epod);
-		dev_err(dev, "can't get EPOD regulator\n");
-		return ret;
-	}
-	ret = regulator_enable(mcde->epod);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
-		dev_err(dev, "can't enable EPOD regulator\n");
+		dev_err(dev, "can't enable MCDE power domain\n");
+		pm_runtime_disable(dev);
 		return ret;
 	}
-	mcde->vana = devm_regulator_get(dev, "vana");
-	if (IS_ERR(mcde->vana)) {
-		ret = PTR_ERR(mcde->vana);
-		dev_err(dev, "can't get VANA regulator\n");
-		goto regulator_epod_off;
-	}
-	ret = regulator_enable(mcde->vana);
-	if (ret) {
-		dev_err(dev, "can't enable VANA regulator\n");
-		goto regulator_epod_off;
-	}
-	/*
-	 * The vendor code uses ESRAM (onchip RAM) and need to activate
-	 * the v-esram34 regulator, but we don't use that yet
-	 */
 
 	/* Clock the silicon so we can access the registers */
 	mcde->mcde_clk = devm_clk_get(dev, "mcde");
 	if (IS_ERR(mcde->mcde_clk)) {
 		dev_err(dev, "unable to get MCDE main clock\n");
 		ret = PTR_ERR(mcde->mcde_clk);
-		goto regulator_off;
+		goto pm_runtime_put;
 	}
 	ret = clk_prepare_enable(mcde->mcde_clk);
 	if (ret) {
 		dev_err(dev, "failed to enable MCDE main clock\n");
-		goto regulator_off;
+		goto pm_runtime_put;
 	}
 	dev_info(dev, "MCDE clk rate %lu Hz\n", clk_get_rate(mcde->mcde_clk));
 
@@ -412,14 +392,15 @@ static int mcde_probe(struct platform_device *pdev)
 
 	/*
 	 * Perform an invasive reset of the MCDE and all blocks by
-	 * cutting the power to the subsystem, then bring it back up
+	 * powering down the subsystem, then bring it back up
 	 * later when we enable the display as a result of
 	 * component_master_add_with_match().
 	 */
-	ret = regulator_disable(mcde->epod);
+	ret = pm_runtime_put_sync_suspend(dev);
 	if (ret) {
-		dev_err(dev, "can't disable EPOD regulator\n");
-		return ret;
+		dev_err(dev, "can't disable MCDE power domain\n");
+		pm_runtime_get_noresume(dev);
+		goto clk_disable;
 	}
 	/* Wait 50 ms so we are sure we cut the power */
 	usleep_range(50000, 70000);
@@ -428,25 +409,18 @@ static int mcde_probe(struct platform_device *pdev)
 					      match);
 	if (ret) {
 		dev_err(dev, "failed to add component master\n");
-		/*
-		 * The EPOD regulator is already disabled at this point so some
-		 * special errorpath code is needed
-		 */
-		clk_disable_unprepare(mcde->mcde_clk);
-		regulator_disable(mcde->vana);
-		return ret;
+		goto clk_disable_pm_disabled;
 	}
 
 	return 0;
 
 clk_disable:
 	clk_disable_unprepare(mcde->mcde_clk);
-regulator_off:
-	regulator_disable(mcde->vana);
-regulator_epod_off:
-	regulator_disable(mcde->epod);
+pm_runtime_put:
+	pm_runtime_put_sync_suspend(dev);
+clk_disable_pm_disabled:
+	pm_runtime_disable(dev);
 	return ret;
-
 }
 
 static void mcde_remove(struct platform_device *pdev)
@@ -456,8 +430,7 @@ static void mcde_remove(struct platform_device *pdev)
 
 	component_master_del(&pdev->dev, &mcde_drm_comp_ops);
 	clk_disable_unprepare(mcde->mcde_clk);
-	regulator_disable(mcde->vana);
-	regulator_disable(mcde->epod);
+	pm_runtime_disable(&pdev->dev);
 }
 
 static void mcde_shutdown(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index 47d45897ed06..e09b2d4aca0c 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -8,7 +8,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 #include <video/mipi_display.h>
 
 #include <drm/drm_atomic_helper.h>

-- 
2.54.0


