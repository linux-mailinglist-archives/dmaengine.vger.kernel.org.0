Return-Path: <dmaengine+bounces-11598-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QDHiNbp7M2qRCgYAu9opvQ
	(envelope-from <dmaengine+bounces-11598-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E5D69D9E8
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="C/9W3eDd";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11598-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11598-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AFC6306A94C
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B137DAAC;
	Thu, 18 Jun 2026 05:01:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366D37C927;
	Thu, 18 Jun 2026 05:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758890; cv=none; b=jHzQCfGi5t7PWNNtalZYXpCQF9m9SSOK09tJMM57blx/KZEJcFdJEqK9Q9g9VsPl3FFX8PvMt6RSDx+wEmU4zVetHojOrYEFKeIEVc4mpOTSrWYFRDFXtCnXsF1NEnz43f8cdGvB9FP92bpTkFRuWxCdN0mDcPm9TB3GpUWUBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758890; c=relaxed/simple;
	bh=dsFDJ95Kn2ifX/IP8PI4bPDq/IDWFdthbtaLjcvHFVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4HJON4Z3xoOHzlWQLHbhSKK+gEeG8hlqy5MgR441nLBGHJCZ279jf7fEnZwNF/eq24pQxCnuSo2Fr9eZbS/92kpsZTWd3CeYPmqxvl+2vH/9MZ78WPQD7q/G0qajpckW+buszURpqe5Dmx+r/tgS8JUzJzrXEJPyBeHKxP9y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/9W3eDd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989521F000E9;
	Thu, 18 Jun 2026 05:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758888;
	bh=yBILmZJ1mWMro5TI/n+b/9wLCKhup6eLvhz9q9e2tc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C/9W3eDdjT41mXk2M3FKcq6C0SQEt8SeG2wVrE4xPllupJ4oVW769W0nrkyHCSG+D
	 FFHzUt/S/NeDJSgaq/Z7M0zco6whPFyp/87Ow1BbGSCv08PQ4sz9/46tOcsufPnmbw
	 wbH6YW32PEniu9ih2gGXNpeAB5EETxmyTF3T9cWT6RC4x2CzH1rnCerYid/fDOzFMb
	 Opy41Kjae+ATzBoctKLnej5042YT1Zo1s/Wl8k5YFGwzPK1B1Jxoz5FmJU19ThclhP
	 9lGYi+xn0FwFPllTIcr64AFzIMxZF93xawgi1BXIdA55qeiGJd/pWmPSeNg5ZNFfQs
	 C4/OiRFvyxAuA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:54 +0200
Subject: [PATCH 08/11] dmaengine: ste_dma40: Use power domain for LCLA SRAM
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-8-eb5e50b1a588@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-11598-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88E5D69D9E8

Replace the LCLA ESRAM regulator with runtime PM.

Use the SRAM device that owns the ESRAM34 power domain.

Hold that domain while DMA transfers are active.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/dma/ste_dma40.c | 97 ++++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 9b803c0aec25..6ca67ec446dc 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -21,8 +21,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_dma.h>
+#include <linux/of_platform.h>
 #include <linux/amba/bus.h>
-#include <linux/regulator/consumer.h>
 
 #include "dmaengine.h"
 #include "ste_dma40.h"
@@ -571,7 +571,8 @@ struct d40_gen_dmac {
  * to phy_chans entries.
  * @plat_data: Pointer to provided platform_data which is the driver
  * configuration.
- * @lcpa_regulator: Pointer to hold the regulator for the esram bank for lcla.
+ * @lcla_dev: SRAM device for the ESRAM bank used by LCLA.
+ * @lcla_pm_enabled: Whether runtime PM was enabled for LCLA by this driver.
  * @phy_res: Vector containing all physical channels.
  * @lcla_pool: lcla pool settings and data.
  * @lcpa_base: The virtual mapped address of LCPA.
@@ -607,7 +608,8 @@ struct d40_base {
 	struct d40_chan			**lookup_log_chans;
 	struct d40_chan			**lookup_phy_chans;
 	struct stedma40_platform_data	 *plat_data;
-	struct regulator		 *lcpa_regulator;
+	struct device			 *lcla_dev;
+	bool				  lcla_pm_enabled;
 	/* Physical half channels */
 	struct d40_phy_res		 *phy_res;
 	struct d40_lcla_pool		  lcla_pool;
@@ -628,6 +630,22 @@ static struct device *chan2dev(struct d40_chan *d40c)
 	return &d40c->chan.dev->device;
 }
 
+static void d40_transfer_runtime_get(struct d40_base *base)
+{
+	if (base->lcla_dev)
+		pm_runtime_get_sync(base->lcla_dev);
+
+	pm_runtime_get_sync(base->dev);
+}
+
+static void d40_transfer_runtime_put(struct d40_base *base)
+{
+	pm_runtime_put_autosuspend(base->dev);
+
+	if (base->lcla_dev)
+		pm_runtime_put_sync_suspend(base->lcla_dev);
+}
+
 static bool chan_is_physical(struct d40_chan *chan)
 {
 	return chan->log_num == D40_PHY_CHAN;
@@ -1516,7 +1534,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
 	if (d40d != NULL) {
 		if (!d40c->busy) {
 			d40c->busy = true;
-			pm_runtime_get_sync(d40c->base->dev);
+			d40_transfer_runtime_get(d40c->base);
 		}
 
 		/* Remove from queue */
@@ -1579,7 +1597,7 @@ static void dma_tc_handle(struct d40_chan *d40c)
 		if (d40_queue_start(d40c) == NULL) {
 			d40c->busy = false;
 
-			pm_runtime_put_autosuspend(d40c->base->dev);
+			d40_transfer_runtime_put(d40c->base);
 		}
 
 		d40_desc_remove(d40d);
@@ -2052,7 +2070,7 @@ static int d40_free_dma(struct d40_chan *d40c)
 		d40c->base->lookup_phy_chans[phy->num] = NULL;
 
 	if (d40c->busy)
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		d40_transfer_runtime_put(d40c->base);
 
 	d40c->busy = false;
 	d40c->phy_chan = NULL;
@@ -2613,7 +2631,7 @@ static int d40_terminate_all(struct dma_chan *chan)
 	d40_term_all(d40c);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	if (d40c->busy)
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		d40_transfer_runtime_put(d40c->base);
 	d40c->busy = false;
 
 	spin_unlock_irqrestore(&d40c->lock, flags);
@@ -2916,29 +2934,11 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 #ifdef CONFIG_PM_SLEEP
 static int dma40_suspend(struct device *dev)
 {
-	struct d40_base *base = dev_get_drvdata(dev);
-	int ret;
-
-	ret = pm_runtime_force_suspend(dev);
-	if (ret)
-		return ret;
-
-	if (base->lcpa_regulator)
-		ret = regulator_disable(base->lcpa_regulator);
-	return ret;
+	return pm_runtime_force_suspend(dev);
 }
 
 static int dma40_resume(struct device *dev)
 {
-	struct d40_base *base = dev_get_drvdata(dev);
-	int ret = 0;
-
-	if (base->lcpa_regulator) {
-		ret = regulator_enable(base->lcpa_regulator);
-		if (ret)
-			return ret;
-	}
-
 	return pm_runtime_force_resume(dev);
 }
 #endif
@@ -3492,7 +3492,10 @@ static int __init d40_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_lcpa;
+	struct device_node *np_lcla;
+	struct device_node *np_lcla_parent;
 	struct d40_base *base;
+	struct platform_device *lcla_pdev;
 	struct resource *res;
 	struct resource res_lcpa;
 	int num_reserved_chans;
@@ -3590,23 +3593,32 @@ static int __init d40_probe(struct platform_device *pdev)
 	}
 
 	if (base->plat_data->use_esram_lcla) {
+		np_lcla = of_parse_phandle(np, "sram", 1);
+		if (!np_lcla) {
+			dev_err(dev, "no LCLA SRAM node\n");
+			ret = -EINVAL;
+			goto destroy_cache;
+		}
 
-		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
-		if (IS_ERR(base->lcpa_regulator)) {
-			d40_err(dev, "Failed to get lcpa_regulator\n");
-			ret = PTR_ERR(base->lcpa_regulator);
-			base->lcpa_regulator = NULL;
+		np_lcla_parent = of_get_parent(np_lcla);
+		of_node_put(np_lcla);
+		if (!np_lcla_parent) {
+			dev_err(dev, "no LCLA SRAM parent node\n");
+			ret = -EINVAL;
 			goto destroy_cache;
 		}
 
-		ret = regulator_enable(base->lcpa_regulator);
-		if (ret) {
-			d40_err(dev,
-				"Failed to enable lcpa_regulator\n");
-			regulator_put(base->lcpa_regulator);
-			base->lcpa_regulator = NULL;
+		lcla_pdev = of_find_device_by_node(np_lcla_parent);
+		of_node_put(np_lcla_parent);
+		if (!lcla_pdev) {
+			ret = -EPROBE_DEFER;
 			goto destroy_cache;
 		}
+		base->lcla_dev = &lcla_pdev->dev;
+		if (!pm_runtime_enabled(base->lcla_dev)) {
+			pm_runtime_enable(base->lcla_dev);
+			base->lcla_pm_enabled = true;
+		}
 	}
 
 	writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
@@ -3642,16 +3654,17 @@ static int __init d40_probe(struct platform_device *pdev)
 				 SZ_1K * base->num_phy_chans,
 				 DMA_TO_DEVICE);
 
-	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
+	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base &&
+	    base->lcla_pool.pages)
 		free_pages((unsigned long)base->lcla_pool.base,
 			   base->lcla_pool.pages);
 
 	kfree(base->lcla_pool.base_unaligned);
 
-	if (base->lcpa_regulator) {
-		regulator_disable(base->lcpa_regulator);
-		regulator_put(base->lcpa_regulator);
-	}
+	if (base->lcla_pm_enabled)
+		pm_runtime_disable(base->lcla_dev);
+	if (base->lcla_dev)
+		put_device(base->lcla_dev);
 	pm_runtime_disable(base->dev);
 
  report_failure:

-- 
2.54.0


