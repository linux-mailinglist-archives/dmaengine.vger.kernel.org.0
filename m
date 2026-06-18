Return-Path: <dmaengine+bounces-11593-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uFGoFp97M2p1CgYAu9opvQ
	(envelope-from <dmaengine+bounces-11593-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A1469D989
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CxvNkNgc;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11593-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11593-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7679530734B3
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE137C0E1;
	Thu, 18 Jun 2026 05:01:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C133F8B1;
	Thu, 18 Jun 2026 05:01:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758867; cv=none; b=DQbUfxJzwrKPqbf00cehkmJ2Ajk7BJMGPnV9xV6h6e2XK1Ca/LlKOw4tg77m6IPW1sI05jLlUNJw3i9gEooKlFQGvg2bSXtNpVs7WH7n64ca2GMmvWcV0UjSDaMz/yCJg2rfVDjqe1fr314hxmkYiVXnGxxYmiWfByfGVPT3oBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758867; c=relaxed/simple;
	bh=TVzCqf/3Nv2cJCCPzsfw7xXCDTadz7VqrgUe5knPeX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkGuhlLGoCZhHimyQGfR1LoUBbWlTCjJlJ5/RZtDQNiVPTAgOUn2oWbLTHb46IX1vF8/WsjetxD1mWv4pubHCLMErpRCeyYncgHntIbyRiakfAis44iNLtDQFSDl5vu/A5tCp1lwM0AK9/gDofX4TuNfTWkXS9WAStfMCQXQelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxvNkNgc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6996F1F00A3A;
	Thu, 18 Jun 2026 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758866;
	bh=lFNx2M5MfC3U2WIlbJTGy2D7mD6ZH4cGBeGNYwK2Y0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CxvNkNgcucGMUG3aYF0RgobZ664zkLYygWHyoD4wkYRQpRHkjHxK7e2fw4To3H8zT
	 /qB47JcWxhOCTiaZYxoZ+yHPWBHDVr65rzJ1A+48UsEmB5d2iUtHbjb1lYYSIivRU6
	 JwFWi5dFN5/F1DNiDb1V5mtxtSATPWqXNy4FOiIUuG276Cq2MFP1qJyDEkS9DHJgry
	 hx6MWM6m9eD95TsXh+Up7JZoqwSIC2vilWJCv0UtZmHVW7fLW231mc5EQIa5NEyDDh
	 wPlE1kCTiOjqQxUtR6chmvpVbdHAP2UTz3o+rUaf6HXQJVuOrwpuUWswgcKZkZdhni
	 ACJ1SUJSDyi6A==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:49 +0200
Subject: [PATCH 03/11] pmdomain: st: ux500: Implement more power domains
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-3-eb5e50b1a588@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Linus Walleij <linusw@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11593-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03A1469D989

This starts to implement the power domains that are just skeleton
implementations right now.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pmdomain/st/ste-ux500-pm-domain.c | 125 +++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain/st/ste-ux500-pm-domain.c
index 6896cb4a7b71..723001004690 100644
--- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
+++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
@@ -41,14 +41,137 @@ static int pd_power_on(struct generic_pm_domain *domain)
 	return 0;
 }
 
+/*
+ * Apart from these voltage domains there is also VSAFE which is always
+ * on. Vape_esram0_pwr for eSRAM0 is connected to VSAFE.
+ */
 static struct generic_pm_domain ux500_pm_domain_vape = {
-	.name = "VAPE",
+	/* Vape_pwr */
+	.name = "VAPE",  /* 0.95 .. 1.20 V */
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_varm = {
+	.name = "VARM",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vmodem = {
+	.name = "VMODEM",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vpll = {
+	.name = "VPLL", /* 1.8 V */
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+/*
+ * CHECKME: as these are used directly by peripherals as regulators,
+ * perhaps they should stay in the regulator subsystem?
+ */
+static struct generic_pm_domain ux500_pm_domain_vsmps1 = {
+	.name = "VSMPS1", /* Also called VIO (1.2V) */
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vsmps2 = {
+	.name = "VSMPS2", /* Also called VIO (1.8V) */
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vsmps3 = {
+	.name = "VSMPS3",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_vrf1 = {
+	.name = "VRF1",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+/* The following are technically children of VAPE */
+static struct generic_pm_domain ux500_pm_domain_sva_mmdsp = {
+	/* Vape_SVA_MMDSP_pwr */
+	.name = "SVA_MMDSP",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_sva_pipe = {
+	/* Vape_SVA_pwr */
+	.name = "SVA_PIPE",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_sia_mmdsp = {
+	/* Vape_SIA_MMDSP_pwr */
+	.name = "SIA_MMDSP",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_sia_pipe = {
+	/* Vape_SIA_pwr */
+	.name = "SIA_PIPE",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_sga = {
+	/* Vape_SGA_pwr */
+	.name = "SGA",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_b2r2_mcde = {
+	/* Vape_DSS_pwr DSS (display subsystem) */
+	.name = "B2R2_MCDE",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_esram_12 = {
+	/* Vape_esram0_pwr, Vape_esram1_pwr */
+	.name = "ESRAM_12",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain ux500_pm_domain_esram_34 = {
+	/* Vape_esram3_pwr, Vape_esram4_pwr */
+	.name = "ESRAM_34",
 	.power_off = pd_power_off,
 	.power_on = pd_power_on,
 };
 
 static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
 	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
+	[DOMAIN_VARM] = &ux500_pm_domain_varm,
+	[DOMAIN_VMODEM] = &ux500_pm_domain_vmodem,
+	[DOMAIN_VPLL] = &ux500_pm_domain_vpll,
+	[DOMAIN_VSMPS1] = &ux500_pm_domain_vsmps1,
+	[DOMAIN_VSMPS2] = &ux500_pm_domain_vsmps2,
+	[DOMAIN_VSMPS3] = &ux500_pm_domain_vsmps3,
+	[DOMAIN_VRF1] = &ux500_pm_domain_vrf1,
+	[DOMAIN_SVA_MMDSP] = &ux500_pm_domain_sva_mmdsp,
+	[DOMAIN_SVA_PIPE] = &ux500_pm_domain_sva_pipe,
+	[DOMAIN_SIA_MMDSP] = &ux500_pm_domain_sia_mmdsp,
+	[DOMAIN_SIA_PIPE] = &ux500_pm_domain_sia_pipe,
+	[DOMAIN_SGA] = &ux500_pm_domain_sga,
+	[DOMAIN_B2R2_MCDE] = &ux500_pm_domain_b2r2_mcde,
+	[DOMAIN_ESRAM_12] = &ux500_pm_domain_esram_12,
+	[DOMAIN_ESRAM_34] = &ux500_pm_domain_esram_34,
 };
 
 static const struct of_device_id ux500_pm_domain_matches[] = {

-- 
2.54.0


