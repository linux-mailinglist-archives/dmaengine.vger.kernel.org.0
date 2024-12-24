Return-Path: <dmaengine+bounces-4072-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FCE9FBCB3
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B1B1639E1
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E641D8A04;
	Tue, 24 Dec 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMWWSZiJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85341B87F5;
	Tue, 24 Dec 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036952; cv=none; b=PUbPJ06HDZc390N8VIxf1IKa1NjujJ5+QnTKvgsHoDhPxqbZ7j3FfI7hK7xMaWDE18AK5VaUsLRt1tu5uUR7HFTHrsukCxTWmocmf5vSVBzqIbcgwLBdTqBOypV3I+703YlEZrWoDC8OQ2h5AaPFh2zcLHEpDGdTgW8Qu4AnXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036952; c=relaxed/simple;
	bh=BiLEFi3wUIMXynIvvrJUUlqWnxsog+eEjk5ujxhqeNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dBKenYiLrHPqFxxOIrMK/vwkz2x3Oawfbi73fjOxcAP8+/bzTohOX1Y7hXChi37Uy01413sst25xliCn4dE3RYNne7+O3dyp1p6OB9sIXgP7Lqy7bqVpBDjtbb1MU7bRKGzMhEhXNb7XUYT0aMJ1aDAnixJ8sp0YVQhW7Cp5mbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMWWSZiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBE3C4CED0;
	Tue, 24 Dec 2024 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036952;
	bh=BiLEFi3wUIMXynIvvrJUUlqWnxsog+eEjk5ujxhqeNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eMWWSZiJGHhpvMsugSJloNQEnZ6UXJpG7Tx/QrnH1/lPwJP0x0/IU5OIwfDDALCK6
	 mcCSN/ehRNaC6fZ0VsyMDrqI95RL29RzH1ggzdCUbUpM9DxhqXgkHFEKDofJZUsnxW
	 MovyYRnRLfOx/mkEfQKL+wiZFTMSxapsS6TBg3MBPCyhf5CrkwxI2hOaRXKis5aj9y
	 Ra7CHalvuTl6U7veGJEc0wrJ0+i/u+CjlWrcKoMZ6vEOHpBG1cytmPFK56gFlP/45/
	 Ga9T/fUMYjdnIPkc6U/xcCiveAg8zxEN4/zjB1vGodt5KnYPfGqYufz4lzttTdWcC+
	 AhiWnbaZ71oGg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205-xdma-v1-1-76a4a44670b5@microchip.com>
References: <20241205-xdma-v1-1-76a4a44670b5@microchip.com>
Subject: Re: [PATCH] dt-bindings: dma: atmel: Convert to json schema
Message-Id: <173503694919.903491.17046143764457899816.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 05 Dec 2024 15:26:18 +0530, Charan Pedumuru wrote:
> Convert old text based binding to json schema.
> Changes during conversion:
> - Add the required properties `clock` and `clock-names`, which were
>   missing in the original binding.
> - Add a fallback for `microchip,sam9x7-dma` and `microchip,sam9x60-dma`
>   as they are compatible with the dma IP core on `atmel,sama5d4-dma`.
> - Update examples and include appropriate file directives to resolve
>   errors identified by `dt_binding_check` and `dtbs_check`.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: atmel: Convert to json schema
      commit: 5d6670033a67b288ffbaa0774966f356b9c4ba5d

Best regards,
-- 
~Vinod



