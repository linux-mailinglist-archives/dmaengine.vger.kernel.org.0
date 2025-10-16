Return-Path: <dmaengine+bounces-6867-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99042BE4179
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 17:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9C35E17E8
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF89343D95;
	Thu, 16 Oct 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4GCGMZE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65FC343D80;
	Thu, 16 Oct 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626932; cv=none; b=NAsKZ+cVek4I49kTAiDrEB0S0ceKYZB7JFIRbnwfgE4Do5SQWpv1of1zaLhmqZW7LykxJMFJFEcEmcVILUP+JcmrAC5TcYifaY+nVLqErJ9xL6tyzgm2cXJ8NrkWBdD46yBNj5ZpWmASURbdY7yg0TIIm59K8Ue5PXQQr9e9uS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626932; c=relaxed/simple;
	bh=h8tOTre9l+/6asGRXu/HExFtRu4M+VJHp3rND9iKq5E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tJZAfdj/+vge0JWloGjvaP9nVTMKSIlCHs9TgWhWBv2u6RInmzAWkwHqukdMAz5xMwnkBtV98+Rz3psWBXfb4oHlBTEb/f7zKq16SxW4lbCXj3E+Uhv/rXKKhKFRSZIaRZa+lzzGF8PZFjkkOp6+rlE77YFNaJqzXrY9z1CfH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4GCGMZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FC0C116B1;
	Thu, 16 Oct 2025 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760626932;
	bh=h8tOTre9l+/6asGRXu/HExFtRu4M+VJHp3rND9iKq5E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O4GCGMZEFFA+hZeRuLPayZrAEJ/PJGsF2i67h9/TqefC3Y6MEOA4B0YvpPVWj45Rd
	 5e+u8ZrifFtuxk3TVspKe6508ti779tpdcv1q15jF5F84t/zL81c/YmRkCzTabUrfH
	 NL1b2E6LKD+aNXQanv3pL+IIUtAnsFVHJuFExiBRBVXThWyOWaO+7c7244CILjSc0/
	 wPGGxt92uJBzrXkNv55DZXOf6JOEB380gznsWcJb29lMPcxLTZXKXDjN4Weic/fFuW
	 8jOsjAwIpSXaNaHdejO5v0ZOF6kyXmzjzyZ3L/ju+p09HKj2LvD74v9RFEYCfJ2jy/
	 lfPwnSJEQaoLw==
From: Vinod Koul <vkoul@kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <cover.1756999325.git.geert+renesas@glider.be>
References: <cover.1756999325.git.geert+renesas@glider.be>
Subject: Re: [PATCH 0/2] dmaengine: rcar-dmac: PM-related cleanups
Message-Id: <176062693068.525215.7428189499426351647.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 20:32:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 04 Sep 2025 17:25:08 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains various cleanups related to power management
> for the Renesas R-Car DMAC driver.
> ARM64 platforms.
> 
> This has been tested on R-Car Gen2, Gen3, and Gen4.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: rcar-dmac: Remove dummy Runtime PM callback
      commit: b78c6286acd7ef93ddb064b5ad08b993eab33482
[2/2] dmaengine: rcar-dmac: Convert to NOIRQ_SYSTEM_SLEEP/RUNTIME_PM_OPS()
      commit: c3c328d2383fa7f68ec93574152924cd8f5fe82c

Best regards,
-- 
~Vinod



