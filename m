Return-Path: <dmaengine+bounces-756-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058828329B8
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA611F234D5
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290F524B3;
	Fri, 19 Jan 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGm1yU+4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B628524AC;
	Fri, 19 Jan 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668639; cv=none; b=pP6P5fCWIcgy05yscUaE8i5fUulCL67+wlPb26VGXQAVaNX9+2peXt6Kne1R4nvydFDLOpVaOY0UfPkmuoy2WD2Jsxy2b8r9GRKUM5+02tsWFFUJfbotPCgtAa18kdtYRteHxqVC/a2/yyl4Iy6x1Kryi64ycXc27gdz57ExLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668639; c=relaxed/simple;
	bh=tdBgxUvVzcXBF9SmsxBHx3Yis3K+qMm2hq5/YBJT9x0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eAQ+MWRP5rd2uE307PgMmX2cBJqudk4AVKnt5PEO8uAu52ZuH6XjF5+NI0YZ50HYn7D8Vp4Sff7hrKxHcevHGysIDkUWuM6N5BsyFSHRfHwejSMk9V5GBnuhwdNVt01ug7acXz6ct419vSDNslqGugXRrMnipWciJbxoEXqz4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGm1yU+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7248EC433C7;
	Fri, 19 Jan 2024 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668639;
	bh=tdBgxUvVzcXBF9SmsxBHx3Yis3K+qMm2hq5/YBJT9x0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eGm1yU+4cjPVMqBHDcPc0vaupWHKr38GtQUrcLk6L7tl0SHUyPemd11phIqO7kJ/t
	 PNrd58LwrRjeTIi7r9rsZFYR6cevUEOrnBnA9chm9/WcwsrVLNvo/NIVHMgVBbpo8Z
	 qK85JGeOA5Iko3TRxS/DaODqZKQadgNqpNcrocwvE46L+6p59ZgvMAqpy+kINzY7tQ
	 Oh6bYQEf79AkWSve5IhbPcGGo/lDT3AU70HdAjtEAujozAnSDSYQkiZrS3VP28DoAD
	 W+t3IQ+rb2QbMHDy+CSxSfBLhIDMLyU1W4cIoytWF4wPYelUWZTx0V8QU4szavdPUp
	 KbJkXwuF7M1/w==
From: Vinod Koul <vkoul@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar <prabhakar.csengg@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240110222717.193719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240110222717.193719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Avoid format-overflow warning
Message-Id: <170566863608.152659.9747569338162328197.b4-ty@kernel.org>
Date: Fri, 19 Jan 2024 18:20:36 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3


On Wed, 10 Jan 2024 22:27:17 +0000, Prabhakar wrote:
> The max channel count for RZ DMAC is 16, hence use u8 instead of unsigned
> int and make the pdev_irqname string long enough to avoid the warning.
> 
> This fixes the below issue:
> drivers/dma/sh/rz-dmac.c: In function ‘rz_dmac_probe’:
> drivers/dma/sh/rz-dmac.c:770:34: warning: ‘%u’ directive writing between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=]
>   770 |         sprintf(pdev_irqname, "ch%u", index);
>       |                                  ^~
> In function ‘rz_dmac_chan_probe’,
>     inlined from ‘rz_dmac_probe’ at drivers/dma/sh/rz-dmac.c:910:9:
> drivers/dma/sh/rz-dmac.c:770:31: note: directive argument in the range [0, 4294967294]
>   770 |         sprintf(pdev_irqname, "ch%u", index);
>       |                               ^~~~~~
> drivers/dma/sh/rz-dmac.c:770:9: note: ‘sprintf’ output between 4 and 13 bytes into a destination of size 5
>   770 |         sprintf(pdev_irqname, "ch%u", index);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sh: rz-dmac: Avoid format-overflow warning
      commit: c4d6dcb3b6250ea546a952ad33382daf7cd32425

Best regards,
-- 
~Vinod



