Return-Path: <dmaengine+bounces-8686-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKAAJU/rgWkFMAMAu9opvQ
	(envelope-from <dmaengine+bounces-8686-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:34:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AC2D910D
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6BB7300EA8C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D3342C94;
	Tue,  3 Feb 2026 12:30:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7F238C08;
	Tue,  3 Feb 2026 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121840; cv=none; b=IhzlkWriKkQOktjnHNXnDnoEfTOjIQiyr6ebdzZIB+E85gNEq7gMRb5Gndgm69lReGxMMPaOGSP4b3TYqoAuwMhGul/m5CPnlrA++ht+zC1v9b2/Ah2vQ7v/DSafIBRzL6BtsnO4KhskyClBX60f4pYo/5mZGYvfzLoIuue1+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121840; c=relaxed/simple;
	bh=xSkZGHYDhEC58xgVczwO2WAMqB7U1AW/5NWYBqSZbOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+0tf7AXDE/83SPAcT09NKY0qTPD02W2kzImOb8DAQob8v6roEcYzmgYOBATm0xyoZIk4TqasB71NLyj6NapxHyra+ahPYpr9pRQdPoj5Fq/mZ8f2z5ICm+q5I/PPMJK4+98KZGQrpyFVXM4nxAnC3bTavj5hCwcBwyVhFpIJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8DxPMNo6oFpHF0PAA--.49668S3;
	Tue, 03 Feb 2026 20:30:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJBxKMFl6oFp7RY_AA--.38493S2;
	Tue, 03 Feb 2026 20:30:31 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 0/3] dmaengine: Add Loongson Multi-Channel DMA controller support
Date: Tue,  3 Feb 2026 20:30:09 +0800
Message-ID: <cover.1770119693.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMFl6oFp7RY_AA--.38493S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEHCGmBjh4H5QAAsW
X-Coremail-Antispam: 1Uk129KBj93XoW7Wry7XrWUKFykZw48Gry8Zwc_yoW8Aw4rpF
	43A3yS93W8tFW3Aas3JFy8Ary5Aa4fJr9rua9rXw1Uur9xZ34UZr1rKFyjqFW7Ary7JFW2
	qFy8GFWUGF17GwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jnUUUUUUUU=
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8686-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:mid]
X-Rspamd-Queue-Id: 04AC2D910D
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

Binbin Zhou (3):
  dmaengine: loongson: New directory for Loongson DMA controllers
    drivers
  dt-bindings: dmaengine: Add Loongson Multi-Channel DMA controller
  dmaengine: loongson: New driver for the Loongson Multi-Channel DMA
    controller

 .../bindings/dma/loongson,ls2k0300-dma.yaml   |  78 ++
 MAINTAINERS                                   |   6 +-
 drivers/dma/Kconfig                           |  25 +-
 drivers/dma/Makefile                          |   3 +-
 drivers/dma/loongson/Kconfig                  |  38 +
 drivers/dma/loongson/Makefile                 |   4 +
 .../dma/{ => loongson}/loongson1-apb-dma.c    |   4 +-
 drivers/dma/loongson/loongson2-apb-dma-v2.c   | 759 ++++++++++++++++++
 .../dma/{ => loongson}/loongson2-apb-dma.c    |   4 +-
 9 files changed, 890 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
 create mode 100644 drivers/dma/loongson/Kconfig
 create mode 100644 drivers/dma/loongson/Makefile
 rename drivers/dma/{ => loongson}/loongson1-apb-dma.c (99%)
 create mode 100644 drivers/dma/loongson/loongson2-apb-dma-v2.c
 rename drivers/dma/{ => loongson}/loongson2-apb-dma.c (99%)


base-commit: 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
-- 
2.47.3


