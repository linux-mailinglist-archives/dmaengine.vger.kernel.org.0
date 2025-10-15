Return-Path: <dmaengine+bounces-6858-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEDBBDDDE0
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2875519C0FF3
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0B31B12D;
	Wed, 15 Oct 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a32v3isP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4731A804;
	Wed, 15 Oct 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521830; cv=none; b=I5x4Si56PwIMMY+UCEDpfKrlA83j0nmqBNprE7z3SXKXX/aSYSKcTe9BWniZzR+yS4AtlTloctbW85GHl9clsQMnTJ17FSyNQqrEjb1Exrh7twP+tfi0pnoh92kLkzY+IPCUOB7S00DLPycDDuG42iZjdbixAdMpG0oPen6VQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521830; c=relaxed/simple;
	bh=DAQ97XxkDaOBHjNynMId/gOsAuupI3l3Tc49SMZfcaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jXezrzD14sz69KNCX3rUTROLtfu/Cvb9TgX9Q6ge5Td1M+oXM0pPlZyKrwLXBmioisNdUkCtG1JHLKWHDQfjd1KQiXsnxIdeHOFaBAt1FOX40acwqcoJUrZqRsi5QdRy5/GGUruty2Ip6pLcs17lNpTgeM42++UjBZs2XX+xATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a32v3isP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1504EC4CEF8;
	Wed, 15 Oct 2025 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521830;
	bh=DAQ97XxkDaOBHjNynMId/gOsAuupI3l3Tc49SMZfcaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a32v3isPJ1uRLrGg7wRW5KoB/X11+APeu4LxPqFyijyED4caYHtlWUGCNBgbK/ux4
	 Kon+P5NcE5oyqaIdH5o1yFgIMuVuHAa3hAAm4VQDbf0Kur1mOHuRt5DL2GD+64TVvX
	 TEbH7zMhdnoMNDC+HpEK4ifnaeVk+ukcprVWgxcKt1lD2Jwd9lj5EL/zchNvVMcrEQ
	 8zSTRErAW/aY9bvTw/K8/uu1eC737Q9n2Zb2b3r7HlnRoX306ijdcT2sB1Y7/VG6yi
	 Wbr9lruIl9ffAiO/vfsxCBVclpF5xk6HX5AuNar1uFQMMaT18UewL+RTL47FbHheBG
	 DCWlj8aJd1+5w==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: quic_varada@quicinc.com
In-Reply-To: <20251008090413.458791-1-quic_mdalam@quicinc.com>
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
Subject: Re: (subset) [PATCH v2 0/9] Add QPIC SPI NAND support for IPQ5424
 and IPQ5332 platforms
Message-Id: <176052182781.20973.15827273241958819780.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 10:50:27 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Wed, 08 Oct 2025 14:34:04 +0530, Md Sadre Alam wrote:
> v2:
>  * Added Reviewed-by tag
>  * Added Acked-by tag
>  * Updated board name in commit message header
>  * Added \n before status
> 
> v1:
>  * Added support for spi nand for IPQ5424 and IPQ5332
>  * Updated bam_prep_ce_le32() to set the mask field conditionally based
>    on command
>  * Removed eMMC node for IPQ5424 and IPQ5332
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
      commit: 454cd43a283f7697297c52981c7a499a16725656
[2/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible
      commit: 4412ab501677606436e5c49e41151a1e6eac7ac0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


