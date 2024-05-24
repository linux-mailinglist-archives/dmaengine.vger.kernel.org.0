Return-Path: <dmaengine+bounces-2148-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC358CE41D
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2E42822A3
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032B84FD4;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAqGC0hG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D81AACC;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546288; cv=none; b=DzTDgZWySEsNFPKCYPMjBBODCgr/9GtP3pCBBCehNHeohP/aFVfjbDfc9Az98xiLMrIIXT84KadT3RYg6f2uIG77Yh/9vJWvOiJyH3OWNch7XovMrWFAKW4nFwtblrFwR7hPuS+Zt+CHtmwK5bD+vkT/In69qRQEOZh7xViu5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546288; c=relaxed/simple;
	bh=CrQprNIxi//+Z+cGBKn4Waq6Mg5oFx7AbnKkwtEfBjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RYKFmjQxIEXN2fva7dqmqUAJ9sxUwL9QLUAX/hKzptSe2KYuwqrD+edTJTULF3UiUlT5mt2p5mPMTYEUF7LdC4tdDvEoH4wj7zlFD8mt2lJ2QMgrQkI7NCM43upJRyZj+YkAdBouXrBHzZxs4A7qCqFUbZJ+QGHGBwo8fmTLXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAqGC0hG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28DC6C2BBFC;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716546288;
	bh=CrQprNIxi//+Z+cGBKn4Waq6Mg5oFx7AbnKkwtEfBjE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RAqGC0hGsdNnBS950pwn3rxjLsPNlgBr0hVIJZ+D8q49AIWu0oGDaE4NEdc0IMkqF
	 qvImZydjAdd38203rVlMxR5BqTW0/ME5TLrGdBVnglaWgHML+4IEf2RX5BrFObnT1S
	 CErkZ7N7YMgnRi4BKJj1Kr70NZ0/rI42uBW2cR8yujszsGpykFfUT48/WVnweim5ek
	 TyjLPFBSjcC7FK1Cw4KpXR58r9fx8UnV2Eh+IbYJMgbqEwN4Gp6s5Iu9YJrHjxfDyk
	 iwk2/woiU17I5aLgbZ4CWT4TA6aYaTIX5aVlDtxFRFfDohP0tFmlXy31FcJY1Cb3k6
	 tChdZqEFN0bjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5FEC25B74;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Subject: [PATCH 0/3] dmaengine: ioatdma: Fix mem leakage series
Date: Fri, 24 May 2024 13:24:45 +0300
Message-Id: <20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadro.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO1qUGYC/x3LywqEMAyF4VeRrCegRfHyKjKLtI2ahVUSGQbEd
 7e6/M/hO8FYhQ2G4gTln5hsKUf1KSAslGZGibnBla4uG1ejbHTElXCSPxtSN4UQqfex7SEbT8b
 olVJYHrWSHazPsSu/Iq/j97puo6NkF3gAAAA=
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Shubin <n.shubin@yadro.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716546287; l=737;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=CrQprNIxi//+Z+cGBKn4Waq6Mg5oFx7AbnKkwtEfBjE=;
 b=A65t7okArOSAbkRGfS8XIdJSEtnY1eofhkJ67p2bUVcBKNM65EhPIQlRCcHuefQIRXEYGuxpkcqb
 0pfpc8vLCljl7kZuHmzGmBpIfRBGq9Rsje3JoDhhpHnxKDR4oszc
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

Started with observing leakage in patch 3, ivestigating revealed much
more problems in probing error path.

Andy you are always welcome to review if you have a spare time.

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
Nikita Shubin (3):
      dmaengine: ioatdma: Fix leaking on version mismatch
      dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()

 drivers/dma/ioat/init.c | 55 ++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 26 deletions(-)
---
base-commit: 6d69b6c12fce479fde7bc06f686212451688a102
change-id: 20240524-ioatdma-fixes-a8fccda9bd79

Best regards,
-- 
Nikita Shubin <n.shubin@yadro.com>



