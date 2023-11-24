Return-Path: <dmaengine+bounces-228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F36437F753D
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DCBB20F37
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF29016432;
	Fri, 24 Nov 2023 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH+F1TDG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9120324
	for <dmaengine@vger.kernel.org>; Fri, 24 Nov 2023 13:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5BAC433CB;
	Fri, 24 Nov 2023 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832796;
	bh=aWJ2oYm4znVqKZ2VTDwtnyLTNpDbDMMTDrHCY2Ki22c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VH+F1TDGSlQ3RYh2cxtjRx63dkpNHBlFulFI8or0MOOkM/UjArGpj8MuEXwIeF20+
	 Zm2ctJPBwfjSv2tZ5Q/jQ7QipI0B/dOkuYT8iFk62BSZTxs0q9LY071Hr10cg10J+G
	 vmB85x64GuOxO0Onm+O0XtBDTdSnCEqq3MUcEfi2ygigg9Yu/YGPX5wghu3r2E+65L
	 qyzOpoYOdfCoL2pzxBsIQ+XCy+g3wVq+DgRSko8DQrP/n28EJmYr7XvFBFbJDPFe00
	 z+Z5ZZR7NUrZElz5AC/xZDw/IWHiKYwMj91iDG0xZoGenBMerHCzCubUIkPI8cczlT
	 X6U0otTDtjzjQ==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Taichi Sugaya <sugaya.taichi@socionext.com>, 
 Takao Orito <orito.takao@socionext.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>
In-Reply-To: <20231105093415.3704633-6-u.kleine-koenig@pengutronix.de>
References: <20231105093415.3704633-6-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/4] dmaengine: Convert to platform remove callback
 returning void (part II)
Message-Id: <170083279415.771517.13702174805536896598.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:03:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3


On Sun, 05 Nov 2023 10:34:16 +0100, Uwe Kleine-König wrote:
> after
> https://lore.kernel.org/all/20230919133207.1400430-1-u.kleine-koenig@pengutronix.de/
> this series also converts the drivers that have a bogus error path in
> their remove function. These patches don't fix the underlying problem
> but still improve a bit, as the error message gets more detailed.
> 
> I don't know enough about the dma subsystem to propose a better fix, so
> the drivers are only converted to use .remove_new() to not be in the way
> for my quest to make struct platform_driver::remove return void. The
> quest's goal is to prevent such bogus error paths to occur in new code.
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation.
> 
> [...]

Applied, thanks!

[1/4] dmaengine: milbeaut-hdmac: Convert to platform remove callback returning void
      commit: 0fdd1c4ea99e188dfa8ab7bafbe4004cc72dca30
[2/4] dmaengine: milbeaut-xdmac: Convert to platform remove callback returning void
      commit: 47ee210011ddb8b366c7dcf9c1a9c3818573df29
[3/4] dmaengine: uniphier-mdmac: Convert to platform remove callback returning void
      commit: 5d4304a8d5646c268d73383fbc179db53f85b921
[4/4] dmaengine: uniphier-xdmac: Convert to platform remove callback returning void
      commit: ead0e402e50d1101939e4af67891d5b2fa9678b3

Best regards,
-- 
~Vinod



