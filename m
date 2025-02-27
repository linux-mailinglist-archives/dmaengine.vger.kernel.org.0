Return-Path: <dmaengine+bounces-4590-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB2A47D10
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 13:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61FC7A8DCB
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 12:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017222E403;
	Thu, 27 Feb 2025 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uquTKJ94"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13322E3FA;
	Thu, 27 Feb 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658086; cv=none; b=SSi1pChJuOGl8NtXYG6x/aqSqA/ibTYWKUQ0+ixRnbb7Ik/qcbOc+5jMmsY1dMP6EOCVe1ZGT1vQuL9vZwaoYy4Qe85jVyXk5lS+5Kta/O3diAz3i7MOW61jzqBwrj9wE50ZrsEEfvPuoij0WvYpuTjXJW9l3Ei04RBlmUkuVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658086; c=relaxed/simple;
	bh=BnTBqvS3GhK4/kPtQtEy6PC0lkfa2QHa90IKHJd3wz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ki+I660yqvcSx56VtVztq1HrqxMSH8Kn7p5MmzDBQoyoCVUZPNShtMoLZfVllfSCn5idajov8549Mbv3xbGiqGW7vxihbwQAS1TQsOEQOOBVmpvyu+pIXxGbp/4OnteV1KAI8WrAzxsyJRMCYZTgHKSnZAkvmCTtt4zs8YTidmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uquTKJ94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B47C4CEDD;
	Thu, 27 Feb 2025 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658085;
	bh=BnTBqvS3GhK4/kPtQtEy6PC0lkfa2QHa90IKHJd3wz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uquTKJ94Qz5BkSDOuuJ5ClJ+zWxWF+wGOaxlrFXZvYZC2zBBZNaCY2MBl0W/XYvak
	 w+wktTZfJN/4BUJ9C/6owR+CRC0ChI41iVxTY88mvK6O3PGbZWIaTgDk9t7A5vJcHt
	 IBNbAMujFlrhzwPWKkquxT1EJqAmhKCw4TPJriIjnu42N0hnwFUcJCfQEA2Mwu4vmi
	 x667jiClQj7Yyu2v1Bre72VjijxgDPJWj45f1NQzIVuNOsB3xKDh+oSlSEiqx5y+5D
	 zvXWPCUQl6PN6XRDA0mmy9sOa0cY+AyJou+SIxSC00ylfvSFk4lu3AB7tuSeMaB1pr
	 2IACkagKPrMpQ==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 MD Danish Anwar <danishanwar@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: srk@ti.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250224-k3-udma-glue-single-fdq-v2-1-cbe7621f2507@kernel.org>
References: <20250224-k3-udma-glue-single-fdq-v2-1-cbe7621f2507@kernel.org>
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument
 from k3_udma_glue_reset_rx_chn
Message-Id: <174065808054.367410.3286112232098432067.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:38:00 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 24 Feb 2025 16:04:17 +0200, Roger Quadros wrote:
> The user of k3_udma_glue_reset_rx_chn() e.g. ti_am65_cpsw_nuss can
> run on multiple platforms having different DMA architectures.
> On some platforms there can be one FDQ for all flows in the RX channel
> while for others there is a separate FDQ for each flow in the RX channel.
> 
> So far we have been relying on the skip_fdq argument of
> k3_udma_glue_reset_rx_chn().
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument from k3_udma_glue_reset_rx_chn
      commit: 0da30874729baeb01889b0eca16cfda122687503

Best regards,
-- 
~Vinod



