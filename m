Return-Path: <dmaengine+bounces-1032-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB39857CBC
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE13B23D22
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195612AAD7;
	Fri, 16 Feb 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXNVFE5W"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545112AACD;
	Fri, 16 Feb 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086912; cv=none; b=K66tfj7/B75FUezMj6ktJtNJsRZ3xGaH2qaoCS1I0B9MFKrcvlzPZhSJ2WWgYz1bBTGzPlx+P7M56uKQdhYQ6cXzO3Eekn0aNU22ZQXvpH7FE7rsUNhx5ipVOlxMwN0SbMjKwBnJxC2EYOQdxUH4TaHBZ4tDw6uBLF4csqsKq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086912; c=relaxed/simple;
	bh=UCRiDyTqdTBsdu54tzQMV73u+uOJTw/lzTO7cUztjsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WRmgL2J02zBsy88FMpvEIz/OC7NCP4JF4CeaTFuzEXlx1npKmEzdfb2XR7nzdHd84STNVzUjU91/AKuuItrKWEFXUAid5YeZZGIZzLBm2eJt5F1VeTGh/8127qARfOVYvsISM2mHSI52Zsvu/eFEJcMPnTggbTtyiyG8eNRN0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXNVFE5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A519DC43390;
	Fri, 16 Feb 2024 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086912;
	bh=UCRiDyTqdTBsdu54tzQMV73u+uOJTw/lzTO7cUztjsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FXNVFE5WwTEsk8Bfhtzq5qn5xeME8qrv+hVulFLS3GE5ukWRdA7tF2IT855hoHMJT
	 vL5CrYah9+d+uEWoTLI71TayZ+ZKRF4QKW03k2krROUYQ+sUYFUZRHqf7bwX0rTNeJ
	 rwU+Rv756b4oXkW2qHQZVbb/jZkd7oEme++pRE3X9W9+QaTBJ8PRxsjIaCgb/ZJsB/
	 UZ10e2hy2lDTP4MLxMPjnVhaJuu77QM27XCdPiSstoj5DDOyeiTd2ANl2hTNYbCx8B
	 919xeiBPkw7tFpq1Swn4IbCE8vuompsTaw9+ZWQY1dFjg+X2uyeg0Wma9mWweYK2Nq
	 64rluxBo9M0vg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <96aad3b532ee401f19693e18038494f43ddb90e9.1707915609.git.geert+renesas@glider.be>
References: <96aad3b532ee401f19693e18038494f43ddb90e9.1707915609.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: renesas,rcar-dmac: Add r8a779h0 support
Message-Id: <170808690922.369652.2274140141441534554.b4-ty@kernel.org>
Date: Fri, 16 Feb 2024 18:05:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 14 Feb 2024 14:00:34 +0100, Geert Uytterhoeven wrote:
> Document support for the Direct Memory Access Controllers (DMAC) in the
> Renesas R-Car V4M (R8A779H0) SoC.
> 
> Based on a patch in the BSP by Thanh Le.
> 
> 

Applied, thanks!

[1/1] dt-bindings: renesas,rcar-dmac: Add r8a779h0 support
      commit: 35b78e2eef2d75c8722bf39d6bd1d89a8e21479e

Best regards,
-- 
~Vinod



