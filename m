Return-Path: <dmaengine+bounces-2589-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8E691BC40
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7E01C2259E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35B155C98;
	Fri, 28 Jun 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsAkHsag"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1D154C0D;
	Fri, 28 Jun 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569417; cv=none; b=Zx11gtGaGW6qDa1QSFN0A80FScnMeYaCYlixpPNy1M4rxVvZ+83jrgKkD23bWAQCWii2FHUWfgjyPquSJUW/Z9UtGRDKJg+bOX8ISPTfeYCAf/YeWbv8UwULALjX+8qNUvvd1rV38qLpaCoBeLYWCvoCVh5YvjIV/hNl35WnRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569417; c=relaxed/simple;
	bh=r5yxHpvZWjXJLLBu9Egy6T8rKUemMj1f5NJWP0DFGfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T2jbYQJ7R7TRARK8Gn4gzqzTFYdY8DHEvfYuQ5FInHcYZB3Yg2l2Ybs/6XCE88MxDWKSYwsQXbNzPCQQfENxDgHno3YuFZvBbXJxw0pKq4rcOKqZ9wVZzr4NBywxRlgU4BKDav/1LVJZaK6hmG95LHw0VMaAYrhuegnjeQI0bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsAkHsag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C91EC32781;
	Fri, 28 Jun 2024 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719569417;
	bh=r5yxHpvZWjXJLLBu9Egy6T8rKUemMj1f5NJWP0DFGfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DsAkHsagsGW70KoGQ721SpKCN39iB7gGgOHicJyphuLw8/O1DFTiEjphEa9vEddBm
	 Zom4bX+ALiUUcJlp5ZQsMSoOK02jyEYvtncvhdjJFplrfW9qZRYwkvkuEKYmlJS1mt
	 YmPEkaSiMF5l0lDTOSx0nKkMzt9X+SaVKz4saacOW2PiFA1ysIGz/jtR1H2NN3SusI
	 GhvFS+0DhEmp+cPsBNAo7MYV7p+C4XgTG5DzoSZXOXg4E7PeD3zhqc91FNlTLYyoqL
	 oiIUcHqwP+K7MKYs16pPRLT0vyNKOYJHF58nQsRpDWXXX4hIngf5KLv1vz0sgBK75g
	 8iR/L4G8RJmKg==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240613-md-arm64-drivers-dma-ti-v1-1-b1154603f341@quicinc.com>
References: <20240613-md-arm64-drivers-dma-ti-v1-1-b1154603f341@quicinc.com>
Subject: Re: [PATCH] dmaengine: ti: add missing MODULE_DESCRIPTION() macros
Message-Id: <171956941491.519169.6048682128414612902.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 15:40:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 13 Jun 2024 12:27:22 -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/k3-udma.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/k3-udma-glue.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/k3-psil-lib.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: add missing MODULE_DESCRIPTION() macros
      commit: 61879ffd6f6f72fe984ee343d2499e96bcf10e3c

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


