Return-Path: <dmaengine+bounces-10495-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLtnMsGICmrt2wQAu9opvQ
	(envelope-from <dmaengine+bounces-10495-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:34:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E83565727
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B1963001FA9
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 03:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216F37BE9A;
	Mon, 18 May 2026 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="qNxuxase"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5C219E8;
	Mon, 18 May 2026 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075251; cv=none; b=PRZ4gRsEbkA5q7SittVVHVgy8oefyp75tWRHwMRtnsILDE4GAZl7+x4siO6bRksxD7zARhWlHXb8ggZ8JEIQXOy32NuAft38vwnslSmErk/5hl8y9rTGrM2bDT/Eagoa540wUxrbv25veLexqaPVGDz/BKQSZP3xnLVTPVTYL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075251; c=relaxed/simple;
	bh=U/ceIKjZFY01LMWlZnV2z7oRNT3AaZvlRAEcN9W12vM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gfACLG6ufW8gOvDF0aQuSbnVt24zfQCTR5bjKOOEpOG+Pwkw1X+ZBYTOo+OM+Pj6U5fjxPKff/unls7s3JoH9LbpI154QCFkZiXnF63ZgeGQmQHc8/A5go1YB63jdVJtCP7K3rt6PByIUvM6N2D1Q4mgCUXH8sVbPEOzCEbE63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=qNxuxase; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1779075174;
	bh=0lG//UW+nL0bVF6fLvPjKVtHMq7p9Uujc8wu21iQ3/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=qNxuxaseIiI1pf/6rMqCBx5vJF+conJh4lced9m76BEPSXZFYd/hDIuYlaF2Xmdso
	 uBVLVy5ZUZj0xl24fnGS7D4edVeIvIuUxzxhnf5fHw4psYHTG/n/nR8MRtKYzAK/RM
	 mpVTM1Pw2jLmO1wLD0+CSqWBb1E/mx3ERecd2k2o=
X-QQ-mid: esmtpgz10t1779075165t2fa57b58
X-QQ-Originating-IP: mx2jasJbyqyltMLsj9OqOTWy41Ajp5D7/7w5+wz3FeM=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 May 2026 11:32:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1709424969747522539
EX-QQ-RecipientCnt: 21
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v6 0/4] dmaengine: Add Peripheral DMA support for SpacemiT
 K3 SoC
