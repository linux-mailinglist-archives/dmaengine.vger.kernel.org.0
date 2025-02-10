Return-Path: <dmaengine+bounces-4401-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB0A2EFED
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556541888801
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC50236451;
	Mon, 10 Feb 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2Fsb1tv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097E204840;
	Mon, 10 Feb 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198128; cv=none; b=mdOrcZXYz8d70zCAU5qoYl1wnBuFqT/q/x5Qn0Lfa7eH3GIo/dj5B2LozAiRt1NJ8YYlrX+Ra19IvFGSJus3RRzcMyIkUF+EHNOCj6WvgijUeJGRveIGI9IUmBi6Xi32nnMj9bXrsZgWp1reE+d02xjQjdtlFKVgZKtHjOp/7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198128; c=relaxed/simple;
	bh=YOnLsQVFLMH2bFUH18nK2RMlrkj9YbYtO1geEZmMl4Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SawJORXzwVqxHCin322mZ4Uxu3JU+lALcibhqhJRz6JihXBrSe/eM5LhXHzs991MvkRVEp03oWgJJZ+6gnUG5B10AQdUYWyTKO1pphUR1WiOoXn3NCcuENfnlxzvbaRdrDSOPrX9iEP+yUJiEdk0/2FHLoympwcKqIvIZ1U19U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2Fsb1tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A72C4CEE7;
	Mon, 10 Feb 2025 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198127;
	bh=YOnLsQVFLMH2bFUH18nK2RMlrkj9YbYtO1geEZmMl4Y=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=C2Fsb1tvvXRR3kJMMeaWrn2+i2Yby3dftAZyFsBmQ79eEk/mph2/3yo61l1MrcQfL
	 hA8JlslLwXOMqyMYlC3HKWHLl7IDfKlzsHgbmCtWDiVxBSFPUt4iKSGQgRuutGisuy
	 GGDBhjmbk5WsGCBARlZDja+rBNlRP7bEWSseAZHa+TohVCR8cdiGAf21VJf025VZHV
	 Qz+S6jJYotb/FeSbMBpyATEJ2o+0INTMj9h8zOEgr4C0PUi7+weAkF7Hd3OS3+4e27
	 1wdDwKcz3I+Ly0Qg15Imii/gq0FC+RpS8sC8NfLJ/xneoVLMmByzW6woZexM8Vtr10
	 Cu3s5F0tLGWKw==
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>
References: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dmaengine: Use str_enable_disable-like helpers
Message-Id: <173919812243.71959.2545724653806590968.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:05:22 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 14 Jan 2025 20:10:20 +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: Use str_enable_disable-like helpers
      commit: 8e63891831f3904047d7ad8078ff52dd454b6975
[2/2] dmaengine: pxa: Enable compile test
      commit: 9fc2f03e85952ee52558ab844473a8284d924a56

Best regards,
-- 
~Vinod



