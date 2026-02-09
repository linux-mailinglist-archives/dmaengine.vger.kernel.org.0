Return-Path: <dmaengine+bounces-8818-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k61OHjFPiWm66QQAu9opvQ
	(envelope-from <dmaengine+bounces-8818-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 04:06:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA910B4EC
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 04:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59DB30086EB
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 03:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207212EAB83;
	Mon,  9 Feb 2026 03:04:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E9A2DC76D;
	Mon,  9 Feb 2026 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606293; cv=none; b=jZLS+Rn9xiYcKRLvY7Zuliu+kmh28pJbfAaU4sZ/NegZ5WgpTKFDrbZOG/MP9I3uior180029/kNmWTobPvo9sD/aPDaJY5Nx+XG/6sYocHmKgDh2rHt4bshI1ziR/F2HxEx6vZJOxp2gYOLceXnE4w2+fcPNSUwEaoMucP7aqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606293; c=relaxed/simple;
	bh=fOmFJPTksruQkzf0HAcoJG692hnq4KsDfAAc6zmJGbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7w4+WucQpxmW8Hes7t7i/XB6ZvidUMxhfRaOkHMHSIy8x++0lCzFalPlUz3+pYgo7k2dBWslWnhaYf1RZV/y1dtC2+P5ThlNMXbt/vg/4KnzAvf7g3Ktatvssh/nmcCXsJWNQGFdj+gThjQCx6vy/ohyerzfnuKe0hpf01Wi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8AxjsPLTolp+PgQAA--.54927S3;
	Mon, 09 Feb 2026 11:04:43 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJBxKMHHTolpRO1CAA--.46046S2;
	Mon, 09 Feb 2026 11:04:40 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org,
	jeffbai@aosc.io,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 0/4] dmaengine: Add Loongson Multi-Channel DMA controller support
Date: Mon,  9 Feb 2026 11:04:17 +0800
Message-ID: <cover.1770605931.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMHHTolpRO1CAA--.46046S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQENCGmIJbsGnQAAsh
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1xtry3ZFy7GF43uFy5ZFc_yoW5GryUpF
	WfA34SgFyUtFW3ua93JFy8Ar15Aa4fJr9rua9rJw1UCr9ru34UZr1rKFyjqF47A34UXFW2
	qFy8GFWUGF1UGwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jnSdgU
	UUUU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-8818-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,aosc.io];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:mid]
X-Rspamd-Queue-Id: 22AA910B4EC
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

Binbin Zhou (4):
  dmaengine: loongson: New directory for Loongson DMA controllers
    drivers
  dmaengine: loongson: loongson2-apb: Convert to
    dmaenginem_async_device_register()
  dt-bindings: dmaengine: Add Loongson Multi-Channel DMA controller
  dmaengine: loongson: New driver for the Loongson Multi-Channel DMA
    controller

 .../bindings/dma/loongson,ls2k0300-dma.yaml   |  78 ++
 MAINTAINERS                                   |   7 +-
 drivers/dma/Kconfig                           |  25 +-
 drivers/dma/Makefile                          |   3 +-
 drivers/dma/loongson/Kconfig                  |  38 +
 drivers/dma/loongson/Makefile                 |   4 +
 .../dma/{ => loongson}/loongson1-apb-dma.c    |   4 +-
 drivers/dma/loongson/loongson2-apb-cmc-dma.c  | 736 ++++++++++++++++++
 .../dma/{ => loongson}/loongson2-apb-dma.c    |  11 +-
 9 files changed, 870 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
 create mode 100644 drivers/dma/loongson/Kconfig
 create mode 100644 drivers/dma/loongson/Makefile
 rename drivers/dma/{ => loongson}/loongson1-apb-dma.c (99%)
 create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
 rename drivers/dma/{ => loongson}/loongson2-apb-dma.c (98%)


base-commit: ab736ed52e3409b58a4888715e4425b6e8ac444f
-- 
2.52.0


