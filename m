Return-Path: <dmaengine+bounces-9047-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NcWLp2nnmmrWgQAu9opvQ
	(envelope-from <dmaengine+bounces-9047-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 08:41:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9220E193A00
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 08:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECE1430219FB
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B03019C5;
	Wed, 25 Feb 2026 07:41:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F922FFF9D;
	Wed, 25 Feb 2026 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005270; cv=none; b=Q2r0/N5PEr/FBBEgGVW0VpLVoV2eHzPezJeBNGLwUv9yoGx0iVrgU7RJeieeDb1GChVZVVvyNfhcukKC2AY65neo09M4kcXjmnv5QN8b4LaRho8Q+Md9Txdr2fv3RK+VDSUZwHbPo7AFQ9DZO7Du0T4LAEbZjHiX9s1w5w741W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005270; c=relaxed/simple;
	bh=eSrkXWy9BCRtHLzgve84b/vlDP4sX8winZUWhH7FZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEELmf4gkSVqN5GJz/gTxI44XplVe49IyuFaM8Yu2H5x9q3jmVqbTVPaLlpalZKifPOJA2lvTcjs4wPYVeA+X7PDDrTnr4dX2XV9SpDKl7VMxZIA70MWxM3w9AUBPL1i4UEbJObkNjYrZOy60UzuCJmjuKFUCiVeAA+E9QOiQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8Dx_8OKp55p3P0UAA--.64606S3;
	Wed, 25 Feb 2026 15:40:58 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJCxGOCIp55pFMRKAA--.9627S2;
	Wed, 25 Feb 2026 15:40:57 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 0/6] dmaengine: Add Loongson Multi-Channel DMA controller support
Date: Wed, 25 Feb 2026 15:40:38 +0800
Message-ID: <cover.1771989595.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxGOCIp55pFMRKAA--.9627S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEJCGmejz8BiwAAsM
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1xtry3ZFy7GF43Kr48GrX_yoW5ur4xpF
	WfA34fCFWUtFW3uwn3JFy8Ar15Aa4fJrZxWa9rXw1UCr9ru34UZr1Fk3WjqF47ArW5GFW2
	qFykGF48CF4UGrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9047-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,loongson.cn];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9220E193A00
X-Rspamd-Action: no action

Hi all:

This patchset introduces the Loongson multi-channel DMA controller,
which is present in the Loongson-2K0300 and Loongson-2K3000 processors.

It is a multi-channel controller that enables data transfers from memory
to memory, device to memory, and memory to device, as well as channel
prioritization configurable through the channel configuration registers.

Additionally, since multiple distinct types of DMA controllers exist on
the Loongson platform, I have attempted to consolidate all Loongson DMA
drivers into a new directory named `Loongson` for easier management.

Thanks.
Binbin

===========
V3:
- Rebase on dmaengine/next tree;
patch(1/6):
 - Keep alphabet order;

patch(2/6):
 - Add Reviewed-by tag from Frank, thanks;

patch(3/6)/(4/6):
 - New patches, format loongson2-apb-dma driver code;

patch(5/6):
 - Add description for `interrupts` property;

patch(6/6):
 - Use ffs() helper make the code cleaner;
 - Refact loongson2_cmc_dma_chan_irq();
 - Simplify locking with guard() and scoped_guard();
 - kzalloc()->kzalloc_flex().

Link to V2:
https://lore.kernel.org/all/cover.1770605931.git.zhoubinbin@loongson.cn/

V2:
patch(1/4):
 - Update loongson1-apb-dma.c entry in MAINTAINERS.

patch(2/4):
 - New patch, use dmaenginem_async_device_register() helper.

patch(3/4):
 - `additionalProperties: false` replaced by
   `unevaluatedProperties: false`.

patch(4/4):
 - Rename filename as loongson2-apb-cmc-dma.c;
 - Rename Kconfig item as LOONGSON2_APB_CMC_DMA;
 - Rename the variable prefix as `loongson2_cmc_dma`;
 - Use dmaenginem_async_device_register() helper;
 - Drop 'dma_' prefix in struct loongson2_mdma_chan_reg;
 - Use struct_size();

Link to V1:
https://lore.kernel.org/all/cover.1770119693.git.zhoubinbin@loongson.cn/

Binbin Zhou (6):
  dmaengine: loongson: New directory for Loongson DMA controllers
    drivers
  dmaengine: loongson: loongson2-apb: Convert to
    dmaenginem_async_device_register()
  dmaengine: loongson: loongson2-apb: Convert to devm_clk_get_enabled()
  dmaengine: loongson: loongson2-apb: Simplify locking with guard() and
    scoped_guard()
  dt-bindings: dmaengine: Add Loongson Multi-Channel DMA controller
  dmaengine: loongson: New driver for the Loongson Multi-Channel DMA
    controller

 .../bindings/dma/loongson,ls2k0300-dma.yaml   |  81 ++
 MAINTAINERS                                   |   7 +-
 drivers/dma/Kconfig                           |  25 +-
 drivers/dma/Makefile                          |   3 +-
 drivers/dma/loongson/Kconfig                  |  38 +
 drivers/dma/loongson/Makefile                 |   4 +
 .../dma/{ => loongson}/loongson1-apb-dma.c    |   4 +-
 drivers/dma/loongson/loongson2-apb-cmc-dma.c  | 729 ++++++++++++++++++
 .../dma/{ => loongson}/loongson2-apb-dma.c    |  93 +--
 9 files changed, 899 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
 create mode 100644 drivers/dma/loongson/Kconfig
 create mode 100644 drivers/dma/loongson/Makefile
 rename drivers/dma/{ => loongson}/loongson1-apb-dma.c (99%)
 create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
 rename drivers/dma/{ => loongson}/loongson2-apb-dma.c (91%)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.52.0


