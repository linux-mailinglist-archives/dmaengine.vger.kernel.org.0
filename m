Return-Path: <dmaengine+bounces-1085-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D094861108
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB44B22184
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB487BAE6;
	Fri, 23 Feb 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBw2jB/u"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F487B3FF;
	Fri, 23 Feb 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690101; cv=none; b=dNWrTXr32BRELexUtXe/7BjMUbi3vtLACoJNA6NwTY/Vz0Yp37JB7QvF/y5RfN9//VGde6JdNwxhdjZFGT2wwwLa91/TjXAWRiSiiet0RaxI1CCFn44PUv+psVnope9r5sTZUilWUH/PuW3mkaYCGzV1qBTwB0siMBkY0hul0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690101; c=relaxed/simple;
	bh=6N8Ld7WGmg8vZ3ZIlQzFA50i0hSgpatFocdagRDrzB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sRLXP1seaXjApBuI49P79Czu9cskhWBqR2cJRTC++SxyiH+qvllA+Hr5193lYA+uPlmsqsyGQ4WORyIMdNtvCZA5x7kXoWPFr/c2HzXjKRe5l/RcPSOC8qmxcVO6l8Z8yDXl2My8IEkPiex8E84+96n69p6djdVcmDozuFaPy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBw2jB/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C185FC433F1;
	Fri, 23 Feb 2024 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690101;
	bh=6N8Ld7WGmg8vZ3ZIlQzFA50i0hSgpatFocdagRDrzB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KBw2jB/u3ET3MtQr5fCPVMdC1IjXmuhrc1qzladUdd5pOXUYj3aeiqnv/7NWmpF9M
	 Hoj+FcKZ+8/nDUSUlz+KwSDg0Yjcb1IA8UH1uTjv57UgKgrrbARFUFB5OJUC8PRjPf
	 dKOtFwk2ivB/+n+WqifbQPcDLgxTHKr1mAI3NRle1WKSsF3xGss7CNEzh/2V77jnMk
	 rnsQw9zifYZ301UzyH+E1F+/cbIQxWDWQymzOfnYud6eCnRcGama13T/u6wF6/MH9T
	 GfTimCQfcFrbh4ZLs9gyT6yVQRjyHk9P7MIhMgHAql24unBBmcKmVuLBMtoBtUrn3Z
	 mwwtcsF95c6yw==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240209210837.304873-1-Frank.Li@nxp.com>
References: <20240209210837.304873-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-qdma: add __iomem and struct in
 union to fix sparse warning
Message-Id: <170869009943.529426.11568585221856957944.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:19 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 09 Feb 2024 16:08:37 -0500, Frank Li wrote:
> Fix below sparse warnings.
> 
> drivers/dma/fsl-qdma.c:645:50: sparse: warning: incorrect type in argument 2 (different address spaces)
> drivers/dma/fsl-qdma.c:645:50: sparse:    expected void [noderef] __iomem *addr
> drivers/dma/fsl-qdma.c:645:50: sparse:    got void
> 
> drivers/dma/fsl-qdma.c:387:15: sparse: sparse: restricted __le32 degrades to integer
> drivers/dma/fsl-qdma.c:390:19: sparse:     expected restricted __le64 [usertype] data
> drivers/dma/fsl-qdma.c:392:13: sparse:     expected unsigned int [assigned] [usertype] cmd
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-qdma: add __iomem and struct in union to fix sparse warning
      commit: 1878840a0328dac1c85d29fee31456ec26fcc01c

Best regards,
-- 
~Vinod



