Return-Path: <dmaengine+bounces-4066-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650739FBC9B
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628C81881921
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988D1C3C10;
	Tue, 24 Dec 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lChuJG9F"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE71C3BE3;
	Tue, 24 Dec 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036934; cv=none; b=M+GQoEw48AYNGJUdgTxguE4h74nLQgCzSXWPezb63bgvZ8rGcWJF3O3pCs6hx5TNzbEBKhs+zWwkCkcJcMES3AT7tJRY4pRsTzAtQ/WmkwGEhkjhKlsdW6WXf4cLlwwczurcYobYqgeNVE672lmKJzoXgYg+vImZw/4ldb9qZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036934; c=relaxed/simple;
	bh=aMnS4IKN1s//xM/IVQp+b/FMuKdwpIxp7wjx4jEt384=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mxUVM0r9GsjWWxUsUK9SduUil9ZojXI0pk4zuV1W/04GVW1N9ruoLq23JndT49UDgZ9O1JBRdsoUo+frb66AlfyI2afWSvi40J5J7gJjO2DijbX/VkT/OG5z1G1BCUh/cCJb9JcAeGkGCal9u1YBLx2R4CFrkz083L3+0+yAVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lChuJG9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C4FC4CED4;
	Tue, 24 Dec 2024 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036934;
	bh=aMnS4IKN1s//xM/IVQp+b/FMuKdwpIxp7wjx4jEt384=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lChuJG9FIOvI4BTnpJlyqTLwTUyeyLQlKv4lQWUXoirJUTJuM7B8KBqIrA+RKrPgu
	 1OMGEr+erSrm6MWzfqSYok/b2tvdMP2XVeXCc5m94oguttiYurK0ntpy6OdiZvvfZo
	 3784S1ETKNvjHHv0R75z95PSVxvE18dfZC1dPv5VjSo4YPNWO9/rfGIIoVPm5voZlW
	 YtX/EoQOf6dJIwzMz+lY1i8cXU7PZyJIXdjAvmnnSO6Oz4ACTRO/x/dB3X+pxzGSFg
	 zOGFwcPH/lsgoYlN5nwRP0yYfxZ5BRXDF/cmyyXBYjFzH9WtztV3qFq8VjUeAvm+o9
	 PP2G6HjivknUQ==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Mohan Kumar D <mkumard@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 treding@nvidia.com, jonathanh@nvidia.com, spujar@nvidia.com
In-Reply-To: <20241217074358.340180-1-mkumard@nvidia.com>
References: <20241217074358.340180-1-mkumard@nvidia.com>
Subject: Re: [PATCH v2 RESEND 0/2] Add Tegra ADMA channel page support
Message-Id: <173503693084.903491.14497745388505993099.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 17 Dec 2024 13:13:56 +0530, Mohan Kumar D wrote:
> Multiple ADMA Channel page hardware support has been added from
> TEGRA186 and onwards. Add channel page handling support in the tegra
> adma driver
> 
> Changelog
> =========
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: Support channel page to nvidia,tegra210-adma
      commit: 762b37fc6ae2af0c7ddf36556fe7427575e9c759
[2/2] dmaengine: tegra210-adma: Support channel page
      commit: 68811c928f88828f188656dd3c9c184eeec2ce86

Best regards,
-- 
~Vinod



