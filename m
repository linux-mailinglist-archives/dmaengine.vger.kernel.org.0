Return-Path: <dmaengine+bounces-4060-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA19FBC8B
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC617A223A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ADA1B219D;
	Tue, 24 Dec 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMtKRzZ4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665F191F91;
	Tue, 24 Dec 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036906; cv=none; b=eFVKT9WsKmAfK68a9WvmbJbONtVPSEHO87d6qPdGvRea3NaWyZyAmqvoR8R7TL2qFWFCDqJA/WKPq2YOsbwgxGnj0OsKTuAQu1cgl+nZy3q6wM/WUE1fi+lJYugdYWsPyLvVTtiFYvaPVF4kxd3J7SeB1ibcAFUccclfvXd6z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036906; c=relaxed/simple;
	bh=GkxtSoGgW/YDAL1IFgPolUg9Fn/eunPwJeEcWD/wjLo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vBUlqCmFwduZbvWLzddwlXKHLzxBqmrNJlQnKJfg1LqTkd9o7Q9ZelJ/2wBrfUWhYNj/JON2Sojmlxr+pwtFF5ZtUvWu9NGQvT9meUw7Vcuw1J/NANKSOhH3KlVzwWsp0LG+byFK9b8RABg/TVEVLGnsTuZWX5i5AmPIZ3oTDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMtKRzZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7CFC4CED7;
	Tue, 24 Dec 2024 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036906;
	bh=GkxtSoGgW/YDAL1IFgPolUg9Fn/eunPwJeEcWD/wjLo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=cMtKRzZ4X7m56eU1OaUovedFWqQhg9U4MhZI+eGeaR2+Ph0lO1O4JiptBBVcn70Rf
	 7WEk9hhAuKF2JjEFVFfcwnfxqWeaA9opnL/o/yfd8cTJeSSUAkldWmgq3xitAlKzGW
	 d5ty2SF5V6lnIT52nCbB4tcsxWcB2RTac7IHOY4FRf+JGv46y282sj/jns6alcrlCD
	 Bh8GWNJ7I1WKvZNOvpREWrboQgZYH+vCXnfG0xDqUBi7dQ3NLryp1s3V8cEn0iEsj8
	 P+RygfbtXydh2VmDF7djt94VwUAUlXJk9jYgZOp5GxB37DlpJIEAEtirKlr6dZMEuw
	 721JmB8AtOMuw==
From: Vinod Koul <vkoul@kernel.org>
To: ldewangan@nvidia.com, jonathanh@nvidia.com, thierry.reding@gmail.com, 
 rgumasta@nvidia.com, akhilrajeev@nvidia.com, dmaengine@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kartik Rajput <kkartik@nvidia.com>
In-Reply-To: <20241212124412.5650-1-kkartik@nvidia.com>
References: <20241212124412.5650-1-kkartik@nvidia.com>
Subject: Re: [PATCH] dmaengine: tegra: Return correct DMA status when
 paused
Message-Id: <173503690354.903404.1508993653667661297.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:11:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 12 Dec 2024 18:14:12 +0530, Kartik Rajput wrote:
> Currently, the driver does not return the correct DMA status when a DMA
> pause is issued by the client drivers. This causes GPCDMA users to
> assume that DMA is still running, while in reality, the DMA is paused.
> 
> Return DMA_PAUSED for tx_status() if the channel is paused in the middle
> of a transfer.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: tegra: Return correct DMA status when paused
      commit: ebc008699fd95701c9af5ebaeb0793eef81a71d5

Best regards,
-- 
~Vinod



