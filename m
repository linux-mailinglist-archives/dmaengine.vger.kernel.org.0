Return-Path: <dmaengine+bounces-9751-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DyBK9mGy2l4IgYAu9opvQ
	(envelope-from <dmaengine+bounces-9751-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:33:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BA436631D
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFBC13062234
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3DD3DFC9D;
	Tue, 31 Mar 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="u39InUvX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD163DEACE;
	Tue, 31 Mar 2026 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945688; cv=none; b=cTwBGsUG0L1rcP4y0jk4Yq97sbjOKwxeUkXpwxN7T9UNLHXe5+ciFkR30i+wkkfiZ2SurNV7nMLPCeTOalJGuGwNPlF6I6kmdalGzsLNTEco3k2rm7mpdjw4C7kxN9PCHBysQEyBjsnNP2ESdPDBG/utHEK2QPDucoU5BLdBfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945688; c=relaxed/simple;
	bh=LvrL0BHWXs0mIoPugVsaBSOeXicquMoRYDC9CopWJSc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BqE3V1vXF1/esbOR2lArnmx9Ji+sTL8TF7PoHFjRYoMk75YanB9NLJUyyffoObD3ax3jP6xuRpMO1jXumgyPIl3DCTVBsT9qpbiyx+INxbCF8RhKu4Uo/JhhJoICBUMLVJfT3fdgaGDbJ96WGB+Nuhyjf1CO+X9byGcjzc8eni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=u39InUvX; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774945635;
	bh=g1gTKNWnRtZJ6FwHcvY1jPFdNxTPp7lh7M3Cysn4aVw=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=u39InUvXqOcpZTHj/jlwmhSdPCJ8NGZHZfucDinKGeH1i9tlm5whiejk+Vb2wlzON
	 zDCQ4XUdATErbYdlVyu2ScQL8IxQ0t5RFzkT43w4jyFjQ0tuMNatqmgKxG5VKgJjFg
	 MizOeesW44r+hkUZYPQm+gRwKV6O5hMZPvGPFCKI=
X-QQ-mid: zesmtpsz9t1774945633t810e87d6
X-QQ-Originating-IP: B7pH8laYsuYyw/pxu5WiH/fba2fLXc+zOpHSgiJovFU=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 31 Mar 2026 16:27:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9070569684775220452
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v3 0/5] dmaengine: Add Peripheral DMA support for SpacemiT
 K3 SoC
Date: Tue, 31 Mar 2026 16:27:03 +0800
Message-Id: <20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MSw6CMBSF4a2Yjr2E9haaOnIfxkEpRW6UR1psM
 IS9W5hoosP/5ORbWHCeXGCnw8K8ixRo6FPg8cBsa/qbA6pTM5GLMkeu4I4w1p0BZblCKZFLLFl
 6j941NO/S5Zq6pTAN/rXDkW/rrxE5cGhQ1+i0qgo05wf1zzkLo7GuoymzQ8c2LIovQJQfQEAO1
 mhpjaqqQhd/gXVd35T2xzPoAAAA
