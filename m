Return-Path: <dmaengine+bounces-3031-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD1964CD7
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF51F23A41
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37AC1B8E81;
	Thu, 29 Aug 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgJ05MCh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0471B791E;
	Thu, 29 Aug 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952647; cv=none; b=AG8YdWA1CZOQ9kAtCtp9W/oY/X2lhnIzpSFpqzvsLjXZ08DJ7D7fdM/yasFxscsY68ac9/qhkbOR+mW80YrpBf3RTiRFG2e9QiggCVwbJi3kINGuFM5jJRe2tr2bbzKl+qZln8IhZ7vV6fe3qDAJstzRjg8mddj4kZlFlGMFDf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952647; c=relaxed/simple;
	bh=L8WDkgRrVHRys7SM5HLkMIzDSSpqns52omw7yHZE0YQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IyfYQ2rAHL/UgZwjmKaxlZ41qU7nzezjV0qC5A1yKbs7+pjmBFff3+wT7tw6uw7ElOJnDn8ALoGNVn2Jq5TEIAcEuJDmojPlIPLbWwLp6LOcuGHl9AN16iy7UYN6UDIHaVA7zKK+DFNqYfbk5sPFCgeDXlOPB17NDKHELe0GxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgJ05MCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D54BC4CEC1;
	Thu, 29 Aug 2024 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952647;
	bh=L8WDkgRrVHRys7SM5HLkMIzDSSpqns52omw7yHZE0YQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=GgJ05MChZEJgQMYFu2vBuD6o8USDRXBn60lNDRHFN/AnH68u1nX1xG2BRU0shOLID
	 oo40AALtxZ7PY80j7VEde8TsjzyPGmvDkMJbUTjFFKScevzDAn2GnLCdZKZ+svytja
	 OkaMdmmJLElmXfmC8JfF4prDUg8pZLgi+2ynMAJNyQXOWxke+RWPYIvpUGn1KJF851
	 MRWKjen2EbS5ELQ+oyhKUyAzXgJ2INyXByni4yGmkyy+HYiSWwwY3l0o9B5KdLL6/N
	 572dGrKsvVpt495EWlmz0vACoZPTXqyFFIGGdZckQIdD2Qi8d5bWiTmhNsA0UWyQ6R
	 c3d6Q3oTyGkMA==
From: Vinod Koul <vkoul@kernel.org>
To: Russell King <linux@armlinux.org.uk>, Vladimir Zapolskiy <vz@mleia.com>, 
 "J.M.B. Downing" <jonathan.downing@nautel.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dmaengine@vger.kernel.org, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
In-Reply-To: <20240628152022.274405-1-piotr.wojtaszczyk@timesys.com>
References: <20240628152022.274405-1-piotr.wojtaszczyk@timesys.com>
Subject: Re: [Patch v6] dmaengine: Add dma router for pl08x in LPC32XX SoC
Message-Id: <172495264508.385951.12025278196392714959.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 28 Jun 2024 17:20:19 +0200, Piotr Wojtaszczyk wrote:
> LPC32XX connects few of its peripherals to pl08x DMA thru a multiplexer,
> this driver allows to route a signal request line thru the multiplexer for
> given peripheral.
> 
> 

Applied, thanks!

[1/1] dmaengine: Add dma router for pl08x in LPC32XX SoC
      commit: 5d318b5959824e15d32f19b2224c69da89e98178

Best regards,
-- 
~Vinod



