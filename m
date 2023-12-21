Return-Path: <dmaengine+bounces-616-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6381BC05
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D852D1F26B31
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A259923;
	Thu, 21 Dec 2023 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trLOMg5F"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43D59902;
	Thu, 21 Dec 2023 16:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01D7C433CA;
	Thu, 21 Dec 2023 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176205;
	bh=QSIN5PEuBM/SnRlW0ctc6105LdnUDAdtLamta4IHtME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=trLOMg5FdnHbBv0cX8A+FTotzKPj05/I4Gm/yIlIMMK/LFlrkcKdRMzbGvF00jac1
	 4irUDB8fehWHaM6hSnQAyTzTjom3P83lqnWBetgDXcos5vBOnJzd4U0TIhVFnKEIUE
	 3S+EstEyNUJG+UdyF/IjZzHi4IvHPQ63MND3jSDvLFH5ZwfiI4uW6PpeS7cJQgV+8s
	 SS9mMQtG6+RXXONYmbghM1YpZZz8lG2Ge/1qhxBbekItjYYk8IhYs8i6TBpWIA0tcP
	 LY/QxwedALWNyFc6zqKUbU8jlIXs07Cb0l1NtC1dUg1TW4vbS94T4tgCCUB+p8vyIO
	 M/blg/0w8XQ8Q==
From: Vinod Koul <vkoul@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, dmaengine@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Huacai Chen <chenhuacai@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
 loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <cover.1702365725.git.zhoubinbin@loongson.cn>
References: <cover.1702365725.git.zhoubinbin@loongson.cn>
Subject: Re: [PATCH v6 0/2] New driver for the Loongson LS2X APB DMA
 Controller
Message-Id: <170317620141.683420.14004711706035537472.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 18 Dec 2023 09:56:37 +0800, Binbin Zhou wrote:
> This patchset introduces you to the LS2X apbdma controller.
> 
> The Loongson LS2X APB DMA controller is available on Loongson-2K chips.
> It is a single-channel, configurable DMA controller IP core based on the
> AXI bus, whose main function is to integrate DMA functionality on a chip
> dedicated to carrying data between memory and peripherals in APB bus
> (e.g. nand).
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dmaengine: Add Loongson LS2X APB DMA controller
      commit: 3b3b5339cdc67e98817d08431f8443b08880084f
[2/2] dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller
      commit: 71e7d3cb6e55ae2eadcdb178f9243dc18499d369

Best regards,
-- 
~Vinod



