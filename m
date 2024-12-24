Return-Path: <dmaengine+bounces-4064-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31EB9FBC96
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08AE7A28EE
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967221BD9F5;
	Tue, 24 Dec 2024 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IViHDj1g"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C971BD9DC
	for <dmaengine@vger.kernel.org>; Tue, 24 Dec 2024 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036927; cv=none; b=FUWUr5PWMQjZxARUndydP6w4pti8q1aM1GZevZtne4uzhG6waqt4Au/vH7gF1dmkyOExV11SqQIKcaurA5D3PHfFkTw6zcLMd+eYsuWiqW2J5T3r5Ou8pGMqTcqp3ijqV5ESSntBeJxffWCg4mHJFhDXCUNPzt5/n5YFxim9ZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036927; c=relaxed/simple;
	bh=YiPFkgNns2P9sdqfegy6HZk/kbJQ0N+n9s6AXB47Ly4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PifryrAVKvOa8PgIiTGTVpuCg22U4fxhdjZqxVerAal7Xwo14y2VJHvwXa1Art5owz9CZHNBt8z/daEYDesfN69cktdAaojHh4M4lX9w8WuZzWqwjh/BHkaL+Of1VypRtEEQ0B5cKtcuckyuXwAGffwHJgkSiKI9kjZkQx+gFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IViHDj1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02D4C4CED7;
	Tue, 24 Dec 2024 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036927;
	bh=YiPFkgNns2P9sdqfegy6HZk/kbJQ0N+n9s6AXB47Ly4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IViHDj1g0TVu0TtUyjTgUBCyaXbSWgKPgDD9YpNP5tlTATQ2F7XkmV/goaJPxU/aB
	 bXQ5jiXlziefnHtt6ZKTFVUifWexpAGvZoEmS1Zs+6zCBNiw4loDD/BTX0qI9EKeyU
	 AE664D7ToKEDcQYrAFRijc3ASKFMI6haGrhFwoYBx3cQ4pCOQSyKi05n7o8mk5s19V
	 nYbXXuOr+/AOLbHRB/CYXDRTG7gMnqY//bIalYTKB7GDw8K1Afj3tUzVwRU5QPAwOT
	 qSljXlqLxAiQ5mnRN/QKYPueXl+if1P4pt0NVv/IP9OeIgD5jWDA2DPsiSzJxo+Kqc
	 9xK/83BfjUHhw==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: dmaengine@vger.kernel.org, dan.carpenter@linaro.org
In-Reply-To: <20241219020507.1983124-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241219020507.1983124-1-joe@pf.is.s.u-tokyo.ac.jp>
Subject: Re: [PATCH v3 0/2] dmaengine: ti: edma: fix OF node reference
 leaks in edma_driver
Message-Id: <173503692540.903491.979475975272886003.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:05 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 19 Dec 2024 11:05:05 +0900, Joe Hattori wrote:
> This patch series fixes OF node reference leaks in edma_driver. The
> first patch makes the loop condition simpler in edma_probe() and the
> second patch actually fixes the leak.
> 

Applied, thanks!

[1/2] dmaengine: ti: edma: make the loop condition simpler in edma_probe()
      commit: 0ab433180eb29bc69f9327e84028d878fb4670c5
[2/2] dmaengine: ti: edma: fix OF node reference leaks in edma_driver
      commit: e883c64778e5a9905fce955681f8ee38c7197e0f

Best regards,
-- 
~Vinod



