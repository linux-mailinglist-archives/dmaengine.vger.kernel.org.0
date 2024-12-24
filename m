Return-Path: <dmaengine+bounces-4067-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE149FBC9D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C31882B4F
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0D51B6CF6;
	Tue, 24 Dec 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+0Ummw4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDCD1C549F
	for <dmaengine@vger.kernel.org>; Tue, 24 Dec 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036938; cv=none; b=he65lby9lDppyLkJfUuVBaIfn8NMNd8b/ZfVCoBHI8X+zq32C+qoQJPnb0v9vNbmmh8f49rVq2nEXDTANK77jxktkkI1nqBSijjRyWRYnaCVAvx3N+wTiwNaCbCVCEvNnQ33YUjiG6kVKKoDJoXZ8YqysEILTJXxSl2GmyybHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036938; c=relaxed/simple;
	bh=kEjX0uMOUgoJnsumDFEjXw0rukEN7DCNLT05YMxM1hQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bt/HVa4be2XgG+Lp2uTJeVmVCiMCKnETyVBGuUPlPiGWp1Iz3AQ2BeLGULTvPG97VtTNZ9AXPgEfXI9fcCsdzV/SJ1U3lWvVwK1VHBCrt8wkiOudSMpJwxgdn+BSFXlsDy64cPPNVg9ToNU5Min1L/+FZMN0/yr67CvlTXZZYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+0Ummw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC747C4CED7;
	Tue, 24 Dec 2024 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036937;
	bh=kEjX0uMOUgoJnsumDFEjXw0rukEN7DCNLT05YMxM1hQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A+0Ummw4MZ9/BndSUcSmJai7EXJrzI/aVGd32/aJHpyGC2eOExYGvIRXZATN6MJv7
	 jgecSBTeCeYYPaIjI1eIb3beCo0/iqdJuUL0SlbHRMG4VlWaE0PGJSewtdGe/xOrfh
	 yOKlxnSusGIY7wsgCaWH4Awb5X3Mc45bdLTlqXEa5lWTdWvz4ff0NlaVo0q9COrkxL
	 l4pH5CCY2W6lWnYq7g8LvQ/yWQdSaTi4B26BRGux2cf6tHYFKHBg3QWHu6CPqxrSQx
	 KEkWTlPbihbT9GgnmQWn+NjB3I0KlTY2r1/wMA8+fd4cx8DnrTXZZR3vnx27NQxy7P
	 frdlXRTIaTU7w==
From: Vinod Koul <vkoul@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>, 
 "Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org, 
 bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org
In-Reply-To: <20241204165546.77941-1-wahrenst@gmx.net>
References: <20241204165546.77941-1-wahrenst@gmx.net>
Subject: Re: [PATCH V7] dmaengine: bcm2835-dma: Prevent suspend if DMA
 channel is busy
Message-Id: <173503693445.903491.14468199759886552238.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 04 Dec 2024 17:55:46 +0100, Stefan Wahren wrote:
> bcm2835-dma provides the service to others, so it should suspend
> late and resume early. Suspend should be prevented in case a DMA
> channel is still busy.
> 
> 

Applied, thanks!

[1/1] dmaengine: bcm2835-dma: Prevent suspend if DMA channel is busy
      commit: 9602a843cb3a16df8930eb9b046aa7aeb769521b

Best regards,
-- 
~Vinod



