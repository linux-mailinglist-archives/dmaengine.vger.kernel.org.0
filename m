Return-Path: <dmaengine+bounces-10261-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DzrAsdr/GmMPwAAu9opvQ
	(envelope-from <dmaengine+bounces-10261-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 12:39:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A57664E6E6B
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 12:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 717503012D47
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FEF3EB7E5;
	Thu,  7 May 2026 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="pPm9zhAA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-usa1.onexmail.com (smtp-usa1.onexmail.com [52.205.10.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910D3EBF06;
	Thu,  7 May 2026 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.205.10.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150286; cv=none; b=E9fRqabVj9txi1iwGl3cfEs3C3ihC7X+fxz1+aZg+SIwv4pQwfe/AOfqf93fnUh41gcRAlNZ1qgiEaLdlvWqSnCGDicQF4RZCCUh0OBuN+jj3PH9F9VlAZr+oTn5JqUJ9OLm50+9yWWGWU9oIDf4E7KQv2H0bg7ZMjcnsYZVzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150286; c=relaxed/simple;
	bh=ldqSgxXBwNiVbDM1IvgqKUTueYaDUJx3Byc33LhWAOM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=punMsRCI/bKnp6jzbGcWE81dCRfYHTAaSm5TQ2B5ZfYIoASG+8gIJ6wZswwHeEGxuh5N7J+e1Z/JuQk3bFvArzJeysf2REAibAnkmZZ4nuHxwy5RuwsRQA6nP99Mmyyw+BnfqmYkzjaCw7wNYWBJu9HcVoe3gQSQzVnQz9wHxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=pPm9zhAA; arc=none smtp.client-ip=52.205.10.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1778150196;
	bh=U2qvUhvca7YAn4TE9hm8vvaV7bUDGvf9K7jZFzPWNAI=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=pPm9zhAAlXtpOm6BoZX4qYpXhwjvB+FCQzQ8gujrpM3bnIz3Ez2FM3tCJ3y4nFDd8
	 +H83HN+6oz/1X5jDXjaI40C1kHAWzKGdHhkXhXyohRbDIOFRARU8U1/L3Sl7l8Hax3
	 bAct4QzPrTSStplLcpU3GhsUydp2jDNEE6dNCVGc=
X-QQ-mid: esmtpgz10t1778150187tf7d04fee
X-QQ-Originating-IP: yFNw69ncz+AtuuWyoTlmv2W5F2yGPj6skwsJzi6XUCo=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 18:36:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9081812575552162141
EX-QQ-RecipientCnt: 21
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v5 0/4] dmaengine: Add Peripheral DMA support for SpacemiT
 K3 SoC
Date: Thu, 07 May 2026 18:36:19 +0800
Message-Id: <20260507-k3-pdma-v5-0-6b9743038026@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMSw6CMBSF4a2Qji1pe1sqjtyHcVDKRRrlkRYJh
 rB3CxNM1OF/cvLNJKB3GMgpmYnH0QXXtTHUISG2Nu0NqStjE8FExoBregfal42h2nINUgKXkJH
 47j1WbtqkyzV27cLQ+dcGj3xdv42RU04ryEvAXBcKzPnh2ueUht5YbNyQ2q4hKzaKD0BkOyAoo
 9bk0hpdFCpXfwHYASnkDkAEsCorgZJLw44/gWVZ3qmLEAQpAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778150183; l=3272;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=ldqSgxXBwNiVbDM1IvgqKUTueYaDUJx3Byc33LhWAOM=;
 b=crauHPeI0mIdx6vwQqL8WvpzOBga3EoQhdCyHmS5ieLVfZc/nzjT1BuCoHxHx4CdvoQTArni9
 bLTzDEmaHzJB57b4mqdcIVF/sCejA68rcVo9Di7dCHMen4zWLdftqNh
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MpCQQy/6khKPen/hkdZhEGd2VxONjZrFsrRw3OeICzwgyhhhjPF+jdCw
	MT91bCLgpE/gz5kS/sE4AyjuU037MtZmSg2MociK431sCQEa6Z2jwp6t/d/zl5Su7gNGu2K
	60rCWrUaXvt3Xdr/xK5byV5ahtZLpnw/k6DLnfbo+tsx0pARZJC5GUjzp4kCuOf/uhJlBli
	S9uUddS2810LkfNEbp3oL1BR2LCbjBtoafO5NxwN5tdGDysgnw7zV2tNGerUDjRXsXg248K
	UBRcs7WJHkJJKYGjYPshIUBumi0Xs+m34udyfj+t01dAVVQIaJgx6YHLd9Wr62MO+68VPR/
	VaLbuQSThUaUb/RC0R/LBw25aJCjlTlxsTrCH85zZFTLjP02E20avloSfxfk+pD1U0MXJwJ
	c8UK2eVXAfJQTzgP6eOg2e4dhDbuFHKdGhpubbvO1vplhdrC0sg35kI/sBT2OUSR2L25REb
	eVgnYruAGzg7AlxvFeZ14kUOflT1tyStQIDXzKubXHiSrNdoTBdhKVLyaeQTmv53wAVefI6
	iXXX9BmLnq3CrHl3rqfsNddnBtt9YR9c3yFX0jtFQzzbtKJzubyKlwjZAiKYsWd0VMEAKIr
	bvjHHBcGbnuXE0GFJ0jFuOvu+HnI+aSgLgGRhh3MmQZWJmqpXEIXzxGS3Z1cnpb5IxPH5KE
	1kr1bVswc5gat9kDmFq1naCPmL441FQCj9hfGzbjf2hPpoFD9vQELohtSVYcqhEa9DQRvUM
	Zm+LRaHHsbhSa9hLsTVb/IaP16lIscBNp7MZ+CInl4gQu4zkedwgf80esQ5kKDn1LZc9Hu2
	l0Wybd4F1L+cIwmw1SrR4u1+C6oYnCd+TO4w8UHDFjrd1iEmlEmrzV25224AkRy2UBbWVes
	vyNjkFN76eWVDrmClNVEMWV5XhKQqwZaMpu/+TXSa1vQEI0koLBiLqiNGn7xXy4fQDnH9fv
	CPtEY7hJsuOtGy7MOKSokujH0vr9GQuJ7nV/vOqsqhs+NRL70k1VC4bJ0Q2MgIKGUrSuTeL
	FcjS/YeiBmjA60g+bbVjCYhtgVx3WqsA5ijz2bFiq1dCI6zRWMcSAEkypKtidEZweI84CXR
	seUUM8fAjca6AaS3HGzVlBSPSRaBrCmffivuMSW5OJk7Vyo9UivP5U8N9YvUGD2eg0odJJv
	rK+d1kGuXhb7NvP4GKCuAdbw5o1WqJSUyLSoklh6MwfZjWu/mR7rZZ/bBif1oKZOoKH6w++
	U53Fp9ek=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: A57664E6E6B
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
	TAGGED_FROM(0.00)[bounces-10261-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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
      dmaengine: mmp_pdma: support variable extended DRCMR base
      dmaengine: mmp_pdma: add Spacemit K3 support

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


