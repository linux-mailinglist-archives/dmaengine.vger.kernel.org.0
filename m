Return-Path: <dmaengine+bounces-7363-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6CBC8D3E2
	for <lists+dmaengine@lfdr.de>; Thu, 27 Nov 2025 08:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8E084E6D38
	for <lists+dmaengine@lfdr.de>; Thu, 27 Nov 2025 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047B31B119;
	Thu, 27 Nov 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERnlZ02D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6E32E727;
	Thu, 27 Nov 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229690; cv=none; b=tqIh7O17a2U51v/jo9spb1D2ukOku2hgqW2U1yO0pqvNEMi8YYTV2f5kyDcR4g8IYf6Bj0XP6yH28cAIWPcauPFQ9VznmGPD0RJPxvQExjDlQFUApDMXYPpWUS1768mgTWANhyZU0uH4IjRVeR+ZEUoic2EonOgafwX/yLHjUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229690; c=relaxed/simple;
	bh=/Qr2YmhnCABhQkXWrs0mkP1C3iyMiGCgJI+FA1RUxxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo0nQ1cMty4DEojH9yF07+J0d/ff0kXr9d0QF0o5vJ7sjBFQr52sHpAR9WGYNhx+F7f725qkBKDYmyb8tcRfzQZFa5S+C8t0pknXLgpu3olD7kN2oyaDP1Gg3l98j2tLjTPcZmLH5zGNc52PL5SsaSJZPGfQy/EFlTtJB3kQJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERnlZ02D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A6C4CEF8;
	Thu, 27 Nov 2025 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764229688;
	bh=/Qr2YmhnCABhQkXWrs0mkP1C3iyMiGCgJI+FA1RUxxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERnlZ02DZtcomfDUwdOPNDbq2+IAQhnC5+D+aG07Pst/ssaq5yf4iwefopb2l1IYJ
	 LRRo71fdopoXg+6DbBz3PQ2efaOJC81Z4Hr+PQYVR5FFANJ1TgEbUvd8herlOwRhjW
	 tS5te/acaTNLUwdANynhx+0gLDHfTe6+dxUWPl+GorMuDaqJnI+fFJ1tZMjA8UNk/z
	 KzC3um+Fzuq8xMV1+UxvkFRuROQGRucG9d+Sl5XGVLaxLP3iQ9ngPkMl8JC7x+qdyK
	 /rp7inSy0f4gvHMqHVBCqkAsmEaxu87PEXUxdlUaDNOLJEBN8Qwzu9Y30iDzx+UEnr
	 15sz9WYYaGURg==
Date: Thu, 27 Nov 2025 08:48:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Niravkumar L Rabara <niravkumar.l.rabara@intel.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: mtd: cdns,hp-nfc: Add dma-coherent
 property
Message-ID: <20251127-logical-gerbil-of-destiny-bd6d4f@kuoka>
References: <cover.1764143105.git.khairul.anuar.romli@altera.com>
 <af528a83b4749fb3e6062bbc75bcb4fd5a6fec23.1764143105.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <af528a83b4749fb3e6062bbc75bcb4fd5a6fec23.1764143105.git.khairul.anuar.romli@altera.com>

On Wed, Nov 26, 2025 at 04:06:22PM +0800, Khairul Anuar Romli wrote:
> The Cadence HP NAND Flash Controller on Agilex5 device performs DMA
> transactions through a coherent interconnect. dma-coherent property
> presents in device tree will allow the kernel=E2=80=99s DMA subsystem
> controller=E2=80=99s to performs DMA transaction in dma coherent mode.

Last sentence is redundant. You say basically "dma-coherent means
dma coherent". Write informative commit msgs, so something which is not
obvious, e.g. why this is dma coherent NOW but wasn't before?

Best regards,
Krzysztof


