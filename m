Return-Path: <dmaengine+bounces-10103-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIcsKfco62m1JQAAu9opvQ
	(envelope-from <dmaengine+bounces-10103-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:25:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5509045B6B4
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D2E30427EF
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFEE3290B0;
	Fri, 24 Apr 2026 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="fPFj44Pz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9F320A14;
	Fri, 24 Apr 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018945; cv=none; b=u8ssKwiMkdQNwiCrz0rhGhT0ZSNexfFwi9BzF0Y10Eim3fOFFPw2j+s5T5mkNfmWAXeiScC7JcRHOOeCIlrGe9X7fjNjvVXPI6rukkVhwGl0MCj0ArPYwbDQFkmr6zx4jiMV3ckJJO6E0qdg3rfYes2q4+kze+agX/splGNMzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018945; c=relaxed/simple;
	bh=nmmcfGtbvriAE+ViUwjIiiQf6Qn588a2oed+diwK3sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HzxrgPBSSNhmEpZ+PdHimWyaFdT8RyScxa9PE83K5csTPbY/P5wQUNM5TIGisc3IstkCaGIscgX+bYsOTxwqinpJmwvGnLN5bNORS1tufbM8fqsJQcrDaVAoRfj5FY/qVk8/I++7OwQdkbSBpj5kZm1EOrosJAT1a9Bv1dGguv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=fPFj44Pz; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1777018886;
	bh=AfkHhDGLpLQTzVSA1vGgmpyjp0IbMp4aeirdAoHtZNQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=fPFj44Pz6r3PGpAGkeY856ucdGyVD3F/CfxkXXGrhnlJ5qFFwt4/Cyqc6uZT4Wyft
	 DujRdKlr4ELqVr/fxBsJkKhT7lffaX5AzgLl7QDFF8/Tm3ro4//tbsvJjXsk/NzVBX
	 G+mgc9UGrHC+f6Ss3LSFnHGG/RJ7pA1iPsc134Yo=
X-QQ-mid: zesmtpsz8t1777018884ta1f1052e
X-QQ-Originating-IP: MQkCKHtWtYfW/btAjq7yno7chuYsBA72HCA3Sb2heG8=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Apr 2026 16:21:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5667929867627662509
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 24 Apr 2026 16:20:31 +0800
Subject: [PATCH v3 3/5] dmaengine: mmp_pdma: add Spacemit K3 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-k3-pdma-v3-3-efdf2e414a08@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777018865; l=1936;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=naSKBQlGCncc4Sjkd1TAFqDT0cym6ceyGaNaHvhlkkc=;
 b=+mkuY8RvtJtQVFI31ITeI1/vanMfW/OCs5bnFnDUCmnRwrKXuf3XxwHdrhDyi3E5ZJkovDzGP
 loI+wJcYG51DEw9+5xDfAaE2Yp1GIcq68H+Qw8vViB7Ch+L+kUCmjdz
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Of6M23+h/X9YXoqnv+8GTwDc/5Yw/bA+G375TurFc2U25EGEiKdake6C
	ADWaakrsYWBkpPWX/BNhasyuSyYN3z7e+LLEUW5WLxaFpwvD2eTDc/3k+U/4dPRWdd0Zedf
	7PnsVcdVSUK0adIyOyG39kh7GmskC5iLQWbSmkmSy2Mam+eG3aqCxGOqVQyXWL6UonEszUh
	pHRoCi6Pfc+C2nBggSG4M0AG3UDseXYZ9ZeulLLhUbcOaXImezNxHfmrZwl6WHEvucz90rv
	xMjVkk2l9vexLyt/tKG2fs9BobOP9J7eijW97eoocAx/71W8SV3sVlehsTdSi8OlWheyR/S
	nGxlFRnKYhBijiPDgO3H9ezt3/xuBh3MQRZ03APaMlJUCGk3gGsXFl9h3wLx1DCO9BjdqOD
	wkgpUrnuHLp3WxfjP5+eIb9DqJIlcqaOS0pO3nUvpl23SFGCBBt5/UidknTi5Dutk1qVOJJ
	sFiFp9h8JB7GSVsc0nf+cU7AIMtMrAKPcH+f9acEPAxmJoUt0k00QCHu+gNHrWsCXPhu8NH
	uQGpqcO8H2B3bGRsAnNtPEbF6Se4U6VxWouzphnSB2H46ru98OD4ReukXWCS+ZzErqQXFfk
	K2D6IoWOW/Xf2FBdCbFIZ/3sY4MVhTQ/vF1Osgqhx1ghJfGhvYlTWUj3cFxbNr9TXtO1rEB
	kdgHtTpa0LxaIV5QQJ/IHTETqpIbKeWLnvBGFQOAVFwJA2dazzfTd3GzIrCh04ii03OgVPa
	/4Nshn6z5ZUCaLa4Xiir25sk3qSrtKEq2keQM+PlDer7hUsB59Oxe91jDpuN5QDcCPokQDt
	ZpBOffqSX3ymT/kNrQoTSOsJpP0IB0kH5kHQEhHflHyIEmBfxuCh7qVGKyteOjLS8oWy6UC
	n1L819RaBOchrX9T9B0Beu4QkT7bHRDIn1gXr1oId92Phr3b64wh0Ox1YSyj0O8LBac2TUU
	ygncsF5YQwG/GjVvfkh6NHd4ooh5/5glGLGwMrai8PpSZbwKzuU+QkVh/RLLWbBPiwVxc4q
	6+BFPnXOVVgYSZRATiLSDRcxKKCMU/YDy66pTdNRYLyaaZuLnOHGvjNKn9VRmZTpw6u18V9
	s7DFkNs5PzZiviru4qAR1XdmSaR8qTVpxt08kBimR8ntC36HiCsRz3rNuN8BXORELC7IJO7
	nX7Bsbyke/ycX/I=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 5509045B6B4
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10103-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar.com:email,spacemit.com:email,linux.spacemit.com:dkim,linux.spacemit.com:mid]

From: Guodong Xu <guodong@riscstar.com>

SpacemiT K3 reuses most of the PDMA IP design found on K1, with one difference
being the extended DRCMR base address. This patch adds "spacemit,k3-pdma"
compatible string and it defines a new mmp_pdma_ops for k3 pdma.

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
2.53.0


