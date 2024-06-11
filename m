Return-Path: <dmaengine+bounces-2342-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57E904381
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99741C24058
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16DF80BF8;
	Tue, 11 Jun 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBHg0MfB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8980607;
	Tue, 11 Jun 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130475; cv=none; b=JuQElO9D8KWWPy+0sMvqW6homlYbCSMg1qnSS1rShnicVixKFoD2NJZ8TdEJqe9cyU9TW14zQ4ey0xLN9Od2P4d8ZHaW8qKdK71uxBFd2BHJBU4h2Wd4v32eCDwkVl7kRPPpSuzLksXCabxxEQ+gOdwgylrFsUpJFtNbbQLBv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130475; c=relaxed/simple;
	bh=mR1yomcPDDwqfOEvZUQfEbXY9LivZonXQM9yLf1PPo8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pgdd2MsxZgmkjrlC/zHV3KnSP0bF1iG9G3ljBGXYZBPvHLL7ipSb38ESpUmd80fAbHf/SwY6aBfLy4pLZDS8KtiZ9+j1BJsbmSGctUSiONTRpw6vamqd1waYiu6bdiqcwwIcTnnoGGnYPt86ZsJ4ckoQQ2tRCoC0ZuPwFXDXdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBHg0MfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F4FC2BD10;
	Tue, 11 Jun 2024 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130475;
	bh=mR1yomcPDDwqfOEvZUQfEbXY9LivZonXQM9yLf1PPo8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tBHg0MfBepQKQEXbN8MlIMGTVX2JpaOrWoMz4LSzmDidVES1r1rfiV5LOUAyMxGu/
	 izXAhEZOPokjqk074EohyTItV9FGkBrDWAQeH1W16BJCCalftxj8Aja8FXFcsWxI8A
	 /Bm5H7Wo+i0FQfhlZ9luxtFXecyRHd1tLCtK7eW/AmhWQCOO+k56y2zaqi5P+fBJx2
	 CcMrbJ9o9Zr4CJwen4GirHVdHdlzAF7Xl6xLRpfPFvblQt29L//5GOSUj4iwBGD1dQ
	 zGCK47nDrTHs5zZBlQmtnUrvhFwe+V+O480ChpAgfWaPbuh4rTRbuAtzoCKIpDP8ir
	 auTeAcDUTEbkw==
From: Vinod Koul <vkoul@kernel.org>
To: Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@denx.de>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240528115440.2965975-1-arnd@kernel.org>
References: <20240528115440.2965975-1-arnd@kernel.org>
Subject: Re: [PATCH] dmaengine: fsl-edma: avoid linking both modules
Message-Id: <171813047274.475489.9770703147232550799.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:57:52 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 28 May 2024 13:54:22 +0200, Arnd Bergmann wrote:
> Kbuild does not support having a source file compiled multiple times
> and linked into distinct modules, or built-in and modular at the
> same time. For fs-edma, there are two common components that are
> linked into the fsl-edma.ko for Arm and PowerPC, plus the mcf-edma.ko
> module on Coldfire. This violates the rule for compile-testing:
> 
> scripts/Makefile.build:236: drivers/dma/Makefile: fsl-edma-common.o is added to multiple modules: fsl-edma mcf-edma
> scripts/Makefile.build:236: drivers/dma/Makefile: fsl-edma-trace.o is added to multiple modules: fsl-edma mcf-edma
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: avoid linking both modules
      commit: fa555b5026d0bf1ba7c9e645ff75e2725a982631

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


