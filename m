Return-Path: <dmaengine+bounces-9755-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MEDFteFy2l4IgYAu9opvQ
	(envelope-from <dmaengine+bounces-9755-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:29:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 378143661EE
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3FF730230B8
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E863E558E;
	Tue, 31 Mar 2026 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="qOlvm8tn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E653E0C48;
	Tue, 31 Mar 2026 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945710; cv=none; b=olpXWPhYXo+Ihum1nQQUJQb3o2E2hJ6c1yzRlLnFA18D+plnVlIIPZ+HFAgOBncVr/fWKYfqLBU8HyXGOzRBPA4rVkN4NiCk8CX5qBEJhnhrTOvw4BuHNmuRKeRnLyUb+klsj6NSskQNaWp5XnTN2JoPgtabyfq8NAyUhwpcXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945710; c=relaxed/simple;
	bh=6+4qGpZANBGTkdbhxDWorKlyYo1yGbDiYzCTa+3RB28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+RvOMb10ZLUA3SemJQZ1Yj9r0MP33BUdLRjAPS81VsjXQyj4QnMsYW0uTlxPe0iVOL7ShjrEAwNhPNW2LwPkY9u8YxYHAIeuIKBt6NQlz2nZZ7cNeb8XaHdTWmYxRWNdzIrQ8xRgDMbBuCa4tSn6OmLNYji4/IEMOyoDRa1BAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=qOlvm8tn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774945646;
	bh=m5PWPnBQvLfR0iomd90tSIxBbWmrGFtCtbcayo247ws=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=qOlvm8tnyTNsWw+xsSNjrx9NdYYZ1gd7GuLToAl3TLcytDQb44f11TjVX8f1tnC0Y
	 r5g885eBgmuPa4oDNu/nuLvkeYlzKQWNETasXInoecwxbJjMjvUzKPRta3kW1xR08k
	 oz2fa0zGXhls4jkeCVSQx9UrEDNUTCLYiywEcFwA=
X-QQ-mid: zesmtpsz3t1774945644t777b7ddd
X-QQ-Originating-IP: maBAG3l49WXkRB/9Ixs25r6m48QgCw9SLz5l/9N3iPw=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 31 Mar 2026 16:27:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 884057616769070951
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 31 Mar 2026 16:27:05 +0800
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
Message-Id: <20260331-k3-pdma-v3-2-a4e60dd8b4b3@linux.spacemit.com>
References: <20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com>
In-Reply-To: <20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774945629; l=3360;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=bkVzrnGk9bZIYctd0IsZBkT4x/MeOiAKSLtr4On4XHk=;
 b=pc1CMn3ozvj0KpM3e6kcSnogXEp94edjM8vtTqePUKBZlVOTAn4/UlxWWvoDtXB343vxnsVQ7
 vyc/4uq5kKnCml8fdpdxL8ZK5QEvPYl0qD8AgrJK9UOyHRxhjW6tWgu
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NLaj0qEn9iQ85GrIMHEJH3T+Kz4rrr6e5aWox4Jw4k0nJRw3/HnpssXc
	/oqHxucAxRAJHrDqeBc+z25OVMQeLHmXQYX7B3nVKI2SEE+Q/Bw4wqM3wQ1DBTnvfsYQO2f
	+DRvgH7cLoAOppn0Q3/91oONRdFO1SY3ZcmYHGR8mRt8Qn0MAgfEii7sYeJPxumasKeC3A0
	17/YATx7Nmn3d+lt5KpnWqDwZx1bILGX9tomd75L1+9kKXzmkKgAAXjcglvz4FZ1hwKnlCo
	o4Zzxg68/TtmA7aY5CT27k9c7w5wPr49QH/Wc25eQfzszE3yhnZoCMcOp9flTCVAM6zfwS4
	grrbka+45pXSOzKHMdCZvFFY/eN+Z3MLVjwMj8W0Q7JH2N+s5zjSpVsgm6c69DzAGa1SdUc
	mGySZQf8M0WYP8V/RGA6MDbi+IsQSTPUnAwjz5NeHvBwWU5CstfakjvRtoCNo8JFcaLgFOy
	GN9xcJdV3Ul2Xwa3AlhohD4Kz8NNIP/IigMVlyt19ldcjCqrqvPQFLMULh78QyLeh1HTjy2
	tV99u7waVFLiEtjObfLd/u+tLDLgLRktPW90KRhiAyBGjeqylFo4n6N3tbRcIUwOoR7GBkj
	izQQP0vu/BFVA+AXdz7ayEoS1TfsLoO58a758dRXicWN2S+cVUxsWzCRAAeTZ6NYtjcETLL
	aHvpQm201ZXt4aJlg+/r+2rJte/KudKAHdsSbjHFL6u7U5y55GjAT7+vuoOQIn3hdmMJZaH
	fNsvQa+f4xp6rW+S4P1jsHMtmbiBfA1U3SiPnjV5aSC2f358Ngu9a9Bm5VZdp1zl7zaaN+m
	5eOcQOQZG4gYUmn164MlUu5n6Qp3mSA1TSa1zK9ri0T3ohjDvUSJblyiO8JQFSZVtrNrGGq
	DgjK0u+ftJ2wx9ozfC0D7Rd3KLx8jFiMhhBVtTxBkzxUZwHQ8hK2rLs64roz5T0rQQJzQh0
	9WGtwt+tGUQaBBn0Y1HyvL4qmKuyKLvY0PiVVuTWt1HrrzSsHVx+DpriSUXah4qunlaBtAS
	QoAzvtnAG9lVcdu2xcMVHuY6pHo+KzTzToMqlucoq6oHW5hsj4QRrbad6G8YTUDnqrqeXG4
	juwdKvbOcfbgveOlvIwYu0lFk6eqFK7LWCS0PPJuuSAed0eEtUIOWYTeVrQn6Yrag==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9755-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacemit.com:email,linux.spacemit.com:dkim,linux.spacemit.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,riscstar.com:email]
X-Rspamd-Queue-Id: 378143661EE
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


