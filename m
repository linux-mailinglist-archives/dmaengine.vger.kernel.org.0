Return-Path: <dmaengine+bounces-9658-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI2RAGzuxGnN5AQAu9opvQ
	(envelope-from <dmaengine+bounces-9658-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:29:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B658D3315A3
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D578B3005641
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842863BD63A;
	Thu, 26 Mar 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ZnF8qyWd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128113B6BF3;
	Thu, 26 Mar 2026 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513151; cv=none; b=MFcPpZIIQ9Pt+fAPscREJkGzI5SBGsELvUxAYE5latiFkPBROBNBOg1+sNbMos9/uDS+QfPtNQRetLKnDv/I+PhdSYsRMw//hnBc4G3y7gvst/Xtsr9cPvkuOl3fYaUPGaweJI+pHEqJ/N6ntirbi8pzb8/B5wKDGxMc7fxXYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513151; c=relaxed/simple;
	bh=nmmcfGtbvriAE+ViUwjIiiQf6Qn588a2oed+diwK3sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNuTQr1LEi05CHrK0Q9GlIhHYJCoNHjP2jtyTxH3jCexdggm8t29043gegYSqsy+zpFQKNUtpwkmsy8D/gm9ekhXbLUloOdd2WHWYWjdX/rRfQ2vJescXDHKUbjubZ9WGuW14ITQshgDHsDG//AKZlo/G9RWvOG08SxRqDwaOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ZnF8qyWd; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774513102;
	bh=AfkHhDGLpLQTzVSA1vGgmpyjp0IbMp4aeirdAoHtZNQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=ZnF8qyWd04nR6pbG5fweVA2kcWfby8ldbygL9cLIXn9yiqJ+CYFOcN7k7YL0PkcST
	 qQVNOnVBiZq/FZTeDyw0R+pGxPGPPGTwLtJghEtA4Geg4L8uk1dtMox8v5N03dI4GL
	 0fpeZYLuRBy5hJMkGIjszj4Fd+t/2O7O5BKvmke0=
X-QQ-mid: zesmtpgz5t1774513100tbfdf4f0a
X-QQ-Originating-IP: q82tvM4vTm1zwnQtZr3+sN72ee+stqENddUckWj/GKI=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 16:18:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2742092535896640534
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 26 Mar 2026 16:17:20 +0800
Subject: [PATCH v2 5/7] dmaengine: mmp_pdma: add Spacemit K3 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-k3-pdma-v2-5-ca94ca7bb595@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774513072; l=1936;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=naSKBQlGCncc4Sjkd1TAFqDT0cym6ceyGaNaHvhlkkc=;
 b=gzJG1oV5yaKVjrZQyaBxqKdVvf3DXkLlZJXiJ6LDHZaazSTBBENlrpMm4+JzvfVmKEqLNfO9A
 FO8Grnpb3geBPvBnhnIpDxbA7MB8QodonXiw/6I0nZyk7cV85pNWkNZ
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NPmDtcYUnVcgDA3jFcLvldAQHB9ct0G//ElTaAQLtiYFncMVSdyaP4Tu
	LfIcKCVVmXX8FXTWf76ANeaklFp1zWXrNXsHbaMVNrb8TN66qPHJzEDw+nI9B+BVY+odu3d
	kbbjFXN4p6P9QoLdlVujO2EF1vWAUX5VF/DczETzXcDjxsldS7aksh6G6xD2C9aT6pYpjWI
	zjhGliYC3u9rYMtVNggUwBj0ao7Oz1jzUgBVS1s61O9r5enjzmUlP5G9tRDs1Wz6Wp4k8pX
	qd3QuLN8ZXeRlLJLkCsxMlrhFOdgTb05cD5rNXyO8bZN0Muq7577oW6ksPXuYUN9YtORz9T
	e+D35c9nyeV3taU5fmBMSxjJMrR4K4m8EGHlAvxElXTVo1kVRF4bb2PE/RoPb+AbD5Z8QC5
	C0qGqBich+fvg5VyB3K9MaI13NCGZL2uvrE0OHDST1Ouq4S4OBoMZUZTS0RR7Vfgr7HsesZ
	OA7dUodRF/AgmG9WPvXMnC1N2qIHbz1Opl4BeUHq7uEEuomdudYKGPClY8hzhDMIp0IiTeY
	zR+k1K0yym54Idacx85abH9wK0L17nAeAri5Uz+35lyY5LdSJ88WMyOALGCV511wA+DK7Bc
	TRN8TmvQU/T58JSAobED/5LZviw+uFTzrUbHpqF4vpFCIPb0Tl1qHDWGU6o76ZA+lH+yo3i
	u0b9MGOVqRpIlsM3JrEzZHsQMWc1PPp//jiPgykkZMKBWRB3HdG7PFKoHYeLZcYfs27XseU
	1Ub54G+30SzXo2jGVWkA4l+aEjFrwtxs3oTBkykNy4Ri1hIf4gOZaAWijXsz58C0qocVHMR
	cqeZjHNE/izLUPERuadaeH7igb1vuLDHjLF/wQz3u2ZyhMuwjIm43NJI291Ul5ZVEpGZAwq
	/j/ps+OCYJ+iaCsng4w48NM7vCjCI1ZDtj0gJyuVcRyzt1WVpWKizwQP3YKK6LyNg80f8Dl
	BsC05OrSstaa5CbcbkU0larwN6PsBLVop1TloghTKZJ+663QXeCjsIn1viRZa2v61JK5gtp
	Pg/NwDr2jqMvLwu/hHdeGorE3ghrNNJ7TXg13Ts/A6FksBD/uN8TmOWLMzkx7EJ7YR6UHOD
	Upqtxh2MzExBO7kVNq//8WFD9LCgUpTQYoGHU8Y5l4u
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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
	TAGGED_FROM(0.00)[bounces-9658-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.spacemit.com:dkim,linux.spacemit.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,spacemit.com:email,riscstar.com:email]
X-Rspamd-Queue-Id: B658D3315A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


