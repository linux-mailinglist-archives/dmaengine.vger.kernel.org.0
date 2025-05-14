Return-Path: <dmaengine+bounces-5166-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE944AB6ED1
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAEB865D6C
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C3E25C809;
	Wed, 14 May 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvS/h4sH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA172586EA;
	Wed, 14 May 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234984; cv=none; b=gmiHDRNzZwpY/mPxmHuJiYArJgjVtdiwTBEnIeWjN/6nooyRTNPZ6VmsHngxmkYr9SVqSFty0qS05TXfZfNPzpRoCUwoQQW4bp3UdeWNtUlZyV3CWl2FGQDptnbQ1owCUY0Rd+/oZKV8ma5yNGGKJFywC2lLnqzkVSHw0tvhEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234984; c=relaxed/simple;
	bh=CrrzdSf126QFxG/h/MtdGCfAFJXhj2DHZoC5yge2PDk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pBnBt2gqSJIcKM2qf5WgLOD+N9GomYIJKAlnI438XHE75zI3om3pm0XjHGeRr4PMJQVftFwEMPxa8DcILwZWoSjfp+5Z9RgVMQxEMMn2TMJ4GIHTEUBilkJDby3RMpIKdnq2M4l0eTUedzmq1CPDPK7z0wgAx8AmdIaAWwx8DWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvS/h4sH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9A0C4CEE3;
	Wed, 14 May 2025 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234984;
	bh=CrrzdSf126QFxG/h/MtdGCfAFJXhj2DHZoC5yge2PDk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TvS/h4sHImuv6xqPQx/O6uSx6gbVgv5RWoB//pZbkqL9B1aVAjvMXfHYAVWYfPC1w
	 G9yxNjBG76689lKx5My5wjAk51escvGIM9OOXdp1rGep9ef0mnO8ZvU9c3JeLvp97H
	 3zVjUCMXqtUf2tzUcSv4Q2kdWHqHsaM/2YxhYROxOUd7U6ZAfVRfO3Ngceyje8gu7L
	 xGrXpJ9Hgl/2B+97cfera5Kgm/YsMxZVN98Z7F+v7IfkJhPD2whRaB06Qt07GyuOGN
	 s42EFJzAJIkNMSLdtGm64vdMgPLpJuaEaNYjIZaKLiIuhIFx8wtNYkrLgKuDGdGcN3
	 AAeivgwN0ojtQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
Cc: linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org, 
 Suraj Gupta <Suraj.Gupta2@amd.com>, Harini Katakam <harini.katakam@amd.com>
In-Reply-To: <20250507182101.909010-1-thomas.gessler@brueckmann-gmbh.de>
References: <20250507182101.909010-1-thomas.gessler@brueckmann-gmbh.de>
Subject: Re: [PATCH v2] dmaengine: xilinx_dma: Set dma_device directions
Message-Id: <174723498087.115803.3330259511910052558.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:03:00 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 07 May 2025 20:21:01 +0200, Thomas Gessler wrote:
> Coalesce the direction bits from the enabled TX and/or RX channels into
> the directions bit mask of dma_device. Without this mask set,
> dma_get_slave_caps() in the DMAEngine fails, which prevents the driver
> from being used with an IIO DMAEngine buffer.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx_dma: Set dma_device directions
      commit: 7e01511443c30a55a5ae78d3debd46d4d872517e

Best regards,
-- 
~Vinod



