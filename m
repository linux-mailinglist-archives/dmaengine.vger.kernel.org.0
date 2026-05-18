Return-Path: <dmaengine+bounces-10498-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAYIHP+ICmr62wQAu9opvQ
	(envelope-from <dmaengine+bounces-10498-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:35:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF2565798
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BAD63029ACF
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E2C3812F2;
	Mon, 18 May 2026 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="dms/x391"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECF219E8;
	Mon, 18 May 2026 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075283; cv=none; b=ViqfgrI4RJSg8KAU903NBvvwLhz1QSN3sot3EtRPSdfcJdgs2ozcieRBR51LP50vADqEAOGObdgoANbpKf+vfwIJcAp5CCK/c53R3XY7ra/0xgCMflLYp2MWN62nyHoTwKBqs4j27BB4KbM9GASq+h11yxcND8Y5lZsvAgT3us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075283; c=relaxed/simple;
	bh=puAycFcz82yFFxTESeoUDyIvYXA6gFPsA1uIzewuISc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aChlYf/EfwV5KDR3T4NNRco2dfF29AxbPH0j6WCtFml3hzHd+4VsZZ/4KrchhZ2UEg1h2L2urZgU8okQPQvRgI+qZ1DBXfsftuhc/JNzh/qJP/doa654oOGMErbKlLnVjChLoJaeSxehicWn1fJK/SCHciu8UIAIFSDJ/3yCT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=dms/x391; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1779075183;
	bh=WEgTcLNT77PCijZFbGfJuG9Q2+FviwpZN+Iidr2F1Pc=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=dms/x391knk1iLj+iJsosBnFkeRnuSDkxVimkvvoAthudCLlWTjArEpD6QtBtgpC+
	 i0WTwnDVWRSg+TTRY+2zO1crfC39uiYtPL3gBtYVCZlraaPgnzSfRduWvJlJVDUtxk
	 KPvBfgsqqwV4uwKhkrNkbvYHJegm+GfCUoCoq54s=
X-QQ-mid: esmtpgz11t1779075181tc414a223
X-QQ-Originating-IP: 4aa4xy6kzyEDn/hB/3pvOYHE+oja7bSXKJIbbQWp0O8=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 May 2026 11:32:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13173599530094016733
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 18 May 2026 11:32:43 +0800
Subject: [PATCH v6 3/4] dmaengine: mmp_pdma: add SpacemiT K3 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-k3-pdma-v6-3-67fdf319a8f8@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779075161; l=1920;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=4bfDEGXKbTnBfbIASslfHWXUB5uEewAj9IfOGNMEQGU=;
 b=35O9x039QUshxfCNVAwtdRjrlHUF1XNZmIUopflu/G8cZVfv1HaITKa6Rdeu52LOlSXMh1z0q
 uVsxDuTNImwDpSV8x+XhBphYQkHsLFMUcdsBIGtHh12i2XneJIF+U8P
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NJ/2NKTMb5Qh5VVYgj+xtVdQuUR1RKX3qnKZq9B3AJh2fRtOCq5b1Swz
	QKtQ/3K90NVDlmQOo9vBZhBGUpQSNQLcNx9Ec/I6qTTr2bHwhajPRh3PVkFjdvmvss1qHVj
	df9DMDcSANIhHzX+mrZ6CHtxc4PlaLxvwtAuLMOVtd8bPuWxuAls3ZeAgO37xLSaj1mwY/Z
	En/+Tp1qMwcfKuZcHEdCRORK7SXAuUfy2pDIj70tQl1Hy7XTgghSZOwBelW8Ur1/clQpFwi
	PrGx3IyRaXPZZ9uQXebV//Y/pr6G3X9ztyVIBRQfWxXc5dp5T6ifsaJmXHThOjiCd3ItZSm
	e78ti6fzwG48mY7DCBJkI4ep+SF06Bd9AC1/yvXuhE028L/n9Lyt7zLSt0ALfnozCcNu9hG
	H3R/Ck6rfyTDt7tZW3S9H7UpUNAsRZgN7KSTzl72HMCA6BuIjv4jA0UhzBqWFc46PBbkDv9
	GzHkL1Xiow6fkO8JX/zW1t+mqgvaLy1KBjuT9g+ZPKfSVXYRy+Nm2lpI49az0HHltgXk2ES
	q0QgdSN07NnwfaefbJgLyhdGskHSnlbcYVRuGZP5LK0+iZlkCXjydM1mKu6TWdAYuaUeWUj
	9W5vvKnD6NORAvLk7WH2YWGlHPx0NjXhplhpnpkK+pT26KNvTs5mo4inb+c0+yk3i48KkJY
	2zLM3BfgYzn05TpyZVjICm9zs/BMBiP0Jn65P79uR4YcNsms3rVS201tmA8CXnIzcC0Bn4G
	FLFGWShHy3jZPi1AoCo+l1BcH1VBRdo9Ex2UPmALyMlf1Rx5sr47oboEikTibycJTiUpqi6
	cVnyvpzdVkw5yzA+81bVQ3IgtV4Kbyy7MzYONX6lFsUWm9AVHJIxRCmGr1hG0ncjN3k4Cx3
	stIA9xcdjRlik7tc1RIiziDN0PjlsKPCwsx8m1d0NJXI23TJQDovtpM6LHxzjLujuAwRwoS
	48pF0V/dUqQlQvZS+pxv1QRm8BDrpU3NcxSfXXKwOnDjzc8G2dQ8x6Z41A8p7OyXg0kGcf4
	s0m7i81s/fIP5uhIe2c0XourDfwu0sBnEzlXGIZP1D1tjkL9WhTjkPBDdAC+XtWIeWSCjhq
	DfZ8QST9UKv2lwhEVSgJQvuYw2ON1RXpaSAz8dwmwJPOAVGVpN7rRqyOA4woSQc5UIHkxiI
	w2NL
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: C6BF2565798
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10498-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacemit.com:email,linux.spacemit.com:mid,linux.spacemit.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar.com:email]
X-Rspamd-Action: no action

