Return-Path: <dmaengine+bounces-10102-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOagItIo62mPJQAAu9opvQ
	(envelope-from <dmaengine+bounces-10102-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:24:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFF45B696
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC0C6303A8CC
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE83290A6;
	Fri, 24 Apr 2026 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="s/41ZW8z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EABF31D757;
	Fri, 24 Apr 2026 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018940; cv=none; b=dWQ0xzawEiAHsmKEtYOiy8xiUKa1MCDk5smh114/wFQzY4fLe8h/DFHhcjoBwwiId5wkzZ6tztl6J1r4AF4co4cxicmTgP36FcGDjfeqm9T7YHC7jEhVFFSihwRnQMKEQvfj6bZZCnjB1bVCrCNytaHqzDjYTnlXC78+B6tFLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018940; c=relaxed/simple;
	bh=6+4qGpZANBGTkdbhxDWorKlyYo1yGbDiYzCTa+3RB28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N//CO4CP7jVwS/ZVcQBr2/vTSVwjoNWk1ELv1ciN+UN2A88L2uyWwIeJ7T9NgPc9eppcQxkkRZ+mARiHa18wR5L4rIOlRXffdxXdd7lE+g431iH9AKDDjuN9GgezWTLAB4iuXXtskSqQdinfix1lN6fFYtz3hwlEG0bj0cP5R9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=s/41ZW8z; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1777018881;
	bh=m5PWPnBQvLfR0iomd90tSIxBbWmrGFtCtbcayo247ws=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=s/41ZW8z5GA1tkr8UZWfAY1o2vchb5yONpepVZLxVb8yMi19ZRP4poYHoSLLGvJ5T
	 +4d4bD4r+Gm5NiPR2aauS1VEIWnRJm0XRFPEvUXZRczypsrKU1mjHOQFU4mpT5vXIp
	 jotItm1JYen9+PlxKrvxkU1ZmRRC2eFZsOkVAWUM=
X-QQ-mid: zesmtpsz7t1777018879t7ea4da7b
X-QQ-Originating-IP: GL9C6ixcKeDY41HiVvwPiGqs1EbzzZbbWPOt+84jJJM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Apr 2026 16:21:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7070314560642653981
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 24 Apr 2026 16:20:30 +0800
Subject: [PATCH v3 2/5] dmaengine: mmp_pdma: support variable extended
 DRCMR base
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-k3-pdma-v3-2-efdf2e414a08@linux.spacemit.com>
References: <20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com>
In-Reply-To: <20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777018865; l=3360;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=bkVzrnGk9bZIYctd0IsZBkT4x/MeOiAKSLtr4On4XHk=;
 b=EI2zGCwbTEfQksmsg1ZbqFgwhWgBjfOHoAOoxGNO9VhvFIyHjc40kFRB7fFifMgwC2r+TSoE8
 /JK6NjwBuoWCewqhiFeSYgtzTKc16UyjcQPLM/275jlE8uLkG3ZDaPl
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MzFuFcyvqEECIAWw/vaGHkmpRkqTUSg+CLVF/XsnUQm9of5t0q4G4z3C
	dtstweKDU7CM/YAkiyR/emrHzG5ZI+ieZFDqKS+6V3PMjf6kUAWLjrV4Ykrtw7DJIscvb5r
	6gouWQklQkgwUIYpLVGFxCGeuACW7kYsJIaM1Z0V/RjK+Wyg/5IYrElTMemcVn0CsVgwpWj
	Td2WPR75fHOz5oW40+MwNuCLouXgaXpfZIJh9ywqd1eL7+j56MkzJ0xHKDY8C51ltVlg8NS
	LIb2hUraJ6J/aopgJ/fe7xENWaZsPdQmf5s2BOwPsexohv5FitiXiHTyOJWD6QI6ZEALgk5
	GJVH0Al34y7spx0aR9pJfZYvQroTCv6LQfssaKGsqVvR2oIMPcCzOR/g6F+7yS2+Cp1CUmU
	kQtD6E4YPNhiMy27j8zPDMhXMPR7KX79r2X8xrZpOAku0q4GdgnEmYS1nmIxTI6BvR3C4x8
	mi8IBVodEPw+SZmcmYOutd3rNlrWuPoqEUiVwEb/2VE1Wv5hvXUOWBt8KXXPnTn3SAoUnoc
	DZsnTtHvuuzPIKRv+KvB9lfo/LouzGpdxjrJMWAouylfULhmyPW38H/RwNDVXovOwZFxG6a
	P57fbZ/QhEofGrL770Wn66Pm3biE6V5h8FtEmqCM3T2yGJyfsrxlybrOKL2g4mK5IhTxGFp
	Jsz74yeYK9kz8Ql6bBGAf4vZ1qu9PplzGa4pE5U7G70hP1MaSFfWYORN0eAT6m1uTmrSbEK
	PqF66lz+sr4ZmVDwTvbDC6jjclVYrKaEwoeelcoPNwk3eQnQcccGOGaEbcWlyys7xorChF+
	EOYHJjKB096fGrOPtAKCOKuKIJefX8LH5K3JlkgQwE8EjyZ6EhE+mkWrXNvbmdqGC0VWgsa
	CzZkQ5hjvYaoGPW9m6CytTy+joUmbDROYetWxwgKuEDgeGICDHuOZ0ewdeXZYHO2raY6yVu
	LIg31HUbyDxoMgBuIp1KARU0EwDtXHMB0T6BEbk8FfRP2PgmlMaoPv/lFNpNb0P2dyMBvrd
	Ax0xczWUjuqPBtWaGfGkB9e76gb9TcPo3EpenLmoX8bB9EuFQxE+RuilA++8EUg5nVC0jpd
	V/zr+8ZaLLxW7n3v2JttLeIeUcns4eVhFbPKeC+huMWNB2UyFAhKOgTctEutzoFgT+Qtk7D
	CpPsHBmrdbpvBkU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: DEEFF45B696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10102-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spacemit.com:email,linux.spacemit.com:dkim,linux.spacemit.com:mid,riscstar.com:email]

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


