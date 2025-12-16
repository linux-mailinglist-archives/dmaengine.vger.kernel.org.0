Return-Path: <dmaengine+bounces-7700-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46CCC4826
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8B3D3049CB1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F89319850;
	Tue, 16 Dec 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd0D1hOV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791C2EFD9E;
	Tue, 16 Dec 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904374; cv=none; b=b5wRPNTO8j8gLYkuXc//uI+Z6zyFUiioL3YPk3aNKZjbC7oBXGnmxY2rbk2ripTizpYRbZ4S0583MgtG8Z7guEPHoBjqN9EhMHD8g367yTP0MA/JySmYsw5fzb2JdHwRT8XdBDqGNUxd9mm9830/y6BfA07dXaBFzKD/MyuIkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904374; c=relaxed/simple;
	bh=u2xpFD/jCgWb8wPDV9D7Rh3i1CiZMtxI89nFvq3Au5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VgN5SNjgCjYzeq0QKeBNa/lQ+kVH68lELZzP9WBmRcujXK0sU838H9jRP4KIX1tTkImedxSsAPwuKbJwGtvoGbwwONXPV1RoHRMuGX9PHXam91ZMKyzWJJm/Apb+sf46L8pSFfhVHLU8V6hOXl8NnbQJKFdvknZrfentB6L2+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd0D1hOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A77EC4CEF1;
	Tue, 16 Dec 2025 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904374;
	bh=u2xpFD/jCgWb8wPDV9D7Rh3i1CiZMtxI89nFvq3Au5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bd0D1hOVHBTjH9OBc1gFFBOPAhERgJS7o3lS/N6/6k3/FHneq0WFlbfVUJNB3fnSh
	 LfO7TlRcQxMHuhkRLJquV5SYzm7RcueRNZTpSzmDKHSwjtyb6PXs2eEyzHQSPGCWtc
	 LV6xy0jLOQ91Vb4QP8XP5M5IEDjuXQNar5V44byp7ddf+nFiLMFJgp5U28xjRN/b1x
	 ci/wVV58jYoQ5xwncjv4P4Rhz52VaJMsYgJt/IzF1wBC8GAOIiC3YrbZmeKWnZqnSl
	 uZqtdmw5fsWspa4pOYdg2MZovz5OyqLGfctA0s238y/wAQ6rvOkRDpZ55rpUwoSox6
	 WEQmYXUtoDDaw==
From: Vinod Koul <vkoul@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, khalid@kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com
In-Reply-To: <20251113064937.8735-1-bhanuseshukumar@gmail.com>
References: <20251113064937.8735-1-bhanuseshukumar@gmail.com>
Subject: Re: [PATCH] docs: dmaengine: add explanation for phys field in
 dma_async_tx_descriptor structure
Message-Id: <176590437126.430148.14439468580856849330.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:31 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 13 Nov 2025 12:19:37 +0530, Bhanu Seshu Kumar Valluri wrote:
> Describe the need to initialize the phys field in the dma_async_tx_descriptor
> structure during its initialization.
> 
> 

Applied, thanks!

[1/1] docs: dmaengine: add explanation for phys field in dma_async_tx_descriptor structure
      commit: 08be54a9e56f9523b50d1923a94a48ef5890c0bc

Best regards,
-- 
~Vinod



