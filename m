Return-Path: <dmaengine+bounces-6865-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65BCBE4170
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC38958633D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676F2E764B;
	Thu, 16 Oct 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE4wy+4y"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BA2066F7;
	Thu, 16 Oct 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626929; cv=none; b=luwP5pmZKMzGQKamPeaCH0n1hF7PT5OMcAlQolfzQiAI//E5r2yMoWfBJx/Z2xyrWsaj4GRGvluHPFLMYWGPXT9L9r9onSmtPoAglkgdDYxh/c3qUnE1StK0luDtq5TlNFvU5QKGv0EIwjrJU1FV+l2y0Y7e7Ecoj2e5eHhpOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626929; c=relaxed/simple;
	bh=dY++USS02ZNrkYKhuyWZNpmVBJdvJkmJCoY4791VUyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aWeqlaqwkjVEchHtvb3DfQodRrSzpFLdyjLid++8cgmrlQYfVD2tb5WXlYws3/1VVrb6JOXxwGwyjTZSXCeUU4bkmytwvh7w3G3kvUfmGZ/ghe1vP+TYDrGIoo9d+icQS0BCd8sKNIfF1uMu77Jr68Dg8UrfDTx6PXZzRvGRU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE4wy+4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D760BC4CEF1;
	Thu, 16 Oct 2025 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760626929;
	bh=dY++USS02ZNrkYKhuyWZNpmVBJdvJkmJCoY4791VUyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OE4wy+4ywrZMHrZyLrCa2T8ZtZE/gEZ68b5PDxXs+nwJ4g0UJmH9oCYV7lIgl2eMe
	 wUzogHXipcNYhx6IwEjz0j+xHTJFDq3TVP0xn3omaL6/p49WANuLEtLHOxRXINZZSK
	 NLu/B1hkbchTqOsvJjljMVYwALNjBs1D/sYCH+wgZqeFwhPpQ99W7JnUxxzTHdPgsP
	 iHP7b1jY9zuUH40RyAqf2tokojFKMbhp+NCqIEsB52zGJiU+VyhGmx92OgKuAyseq6
	 8t3DhxeVGGRPeNGMPyF4gDoizAJoxBKcqaz2tk00ZyXRJ0SzWouRkP5plmDYGZSiRQ
	 pqKukKaborl7Q==
From: Vinod Koul <vkoul@kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <f456411acfab95f8a4213156fbbabfb90e220a59.1756999732.git.geert+renesas@glider.be>
References: <f456411acfab95f8a4213156fbbabfb90e220a59.1756999732.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dmaengine: sh: usb-dmac: Convert to
 NOIRQ_SYSTEM_SLEEP/RUNTIME_PM_OPS()
Message-Id: <176062692752.525215.5973442571794371791.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 20:32:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 04 Sep 2025 17:30:08 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas USB-DMA Controller driver from
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() to
> NOIRQ_SYSTEM_SLEEP_PM_OPS(), RUNTIME_PM_OPS(), and pm_ptr().  This lets
> us drop the check for CONFIG_PM, and reduces kernel size in case
> CONFIG_PM is disabled, while increasing build coverage.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sh: usb-dmac: Convert to NOIRQ_SYSTEM_SLEEP/RUNTIME_PM_OPS()
      commit: b46d155e0db3b98a531431357247e15dc357a797

Best regards,
-- 
~Vinod



