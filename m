Return-Path: <dmaengine+bounces-7321-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF50C8092E
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86F24343F44
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7630148A;
	Mon, 24 Nov 2025 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="ocCJdz60"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2A3009ED;
	Mon, 24 Nov 2025 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988636; cv=none; b=YcxY/sUTVOsbfXGqrLv6xzVxAyBy4jGUL4ySHmdJrQo7XzTSCUZz2pbdVKFm++09+EdbxqetWY3uvef4pi2QrM7ECbGiGNXv5rmtT+JUF7c+FvLGRqId3sX5uDO7bBbiRK81XscXRKOrNfuV0IIXW4wtEElbbAr8gd7hTlCDdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988636; c=relaxed/simple;
	bh=BaqG+ncA4e6jPTLXGj38TJPyzRCYGVfmkhU4oOz1CUk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qa6XciMxG17UFIjCx6NaViX5vIxouv8WdX5598OG8hrAC/XtBnDyqBggh93emQuCx2X+V2Q+WGyOu+EFCx3M/ScAZlz0x8aXoYreip7kYgwltbO1VTZkbK1LFqFvCeWhZGeisJ0ztNU7dlG5bYJ0Pp1uQVJfBuBP0qvAJrYov1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=ocCJdz60; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCD29442B0;
	Mon, 24 Nov 2025 12:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1763988625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W5926LvFRqXES9Meu0EUUgUHy4p8Z6V+TT02fhE4MHI=;
	b=ocCJdz60FjHaM+ZEJvXxQ9T1XOBfGdtDJyk5GkWBe4Jkbhwo04TgRdLAGih1OQFWEtnStB
	tV4cfZEbNrKqe6Yg0NeBFB0RBUblM5/Ak/Jxi3kH6did7jk+IU1oUW2v+MsvCoR2Cj67KR
	o1gvdLE8PXCXkWSeeNBr3Bs+hJCnWLceHSwTnwuWUS261fPLI6Az1VHxZlQXn16hcL0fpn
	CIynIp+9XaVobsMyb4qpuDOlYDD2Gq97trWIrAxGpWqQY7IVFZTHF3MHMQpoc24IYsj+m+
	J7XOYdvM1M8Nf2kDsBHU6+xXXbX/d6M7orVni7G8eI/i8bhcimkO8Om5KD5Vjg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH 0/7] dma: fsl/mcf-edma: Bug fixes and enhancements for
 ColdFire support
Date: Mon, 24 Nov 2025 13:50:21 +0100
Message-Id: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1UJGkC/x3MQQqAIBBA0avIrBtIzRZdJVqYjjVQGgoRSHdPW
 r7F/xUKZaYCk6iQ6ebCKTbIToDbbdwI2TeD6pWRUmn0p0WXDh84E5qgR0skB71qaMmVKfDz7+b
 lfT8OBzYrXgAAAA==
X-Change-ID: 20251123-dma-coldfire-5f36aee143b3
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763988624; l=1829;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=BaqG+ncA4e6jPTLXGj38TJPyzRCYGVfmkhU4oOz1CUk=;
 b=Fxs1DZlsqwRCapYlWQSXqfJsbrfVlGZrT6bjmqm46WsGu4wjs2yJwd65eXhY6P2NKfjlmEfkm
 iPFA+GgIN92A2Hgn/lEuy4b8mQbXX+KUEphIaaCLZzgQtWpaCyIUTd2
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeduteehgeeihfelleelkeetkeetvefhvddugeduvddvudegheelkeeltdfftdehjeenucfkphepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgspdhhvghlohephihoshgvlhhiqdihohgtthhordihohhsvghlihdrohhrghdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepkedprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhrtghpt
 hhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

This series addresses several bugs in the fsl-edma and mcf-edma drivers
affecting MCF54418 ColdFire processors.

Patch 1 adds a write barrier after TCD descriptor fill to ensure proper
memory ordering.

Patch 2 adds the FSL_EDMA_DRV_MCF flag to fix byte-lane addressing for
MCF54418.

Patch 3 adds per-channel IRQ naming for easier debugging.

Patches 4-6 fix the interrupt and error handlers for all 64 DMA
channels:
- Patch 4 fixes the interrupt handler to process all 64 channels
- Patch 5 moves the error handler out of the header file for clarity
- Patch 6 fixes the error handler for all 64 channels with proper types

Patch 7 adds source stride support for interleaved DMA transfers,
enabling memory access patterns where source samples are not contiguous.

Tested on a custom MCF54418-based platform with slave DMA transfers.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Jean-Michel Hautbois (7):
      dma: fsl-edma: Add write barrier after TCD descriptor fill
      dma: fsl-edma: Add FSL_EDMA_DRV_MCF flag for ColdFire eDMA
      dma: mcf-edma: Add per-channel IRQ naming for debugging
      dma: mcf-edma: Fix interrupt handler for 64 DMA channels
      dma: fsl-edma: Move error handler out of header file
      dma: mcf-edma: Fix error handler for all 64 DMA channels
      dma: fsl-edma: Support source stride for interleaved DMA transfers

 drivers/dma/fsl-edma-common.c | 14 +++++++++
 drivers/dma/fsl-edma-common.h | 11 ++++----
 drivers/dma/mcf-edma-main.c   | 66 +++++++++++++++++++++++++------------------
 3 files changed, 57 insertions(+), 34 deletions(-)
---
base-commit: d13f3ac64efb868d09cb2726b1e84929afe90235
change-id: 20251123-dma-coldfire-5f36aee143b3

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


