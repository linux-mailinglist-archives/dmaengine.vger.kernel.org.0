Return-Path: <dmaengine+bounces-781-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E25836D3A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04772B2FB95
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024373FB12;
	Mon, 22 Jan 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHzd7Jgt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D63FB11;
	Mon, 22 Jan 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940701; cv=none; b=kRrahJL864oHcQcwWBC49SJR8jqS3AcLKcMk5kzolG0IdGhJi6sxH39Re77u75f4Ri3MWdSRUHntgv6paIV5ljwF3PFftTn2dXEX4wqlJBMlBDIE/ss/xteBcyX/FnZ7BjlXTKKN/hsJNQgRC50o0qrvwXdoKztpQQ2fyZtT8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940701; c=relaxed/simple;
	bh=kROFFa7C+CqN0KzOamkTCnBYuqePSePgu1aL6iT9cIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hU7Exf4Q0C19RGLkMGBOIgNiakMFkt2dVZPnh2B2gJ0OvF7vnMQm5lJfPEPbZw4U4tS7IyVtLJmJwETncauU8Oa3QoD0SihQM+311CvXwgmzEjwz6FoF3uOgH0Ke4iDdGvoQ80P+Ah0g2s+rJ7IguBQAiS4Hs6vrPlcuQ35hW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHzd7Jgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF015C433C7;
	Mon, 22 Jan 2024 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940701;
	bh=kROFFa7C+CqN0KzOamkTCnBYuqePSePgu1aL6iT9cIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WHzd7JgtY3AQVmjYB9doelLw14nBuFu+f/t3F+K57d/QBRxZjN2Kq3g31FsyDpnIq
	 SJze3ti+c1PUR3fZ1nllvyKMoXDH1yF1EPrplPhzKNNVN2C9GunBG5mU9leJiBEbxV
	 VHK14vT6y+zDSJ3ePDWr8+Kamggka5gIHIydW6F5NCcRLq6rAX+zxHq1sz5qmqKln3
	 XJcXClKX5jfXmMN9Hx3OkJIKLqf2IKfu70Iz7vR2toTgiyV5lKGheNgEK8OMstIOfi
	 cEe8R2p/nDKg61UEWlb+nAlYlSiUc/7azlxCZAjbF6MI1ur7VJ3LgeCrWfrkkTBU3F
	 h/tvzbqQhQRNA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
In-Reply-To: <20240121070021.25365-1-rdunlap@infradead.org>
References: <20240121070021.25365-1-rdunlap@infradead.org>
Subject: Re: [PATCH] dmaengine: at_hdmac: fix some kernel-doc warnings
Message-Id: <170594069935.297861.2502894257927819845.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:54:59 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 20 Jan 2024 23:00:21 -0800, Randy Dunlap wrote:
> Fix some kernel-doc format warnings:
> 
> at_hdmac.c:243: warning: Excess struct member 'sg_len' description in 'at_desc'
> at_hdmac.c:252: warning: cannot understand function prototype: 'enum atc_status '
> ez
> at_hdmac.c:351: warning: Excess struct member 'atdma_devtype' description in 'at_dma'
> at_hdmac.c:351: warning: Excess struct member 'ch_regs' description in 'at_dma'
> at_hdmac.c:664: warning: contents before sections
> 
> [...]

Applied, thanks!

[1/1] dmaengine: at_hdmac: fix some kernel-doc warnings
      commit: e4cec073b7755a78030f30cf627141c759035b50

Best regards,
-- 
~Vinod



