Return-Path: <dmaengine+bounces-3023-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BB964CC2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934FA2854AB
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28771B142A;
	Thu, 29 Aug 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XukKEq6r"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF5640870;
	Thu, 29 Aug 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952627; cv=none; b=iB74GBGERT9QfZK9M99vNOrjEP6kk/nhvcPwfpdLBJC7NAt2B7O+JJ3WeXkmBNduEQXYasMnSK8lDtTkRgajHmnIxlu2kAuetqzzEA+5TOM3GRIhO9YHhwa+lcvbJfzeO3G8FyOSJ2Faecm1FQigPdQeRnu7pKmtdpToSWEFb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952627; c=relaxed/simple;
	bh=kWuFHoupUeoLMSNjGVbiL4lpeHmH38kYHoBuArnwaN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m+N5VvOkUSLg5jRkSWa8jNPsWgBiphluAKYl9x5ejCuVtGYXkdwvQPJPl8o8Gocn0JiY2Zv38LUV29WZS+3Z5H1L+56iROctAfo6BoFCGHnNWcJTd76SoNwj9Cw8EKlKkpY+RsxgTvWK8HN7EuLhAKJ51jpmLs/yQy0DSkZglIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XukKEq6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40616C4CEC5;
	Thu, 29 Aug 2024 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952627;
	bh=kWuFHoupUeoLMSNjGVbiL4lpeHmH38kYHoBuArnwaN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XukKEq6rmbwer+gAM2hmk7PLHsNHFve0Qwe270Q5CSsT7IXjwB8BJved+AhZtpNgZ
	 tAgxvr4SeWS2yfqRBj9dSsMFEZcd90OiBqQJZEJu5Vm3v7r1cKhRrEcFOyXcgQaYml
	 cMhsneue2jS/4xeO8PHk7UWD7fme7sdsIG1YPVHzqDVBwfUkt/hzUK9ocPvIsdaReW
	 PGCn+UsOT/cAqOsx5f07vahH8fhM+KOacZ0Rxiucs3DY2BNTDgizahi/6yuU4bEWm2
	 CTMwRdFzsrthPc0+nV9EFO8eh8VBeEC08143R/XY6FOEdCBTkNbklmXoxpWNIjhGnf
	 QA8X4Fa6wxQKg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20240607-loongson1-dma-v8-0-f9992d257250@gmail.com>
References: <20240607-loongson1-dma-v8-0-f9992d257250@gmail.com>
Subject: Re: [PATCH v8 0/2] Add support for Loongson1 APB DMA
Message-Id: <172495262390.385951.6697848658942844877.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 07 Jun 2024 20:12:22 +0800, Keguang Zhang wrote:
> Add the driver and dt-binding document for Loongson1 APB DMA.
> 
> Changes in v8:
> - Change 'interrupts' property to an items list
> - Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7-0-37db58608de5@gmail.com
> 
> Changes in v7:
> - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai Chen)
> - Update the title and description part accordingly
> - Rename the file to loongson,ls1b-apbdma.yaml
> - Add a compatible string for LS1A
> - Delete minItems of 'interrupts'
> - Change patterns of 'interrupt-names' to const
> - Rename the file to loongson1-apb-dma.c to keep the consistency
> - Update Kconfig and Makefile accordingly
> - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: Add Loongson-1 APB DMA
      commit: 7ea270bb93e4ce165bb4f834c29c05e9815b6ca8
[2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
      commit: e06c432312148ddb550ec55b004e32671657ea23

Best regards,
-- 
~Vinod



