Return-Path: <dmaengine+bounces-9753-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO/HFxSHy2kuIwYAu9opvQ
	(envelope-from <dmaengine+bounces-9753-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:34:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A37366366
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13C1E30A76CE
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301253E0C66;
	Tue, 31 Mar 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="xISPJjvj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F53E023E;
	Tue, 31 Mar 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945704; cv=none; b=vAtFjBraSOd2N5NXMKxEGXnrcozYn9yCeruVbhCyeI+d0WkMvhhw64EpN3fUoKstGmbNUgp3THz2Da6Yzu6YY+x9zV2MZUm5lTzjODUlIZa9tsw9md3PC1YLPPalsvGc7V6wT2qUJyFzs43Oyiv7keIXOhW5ba4xAsJcfQVg5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945704; c=relaxed/simple;
	bh=nmmcfGtbvriAE+ViUwjIiiQf6Qn588a2oed+diwK3sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNshMz/5AJleKlWyrvqGxNi3kRdil3eHXV8rxavnoUl98rIqVh7j0QpEssUsYEwumDzu0WoPCTm3DyJ4q0tZ9eMvuOy0NGKCGIYmkFF7yracE2TCwpdo42wgFoMJ9R1iw8/TcWxo2ezpzOWm+m8rG8mwPrFVISkqsI5XlHVXjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=xISPJjvj; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774945651;
	bh=AfkHhDGLpLQTzVSA1vGgmpyjp0IbMp4aeirdAoHtZNQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=xISPJjvjLIISW4iDIrdj5u+IRJJm/XTnX7ZG4vd93uuH8DkHFO71fLEVNkS+zYGfk
	 wLKUu2bGNVqINki4bfd9m4cWySUdTiOAtNzGolrh1QgaQd4BrFGB+G1vLo36bvD2HK
	 Gw2DaSpOsdTz+y+gHdUVto5BBMuU9vnDlkRPcvbo=
X-QQ-mid: zesmtpsz8t1774945649t3f9fb1fc
X-QQ-Originating-IP: pSoIYL+Ok+X2z86E2GPV9+HUKi5ghFbaPNIDQuTAFvM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 31 Mar 2026 16:27:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10790581914033576037
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 31 Mar 2026 16:27:06 +0800
Subject: [PATCH v3 3/5] dmaengine: mmp_pdma: add Spacemit K3 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-k3-pdma-v3-3-a4e60dd8b4b3@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774945629; l=1936;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=naSKBQlGCncc4Sjkd1TAFqDT0cym6ceyGaNaHvhlkkc=;
 b=JzGVaBB9r087s/TJzpcykTwUhsUXS625HWzNd/4ybcfN3ErXRVU9yKPkhbgiyil8P6xuBcEyD
 eVJV4BQITBlCzPy4HYXt29gmevZnEQgyo9UbEE4MPy6Ad8BxcDmePhV
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M/gYBZzTb9iML1mczemgHAV4c/FA4lQRCwpRf3EriTxc/nN/foLPyfek
	pv6QjtWdKn+sS1V9lZ12k1G78L40lijqvLBsf43f0w/zwmTsFfJULhdUegHnnF9SN89lyrb
	IusU0mnX+BQgesw2Lq+lLw3UEAmGtHt7rnbQddm1djj2xWLSQaa2PfwWctu8W5mMpszdCOK
	pwPqkKuZ7AFov6U3lfBOkebfYKp8BspnGGUO4aWL7s3vuH8/7nhd4VgY+SX8yB8bapa9txo
	4s4dOOdVVXMgMClrG31gRU8Fpx065ahhuS+9Wich/BX7Ifnq0Em/60xuoE/Ewb4AXlNo8Z/
	fDpFd7hp4XTIgGS8EPIV+N07pP74jDf+2chwqM94v18ttGBfyEZ015x/L6+w5bK9tFwbQcW
	OK8Id6QaW09Sch6iyrAAIxKjkn8iyZSw7nXVBC+aAjp0KVK8OX8d+blHmp6A30LfWCVxs4q
	LXHkqsN9H9nGBrOMCegM+IFibwPh5jNDOgnMCiEzkU4Euh8z3x95DVwppzDaEVF6YSApVvi
	MUPUuk1PnYtN0xHJo1FVJNtNt8hTbkYrh2SMrTNxsxI3MT9TlnJzpc9Ik/SaG1rhpOWGD4X
	c/1h7LMQVSMuzTKPjnE1vS3rH+tpQBai8XA5sMlkmr3HKtcd3RPP7YM8Op1tCGwuRMBfWDI
	5Ziv7Jg/NOt54owx4I2mWld8KQyyOjViCz15YL/MuWF1xIrw4Z0BKdVShjBm7ZdiEdxX9V4
	cNVAPd3SWU/ukl7tyUNLR813QHq9TBUSPcvRNG//PCdJ4AmJ8cmOfmTyWC+tNQhbKHZ7XqH
	aArOlg8y9C3BevlTjKGdc+IQgUaGHK3TOQlZEoeCVOuMwbiJEJ0skPztwCIqazlt7faj2o/
	r8THwBzIGtFjWvVwwxuZ9DDD7upGJN/4fFSri/190cWUBd/+rWRt0iOOYJCfAFo+WEesVzh
	N32U0BAK5WWQKmODQ5Xc2Pei8e+Gr0VsggGSO548KNjzD2HhAzEftdZmkhO6QkR8S7T6JzQ
	wGHZIRgtiUS7rWTuHJDiEtLhOEvCtXtx9oZv/UxuIxOefgqDAl5tnCFjeygZBtsrgIKfHVP
	engg9OVPewgjEnd2sq2gBHufNGgqu6pRThvWd7KXGK0Nzn4PY8RghaLg684GzCTfWvpGgcv
	ePFK
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
	TAGGED_FROM(0.00)[bounces-9753-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.spacemit.com:dkim,linux.spacemit.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spacemit.com:email,riscstar.com:email]
X-Rspamd-Queue-Id: B4A37366366
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


