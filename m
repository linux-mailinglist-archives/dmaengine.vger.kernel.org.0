Return-Path: <dmaengine+bounces-6830-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E678BD77D0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 07:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F64E63D3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 05:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4601990D9;
	Tue, 14 Oct 2025 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="C8xbCx7N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx-relay47-hz3.antispameurope.com (mx-relay47-hz3.antispameurope.com [94.100.134.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC652F88
	for <dmaengine@vger.kernel.org>; Tue, 14 Oct 2025 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.236
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421068; cv=pass; b=g3T7dp1uo4RKZ1sPYBno9hG/sqmctgwnhL1Gf0P2Y8aa1SioAU6Fu+Mb5UpsONFo19+uPyBOySoQ5MlRdihNaCtXvcMlc+QRFkQDzP7OK1sg9mJ35GlC6b37gKU0FbTr4UezvOkfk7LAehWR7n96+ja1xa8eYw9SoUN5Lrr4vuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421068; c=relaxed/simple;
	bh=ZKBXzuLgHnPv9Mp/a52fJXSw1h9XVCMhyxdDTH7YLLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G67WjOP0bPjVrKd42LkwmOpGT6YMVyHmKmfx2e6HTGR8nIXsNBdt10vKCv3gkda8+RfSZNv7Wde/khgWR21J3zjHZeJWTeFSaxt6NL79XfVC7CLfiy4r9xKOQAsFWPj4AbEi21sOzZLAGNCJkV8V8v8cRHe04iAsvWAsqua3oBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=C8xbCx7N; arc=pass smtp.client-ip=94.100.134.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate47-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=H/kOwDFzfm3IalvPOezvdeJs36K8vMFT5gBD1NEeb8I=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760421046;
 b=VVEyd/AKzXjXSig+OnPLougu01MRaclT/lxOHnI2B9rTeSbiZ7Q+NEYFCSHmlRt4x+Z3rg5+
 QKVDYBq8VwQKMep/zRWzlR/R4LwBPZlsb4Z/+wQ0GqatVGmamP7zVb28w7HFABbLNmYxV4RVyNS
 qHKrjcN4zcvdx6Eler4wTSiUPBBw+ZduFkwkh7yHXhsfZynb828LH5yOHhBahi2fPbTs6Fl/SeF
 zOjVVjJ6kEqBhzQ8dGEJaeVU6gxFpd75eZ4RwbUi4VqjLdG3Qv4+fCLqtTE4escAdnQrxURZu6U
 wMJSVIkyGuL/AWL0Vwxa718i1ZUhw8hws48mbx+/CMaDw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760421046;
 b=Wbv4OEv+9knBMZ/upf4MXeAO3LRPmGQifSJc8SaPXDtkQ2Y/RK7n3bi3lRraJxzzrUdOjNIx
 sQOBca+bF2PvPy5LtqrYdfNVeTY33RkEs2eTqSfKNn6u7iwbVyQYWYlHhET/96yYvb3uoNyB0kj
 il3Fx7jeEcB5I4+zpgK90MnKWaX7zuKxoGCaIt0H7Fru7QzB5W6bhn0rpSZrwLchq/p8g7K7OB1
 l4EWOLqNSuuqy/gk5l4rqseWspd3VLeubsb6tS+07/8CAoK6mnAZcfcE1V4kKrj4I0AXuwoi1mM
 FS7mqUq/8il3+Li3CYQlLyNpwk4yrIZ6+EJGG4F65kXVA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay47-hz3.antispameurope.com;
 Tue, 14 Oct 2025 07:50:46 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 0231ECC0DE1;
	Tue, 14 Oct 2025 07:50:35 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: xilinx: xdma: Add regmap register ranges
Date: Tue, 14 Oct 2025 07:50:33 +0200
Message-ID: <20251014055034.274596-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:dmaengine@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay47-hz3.antispameurope.com with 4cm3Gh401Pz4MZvT
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:68dca67b7eb0fd836cb29e646ce2f625
X-cloud-security:scantime:2.704
DKIM-Signature: a=rsa-sha256;
 bh=H/kOwDFzfm3IalvPOezvdeJs36K8vMFT5gBD1NEeb8I=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760421045; v=1;
 b=C8xbCx7NUIPVWas8rIIRANsHWD4ObeQWirLDOUxKQI/Qr3tmxIavxjyLTGVYevbdg8jtG+lF
 wWA7c8wZMp2uTSXBsbK5VWczdEJLo4b6tuCvt31BeaFeMaI3d+QXCLtTRkOmqaooogDxksRknhF
 8CHQSObNnd5mybzeWZhdXN6s27v/Fb2fAa0XoTp2NT/yvfxFiQ5qpNbcsipZTiqfOXJx2TY1Ai+
 JzNflhAWAblnbyHWEYoPyDAv6cJo8YbIb8i340qYZO5joiAdCRfEr30K2+yvdu+QLSdWyGNz8Zt
 MbqCwIjTUtoM6YtZk/CHGHbvH2E3JQh90Bch2PwLVoKcg==

