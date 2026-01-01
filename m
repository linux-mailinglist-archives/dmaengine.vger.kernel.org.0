Return-Path: <dmaengine+bounces-7993-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6178ACED3D0
	for <lists+dmaengine@lfdr.de>; Thu, 01 Jan 2026 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D593008FB5
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jan 2026 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4AB2512C8;
	Thu,  1 Jan 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl7DQrFg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0C220F38;
	Thu,  1 Jan 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767289306; cv=none; b=RFJbKXqHt3V1FSe8WNHO+IQR5uwvRf3IgSvZlkLm+FvMVeumRfnGQZtI74yytSgHaCEhZSCZ8kPTwXrqpwB02CMBIHuAPHozHN+pm9nkZTxZ2q4dCtumg9xLyn0044t/ZKHcx/VlXUaauQhnA7XxTB8TGeFAt4p9vOhDXhzkhfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767289306; c=relaxed/simple;
	bh=ZWbNhuNoC8b/kJFEaYAS2ZjsFjFEBUbWkUGBo3A4E+g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HXUY5RiFHYKxuiJS3va7gcrBAvtZsPWmZ0dlxO9hoxVRB/UysRg8ZvIfvZY6WOKD+SqqCVvMWxP4GxXWRYkEnsAgGMo/nBc7xS7yO48coFL9uFXYfHfRQndNjbMplXroZ3EimNW3Xaw6qBKqIXgRqNSxG5nlx/dQ4QWiL+0LBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl7DQrFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E040C4CEF7;
	Thu,  1 Jan 2026 17:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767289305;
	bh=ZWbNhuNoC8b/kJFEaYAS2ZjsFjFEBUbWkUGBo3A4E+g=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=rl7DQrFg1BNmiwvOSo0xMdiSSh9m2Lv2ahAlpeYOmgtsxtq928Cj1MvynEQxu8E+b
	 yTypJK0T0wZK/gTtOBHdUKusXNJZubSz4PQq+SIRbpue/vGp9DQiOX7LSLD+l1CiPl
	 CtkSM/v1QR9eGhBf7ElCQySLviJJtg/9U5NX2kKLioLG7HDw6535uOB5dIcpePULNb
	 11WXEaOUG6p2kM+6O1bDiEpuIBHfBKiJIruw7IcZtZ+ddOl5H0OAjKOTmXtvWNi9z8
	 68QOC5pE7IxtAmq6HcXLE8EkbzvUjz8VCCpKY3ApAFzzzKAYEWLXhGYCaBNpItnm+6
	 TgLgmxblU1mvA==
From: Vinod Koul <vkoul@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>
In-Reply-To: <cover.1766966955.git.khairul.anuar.romli@altera.com>
References: <cover.1766966955.git.khairul.anuar.romli@altera.com>
Subject: Re: (subset) [PATCH v5 0/2] Add Agilex5 AXI DMA support
Message-Id: <176728930288.239406.12362948217259379016.b4-ty@kernel.org>
Date: Thu, 01 Jan 2026 23:11:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 29 Dec 2025 11:49:00 +0800, Khairul Anuar Romli wrote:
> This series introduces support for Agilex5 SoC in the Synopsys DesignWare
> AXI DMA binding and updates the device tree to use the platform-specific
> compatible string.
> 
> The Agilex5 only has 40-bit DMA addressable bit instead of 64-bit. Hence,
> this specific addition will enable driver to handle this limitation.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
      commit: 0a6946644f0d1151d31212820497e1a49fe1a0a6

Best regards,
-- 
~Vinod



