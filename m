Return-Path: <dmaengine+bounces-10258-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uExzLZ9r/Gn0PgAAu9opvQ
	(envelope-from <dmaengine+bounces-10258-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 12:38:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 111144E6E04
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AE5F301F496
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 10:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63873EB7FA;
	Thu,  7 May 2026 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="tpxzY/hs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B03845BE;
	Thu,  7 May 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150244; cv=none; b=rVhfxugZzRPeD8I/Lr/4igApEnhTkEvu4fXKriH00mjzXRhi0r7ZPJ5BBKWZhFhaKnooxRU/cZM4ZHuddxr2KL12xrRD74DhefpE1Yt8YW42FDd7Vm4PkXCVjLOU03hge01a5osSTQ0PqBO0PfJg5xO3Q3C4QkRTHZ/LZ5nUzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150244; c=relaxed/simple;
	bh=YVYOiD0eP6yd+UvcXTn6Thio/bo8CvlHL5PvAFWxilc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+VE3/wGWKL8S/x5MAUILwc7B2HGyWAPli8S1nRrC8eRz1iqyyb5zdwFIWWMfw7a/iVFwEQOdt9SoOfo0sd4hGhgCj6nX7jFzBL2PkCoi8ZjR+3i5Pd6/vKnalRFbhAXgEZtzOq5GYNlY3HUeN3ricfvh1Hsf9cIMoqD7n7FilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=tpxzY/hs; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1778150198;
	bh=sHkoX8vNBLMUFbRQgVPu3YGpMESM1FxDTF4U+0Fo1n4=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=tpxzY/hstQ//1xdqH23gVu6cvhH4Vd02UdcR5E8mF5T+Wiw3vSFG2djPMvncm0xWf
	 JR5dGcd7VSQL2rfU+NVlN8Hj8BSw3XxtP1bwPxI6qw2biFlEYPVsNtB4Wem6bLEKGI
	 9py2IzlCFNIL43vOiei4A42i/IVhf5RfQ3oEFH04=
X-QQ-mid: zesmtpgz1t1778150196t9dc38bac
X-QQ-Originating-IP: HyHuDtH23EJGYtUrGvw3Xt0V1ggtU5dZGJuwPL6eRKE=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 18:36:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13784152864614203457
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 07 May 2026 18:36:21 +0800
Subject: [PATCH v5 2/4] dmaengine: mmp_pdma: support variable extended
 DRCMR base
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-k3-pdma-v5-2-6b9743038026@linux.spacemit.com>
References: <20260507-k3-pdma-v5-0-6b9743038026@linux.spacemit.com>
In-Reply-To: <20260507-k3-pdma-v5-0-6b9743038026@linux.spacemit.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Guodong Xu <guodong@riscstar.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778150183; l=3360;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=APvYenLY65RU5Mp1C8YoX68L26txn3bZfRsaRT1Gx7A=;
 b=9n26b2ESPk58g7S8iOWXlY3QbvbgZjTWcp0Blh/Y+1oAhvh5lGVkfOYkPwqnihRNpD31kPN9u
 2d5H3avJpEjAtMeT29Jy7M+8HxD5ygVtXpSTCyMBxBglSk1uoI94/fR
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NepF8YL2AyLP3FutXeEQXT290QUOWynMV6HjWQ+GnMr9snSrlrfgF0Xu
	6nNMNVdUia+X2VvNawOyB4awRgs7mV2Jo91IeeFdJcZLIhh9jTj5JVfaAQrkcwCR5VT2Kql
	npAfZaCVqfMkVoR7hfGwPcXmsIDPXEg6KkD8V6mEPsiERpB+P3XfBqaY93iWXbd672GDbaL
	GcmnqYBX4oYf7ltIUQq9i2891e1G+xWcJ0k4eJABbvzHLI5nq2WcU1mvLo7G0ujTqm39P7G
	4nGM82XT4X6nBbg2GJqcqNIUmyz1XR0PTkMnNdpiXg2fVoK1M/NKxeUNDYuySGqaC+aqV1c
	PrcDE44JFyQfWgglHvSPK29b3C1aORGfqQ2HvyCwuz3955KUEs6vbmKRN4eM4jJIEYcfWWi
	bKIjqtBIg2Ixi67bOxfCsOQoUBLBYHFEy3aNiWB7/ByFEc4ZCv9h6Qk3nnm6RK65QmoFdjY
	co4lsE4nlDhGMSj+YKqH3mZsvTpZSBfV/zFqsX+bZf2K2SCghwqtag82ESjXt9/kFl17h6f
	5aP6ftau6omFjJfE+uka+NiaMIBPx3K+j2gO/+T1dlwodgugT41WXbr2LJrqvCliG6m3o83
	0XyPis8l9Rauzkaqs/oC6ftLUgL4XglLKG0bBDQpLXa/xPV8+NEqi+e9NMI771F2ArqKmNp
	bD6nfTjdfKILZa8GfVMgy2hngyFkJuYQPyrPnv2H8ikegMZKVoeemXVHLe4M42x08cakrcY
	KtqbKzJU6yWu+e+V4DHMfXVDnINjGd6MOjfWz03Nm7iCtcQf7UCHEqyzl4bOLRjHD770j4+
	qx/DeKmuN1fdqvoF3Z0XK26gNUfZWdY1ele5dHyor4I9m7C75rEcmQxbLKY6H/8zP/fnzU/
	6QodaXKu0q1A+5vliCUCpQMsFcw+rHr1FtuEH5/PX90cNGdf4YtC8Txh0BclkSd5iX6TAs2
	5flA9p3X3q2TpoOgPr10ycMYzqKVrpmWy5MGebxOe8OSDKM1MBS9TpFsODxeE8WVGWnOEg7
	tetVCwMakFYNObZQwvUCroxxKhS0M2gPxfMYxM2+l8wrLxhVahRwDjQoYcuUaEHT0Vf2lK1
	bgNVvRl9Ei3bY9p0caywGON+MhX3/GmI2qb0O/qmkeA/Vdj7Sz46BI8vHfdtm4kogQT7kLb
	beezRGmkvkXoqAE=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 111144E6E04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10258-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[troy.mitchell@linux.spacemit.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.spacemit.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,spacemit.com:email,riscstar.com:email,linux.spacemit.com:mid,linux.spacemit.com:dkim]
X-Rspamd-Action: no action

From: Guodong Xu <guodong@riscstar.com>

DRCMR base address for extended DMA request numbers (which means bigger
or equal to 64) varies in different PMDA hardware implementation.

One such different PDMA implementation is found in SpacemiT's K3. In
this patch is for preparation the adding of K3 PDMA support.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/dma/mmp_pdma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index d12e729ee12c..6112369006ee 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -51,7 +51,9 @@
 #define DCSR_CMPST	BIT(10)	/* The Descriptor Compare Status */
 #define DCSR_EORINTR	BIT(9)	/* The end of Receive */
 
-#define DRCMR(n)	((((n) < 64) ? 0x0100 : 0x1100) + (((n) & 0x3f) << 2))
+#define DRCMR_BASE		0x0100
+#define DRCMR_EXT_BASE_DEFAULT	0x1100
+#define DRCMR_REQ_LIMIT		64
 #define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
 #define DRCMR_CHLNUM	0x1f	/* mask for Channel Number (read / write) */
 
@@ -154,6 +156,7 @@ struct mmp_pdma_phy {
  * @run_bits:   Control bits in DCSR register for channel start/stop
  * @dma_width:  DMA addressing width in bits (32 or 64). Determines the
  *              DMA mask capability of the controller hardware.
+ * @drcmr_ext_base: Base DRCMR address for extended requests
  */
 struct mmp_pdma_ops {
 	/* Hardware Register Operations */
@@ -174,6 +177,7 @@ struct mmp_pdma_ops {
 	/* Controller Configuration */
 	u32 run_bits;
 	u32 dma_width;
+	u32 drcmr_ext_base;
 };
 
 struct mmp_pdma_device {
@@ -195,6 +199,13 @@ struct mmp_pdma_device {
 #define to_mmp_pdma_dev(dmadev)					\
 	container_of(dmadev, struct mmp_pdma_device, device)
 
+static u32 mmp_pdma_get_drcmr(struct mmp_pdma_device *pdev, u32 drcmr)
+{
+	if (drcmr < DRCMR_REQ_LIMIT)
+		return DRCMR_BASE + (drcmr << 2);
+	return pdev->ops->drcmr_ext_base + ((drcmr - DRCMR_REQ_LIMIT) << 2);
+}
+
 /* For 32-bit PDMA */
 static void write_next_addr_32(struct mmp_pdma_phy *phy, dma_addr_t addr)
 {
@@ -301,7 +312,7 @@ static void enable_chan(struct mmp_pdma_phy *phy)
 
 	pdev = to_mmp_pdma_dev(phy->vchan->chan.device);
 
-	reg = DRCMR(phy->vchan->drcmr);
+	reg = mmp_pdma_get_drcmr(pdev, phy->vchan->drcmr);
 	writel(DRCMR_MAPVLD | phy->idx, phy->base + reg);
 
 	dalgn = readl(phy->base + DALGN);
@@ -437,7 +448,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 		return;
 
 	/* clear the channel mapping in DRCMR */
-	reg = DRCMR(pchan->drcmr);
+	reg = mmp_pdma_get_drcmr(pdev, pchan->drcmr);
 	writel(0, pchan->phy->base + reg);
 
 	spin_lock_irqsave(&pdev->phy_lock, flags);
@@ -1179,6 +1190,7 @@ static const struct mmp_pdma_ops marvell_pdma_v1_ops = {
 	.get_desc_dst_addr = get_desc_dst_addr_32,
 	.run_bits = (DCSR_RUN),
 	.dma_width = 32,
+	.drcmr_ext_base = DRCMR_EXT_BASE_DEFAULT,
 };
 
 static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
@@ -1192,6 +1204,7 @@ static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
 	.get_desc_dst_addr = get_desc_dst_addr_64,
 	.run_bits = (DCSR_RUN | DCSR_LPAEEN),
 	.dma_width = 64,
+	.drcmr_ext_base = DRCMR_EXT_BASE_DEFAULT,
 };
 
 static const struct of_device_id mmp_pdma_dt_ids[] = {

-- 
2.54.0


