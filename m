Return-Path: <dmaengine+bounces-7703-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF4CCC483E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A93333059BF8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043731C58E;
	Tue, 16 Dec 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPd7NkjR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E530BB87;
	Tue, 16 Dec 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904380; cv=none; b=i8oSc1g8AE741LNwr5x3k60SQfle9CUPn/ZBTWcWtrrUG5Mba/8b/hXoAVyl2rxIkYnWk8i56Fsv1nfylNmtxEAxRc9bu4KN93DO0HtlLgEVUsicTje3CIFa1reimZqGtU5mdmpPp8HXAO0MWUtko7UmiT3pFyIzoAojFYN6RMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904380; c=relaxed/simple;
	bh=MYYN5ovVnme2x4lpuOhTvRHfYjuOenPXUPkmv+yXF3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eiOw1L4P+17SaPapvxZnr2CJdbKwrLdYuQCXeW6VPnuAR8QxSYagGkCCxFVJBoPOhpOKrRIixhEEQCYGh0y/Cbd/JEX3iUUIHzdmsVJajccy+twnQJ7yrxQ5Dyv0Izv+fjyu9KusSFBQO2l2Op3IMoxzX6ICHFrUE/PYmWrjYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPd7NkjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E3C4CEFB;
	Tue, 16 Dec 2025 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904380;
	bh=MYYN5ovVnme2x4lpuOhTvRHfYjuOenPXUPkmv+yXF3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HPd7NkjRErMLRrbViSvBz7pdzFFX8LY12SmS+yPqnh7WvFR8NmtmMnoRg24ZboTat
	 2qdlS7drucyflsrTyBBipz3KZ1PoIeMeKWJtVYlIu3h8kgtM6IOfF7tM6uC9mVuZPz
	 IKF0dk2VR8Flmv5OsUmQWCfcMfOT6XuMUK2xWrLFKe5pSCWEziRuZDwhwPlu+NlHjI
	 dotD29wwPOyIyZ1GVABjT42vht6hJBUiaRcOf53uwhmSMUXNnjNr8xPR6uvwTFxvHY
	 Iv58YLDyzdLpp1BXjsDXshrT6LvAXGNhznzXNxnwCN5birEOstByR1qdZGBCcBLjG6
	 COSgpe/JF8REA==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Johan Hovold <johan@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251117161851.11242-1-johan@kernel.org>
References: <20251117161851.11242-1-johan@kernel.org>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: enable compile testing
Message-Id: <176590437853.430148.9097023530682115764.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:38 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 17 Nov 2025 17:18:51 +0100, Johan Hovold wrote:
> There does not seem to be anything preventing the K3 UDMA drivers from
> being compile tested (on arm64 as one dependency depends on ARM64) so
> enable compile testing for wider build coverage.
> 
> Note that the ring accelerator dependency can only be selected when
> "TI SOC drivers support" (SOC_TI) is enabled so select that option too.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: enable compile testing
      commit: c381f1a38a4c7542cc6ec049d4dcff90a9423e89

Best regards,
-- 
~Vinod



