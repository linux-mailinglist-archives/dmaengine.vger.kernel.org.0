Return-Path: <dmaengine+bounces-5640-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A4EAEAA0B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D044A1885D25
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC32264DE;
	Thu, 26 Jun 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk/V/Q9r"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177920487E;
	Thu, 26 Jun 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978089; cv=none; b=iXjJilkhBgeWWdRNp4Tr5kiDlWYBkP0MTH3Fdaqh5YTcfI8Qqgdg706P+kaSmMtZ6EiL3xUHJcJteEocoArc7CYthsWOyjCZF7AFDkbqMI/dC+jHvd0aifsk2nn1JigcwL+51t2qeQncN5o+HUupYS4BQx47asUmnYDEslBde5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978089; c=relaxed/simple;
	bh=R8CLx3lBBBA7LvBgT58Sc9bRYzTVrORcyxFh0G7ROJ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lb/V9dQLcgUTStPGzrCTRvE+MtjdAv7O3jpEbix79ImQKtQmo4/pwB13dJCtOXKeCDEtvM0kGssmp31dlECkq859Ra0Mwhc9q74Fd03Kz+zX4/gaRngF7LJNpvHPE6hH+CPOnifwVZdAMOl6ZJWA2GSf0CtyZvlqQdOcBXcAVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk/V/Q9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C18CC4CEF3;
	Thu, 26 Jun 2025 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978088;
	bh=R8CLx3lBBBA7LvBgT58Sc9bRYzTVrORcyxFh0G7ROJ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zk/V/Q9r0eFXhj7iEBCs7Oehj+R3cZd2JUeipOAReEk8S3l744NsU+t+jn2Bapkyo
	 Rh+e4lSTKlouajX/NAqfhZOYEBZ4+AFtXeXLmtVyqain1uXjng7723WJ+HWcRxL2wO
	 SzFKq2k8XNQ8VA8d6ZHYjyVeycTPMmnlxzmH1RR1zkws4WYUH2irgcG+iOCKqJEM0B
	 lF/ZxKdmd2yC2df1oN44OIQBFzXSXWFz73G0d5MkHB7XG1ai7kHeYR5xlJiPX/QeEX
	 QLj20bEkI4AW6Xw8VGgrWUvE/7FYh8PDgGbx8+Zuqu3gJs5aZ2NdlLLgJ5r2PzXo1z
	 QHhC/+PglSnvg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Julian Calaby <julian.calaby@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
In-Reply-To: <20250625085450.154280-2-csokas.bence@prolan.hu>
References: <20250625085450.154280-2-csokas.bence@prolan.hu>
Subject: Re: [PATCH v11] dma-engine: sun4i: Simplify error handling in
 probe()
Message-Id: <175097808852.79884.3766453152059490417.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:08 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Wed, 25 Jun 2025 10:54:50 +0200, Bence Csókás wrote:
> Clean up error handling by using devm functions and dev_err_probe(). This
> should make it easier to add new code, as we can eliminate the "goto
> ladder" in sun4i_dma_probe().
> 
> 

Applied, thanks!

[1/1] dma-engine: sun4i: Simplify error handling in probe()
      commit: 814f047fc96d6631bb2c76557aad8e4aee8f532b

Best regards,
-- 
~Vinod



