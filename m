Return-Path: <dmaengine+bounces-9311-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAk3L7uaq2kLewEAu9opvQ
	(envelope-from <dmaengine+bounces-9311-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 04:25:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4FD229DF1
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 04:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6508230480B4
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2026 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265930DEBE;
	Sat,  7 Mar 2026 03:25:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F0A309DC4;
	Sat,  7 Mar 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853941; cv=none; b=EQR6jVIO6DK3rpkVuL7ESoUnLHavNwMYI8UI0j1oLw5JuT6l3U/v80LGlcC2A9Rb4i3vbFn7+3LtWLCBCFU8TaS3qNSA3BEc9YXzb8szSxz0SQPH2XuQd54i3nlo1dhe3ECYflQb0pITIx0A4VaoQPnWSKAIr6n9Un6hkYo6rBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853941; c=relaxed/simple;
	bh=Xi6c1dAck5ti3ckerzYqQncj4PWvRvHDU6pbAFkcqmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjOcVKIE7ETwyW25ntNJqbZ8d4puDtxiofe0AEEYUkZxnf7jiQNNPVXSKnll8F2ozPhgdI6l/C09bWWqbjgs44i+EkhFOlNmmPi+wWnPoVlO7B6+oyXpdvix95Nxu9m80++qQXCKigNEKAThlW13J5SHRZpDTBdE8tgEPWAozAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8CxacKpmqtpC2cYAA--.6584S3;
	Sat, 07 Mar 2026 11:25:29 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJCx2+ClmqtpI+BPAA--.21248S2;
	Sat, 07 Mar 2026 11:25:26 +0800 (CST)
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
Subject: [PATCH v4 0/6] dmaengine: Add Loongson Multi-Channel DMA controller support
Date: Sat,  7 Mar 2026 11:25:09 +0800
Message-ID: <cover.1772853681.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx2+ClmqtpI+BPAA--.21248S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQETCGmqbMIYzgAAsg
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1xtry3ZFy7GF43CF1xJFc_yoW5KFW7pF
	WfA3s3GFWUtF43uwn3JFy8Ar15Aa4fJrZxWa9rZw1UCryDu3yUZr1Fk3WjqF47ArW5GFW2
	qFWkGF48CF4UGrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
X-Rspamd-Queue-Id: 6D4FD229DF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9311-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,loongson.cn];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.893];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
V4:
- Rebase on dmaengine/next tree;
- Add Reviewed-by tags from Frank and Rob, thanks;

patch(1/6):
 - Add `depends on` restrictions.

patch(6/6):
 - Move loongson2_cmc_dma_config{..} close to its users.

Link to V3:
https://lore.kernel.org/dmaengine/cover.1771989595.git.zhoubinbin@loongson.cn/

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
 drivers/dma/loongson/Kconfig                  |  41 +
 drivers/dma/loongson/Makefile                 |   4 +
 .../dma/{ => loongson}/loongson1-apb-dma.c    |   4 +-
 drivers/dma/loongson/loongson2-apb-cmc-dma.c  | 730 ++++++++++++++++++
 .../dma/{ => loongson}/loongson2-apb-dma.c    |  93 +--
 9 files changed, 903 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
 create mode 100644 drivers/dma/loongson/Kconfig
 create mode 100644 drivers/dma/loongson/Makefile
 rename drivers/dma/{ => loongson}/loongson1-apb-dma.c (99%)
 create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
 rename drivers/dma/{ => loongson}/loongson2-apb-dma.c (91%)


base-commit: c8e9b1d9febc83ee94944695a07cfd40a1b29743
-- 
2.52.0


