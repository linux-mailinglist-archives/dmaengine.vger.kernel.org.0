Return-Path: <dmaengine+bounces-10257-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1B6zMGhr/GmMPwAAu9opvQ
	(envelope-from <dmaengine+bounces-10257-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 12:37:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA364E6DC2
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DDD1300E161
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475FF3EAC71;
	Thu,  7 May 2026 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="b/iB98Qx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745431AA8F;
	Thu,  7 May 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150244; cv=none; b=XUuyrr8Z171h88rSnMd2J2EUnlfzqdlDRC9g2n5yQy5SYa1EEy0OmHJA0jGG5Zpd2c5U9KHdbPD6h8ccydpYWUZ9kS/+wqt2FGVCuD4DiyeIAHTAYcgEiTqRa2XLXwbivE6ZxSH/A3mcjSa7NrGFpSBdh+YFoKi0We8FkaaNSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150244; c=relaxed/simple;
	bh=ESr5oLueEavHIEx5CDfpdUrwWxLz87NQ2AGm9fApLJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrCpe5JdvjCybg+Qipl8fxYJxhsA+eMjv2r3kF6hlFqnLZvgI+ZrG7YmRwZMw2utTyhasK1sxCx8b/ODxFaAzaaTAKRHK5Ho0T5VgWs7cKEeso/69lASUZieCP53N3Xfmn8t+vAFS71Bbqnw8yQlYSftdBkkf+Lt5zpbE69X72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=b/iB98Qx; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1778150203;
	bh=Gj+W+N7im+aQQ8FFJbTvQJn0dNoasXq83/GNhZL6xwU=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=b/iB98Qxr33fDr1N4cROaWUU80Xk0Fi6Y8/cAB1y+t+deRKcfYVeU3AVZxxjCwfxe
	 o4nKoEjH88H13GQRO8NecrgCfkwSHovt08q02jzJrU/uRxZc3WoY5Y092mIV1zyPzh
	 th3q2bpDX2tZGaZXqZ48DkTiwxPUvgy7hSe3C71Q=
X-QQ-mid: esmtpgz10t1778150201tb51ce93c
X-QQ-Originating-IP: T6++f6lRK+n6ypX3y/ZECT+G0QZ4TApbmsD2W8JptP8=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 18:36:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4507917310872199054
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 07 May 2026 18:36:22 +0800
Subject: [PATCH v5 3/4] dmaengine: mmp_pdma: add Spacemit K3 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-k3-pdma-v5-3-6b9743038026@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778150183; l=1936;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=0uBBuEM27xA3rpe8lKTZJ07znj6/zACtY5VL6lS0imo=;
 b=YarURs6eql25oUea+1GkYffFXSwwGIpptcv2PTQdlBIvFqKFVeO0tCYz+0IBNJg4v9KHxiYAg
 NPYiVM8FyKlB6CkJHZaclYjs1H/4/Ja9bA+oD+WTPnCGhDqM+pVqGZg
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MW3wiet0EsO3ZtRRGasWQ0A1hgHuEXzsASyoHuEo8mPrQ+1DfqXpo8t5
	fh3tM4KRdJbXdSxsEdRCRNUhr2jsXPr05QJrCHas4cePkQUWWLYb3POKV+DhAsTXw/WTae4
	6zWb6hD8+Jkj1O3w7EY48yU5cqyoVv4nPGT1YqO0Hk7uEIBojUrVgZAEBaZgUzP3tKxVo8I
	Rc4LMBmjIVprC14Dde3LWItqzWw8P1ZyOsGjjUzRTj+Eas5w13J8TfVcuFmBWwcu/xHx/+B
	gDQhGtE0Bf1fiZ4EBAj1mLvpAuOhfTPtUaCAQE/hNlPHH5V1EBlZacBKzbS7az991S0Dcp/
	yTBrph4gwFCO++iQQcor3dhqryQ/bQowUm5K8q/nnKVVg9YA4etT7Cyb4zzv0Z83rBZCWlB
	PL6Yd7yuX7/SnNMzUX+9wepjQU8+UScLKiBfa72509nDjpfTrSF7P7rNe+mwUoL3MzlyMfq
	eHcHjsRaHODSgH7uu3xJi8LIgdbhWkEnObzOIIbWhRkQUdmO63KhPg4aCxvxRmR1KJkO0oN
	UH7jhNdCiO8ncizgnJlr3R+k3uJVO2TTUGqd07czQfpi0Y5+fgT00yKt6y4IDTZs+WMdbQY
	jwBChB3wXdINsUSDYFg6IcVNjuC26HqBIJtF7V3wksX7iNXVPMUCR4KH0NG8QQ7l9GeycIZ
	zPegJuUmF/Q390xSJkAXAUSqmG3Gf2vQRl1T3NvJH04J+zUEaWMvJuH+r9mewmzPhJ7PT4x
	+2A64LOML8AvahrXpBoEVVqOX1QtDXqCcWTqqyHKYHMLZZJbSP44qKaZQc3xssYd1cx1ho4
	MJN3SFZC3Of7nNWrDDfBhzyoI8inxfuLI5O4xwChTX9lISXber0P0H4sQihioAGBuVqUMO2
	efOVJANAcFJoWEV+ilhiH0cmiiW6aKxG2t2Y+RvNgNgYTVtVa5CdbK7KoSFXwG4HNxPUNer
	d7hczzfEvx+qZXnprk/JhPWVSQxYF/EhBXjCUqNe+JMgpNvL121feuguyPkIDyEEsSbwSNz
	0wwarlz5B62JkS9n8Gu7LMs9PAMIu5dfR/4ApSlKyTI603musngchtz6+yniKm1rFYlJx5Q
	jCPOoEYqvBYmqxIl8jOX/CCZkY1zjlvBCCvOrx212hjh2cjeeunkq4KapCjfHAWD4gv5gRO
	l3EsX8Ro+2OOiaI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 9EA364E6DC2
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10257-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.spacemit.com:mid,linux.spacemit.com:dkim,spacemit.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
2.54.0


