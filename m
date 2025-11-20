Return-Path: <dmaengine+bounces-7262-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC35C73CB7
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EA6DB2A85A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144A32ED44;
	Thu, 20 Nov 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcWdu9K8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF4302CB0;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639160; cv=none; b=q+7iYqtvDMXRM9ns/1nf15EF+WegITSfkm3ugOudXulnisbRBk/p8hJCSKe2/vM6GOJu62MsJ6TZNYLLh3+T21vO+jxcIl6/7VB3BtCy/Zc8WX2aj9f4rqg/jSwi2fhUf2Sg9CGGboekZxzBY30aeQ5IYjpnsAGyrLElUPKhsoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639160; c=relaxed/simple;
	bh=I4xIQ7jL3cs2Wam+tyw6wArNl9Qbtz5uTgXxdZQno2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbVcHJW+oGstGWqzsUcEqGfD0onL02djlrnMX0Sn9PhJ7HcvZiLhjIArOPIv0P7BOttJfR4oGHpkj0LaecocZuVyrHRJBe00uSeiPmYz0lzchU/tgPTHWx6WDOVgCHcVl1TDZyxP87msCQXKVh40rKf3xAsbZ9YfiARVO0jf/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcWdu9K8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD29C2BC9E;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=I4xIQ7jL3cs2Wam+tyw6wArNl9Qbtz5uTgXxdZQno2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BcWdu9K8zWRuotMmSVgpYZPyzgszcXhPQZ6T0mJxbTLtiEL05U+4oZhjxkYddzuNz
	 KWZmCBsu2r8yrNlKWkJo24sxzYa7Eu44cZhGQ/2BEY+nOc2UVEsq+GV9CQbkbo2bGe
	 Ksqgmpk5xv8vUJh0DDHwQcw24XOxTaBZxqkM5NHx3K5yapibYUTAB2Ztq2QuscRXpV
	 3dUAAoh05wnTcmfJmELJmmSIB+EUlC5mcnjcGpSXwNu5WQ8MZtK2GJUB0rvwEAaPAp
	 riboOtOsaAjaPmXGpTV3/1PSpNx8gOIu6w6pLlFkBMKc+1vuzuUN+BkWsnXMqq+MgG
	 TUyyqZTTv9NnQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36t-000000002D6-393H;
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
Subject: [PATCH 5/9] dmaengine: k3dma: drop unused module alias
Date: Thu, 20 Nov 2025 12:45:20 +0100
Message-ID: <20251120114524.8431-6-johan@kernel.org>
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
 drivers/dma/k3dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index acc2983e28e0..0f9cd7815f88 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -1034,5 +1034,4 @@ static struct platform_driver k3_pdma_driver = {
 module_platform_driver(k3_pdma_driver);
 
 MODULE_DESCRIPTION("HiSilicon k3 DMA Driver");
-MODULE_ALIAS("platform:k3dma");
 MODULE_LICENSE("GPL v2");
-- 
2.51.2


