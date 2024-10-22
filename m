Return-Path: <dmaengine+bounces-3402-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0889A988E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 07:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA49B2375F
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 05:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A6152160;
	Tue, 22 Oct 2024 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDnvmpTe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A10141987;
	Tue, 22 Oct 2024 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575177; cv=none; b=N8OhzzbgkOAUzFHDeRkO2sn2+SIZSq9a3Dij7WEP1b3IalOUbH5v3g9UhenMrn45kxQ8E82cStQXXhaLgh2OuIm0tX/4sTcFF3K3TPZZsln/JEZmp6uCqF1wfLurDG77lgvj38+Ns9HpnEPSNGnlERA7+KChOAWYNRwNi2wn/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575177; c=relaxed/simple;
	bh=ObXUbFzSU7KwMPX2t5eNAenBDiiNSoo6Bd9xQxKqO6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ckCCravGsSyMeq6yu12XuehWK3ba3hdf/esRPPnlrheUDRnP3X8U96sEjA9SsAvB9Nedo8TYBm6OA/ruuddMBMCw5Xbv722htEWEw8PBWStTWJlU/BOZSoC5hRUKDI0M5KSejqv0G+uAyafl4E1SyK78DDE9veP8W/2n025m2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDnvmpTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8200C4CEC7;
	Tue, 22 Oct 2024 05:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575177;
	bh=ObXUbFzSU7KwMPX2t5eNAenBDiiNSoo6Bd9xQxKqO6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pDnvmpTeWFetlTAyn9/yQEp0M4OjtX5Dhk598LoEjxeD9Ztqt9XQlZPbqAgL/J2fq
	 0ds3US83UyA1zmDIMnILXkSt47hE5eh3IhOrXi9PiH81MU5dPcNVKJU/L+SX9bSPh/
	 I64ELzERaEIMgwZMd+NSXo+dvCW/s/+IFQn3PfiSfDc1ph2GgTBpjs15qla0+bxvbm
	 yOrzwDrl8QmqTt7KS6nMBQXoFKl3ItPk01VEM7DvwBaEQ9kvpXtmSQxbH2cfBtN2k8
	 jEAwW2eb/5FTkEeQT47mXM95KrJsY0wCZlodgW4N61VKi5YNKLvpqFK3pzB+T8sBbX
	 1aFCWq4jzlKQw==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20241018213725.4167413-1-fenghua.yu@intel.com>
References: <20241018213725.4167413-1-fenghua.yu@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Move DSA/IAA device IDs to IDXD
 driver
Message-Id: <172957517577.489113.12458642977004034012.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:02:55 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 18 Oct 2024 14:37:25 -0700, Fenghua Yu wrote:
> Since the DSA/IAA device IDs are only used by the IDXD driver, there is
> no need to define them as public IDs. Move their definitions to the IDXD
> driver to limit their scope. This change helps reduce unnecessary
> exposure of the device IDs in the global space, making the codebase
> cleaner and better encapsulated.
> 
> There is no functional change.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Move DSA/IAA device IDs to IDXD driver
      commit: 3e482e2840546a3ff725d5adf8d0779ac1c3cf4f

Best regards,
-- 
~Vinod



