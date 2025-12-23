Return-Path: <dmaengine+bounces-7873-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E5BCD9009
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5685430433CC
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C133F364;
	Tue, 23 Dec 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdCeVmXm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BA33DEFA;
	Tue, 23 Dec 2025 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487608; cv=none; b=Cr6Ov9Vp/LHth+/FqWrvnKDXlAT0km2WcNfq+YujNMiz4CWC5wuxChoEz+b7naaqfmwBrsnwrPoQBjTXdmiMBRzisdIgHz++Zy6ITRl3hVDFlu9aaJqOjj7TsjV2i09PxXywpHfmzUkJ9IqNMOFPfU9BxdxGPEE06+iP64BkGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487608; c=relaxed/simple;
	bh=bcGMCw+CenBCj2sTzEG9MDgQX6flK84gwT3bccMPJ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqwMRDvgS09EdpFXUT9cb9XdQw0Jt7RGtByVi2Z0oqAlCsgzp33C55XUIX7eYjc0Ni7XoqIKFSS6uEsqrmtEZLMDCvzmr8Z2O50VxpwsIw8SS05YQn/ZThCv1hZQzhOwjupYHP1NGYV2w9WL8kgP0L2tybbo8ulExkmu0gKE86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdCeVmXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0592C113D0;
	Tue, 23 Dec 2025 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766487606;
	bh=bcGMCw+CenBCj2sTzEG9MDgQX6flK84gwT3bccMPJ1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdCeVmXmKdQVqI3VjSEwbOOSPunRXt25bjBVAYQ8Qq5DX7Xmv8he1QHB4IM6kmiol
	 kSQFG0uH3AooaJfKlQ2vmeyi4DdTdaOFctqyYh371npDMV1Hiku1nwZS7L2sNaZkxW
	 w9BHikFKc8zG2JxTx9Ej5eSnjZ59zi+qmqELObExP/Gdh/7hwdlQCEsPHcdpw2RFkx
	 446pkFSc/P9vixCHjc/aT5tyO5ZK7cWhprpeiBwNp4d+2V+3lJs31OsctwaU2xuTyC
	 WTQVlGeC7dH4+DB2aeaIjv+NvEz6Lx0A6KQ2wP/1MzgDfscJXtAcIfuR2/U0dw/tmG
	 lp/dw9brRCw5A==
Date: Tue, 23 Dec 2025 16:30:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: at_hdmac: enable compile testing
Message-ID: <aUp2MkMmDFw1kgdK@vaman>
References: <20251117161657.11083-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117161657.11083-1-johan@kernel.org>

On 17-11-25, 17:16, Johan Hovold wrote:
> There seems to be nothing preventing the driver from being compile
> tested so enable that for wider build coverage.

Sorry this fails for me, can you please rebase

-- 
~Vinod

