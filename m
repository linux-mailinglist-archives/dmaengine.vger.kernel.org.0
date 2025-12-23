Return-Path: <dmaengine+bounces-7887-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB76CD920F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF4130A816D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658F33375C;
	Tue, 23 Dec 2025 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXcrXQUK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5C3314CB;
	Tue, 23 Dec 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489326; cv=none; b=c4C5jowXq2J6lYtZSrv7GyEIyxejxNquWdi7jEVJCFf00ovX6pKUbvpNbdNXp3AcxGOLTJ2VNWvOiOZcQRbT1iSoo4Z+BLA215QQdbehGaJ/2aqx8/9SaKh/zOSRn0W8mu24dy8KN1Kr6stf5nEMYfy5Gpblk72afhiyfms+OTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489326; c=relaxed/simple;
	bh=eOIiJTg87KZoXyZI/ZS/lA9apqI7cx2ccwsU6fjgU3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A+iHyeHLHnPTn0XyKV9Qn0a9TOlFV3Dm1a0YHE/QAdkd+CMEanPZFIgGVYaMGKeCL+0nfz8VqSoxm7R2uqZREfIpYyuNupncwbrHn1Q05Agm8xA4LzFNSdsYbyHhBqrZEJzmE2HXzNAAGv8a/E+YetjU/8TIThX6xgycNZBDhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXcrXQUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABBAC116D0;
	Tue, 23 Dec 2025 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489325;
	bh=eOIiJTg87KZoXyZI/ZS/lA9apqI7cx2ccwsU6fjgU3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BXcrXQUKMKbWls6QLJXwo/Wt8OeHk0k8ksI2AvD21eKBO3haiE04qbJSt2PByaa3F
	 pKXqD/+T340++ZrRFo2Qy8nRIeoQB9OXKzGeoXT5Cw2ZCQZpJvnR79s098srsjH0rY
	 rLEowP+kqQt1sjKll1naO8PXjKzUZvNJh+bkp6h8QfeyNa74FT0oRODxbbKzeaujF3
	 9tNnnELLuNFz6GhZ64qsdnWdX7q+oMf/kF286WVhAe0wtEk3HJbpuDThPJhvyJbAHs
	 rx9dEVj7xGaP4EwTNftnZaoXh8DylkOOC19c/EFiusciCq/X+6QEs8/1LSMADwS2SJ
	 FTHmSpxn2XJEg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, "Sheetal ." <sheetal@nvidia.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
 Sameer Pujar <spujar@nvidia.com>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20250929105930.1767294-1-sheetal@nvidia.com>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
Subject: Re: (subset) [PATCH V2 0/4] Add tegra264 audio device tree support
Message-Id: <176648932106.697163.11384203027531307860.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:41 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 29 Sep 2025 16:29:26 +0530, Sheetal . wrote:
> Add device tree support for tegra264 audio subsystem including:
> - Binding update for
>   - 64-channel ADMA controller
>   - 32 RX/TX ADMAIF channels
>   - tegra264-agic binding for arm,gic
> - Add device tree nodes for
>   - APE subsystem (ACONNECT, AGIC, ADMA, AHUB and children (ADMAIF, I2S,
>     DMIC, DSPK, MVC, SFC, ASRC, AMX, ADX, OPE and Mixer) nodes
>   - HDA controller
>   - sound
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: dma: Update ADMA bindings for tegra264
      commit: 0b4f3aeee766fd3cc3bf254a26b9761d9b53818b

Best regards,
-- 
~Vinod



