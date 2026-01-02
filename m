Return-Path: <dmaengine+bounces-8000-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE4CEEB2A
	for <lists+dmaengine@lfdr.de>; Fri, 02 Jan 2026 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A62300D436
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jan 2026 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88A311C39;
	Fri,  2 Jan 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMq5sKk4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F74310763;
	Fri,  2 Jan 2026 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767361941; cv=none; b=K2y3fQla7p0Fx7+wNI4zi54M2UzGm+S74JWdpEByDwPYJ37liz39WZ84ZYF0SJe8yXBhSsCWFNOn6SNmInM6UU1jmPHh85gusvvSxHZ+7qKxw1rsnqs3//WIlG+dqOgy9AOhjGD2AYSUk/uEnkX8WX7F1y8l9TYpjf+2sfJ6yUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767361941; c=relaxed/simple;
	bh=BqNSZT2cOzI2ag9wybPe7EepahdlA7tYbjaMGwVTos4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OXefBHEW7IBfhL3eaBDd4fk9rwpHGH7W+zUM5KRc8DZDQ28qoQhs093lY2i7QRo6iGsXJvAHlg2t4HnbMU4M6BbsGWRb/YLo2KfJ6PUTYukKfS6JA6zcNVi+INUfs9LruPH+cusWRIbspZS6/+a01ckv9y2t09OVJUzZThialLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMq5sKk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A634C116B1;
	Fri,  2 Jan 2026 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767361940;
	bh=BqNSZT2cOzI2ag9wybPe7EepahdlA7tYbjaMGwVTos4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AMq5sKk4Y5TY8W5lO9XhJcdZY68sJj3Sv7XTA5DdpnxQEVFP2sRwuA5tq0spUFpQ2
	 Dnu+GACBmemUfaTq8cgVJsRX8gVCGHNIhosyVm9W8Yu1ELfRmGnLRVaFmqx1NaUhvv
	 6m2Li4+2UAHV7VnfVEYmKI6A3j1efikVPNN655hUiZE1RisyESxWtqZQTJyVvlSJaY
	 xXirzBBxyl3i9WiaF6qT9N6tLvsh0kUcJWFU1bSzhb6naipJ4nVWdsR6S6fnUlrTNS
	 s1vYH467k6EWE0r+WXIPXSE0dNbAUvWzNMi0jliIM30AOypKi8Z6yk6xD93yK0cPpV
	 bhbuQ8jqY9WaQ==
Message-ID: <e10dd345-01e6-4be7-bd9d-d0a464aa679e@kernel.org>
Date: Fri, 2 Jan 2026 07:52:20 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: intel: agilex5: Add simple-bus node on
 top of dma controller node
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul
 <vkoul@kernel.org>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1766966955.git.khairul.anuar.romli@altera.com>
 <ef6ed8338e54c02ed9508e91bdf120580e834e17.1766966955.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <ef6ed8338e54c02ed9508e91bdf120580e834e17.1766966955.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/28/25 21:49, Khairul Anuar Romli wrote:
> Move dma-controller node under simple-bus node to allow bus node specific
> property able to be properly defined. This is require to fulfill Agilex5
> bus limitation that is limited to 40-addressable-bit.
> 
> Update the compatible string for the DMA controller nodes in the Agilex5
> device tree from the generic "snps,axi-dma-1.01a" to the platform-specific
> "altr,agilex5-axi-dma". Add fallback capability to ensure driver is able
> to initialize properly.
> 
> This change enables the use of platform-specific features and constraints
> in the driver, such as setting a 40-bit DMA addressable mask through
> dma-ranges, which is required for Agilex5. It also aligns with the updated
> device tree bindings and driver support for this compatible string.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v5:
> 	- No changes.
> Changes in v4:
> 	- No changes.
> Changes in v3:
> 	- Rename the patch  "arm64: dts: intel: agilex5: Add dma-ranges, address
> 	  and size cells to dma node"
> 	- Add simple-bus and move dmac0 and dmac1 1 level down.
> Changes in v2:
> 	- Rename the from add platform specific to add dma-ranges, address
> 	  and size cells.
> 	- Define address-cells and size-cells for dmac0 and dmac1
> 	- Add dma-ranges for agilex5 for 40-bit
> ---
>   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 78 ++++++++++---------
>   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 78 ++++++++++---------
>   1 file changed, 43 insertions(+), 35 deletions(-)
> 

Applied!

Thanks,
Dinh

