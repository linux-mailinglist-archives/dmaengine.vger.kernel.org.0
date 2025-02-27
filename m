Return-Path: <dmaengine+bounces-4587-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7875BA47CE9
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 13:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B075188F373
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739022D798;
	Thu, 27 Feb 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHdCOLJC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9A22D4FE;
	Thu, 27 Feb 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658073; cv=none; b=Yat14AT1LqpZOSv2oJLct3EgcjiFdX+iX/4qnlzbJ6vPZgvgBfIe1J8DThC/CQGLLA/N+gqc4b/FiJO5ZaYhOyKVl9qt6z6ZMKb81jI3OmxekegqGflJp85bdxEKr87mbWMyYfrRwmTPAjt/ikzWYjIemA6N8DxGIchpJuM2X7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658073; c=relaxed/simple;
	bh=XeRhQ6iq6uKT/D+pyDPZgb7AbcoHU0EabaJrmBJdI+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MCOfPOMoWE62ed3C7Zwi5+mB3JUSTJ/+X+w6MT02biPmA5hEBT3F+l5j6YEAs+fKsg8v1wX/to6V7WmR7i/i2Z6ZIiKnZZ1BwvgspW4DT66j5QRYZ/2HrOxyN3fAISP+Fd+QObc+J/uo/m+xyBeaofj76jl8jKUTT9XYhyrin2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHdCOLJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D6CC4CEE8;
	Thu, 27 Feb 2025 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658072;
	bh=XeRhQ6iq6uKT/D+pyDPZgb7AbcoHU0EabaJrmBJdI+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IHdCOLJCXFMQcKDXTBbd5QCoOizYpE5URnyiFNAasjlOnNLT5ECIj//PcH0kWMFVe
	 lEpYbKBGqTOUHrgtxTqXoFokwe5MfuFI2bkNpTo/WVY+0Mr/XiGC+2onpLAuxng/eH
	 QGlI0zsWnCOHseAXuMInqtQLzcbx0ztw5ImyEWtff3hsxgIDNxTd5GlbTM/l4MyTPM
	 AXzL/UdBkODuMCt7Jm2PguiYx3H6wxgasJtqNoR+HJuoXE28OH6y27cqdpaqGBYlBG
	 En56VXbzMy9zqkgcn3qGrd1piftlK/xyMcLo5MDYwNubmJBVtSHt3vPLyQf/yGf212
	 IzqzKNIskEYSQ==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, wim@linux-watchdog.org, linux@roeck-us.net, 
 Ryan.Wanner@microchip.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-watchdog@vger.kernel.org
In-Reply-To: <cover.1739555984.git.Ryan.Wanner@microchip.com>
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
Subject: Re: (subset) [PATCH 0/8] Add System Components for Microchip
 SAMA7D65 SoC
Message-Id: <174065806827.367410.5368210992879330466.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:37:48 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 14 Feb 2025 11:08:13 -0700, Ryan.Wanner@microchip.com wrote:
> This patch set adds support for the following systems in the SAMA7D65
> SoC:
> - DMAs
> - Chip ID
> - Dual watchdog timer.
> 
> Ryan Wanner (8):
>   dt-bindings: atmel-sysreg: Add SAMA7D65 Chip ID
>   dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
>   dt-bindings: dma: atmel: add microchip,sama7d65-dma
>   ARM: at91: Add Support in SoC driver for SAMA7D65
>   ARM: dts: microchip: sama7d65: Add chipID for sama7d65
>   ARM: dts: microchip: sama7d65: Add watchdog for sama7d65
>   ARM: dts: microchip: sama7d65: Add DMAs to sama7d65 SoC
>   ARM: dts: microchip: sama7d65: Enable DMAs
> 
> [...]

Applied, thanks!

[3/8] dt-bindings: dma: atmel: add microchip,sama7d65-dma
      commit: e19ba02eeb8e98086708ee11ca1b123d17ec1977

Best regards,
-- 
~Vinod



