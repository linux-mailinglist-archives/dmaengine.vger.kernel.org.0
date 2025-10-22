Return-Path: <dmaengine+bounces-6933-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D670BFDF72
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 21:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA203A7E2D
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B9534D4FE;
	Wed, 22 Oct 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9miCQTQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE82F169AD2;
	Wed, 22 Oct 2025 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160062; cv=none; b=t6XXS8/TmEXERn4QOgM/pJ7tH/XWZ3jHo5yKjUl5LATwMXiAmtOVCaYpVMqS/lqNgimvd25BJj2tgtpMpNYeJISsAHMYXlQjzmTQ36J+IkWLu/SHBoBPWR7y0QFc9gbIYtkAZdJkSXWlmPLzPS7g7I/x9dTPkpOPa7z6xsB3cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160062; c=relaxed/simple;
	bh=MhikHcHibevNQwj+BN+1cIYd/DKSbUvhjASlY7USh2I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PjQRY4sB5y8Qjf04Kc7tsCsQbWmvhPAZ4ULBVfciyhODhyLvUVgEUm840RuNLmrw7es1doFpGUJg+GTuT+CK1kr6Tw+32/+VUiSHJ3Y26ywia3hQA1gLy3j53S4CKvt1/c3mzHqdyJXDvR7iJDzVwWBhY7hUzvShWZVzngh0xhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9miCQTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AB5C4CEE7;
	Wed, 22 Oct 2025 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160061;
	bh=MhikHcHibevNQwj+BN+1cIYd/DKSbUvhjASlY7USh2I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F9miCQTQy14eYv+G7sJbojMRVwwyrJRzB0o2GZHQKS0qKMOyst/6rYHsNjj07SrzV
	 Fb0dkWL7Zq0ov7ZxRcJOlIR/vf3Kggf3cGt7DTZ4cdsZS8ONKzkcVd9Jsz8Wrq4U5y
	 0jaYNouJSYD4QSRM8Dv8E7uTfb4tf4011jX9NkUzrrxPi/QSZwPL63VpaOFJ/wrizq
	 vwtojQKQ+xxRDWp/4jPX0sT1D4FrZo0KbKhJhj/DJSSGc7UTiSrZ2rN9TiX7THz1ZP
	 b8uH7YcopmBnh+vGj/e+9Hum9RJNMb/FLvcoihktILJq+t44xxWhwHQBQVC9ui75o9
	 dTajyQwN79FvQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id B91885FB54;
	Thu, 23 Oct 2025 03:07:38 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020171059.2786070-1-wens@kernel.org>
References: <20251020171059.2786070-1-wens@kernel.org>
Subject: Re: (subset) [PATCH 00/11] allwinner: a523: Enable I2S and SPDIF
 TX
Message-Id: <176116005873.3514774.12511738732010312757.b4-ty@kernel.org>
Date: Thu, 23 Oct 2025 03:07:38 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 21 Oct 2025 01:10:46 +0800, Chen-Yu Tsai wrote:
> This series enables the SPDIF and I2S hardware found on the Allwinner
> A523/A527/T527 family SoCs. These SoCs have one SPDIF interface and
> four I2S interfaces. All of them are capable of both playback and
> capture, however the SPDIF driver only supports playback.
> 
> The series is organized by subsystem, so each maintainer can find the
> patches they need to take.
> 
> [...]

Applied to sunxi/clk-fixes-for-6.18 in local tree, thanks!

[05/11] clk: sunxi-ng: sun55i-a523-r-ccu: Mark bus-r-dma as critical
        commit: 5888533c6011de319c5f23ae147f1f291ce81582
[06/11] clk: sunxi-ng: sun55i-a523-ccu: Lower audio0 pll minimum rate
        commit: 2050280a4bb660b47f8cccf75a69293ae7cbb087

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


