Return-Path: <dmaengine+bounces-4685-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33268A5A5A2
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455537A7AE7
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539191E25EF;
	Mon, 10 Mar 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngHwvGQo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295141DF987;
	Mon, 10 Mar 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640808; cv=none; b=IaZyu6vthZb6cdqbyDjcz5EdpH/9gtVhaaJ4iGoVXPgk9Q6r6YVeGAz8WvQnTyu5DjEDbSL4fuBVKGJBv1D6uuSp8s2kWJptwhrvITXRNv2CYYJEIuGA7GhS35VGAIA57RPJMSLg12IT+WI2iQVTh/fgF0NIxbH/iPVQ8bEn8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640808; c=relaxed/simple;
	bh=LUIaBdTMgvjB8mW49OVudEiPUFjgQuQv0DcfOzsjxKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dQHklyCnJ5J1xelmZ+2aiVQVjkf+lAnRd3r2rCryUEUjI+tDT9WZHnvg9u5yXED1A7R+s5efGE5yYjRfCdonK+PEf8JcZtib3BENm0LiBRWxbaJOl0GkFya0GfzTZtJoqQoJg2/A/aj3wZZLzcqSCtECkIPBVu/nKHBp+PK2bGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngHwvGQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA55C4CEEA;
	Mon, 10 Mar 2025 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640808;
	bh=LUIaBdTMgvjB8mW49OVudEiPUFjgQuQv0DcfOzsjxKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ngHwvGQoDXr044MyVtgiG8m59kvGx4OVARGotRxpewNDcQHeCU2C0LCtik0qh6xFn
	 GEbxJfWvVbLRvBVy8Fn3tjWbZnXBnEo1NCIz9nryAh44hkqCO5+siX0CMy/d0nPygl
	 U0Wgg+CTJbBJSZx3rRwuSZk1oMqXK53PkAfNM8YXkPrbGyRBVCQkihUEAY7vrwbeUE
	 nquHm7gRXGp4xc++eRJYPp8LU7YYBvkcFZzQjGUhJ6tW1xAIpJKCiHf1MaoZHQ3Wlh
	 XjwYq/ftAsTfNAzCPogMwnc0xpGz0897Jmj53dOLARBF9XjVZBP1GyAv0HMpOURkS6
	 UxRmz/1lv+mQg==
From: Vinod Koul <vkoul@kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
 Longbin Li <looong.bin@gmail.com>
In-Reply-To: <20250303065649.937233-1-inochiama@gmail.com>
References: <20250303065649.937233-1-inochiama@gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Allow devices to
 be marked as noncoherent
Message-Id: <174164080465.489187.953643142070263441.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:44 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 03 Mar 2025 14:56:48 +0800, Inochi Amaoto wrote:
> A RISC-V platform can have both DMA coherent/noncoherent devices.
> Since the RISC-V architecture is marked coherent, devices should
> be marked as noncoherent when coherent devices exist.
> 
> Add dma-noncoherent property for snps,dw-axi-dmac device. It will
> be used on SG2044, and it has other coherent devices.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: snps,dw-axi-dmac: Allow devices to be marked as noncoherent
      commit: 6ec29d4086ed8b951fa794ac6c0e7cd7ae3762d9

Best regards,
-- 
~Vinod



