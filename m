Return-Path: <dmaengine+bounces-3349-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D75D99D691
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 20:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33634285741
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 18:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1E81CACE5;
	Mon, 14 Oct 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE4SCEAj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDD1CACE4
	for <dmaengine@vger.kernel.org>; Mon, 14 Oct 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930775; cv=none; b=cB3fXtJBMkK2MwMRaaGgTCRWGA4zO1pHLQtpeHl6JzYKFGhsDV/YEywcvY+lFUi1gGwYM54dxW5FtyMFgq2rTfX3s85FwQp9nshxNc3zYRYvvgdVdC/QCLQgsFk436pvjbJngg45Ty35L3iXQculGdqAD7Y+b609gZ2V/oFvccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930775; c=relaxed/simple;
	bh=5Hy2NzHORJplSK2odU/NgXpMBQwESsNzwKrhc95yp48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bm24XqAfYjfNyR/7kDVfxC7LueuCpyF6W/XinV8Sy/FbHxz0esHWf4zxqnlM5mqXGHYBqJ/H0s3WXrsDo8oBX98HRd9n8i//uUI3iCdxirR4ruxXnqr0QoWEKKpHueRy49HXb0FgqTxVIwGPsbTjQ3Oh+AIhRacG27Penh79rEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE4SCEAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F9FC4CEC3;
	Mon, 14 Oct 2024 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728930775;
	bh=5Hy2NzHORJplSK2odU/NgXpMBQwESsNzwKrhc95yp48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vE4SCEAjZDK+/tVeUNbNeUpddg/s8CnNNCdc/NcBWoklFyfAat1Fe0FtPM9Aa5fRn
	 ZrXLfejlAQN/r2Cm1repHqYWzmBtLs02u6rlss/cGaAZ54xwXwW+/P4D8/OKIoBSdP
	 ztiqa77of4yiDc+qYBkeA2P56ZPYp0SHB0j6l5tkPIOa6gM+fjoMPryIEIXJejeeBL
	 4IU4yTldaXynv3mqQ45MK2Jfi2mAIpG1ULfXh7paEPsa4+xcRYnO5HHvbNoF111Bzh
	 Hm+eMEqP1NQkFK0vNMIP3Ku0/GSnOWitlEmK7+f3gXlQJcp+K7IUO/TfwbqthfTnw5
	 C+k27XSdCc0LA==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: dmaengine@vger.kernel.org
In-Reply-To: <20241004062227.187726-2-u.kleine-koenig@baylibre.com>
References: <20241004062227.187726-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] dma: Switch back to struct platform_driver::remove()
Message-Id: <172893077400.76035.13960834346919498953.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 00:02:54 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Fri, 04 Oct 2024 08:22:27 +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/dma after the previous
> conversion commits apart from the wireless drivers to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Applied, thanks!

[1/1] dma: Switch back to struct platform_driver::remove()
      commit: 76355c25e4f71ee4667ebaadd9faf8ec29d18f23

Best regards,
-- 
~Vinod



