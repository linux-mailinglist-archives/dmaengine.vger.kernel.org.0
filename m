Return-Path: <dmaengine+bounces-3027-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC458964CCF
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795AE280E65
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2F41B86DB;
	Thu, 29 Aug 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9WoHNIF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505A4DA14;
	Thu, 29 Aug 2024 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952640; cv=none; b=prC27JshEFSRtmz7jyINB9CL2Swq8ykPkVlt8AG1DsoKmejEUgBsx4AAPcrEtR+yRxF0v8dykGe1ZhWVNlPgYuQA6UJHHFZGvWgCVWivk8xfoirt/CsD5TOhY8/ouk9tMNjVOcZjCsBdEEj194OgGnlvrWYomdVKgUFYMHvadpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952640; c=relaxed/simple;
	bh=TEsB8LNFhusEQgf0kKmbqfMQXDUwHoHoROc849hZ0bE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u3dgtAxt3h/S3nHnrHWy6qjpmevY3dFkhH75PhJyUexkSyP+UNqES3I1+FzJGPQTTVHigzkXht7WeLH7DJ18iDstm1nDo+uhlTKbckz2uKEp7T3xGO5V6iaF1EbTrlWPV9ck0m5tBhwvATNNcHUxw/ngJWYLKwynVcAPtIi5s+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9WoHNIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9AAC4CEC9;
	Thu, 29 Aug 2024 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952638;
	bh=TEsB8LNFhusEQgf0kKmbqfMQXDUwHoHoROc849hZ0bE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i9WoHNIF87zh4Oy3KAe2hxdGM+OnfJ4mo4YoxOMRwck1N4KScmM98LTchnsV9DhxE
	 nUIw6A0cjnTG6LJxbKTIHxmxcV9gHJjxKe7itsWv7CbO1FPkjfbcHGpQefks3D2/tj
	 Sbd87ucnKdivj07+1ks1ByIsjQ++RUrfJ2wKmMmWO1/7bW3Nwx6AXui64m9XzvGqkZ
	 JasiovCPuaOAbrcvgmNfPFMTYPpLUr9pAisMtS5WbcVBc72I9KVnPHavBaq3IF0jNu
	 uonF7lFJEiIt6UX+kvE4JMkm2IA/t8PTl6mLO6vqgD0eVcAmYL7470/HKBiLHLbfx+
	 GNR12IGSQvSGw==
From: Vinod Koul <vkoul@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 Fabio Estevam <festevam@denx.de>
In-Reply-To: <20240807170517.64290-1-festevam@gmail.com>
References: <20240807170517.64290-1-festevam@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: dma: fsl,imx-dma: Document the DMA
 clocks
Message-Id: <172495263633.385951.4011383179072165108.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:36 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 07 Aug 2024 14:05:17 -0300, Fabio Estevam wrote:
> Document the IPG and AHB clocks that are needed by the DMA hardware
> as required properties.
> 
> It is not possible to have DMA functional without the DMA clocks
> being turned on.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: fsl,imx-dma: Document the DMA clocks
      commit: 2ccf4822683336f027a5c9f12cb2468e329125d9

Best regards,
-- 
~Vinod