Date: Mon, 18 May 2026 11:32:40 +0800
Message-Id: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPzQ7CIAzA8VcxnMUALSCefA/jgbFOie4jQxfNs
 neXeZmJevy3zS/pyBL1kRLbrUbW0xBTbJscZr1i4eybE/FY5mZKKCNAWn4B3pW15zZIC4ggEQz
 L111PVXy8pcMx9zmmW9s/3/Ag5+m3MUgueQWuBHK20OD319jcH5vU+UB1vG1CW7MZG9QHoMwCK
 C548A6Dt0Whnf4LwAKgwgWADFBVVopQohfbv4BeAC0+XtAZMIWzCAK2efsTmKbpBQdfrwhqAQA
 A
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779075161; l=3651;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=U/ceIKjZFY01LMWlZnV2z7oRNT3AaZvlRAEcN9W12vM=;
 b=o8lOYG5aXVodRXrfGBNGNT1VCeJDoqFQe0QGU1qddTVylWgSIMGoO90sTl0GxX+FPSuknU03H
 bFKTw1P+1h1BcXnfs43q7Ilo/Kp7d3lrLFTFXsBU7idZ95fWjfMTmgx
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NxaXz+5yuHzbtGJvujyIbKBjBTDOyj03TQRW8SzitAHZvnHOShsTeIea
	F1oC5gvtJ4TWucyh0AeMPHvDRrEyvDkmQj80DdzDq0HFKT5qO15MAX3vbh30TzRcE00dEWW
	KJowm1MJOe8ZUts8S2J8WsD/pTZfYN+anKoYtbs6hGT8jZZo0BbEqpb+NoO3jdMB2s/yyJ9
	E9MRlqHZq74SqZ6dUapJyqv6MhTFDWPy8iAh5BKhYuHwVtvkL2QAz0B7CVpoPpzM4yh7j16
	Kcf2hpMDPF0BznQgHrEItCN+QTpmCFjfkqSoS3yTCcrrU/I9dNd1uFh3y9sOjIb1VhkoNU8
	brUAUb3KdvQMQR2I+0v9MqV8Yk07dxGZYdbASb3E99jR+cE7zODiMHgvOnbT4smlcC/iu1a
	Uj0u+lyC5QkzpFdhyWA+x6ahG+5Vsze3C6EFGNKqXmKSEf7VIzWYOcdi7kJD/tu/OyIBp7P
	uUyu77qhILvzgmqbg3qN+rLjV6ZNcPeYK6ZdPuQOXRLMMaJr8VQobGhUSIh2K9Vq8mZldl5
	51Wlr5KYyOcKMDh7O5HMXMQDCwCrAfSXeLg/s3fOw6x5lD7FywoKfU4fdaD7AAVZ8vyygAy
	UotlQp6ZI2vhjAaef08Iw7r2FeNDFEHdmpormDWHEk59i+vJOGThJZOBASjgz+mEQslMPti
	N7y2F7VR09AfXKaVf/cOF0BFPhIio8tA3zVMDBkxf9gRP77ZEly7zIoPTVvMEreczdzU3th
	zr0ch/vBaS4kB1hKZiVaeUuY0DZN3CS3fStjKAs5XiL5x8IKpWjm3EWlRzIX+Q4km7t9+V0
	AKMcFGWabooSEru0MHdJ4G1c+wnYCgOtqKAcWb7hQ3ZKN9CF9M9Gf7+JETdub7poZji1j/Y
	PsBkhcfI7mEzun5iycJiWmsGRPnEi0pmzPO75LWiOxoZDSZyxqpGT4WGshJ9Q/DmCoydr9l
	njG8hC5BCaNrGQMMATSd4y9/V4J0uZhwpEzWncCJjrrVTddEO9ECEL8eTtqKI6tSdP7+pgd
	hrF/OSaeVGDIW4/noOJBEcy8fkYGBnNYZuQl6Khf+jiD2A4bcHbRN45A+AuhFBKP83v3pbl
	Yaw30aSWMQ1/Y63Q0vnUOqnPVyd9PknHp2cUPsF4CITUW89A/j2hbb9ybiEwWm0K/u5/00r
	cFz+EYMmEQhNbmg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: E3E83565727
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10495-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
Changes in v6:
- patch 2/4: rewrite commit message per Frank Li review (avoid "this patch",
  use imperative mood, update subject to better describe the refactoring)
- patch 3/4: rewrite commit message per Frank Li review (remove "This patch
  adds", use imperative mood)
- Link to v5: https://patch.msgid.link/20260507-k3-pdma-v5-0-6b9743038026@linux.spacemit.com

Changes in v5:
- drop patch 4/5 (has been merged)
- add Conor's tag
- Link to v4: https://lore.kernel.org/all/20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com/

Changes in v4:
- patch 4/5:
  - add Brian's RB tag
- patch 1/5:
  - update commit message
Link to v3: https://lore.kernel.org/all/20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com/

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

To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Yixun Lan <dlan@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: dmaengine@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: spacemit@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

---
Guodong Xu (3):
      dt-bindings: dmaengine: Add SpacemiT K3 DMA compatible string
      dmaengine: mmp_pdma: refactor DRCMR access with helper function
      dmaengine: mmp_pdma: add SpacemiT K3 support

Troy Mitchell (1):
      riscv: dts: spacemit: Add PDMA controller node for K3 SoC

 .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  4 ++-
 arch/riscv/boot/dts/spacemit/k3.dtsi               | 11 +++++++
 drivers/dma/mmp_pdma.c                             | 37 ++++++++++++++++++++--
 3 files changed, 48 insertions(+), 4 deletions(-)
---
base-commit: 02f90981a67f3b9ee7d6684e7503a4fed7aade0c
change-id: 20260317-k3-pdma-7c1734431436

Best regards,
--  
Troy Mitchell <troy.mitchell@linux.spacemit.com>


