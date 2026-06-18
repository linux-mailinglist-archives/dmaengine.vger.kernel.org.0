Return-Path: <dmaengine+bounces-11590-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ez4bL497M2pmCgYAu9opvQ
	(envelope-from <dmaengine+bounces-11590-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E7E69D94E
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:01:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VklzBwsc;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11590-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11590-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64963300B537
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907AE29B8CF;
	Thu, 18 Jun 2026 05:00:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3791A8F7B;
	Thu, 18 Jun 2026 05:00:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758854; cv=none; b=V0XhEL0/SnIdImUqs8t4sGhcYJOMcqKLF4lzYDypw2VXoZWWbm+05EO4g67ig6qI3l27tCEBOEZ9sfXlSsPdb2abNqlJHtrPjcS5npw+2v5367uvSWD29y18/ZY2sufiDx768Z8Q+Es3FDzlSyABd1PZ9CUhjVisdV/k5/7rZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758854; c=relaxed/simple;
	bh=kJQzE8Q4Y5nxamJ3QCFApDJnkW7yvfCIB1dtuLl4GoI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ets8r6jllc+7HfvjEKALtoCVBosAalj+M3fvujbCoHYtj6yNtZ4wykTRTUT1By7vqEWzMDBXHSLwqd46iAdIa1LejNGr9MZGUVDmEPyai71rHIzM0ZNsGpE0FV1NoShVRmhR0Xot16JWJl7kqdms2ZO4X8XCvgzLQIFrN1Dtt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VklzBwsc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133171F000E9;
	Thu, 18 Jun 2026 05:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758853;
	bh=vyUxyP5gZaT2qGm7a08VKFmvCfpvDeHxeR+PC1uIn3c=;
	h=From:Subject:Date:To:Cc;
	b=VklzBwsc01IeU3y5Q0U1iZ/UkbtV1eyaMSg+wVFiJfs1m7m4j+q32rwlNmGKAyGJn
	 7XG9QIn+F79kTNk8tURp4j7m2DZnv/BOX6McqRfFCP7ZaRn5ezVHhasMuRYXFvkrW0
	 i9zTKd2Qd1B+h+zKfgnYuNQVmo0+zSBeC2n/It+6lXH4wHpu4kfyXa0gWBo3XcEAO1
	 GBcqq97y7zqUDgfWditNHqzfZkX4iLA92BZHQEjVUmtaBuEAnd5v4pcJNAuFWEc999
	 5pAXNhHfwLRPUQTCNz5BZ/2Yq1qY0RFFe7df+GZvj88bkjTXUOH3leAa/SE7oWJo1N
	 6McfzbHRndf7A==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 00/11] pmdomain: st: ux500: Implement ux500 power domains
Date: Thu, 18 Jun 2026 07:00:46 +0200
Message-Id: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgNpRa1eRRykjZrBVlr8AfHuF
 sdveO+BxFE4QV88EPmUJMFnqLIAu05+YRSXDZp0Q40yeNw1Ee7h4ogubJP4hGeLCivbOepqo43
 VkPM98iz3vx7G9/0APODuGmoAAAA=
X-Change-ID: 20260618-ux500-power-domains-v7-1-3c9d095828c2
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
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11590-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77E7E69D94E

Today the Ux500 SoC specifically DB8500 is using what is called
"EPOD regulators" (EPOD = Electric POwer Domain) to control its power domains.
This was done like this because at the time, power domains did not exist as a
concept in the Linux kernel.

This patch series completes the ambitious work started in
commit cd931dcfda5e ("ARM: ux500: Initial support for PM domains") which added
a dummy domain driver for Ux500 in the following steps:

- Convert the old Ux500 power domain text DT bindings to YAML schema.

- Extend the bindings with all the 16 power domains actually existing
  in the hardware.

- Add these domains to the existing ux500 power domain driver (still as dummy
  domains).

- Add the power domains to the DB8500 SoC DTSI file.

- Move code over from the EPOD regulators to the actual power domain driver.
  Since the two drivers now control the same hardware, make the drivers
  mutually exclusive.

- Modify the MCDE display driver to use the power domain instead of
  the EPOS regulators.

- Modify the DMA40 DMA controller to use the power domain instead of
  the EPOD regulators.

- Delete the old EPOD regulators.

- Implement regulators activating the VANA and VSMPS2 power domains for the
  power domain voltage rails that are routed off-chip as external supplies,
  re-using the existing EPOD regulator bindings.

- Delete the references to the unused EPOD regulators from the device tree,
  keeping the references to VANA and VSMPS2.

This is a bit of brain transplant on the Ux500, and the series is not very
boot-bisectable.

For simplicity, the series can be merged in separate paths and subsystems as
there are no build-time dependencies, as long as the result ends up in kernel
v7.3. Once the concept and patches are ACKed by the power domain folks, I will
send the patches that can be split out individually to each maintainer and
it can all be merged in parallel.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (11):
      dt-bindings: power: Convert Ux500 PM domains to schema
      dt-bindings: Add the actual power domains on U8500
      pmdomain: st: ux500: Implement more power domains
      ARM: dts: ux500: Rename power domains node
      ARM: dts: ux500: Add power domains
      pmdomain: st: ux500: Control DB8500 EPODs
      drm/mcde: Use power domain for display power
      dmaengine: ste_dma40: Use power domain for LCLA SRAM
      regulator: db8500-prcmu: Remove EPOD regulators
      regulator: db8500: Add power domain regulators
      ARM: dts: ux500: Remove DB8500 EPOD regulators

 .../devicetree/bindings/arm/ux500/power_domain.txt |  35 --
 .../power/stericsson,ux500-pm-domains.yaml         |  46 ++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi               | 134 ++----
 arch/arm/mach-ux500/Kconfig                        |   2 +-
 drivers/dma/ste_dma40.c                            |  97 ++--
 drivers/gpu/drm/mcde/mcde_clk_div.c                |   4 +-
 drivers/gpu/drm/mcde/mcde_display.c                |  11 +-
 drivers/gpu/drm/mcde/mcde_drm.h                    |   2 -
 drivers/gpu/drm/mcde/mcde_drv.c                    |  63 +--
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   1 -
 drivers/mfd/db8500-prcmu.c                         | 239 +---------
 drivers/pmdomain/st/ste-ux500-pm-domain.c          | 353 ++++++++++++++-
 drivers/regulator/Kconfig                          |  22 +-
 drivers/regulator/Makefile                         |   3 +-
 drivers/regulator/db8500-prcmu.c                   | 501 ---------------------
 drivers/regulator/db8500-regulator.c               | 221 +++++++++
 drivers/regulator/dbx500-prcmu.c                   | 155 -------
 drivers/regulator/dbx500-prcmu.h                   |  55 ---
 include/dt-bindings/arm/ux500_pm_domains.h         |  17 +-
 include/linux/regulator/db8500-prcmu.h             |  38 --
 21 files changed, 748 insertions(+), 1252 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260618-ux500-power-domains-v7-1-3c9d095828c2

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