From: Guodong Xu <guodong@riscstar.com>

SpacemiT K3 reuses most of the PDMA IP design found on K1, with one
difference being the extended DRCMR base address. Add "spacemit,k3-pdma"
compatible string and define a new mmp_pdma_ops for K3 PDMA.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/dma/mmp_pdma.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 6112369006ee..386e85cd4882 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -52,6 +52,7 @@
 #define DCSR_EORINTR	BIT(9)	/* The end of Receive */
 
 #define DRCMR_BASE		0x0100
+#define DRCMR_EXT_BASE_K3	0x1000
 #define DRCMR_EXT_BASE_DEFAULT	0x1100
 #define DRCMR_REQ_LIMIT		64
 #define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
@@ -1207,6 +1208,20 @@ static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
 	.drcmr_ext_base = DRCMR_EXT_BASE_DEFAULT,
 };
 
+static const struct mmp_pdma_ops spacemit_k3_pdma_ops = {
+	.write_next_addr = write_next_addr_64,
+	.read_src_addr = read_src_addr_64,
+	.read_dst_addr = read_dst_addr_64,
+	.set_desc_next_addr = set_desc_next_addr_64,
+	.set_desc_src_addr = set_desc_src_addr_64,
+	.set_desc_dst_addr = set_desc_dst_addr_64,
+	.get_desc_src_addr = get_desc_src_addr_64,
+	.get_desc_dst_addr = get_desc_dst_addr_64,
+	.run_bits = (DCSR_RUN | DCSR_LPAEEN | DCSR_EORIRQEN | DCSR_EORSTOPEN),
+	.dma_width = 64,
+	.drcmr_ext_base = DRCMR_EXT_BASE_K3,
+};
+
 static const struct of_device_id mmp_pdma_dt_ids[] = {
 	{
 		.compatible = "marvell,pdma-1.0",
@@ -1214,6 +1229,9 @@ static const struct of_device_id mmp_pdma_dt_ids[] = {
 	}, {
 		.compatible = "spacemit,k1-pdma",
 		.data = &spacemit_k1_pdma_ops
+	}, {
+		.compatible = "spacemit,k3-pdma",
+		.data = &spacemit_k3_pdma_ops
 	}, {
 		/* sentinel */
 	}

-- 
2.54.0


