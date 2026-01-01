Return-Path: <dmaengine+bounces-7995-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD131CED3E8
	for <lists+dmaengine@lfdr.de>; Thu, 01 Jan 2026 18:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACED930285E6
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jan 2026 17:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8362E975E;
	Thu,  1 Jan 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coz2jbT+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652F2F28EA;
	Thu,  1 Jan 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767289318; cv=none; b=XXFraON/1YdHIQxpTlXYmE6K6lsepKssMqIYBRRUklhELpub39s7QQqsxwL2CdXxGu6lDtJypCcsqJ61Te0nFmjQXk1TZLv8rW7vtGEUGrONChJVkGl9VKmwrCs/9Fw/T1AWcX6ECXHTi8Wf7BXoW1L/xhFNjUNgAb9+nJB8Djs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767289318; c=relaxed/simple;
	bh=EzgEO36WKTuxxmrk9QYRyVB5NuHgZRZWzoxw4v+H4uk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ARkbBwyaBqcpwNODHrSub4FREi8ZkEywWzRm4BMIiXjr6A0hCCoC8ro6jaT1UnIw4M6CfYtGX10Y19r2sqAXyFf5zVv+lkT6b2GIA2/KAe20Ze/o8o4ftvilfrutZAH7KpngCwEobvVg3Zt8cWW8TbSTUTNDfIK+fiX7+68KoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coz2jbT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBC8C116B1;
	Thu,  1 Jan 2026 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767289318;
	bh=EzgEO36WKTuxxmrk9QYRyVB5NuHgZRZWzoxw4v+H4uk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=coz2jbT+XkYJivihRAqqsZ9UIfxOnUF40vslhia+SF3yAMvBv6lgzA2brj/qQ6jur
	 0JHqk0k9BM1dCa3yuRPMM/yIo9EQLE5JomAZQ8siN0sXvJ1qQ6lspcX95hoQZ72+1g
	 MNxHd1ohGHA2+UOrVgfLIiKrq8KJ04SAVk0KyNIa1ASooQDskoNx6u/FJpvfF5UaUD
	 C9ZcupaJXEVJ/EIFj1ZBdSj0PBpdCm/R7VJowkBNaU0KS+67qSglNf3mGLiQRpIyA5
	 gF0csejz/USK96ucPHS+1Mp8NyP9MpO0cUvLcK5z32sWhip5UN9CIISR3rQlNPqd/e
	 4hXdb6k7TllHA==
From: Vinod Koul <vkoul@kernel.org>
To: ludovic.desroches@microchip.com, linux-arm-kernel@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 daniel.machon@microchip.com, Robert Marko <robert.marko@sartura.hr>
Cc: luka.perkov@sartura.hr, Tony Han <tony.han@microchip.com>
In-Reply-To: <20251203121208.1269487-1-robert.marko@sartura.hr>
References: <20251203121208.1269487-1-robert.marko@sartura.hr>
Subject: Re: [PATCH RESEND] dmaengine: at_xdmac: get the number of DMA
 channels from device tree
Message-Id: <176728931580.239406.8826639306613360080.b4-ty@kernel.org>
Date: Thu, 01 Jan 2026 23:11:55 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 03 Dec 2025 13:11:43 +0100, Robert Marko wrote:
> In case of kernel runs in non-secure mode, the number of DMA channels can
> be got from device tree since the value read from GTYPE register is "0" as
> it's always secured.
> 
> As the number of channels can never be negative, update them to the type
> "unsigned".
> 
> [...]

Applied, thanks!

[1/1] dmaengine: at_xdmac: get the number of DMA channels from device tree
      commit: d3824968dbd9056844bbd5041020a3e28c748558

Best regards,
-- 
~Vinod



