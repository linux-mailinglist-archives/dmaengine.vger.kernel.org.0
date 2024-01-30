Return-Path: <dmaengine+bounces-901-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611DF8429F4
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936661C23B66
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF112BF21;
	Tue, 30 Jan 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMdKPIhM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77612BF1B;
	Tue, 30 Jan 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633467; cv=none; b=P0FLs1pWvqXKzZ2ZCGSajngcfD9efBO6JfE4kZ1r2d1NIY4SEy7jPn/i/+Gcsi8c1YkkAPo+FgkygRe4weTPSm2UJ7WUv58aaFHavSYuEHLulqvj3CchvQYqai8U91ppFoVZ+m/gAg08BkXnXZE1ku38Jebj3b3VDRDgVzg4Ucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633467; c=relaxed/simple;
	bh=3J+WSpDRUsRJnrArZ9BoJxmiZJqhIfdmmXusteVUKXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RnDHptlsgPdBBBZonjgDzCxgxWZIjKFJTwUedtPsZNvjk2fRaLeX1OuD54SkLBbc/jxX62d5q/+Wssqo8XMLgr0i7Sv7ssq7rmp6viZwsfRNsrhrSZ/L7qjTpJo4EEgOPCzuKBe8gHSFFS4EiPDiHELI0LaSrhVXSsdb64hn60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMdKPIhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3906DC433A6;
	Tue, 30 Jan 2024 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633466;
	bh=3J+WSpDRUsRJnrArZ9BoJxmiZJqhIfdmmXusteVUKXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aMdKPIhMbYX/7RAVNodFnyTaUz5rhHYLPz2mgGk9s+C6UEi+PvX8vCO82mpaWlMPm
	 MygEXhjAs3BFxdDEsTNraeqrQm6Q7qXAQlG7mPaC8jLxXwzYzbJXEioCKnSqmltxVy
	 K/MibYo2Y0gUgyyVrnhju7c9O0kDKe+/rCTZkQyMKq5SCxWsySPGwMF6cOLVHYW6SU
	 pWBkrpppD75HlGSCyGf7507RgVAHorXsXbM8z1AWbTYfb2nfxr006sma+PqC6oKti6
	 fgH1/YtDS/2DaUGAK6eL+OBKR98n1j2xvdYXVcr7KQap9/xTdg19s33Xib67T529m0
	 iEUEetLdfvVtg==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com
In-Reply-To: <20240124124319.820002-1-s-vadapalli@ti.com>
References: <20240124124319.820002-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v4 0/4] Add APIs to request TX/RX DMA channels for
 thread ID
Message-Id: <170663346383.658154.6469293255184472126.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 22:21:03 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 24 Jan 2024 18:13:15 +0530, Siddharth Vadapalli wrote:
> The existing APIs for requesting TX and RX DMA channels rely on parsing
> a device-tree node to obtain the Channel/Thread IDs from their names.
> However, it is possible to know the thread IDs by alternative means such
> as being informed by Firmware on a remote core via RPMsg regarding the
> allocated TX/RX DMA channel thread IDs. In such cases, the driver can be
> probed by non device-tree methods such as RPMsg-bus, due to which it is not
> necessary that the device using the DMA has a device-tree node
> corresponding to it. Thus, add APIs to enable the driver to make use of
> the existing DMA APIs even when there's no device-tree node.
> 
> [...]

Applied, thanks!

[1/4] dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
      commit: 81a1f90f20af71728f900f245aa69e9425fdef84
[2/4] dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
      commit: 7edd7a2fd345b10e80ee854aaacc6452d6f46a7e
[3/4] dmaengine: ti: k3-udma-glue: Add function to request TX chan for thread ID
      commit: 7cbf7f4bf71a054d687c8860380c655a36d0f369
[4/4] dmaengine: ti: k3-udma-glue: Add function to request RX chan for thread ID
      commit: e54df52312fed462a005706d5d7ed6250da91d1e

Best regards,
-- 
~Vinod