X-Change-ID: 20260317-k3-pdma-7c1734431436
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774945629; l=2453;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=LvrL0BHWXs0mIoPugVsaBSOeXicquMoRYDC9CopWJSc=;
 b=bG2SuF13yVtqPTcEtTTXJoZA9l2t1O3ipq+1Qsf91FOD4Zq41V208uOjKQxWF7bZsHm7yUBjh
 esJjzS7Jb94B6c3eleaYy9CzgAGNvjauQjDAbbtN6kTqdfUBHirHXek
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OT30tXkhdtaaCWeHCGzrz/zv8MUJW4KS7B9X4Tir+AMEhkzj2CeeXcvX
	jOdnW1bJjIg8gQlmf/Ra6ASLjc6oRRheLF8QLkxYa1fcT8MaNpeE3KcITa3u4yGXZS/CzKv
	0kPw7ro26zEGhSoULzW11twqEIO79rSyDlVgwyelJi452uY1eV2KHF6etP6rWHqLwL7mXq5
	aXjnBpQMz1TVlAkhY31lnDUlo2pbtlPg2/2y0BvoEoBzqhiUgsj4MNLQqM24Gso72krri0e
	AgCJF0GBX5tn3MTHWGYheUVG7WD6JYr5z1buzdQahLn0jWfwjov+kKKewEiGWy8Md+WudID
	yxLd9URl9Oxi4J15Djg2+WvNqDP7Jx3hN7Wgo84TtJvF43ZR/0ff9dgqPc6ve9+oTaCV+oU
	Sla907f8gOLnNgg0qb4nyayS58Cu6IlYRDz73puCHxZlnftgl3QWEV6CPlR8R2RYw54cynM
	6de4P96qgM8Rx90+tyGox2PW/Hcsr3mv4pezeK0oHvYdVEmj6QyKw0epv2inmIVqPykTT2H
	RGLnS+p/VLRbj3BOLFAtGFZ4putyH9jIkA7tiy8jH2dYNdtL+AbkfNAOfh7xgS3aS8SBwl2
	OFu+fxkKa9xLbnjj879Daisbl0smXCPqt0KO69tT4QqT56iLb7utzhWdq+ADtxH6eGM0JmH
	Y/tcObBnyS8SPzFPfaoXi4/yJ3nULvcBPEjobfq5u7HBUZYeUjJrWVTEfAf0SW9IkH+Y9++
	i/cDcDjoazslpAv51UQzzmH89NblrzIrTO/3caLffa6qo32yzcMwtSACmrJbLrF9In3IWmV
	F1C7P5RWzB1mFqR+aGASa87ikQQXF0WCX8+mFJCFZt4E8oUnGTcnIxad116IWCT4N/wAW+m
	QoZMlw2jKWqyNewEiAWu6nqG3qiATB+M6EFQycyrYqB/O4byyNELQssCDjsNaC+nz57VgXA
	VvDGd99Xf+ijNOn2sdagVwF4QqgqPuHZjYV9GaJFOoPKAD2BDOZzSiepEbs/hUCLS168gTQ
	ZVvK7Q6AXffQPVq7bqazl1LaJXSuGpqkzC9tJ1BNkMmDsSF1VLPn+oM4QpTGyBt92XD7zWz
	XF3QP9FL2veMlO56owuzMCJD3jjQiLMZHJ1wY962hpwTki/EYvN3MpQWM9bJb9bjC8TSpkT
	8CnV
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
	TAGGED_FROM(0.00)[bounces-9751-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[troy.mitchell@linux.spacemit.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.spacemit.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.spacemit.com:dkim,linux.spacemit.com:mid,spacemit.com:email]
X-Rspamd-Queue-Id: 56BA436631D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

This patch series introduces Peripheral DMA (PDMA) support for the 
SpacemiT K3 SoC, leveraging the existing mmp_pdma driver.

The K3 PDMA IP is largely based on the design found in the previous 
SpacemiT K1 SoC, but introduces a few key architectural differences:
1. It features a variable extended DRCMR base address for DMA request 
   numbers (>= 64) depending on the hardware implementation.
2. Unlike the K1 SoC, where some DMA masters had memory addressing 
   limitations (requiring a dedicated dma-bus), the K3 DMA masters 
   have full memory addressing capabilities.

The series is structured as follows:
- Patch 1: Introduce the necessary dt-bindings: K3 compatible string.
- Patch 2-3: Refactor the mmp_pdma driver to support variable extended 
  DRCMR bases, and add the specific implementation/ops for the K3 SoC.
- Patch 4: Fixes a critical clock issue where the DDR bus clock 
  (top_dclk) could be gated by CCF, which would cause DMA engines to 
  hang and lead to system instability.
- Patch 5: Finally, instantiates the PDMA controller node in the 
  SpacemiT K3 device tree.

---
Changes in v3:
- Removed the dt-bindings patches related to the DMA number.
- patch 1/5:
  - update commit message
- patch 2-5: nothing
- Link to v2: https://lore.kernel.org/r/20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com

Changes in v2:
- patch 1-6 are added in this version
- patch 7/7
  - update commit message
  - using k3 compatible string
  - Link to v1: https://lore.kernel.org/all/20260317-k3-pdma-v1-1-f39d3e97b53a@linux.spacemit.com/

---
Guodong Xu (3):
      dt-bindings: dmaengine: Add SpacemiT K3 DMA compatible string
      dmaengine: mmp_pdma: support variable extended DRCMR base
      dmaengine: mmp_pdma: add Spacemit K3 support

Troy Mitchell (2):
      clk: spacemit: k3: mark top_dclk as CLK_IS_CRITICAL
      riscv: dts: spacemit: Add PDMA controller node for K3 SoC

 .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  4 ++-
 arch/riscv/boot/dts/spacemit/k3.dtsi               | 11 +++++++
 drivers/clk/spacemit/ccu-k3.c                      |  2 +-
 drivers/dma/mmp_pdma.c                             | 37 ++++++++++++++++++++--
 4 files changed, 49 insertions(+), 5 deletions(-)
---
base-commit: 02f90981a67f3b9ee7d6684e7503a4fed7aade0c
change-id: 20260317-k3-pdma-7c1734431436

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


