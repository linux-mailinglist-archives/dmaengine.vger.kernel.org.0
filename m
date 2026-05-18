Return-Path: <dmaengine+bounces-10497-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDEVBd+ICmrt2wQAu9opvQ
	(envelope-from <dmaengine+bounces-10497-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:34:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABAD565772
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613B4301F4BD
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 03:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C418380FE0;
	Mon, 18 May 2026 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="TWOG/H8D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E918C332;
	Mon, 18 May 2026 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075281; cv=none; b=HhkCJRqAbDajxaJPM/Ny7umcrEdoYI+Z1pBSwKXrw0ACX6kZFLvFEsqRWruPi55wI31V4SdVqfw3A3iSp6nq7GswL1FRMRBK3XaDeGHYwe7PIgdRAf4tftM8F863CWPRFYsky3Hl37IujDrWjvYCavu36M1APKANq4Z/9E5DNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075281; c=relaxed/simple;
	bh=YVMoIbOn6YecIFTQyAsU8tb/SRboDmmgHXX9RODPOg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3EbRJUesiuXuGaUze6gmpnsEfRiHywllbEbHsBHZEJ7opLNwVJ81VtIyqdamQtFXLUpYPyP3SL0JNpMmIHATxE7Y0/j/BJOF+LXaqV78P4nY1GvACyZWjhBiYfG24vjyzH10IFJ2s8CpCJbfbSH4BAeD1W3BeJzHNG0ErP0XEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=TWOG/H8D; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1779075178;
	bh=Z+NDK3NBfapxA+/wLVSZ1OD25Ga6fXQEelZnMC4wbss=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=TWOG/H8Dwv6+KVEyJHfUIyJVW3cEiuARpRnGZCo7iNtPDBnF+I3hG0lTX3glpZAZI
	 hFGuagkNJZiO6bjlZo8EhsGWaEFlV9XYpqiisMvvsXanFMekQZ296kdkra7yqLoLGW
	 5WhzxjP8DVT9lCUUix2mMiDPd/pNznnM9grRjUAA=
X-QQ-mid: esmtpgz12t1779075176t83c01d00
X-QQ-Originating-IP: VUNDhWnkeZJ77kznvS5xP4mwVwqnyDjI3vd5qUd1wPs=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 May 2026 11:32:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10048958506194084896
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 18 May 2026 11:32:42 +0800
Subject: [PATCH v6 2/4] dmaengine: mmp_pdma: refactor DRCMR access with
 helper function
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-k3-pdma-v6-2-67fdf319a8f8@linux.spacemit.com>
References: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
In-Reply-To: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779075161; l=3268;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=w5fmms7zEKXi5LHvgSGTUoseJ2ZgoZsRCQwLD8J9bLo=;
 b=7+QAaP9dDheYiaDR3fXiR7ADYMKLJL7wXghp43IVvGMcX0gNsUQKHn3u51KGgIceC5QjFevsf
 b6pofBnEiHjAm5b86z9tWQBIwvLtRWCr5P4O7cE8X9EMlKCuyJzcnTh
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MsODpb+k04Rn0StkLv8Ifa8lbo4g4sZ74dqN7+jsAIvVXjITl0pTOkYE
	UFFqFemrc9wGoPL21fkuOFkUAeCwWhUqlgwuM1l9i6Y6rebWVwfCDjkxQi5YTo0ldVPQPl8
	x2Q39I7x+HTzyr8YSFmVr2Uu0/rWum9rb6d76IOwl/AYVN7fEQYqEnrvQAVxcEBPJNN7Np9
	Osdgim51WylY0icvfncfyyIFWgmkAEPVczcGMz1BkjDGe9M0XYWa6rhLtVH4ONXHOd9Rmi9
	Fq6/PGmiwHnhWNsN7shtvCteLxz+DlEN4yBbjORyVFHWzVuePscIUhrLrLXgR5gpqVoHe+q
	YIXK7o1gO+8rgQbYn8z6mBhUoNtRwIVAPI6crHJcFZ3VsU11Qt6lm3znWEb8eyWeB/cFQs9
	9OzKFJhXIyS27zx1qrhl0tSvxXi6VyGFNc7spE9vgdSns/ZNc/FZdx+TbdedNsUAexLivh6
	j0My5+sKGRNqTpC4Pg/lyrpniZN79SY1WUM4oQ8CxmjtQ7qrSDluoyM+KCP9FRsDtdDbpUj
	fAcZyNj5l24gCz5ETwmr7TBxOM8Fa6jYulQ3d7ZoW6By7rxk3jym7AP1+cmMkQpQBlJPyTG
	iEQorL19s4cNpRfc36wMrnapfCxx7sgxM8/kbo9+43PlQWQuf0LaKQ1rwTyIO1z0huyS0s1
	FRxOKipg9zONjuBbks6UhphEnI6FnAbrTc0XSwePBxR/UV/Ct2Ec/jwQTHJZNo+5SrO/KWS
	/UH+XPdpLSSmupgVsgjsg66ADE8DRk6Ub79oyVeCNoKs0RS5sRqLTToZwPHr0x+QPfwL4wl
	WFxfVkhtjpjp9lMG97BDqCpbTncTexKV0Xiuj8kjjafuOtndBV+mKneQTUUgDX8wwEJSGTj
	DKFHjENMADkcV6lg7P9KbGviO5+3AeZ8ZEGZkKJQopEpHfzV7FLsXoaxwueeR10dzQIyCXJ
	sfxEDzyjDdMm7Xs5WcJSRUYvXczZQwRxc/0UpeWc6NSb+jDyvIJ7BHFN9auUvQnS7O8Vfwq
	a7YtgI6q/2OOulv3CwlGO6Jal2lYlq9IwkIYtwvFIyPwtVEfCrkv0/0U6nvkwBYrf+I4LFy
	ypcGx1LdgWHpSQmgSaWtYuwx9QMj269JuquQfSix3v7
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 9ABAD565772
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
	TAGGED_FROM(0.00)[bounces-10497-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.spacemit.com:mid,linux.spacemit.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar.com:email]
X-Rspamd-Action: no action

From: Guodong Xu <guodong@riscstar.com>

Refactor the DRCMR macro into a helper function mmp_pdma_get_drcmr()
to support variable extended DRCMR base addresses across different PDMA
implementations, such as SpacemiT K3.

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


