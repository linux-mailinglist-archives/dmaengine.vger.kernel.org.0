Return-Path: <dmaengine+bounces-9656-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIc/KJvtxGnj5AQAu9opvQ
	(envelope-from <dmaengine+bounces-9656-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:26:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6B3314AC
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 337BB30692E1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53C3B7771;
	Thu, 26 Mar 2026 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="YDB271VF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A663B7779;
	Thu, 26 Mar 2026 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513147; cv=none; b=WT/1+Vlk8Ls9Gdu9D6ViHyy8YvZZl18oQqad4gkGYe8RqJAoZZ3oDAKh2yYjfdLR5ZO42DkAtOFR3vuX1IC/jdN+6N7Tqxd7pu6RZFba1nA5LimCvXrucYBqW0ogHmLKD4r+yn9wOGQP5gAXCIgGU/fpPv1An/unoAnXeS37TBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513147; c=relaxed/simple;
	bh=6+4qGpZANBGTkdbhxDWorKlyYo1yGbDiYzCTa+3RB28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLibSbKJccn2sxd1lkDoUiEHwTOTpQV/Z+U8KysBpUKslgAkNd3S9kVnSEu5X/qVx0TzinKxCX2METqlbnQXGU334r+EUrPWbT+77B8HqK0EsVDWyp/duJdthCayHRPhmKZlWuhxaL2CwduxCPJHS6SidW4ohgqxaUg9xHJTtLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=YDB271VF; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774513097;
	bh=m5PWPnBQvLfR0iomd90tSIxBbWmrGFtCtbcayo247ws=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=YDB271VFeX81Bz/guWUMIjGgKNCklfADV+xMOYY+lTRr+Nuvcs6/IsHCP1e/kdQCs
	 wMY+By8mV6lI/F/VaaNbWEBZhmVKG5JwnVVm4hm5yGT8fbqoi5dpWOxex0ZWSpPeOo
	 NIJpMyafOEEekmdICLC2/cJ5ihH8hsRfKpMmoqsY=
X-QQ-mid: zesmtpgz4t1774513095tf4b95636
X-QQ-Originating-IP: MLG/4cQa9fTlETy0q6JlXGxJJ0NXRsbM+d638VJCojM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 16:18:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1769004808767929823
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 26 Mar 2026 16:17:19 +0800
Subject: [PATCH v2 4/7] dmaengine: mmp_pdma: support variable extended
 DRCMR base
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-k3-pdma-v2-4-ca94ca7bb595@linux.spacemit.com>
References: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
In-Reply-To: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Guodong Xu <guodong@riscstar.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774513072; l=3360;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=bkVzrnGk9bZIYctd0IsZBkT4x/MeOiAKSLtr4On4XHk=;
 b=0d03RiQJeIucgARexiViZldHvy/GmpOndf05AIzD7aPAhcd8XveNAh6ZZDGm5evT+V5fUb0SS
 sVACPel7RJzA35wNTL39qSsCKBA389y+pCmkNiegesnbqceik6YrBJO
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M8hK3+dbYzF1mmeBWQlfDKKsYzeliPpE48yCw4MDZbMX1vqhmK0u34Vr
	UXLe1gJ3QDA0oI10tNsBYQvpJUyWvJ5SV+JRU8ArTT1JgscoX7+1PE4OFqiDl1bdtCQJrpK
	mhL1/QzU8h/HAVuT1s4x2NS7blgrBxirDTaVWSAILKykSp/Rx/LeYjdBAMgHf72RNMoSs/o
	uUmEPiOEiFFggB+ZijfMVNKMVi1Y9hR6cOHSPbRK3bhLSVCeNfxtLGe88hqPSPdbm0CiKhY
	MGYoKn0Nnsp55RdlP61xWGp/rYsXNiPSnImdplzmDtH0su7Fivl+bDgXi4yxapvuSrN3mbS
	RJPMMvCG2b0bJ1DLxSm3AVd4E0S3g2xK6/cD+ak1j3TmyIdcEhXzlf6pXHbMzXsEV+6mFB5
	tFlxHRb2c6oon8woLXyFMA30FKqaz3fkuNsYeUtN3SOWC7qsILCVuOG75q1yAf0w79uYTDq
	wKkgwOBwhkGizeiTsGx7raMr/CWQ5P0gSRl52+jKdWgO+FacqGMdUFZDp/+TyvF9WzUu4ck
	93YVeVa1pZ07X9uhmCqjRVjlvQigRISPB4gD2c34fEYhtMJ5F9HcXWBX/OSOez0I3PuT73H
	kjYP76H9goqZ6W1gI5NOrxiigJwzV1N/LOv68jVmVfO0JIkAC2YWXarJjj4TQAiBGtDPxQM
	AifNl55UeuEUaWWOI1FEq22Dse9l+bbyGK3NSvD+TGlkbcNV3ZBLc2qZnD3f9hkkX73EKDM
	7yHekhf0EXaQDqxVNfDlKsZUZ2VeIMd7rgt79pdViSuNAXdGcHT1y9HwHIBSIINDCt+KG8n
	Z+cDYC5s2ndCoriirvXRNSJO5SctQ1pAJDDYGkfLBW8sq8CQhszNC18+qQwFo2raXdj6Sy5
	2BPbyEaGs50UPgKS2HEMhqA3NASxgzmycGNIERhKHymNuzLVu8Jlpf/5KYubTDykbpzjGVN
	EO7fPSeiVF4v6HYep+LqX8mfzbN684BDGhbq4xMPbTTNtGGER9zh9/AP1gYjbPLyRxXFEtD
	6MmY1kg9Q7UUlPFc5XYWPmd/59qXp0ODExyO6BJSW42YlWWiys1RJtDgPqEUDy8RfjSH1j/
	zA4oTu+b2Z1sx6XLe+sElSyesgT1V6c8gjaRBSIiX7PU6zs66e9YNZmarVD6X1o0A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9656-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.spacemit.com:dkim,linux.spacemit.com:mid,riscstar.com:email,spacemit.com:email]
X-Rspamd-Queue-Id: 14C6B3314AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.53.0


