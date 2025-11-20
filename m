Return-Path: <dmaengine+bounces-7257-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D07C73CDD
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 459984E5A85
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65822F7ACC;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO0TNwht"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECFC27AC45;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639159; cv=none; b=SFKQhaRmd5Z/KqMDYsxOndnx0LfGngAhkwEi3JPmxoSBYAHHISHi0k7DhuEUdEakKuDGcA745DtgQti3RU4c3hqEDWVvXGt7K+GMWXifTdMvGK/Y4w/dtmBhcfEY7mHo0UEWSlzRnL+7XBQtkxwtbwiz52+hSfaK17X8vzdE+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639159; c=relaxed/simple;
	bh=9kPMABRFIrIrkEv9ANxDl76NY3lYwvP2nyb0kKALLVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqtZxtGc2wB92EKBY1c+H9CJp/TfOrCdM5F89h8Z8IrCOkRCqsmq5o+b0YeUVJxq2WQHncK6G9Dc2z+323WU691SWrmvOD6gOWgcz/4kgdTimgsPIJXk4KdrbRikG9mF2aYe3/pHSc0Axv7WjSC7JVoN/bvbrInZrT6zwj4WdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO0TNwht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAAEC19424;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=9kPMABRFIrIrkEv9ANxDl76NY3lYwvP2nyb0kKALLVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DO0TNwhtVAqyQA6RAZUhKZjs5xJ98OiwaSqMDahBJOXKOsMwOTBpdCHd0aM84tQ5q
	 okZDzIalk0OMMEp5y0O6883asf2qMTrc1MdXI1cvWjXIKWd2xvGhdHY5VBIpzQdN/V
	 9NyzEB5c1WGEW+HTL2flExy8SVeewZmqAtUYu9Y4FE72B0DnzhEMpZAsszWPE1VGh2
	 c0bkSUdhqrGaWyCuow295KKu0wG2tv8cVp4s/MZ+EGJc5xiCMSXcuaGuDBmJKweuVv
	 hDpvcoCzrgf4ANNdB0FIxhdS0r8JZpUHTusaF0ZIQbihZg4pgpiVcOOdU/yWaD7qko
	 /KuPDT5/guIGw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36t-000000002Cw-1c2A;
	Thu, 20 Nov 2025 12:45:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/9] dmaengine: bcm2835: drop unused module alias
Date: Thu, 20 Nov 2025 12:45:16 +0100
Message-ID: <20251120114524.8431-2-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120114524.8431-1-johan@kernel.org>
References: <20251120114524.8431-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probe so drop the unused
platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/bcm2835-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 0117bb2e8591..321748e2983e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -1060,7 +1060,6 @@ static struct platform_driver bcm2835_dma_driver = {
 
 module_platform_driver(bcm2835_dma_driver);
 
-MODULE_ALIAS("platform:bcm2835-dma");
 MODULE_DESCRIPTION("BCM2835 DMA engine driver");
 MODULE_AUTHOR("Florian Meier <florian.meier@koalo.de>");
 MODULE_LICENSE("GPL");
-- 
2.51.2