The XDMA bar is 64KiB, way too much for debugfs dump. Add register range
definitions for all defined registers in PG195. As this is PCIe memory
range all readable registers are marked as volatile.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Although the change itself is independent, this patch context depends on
[1].

[1] https://lore.kernel.org/all/20251013-xdma-max-reg-v5-1-83efeedce19d@amarulasolutions.com/

 drivers/dma/xilinx/xdma.c | 89 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 5ecf8223c112e..3d9e92bbc9bb0 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -33,12 +33,101 @@
 #include "../virt-dma.h"
 #include "xdma-regs.h"
 
+static const struct regmap_range xdma_wr_ranges[] = {
+	/* H2C channel registers */
+	regmap_reg_range(0x0004, 0x000c),
+	regmap_reg_range(0x0040, 0x0040),
+	regmap_reg_range(0x0088, 0x0098),
+	regmap_reg_range(0x00c0, 0x00c0),
+	/* C2H channel registers */
+	regmap_reg_range(0x1004, 0x100c),
+	regmap_reg_range(0x1040, 0x1040),
+	regmap_reg_range(0x1088, 0x1098),
+	regmap_reg_range(0x10c0, 0x10c0),
+	/* IRQ Block registers */
+	regmap_reg_range(0x2004, 0x2018),
+	regmap_reg_range(0x2080, 0x208c),
+	regmap_reg_range(0x20a0, 0x20a4),
+	/* Config Block registers */
+	regmap_reg_range(0x301c, 0x301c),
+	regmap_reg_range(0x3040, 0x3044),
+	regmap_reg_range(0x3060, 0x3060),
+	/* H2C SGDMA registers */
+	regmap_reg_range(0x4080, 0x408c),
+	/* C2H SGDMA registers */
+	regmap_reg_range(0x5080, 0x508c),
+	/* SGDMA Common registers */
+	regmap_reg_range(0x6010, 0x6018),
+	regmap_reg_range(0x6020, 0x6028),
+	/* MSI-X Vector Table and PBA */
+	regmap_reg_range(0x8000, 0x81fc),
+	regmap_reg_range(0x8fe0, 0x8fe0),
+};
+static const struct regmap_range xdma_rd_ranges[] = {
+	/* H2C channel registers */
+	regmap_reg_range(0x0000, 0x0004),
+	regmap_reg_range(0x0040, 0x004c),
+	regmap_reg_range(0x0088, 0x0090),
+	regmap_reg_range(0x00c0, 0x00d0),
+	/* C2H channel registers */
+	regmap_reg_range(0x1000, 0x1004),
+	regmap_reg_range(0x1040, 0x104c),
+	regmap_reg_range(0x1088, 0x1090),
+	regmap_reg_range(0x10c0, 0x10d0),
+	/* IRQ Block registers */
+	regmap_reg_range(0x2000, 0x2004),
+	regmap_reg_range(0x2010, 0x2010),
+	regmap_reg_range(0x2040, 0x204c),
+	regmap_reg_range(0x2080, 0x208c),
+	regmap_reg_range(0x20a0, 0x20a4),
+	/* Config Block registers */
+	regmap_reg_range(0x3000, 0x301c),
+	regmap_reg_range(0x3040, 0x3044),
+	regmap_reg_range(0x3060, 0x3060),
+	/* H2C SGDMA registers */
+	regmap_reg_range(0x4000, 0x4000),
+	regmap_reg_range(0x4080, 0x408c),
+	/* C2H SGDMA registers */
+	regmap_reg_range(0x5000, 0x5000),
+	regmap_reg_range(0x5080, 0x508c),
+	/* SGDMA Common registers */
+	regmap_reg_range(0x6000, 0x6000),
+	regmap_reg_range(0x6010, 0x6010),
+	regmap_reg_range(0x6020, 0x6020),
+	/* MSI-X Vector Table and PBA */
+	regmap_reg_range(0x8000, 0x81fc),
+	regmap_reg_range(0x8fe0, 0x8fe0),
+};
+static const struct regmap_range xdma_precious_ranges[] = {
+	/* H2C channel registers */
+	regmap_reg_range(0x0044, 0x0044),
+	/* C2H channel registers */
+	regmap_reg_range(0x1044, 0x1044),
+};
+static const struct regmap_access_table xdma_wr_table = {
+	.yes_ranges = xdma_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(xdma_wr_ranges),
+};
+static const struct regmap_access_table xdma_rd_table = {
+	.yes_ranges = xdma_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(xdma_rd_ranges),
+};
+static const struct regmap_access_table xdma_precious_table = {
+	.yes_ranges = xdma_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(xdma_precious_ranges),
+};
+
 /* mmio regmap config for all XDMA registers */
 static const struct regmap_config xdma_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = XDMA_MAX_REG_OFFSET,
+	.wr_table = &xdma_wr_table,
+	.rd_table = &xdma_rd_table,
+	.volatile_table = &xdma_rd_table,
+	.precious_table = &xdma_precious_table,
+	.cache_type = REGCACHE_NONE,
 };
 
 /**
-- 
2.43.0


