Return-Path: <dmaengine+bounces-7301-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B937EC7CB61
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 871A54E3426
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169C2F6936;
	Sat, 22 Nov 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5cLhcgK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E12F6923;
	Sat, 22 Nov 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763803825; cv=none; b=XP8L/+4uD2jr9Q/Qms8c4CLWDvA8kWd//HZ4Qlnh+N13iH07c+ZoCgCxQJ9qlnaPcdSYUEa/6Lr/xOYUp2jJUeEObvPmPURSrV/DM2U8tda4sL75unk4hW5SnpaoCgtMCeG0G48rNqmM5f41la1/yxR3SGQMmxdS74x6FX9RnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763803825; c=relaxed/simple;
	bh=Wm6slHa+RMsQOKGO9QM0Ok/dAlMRmwnMCBLQ/VVrhkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e8x4U7xD3Bo9VVhYFLfCNxunf5pMY+GXrqTpfrrGdTe3isd0WnmTEtxTjJ3qL1SUYyDiAcAkhpa20F/mHaxBxbf9kihN1K7l0Uu+tWkEhuG8K/t/H6PqF2hXE1dn9K/Syt9TsW8M/8vp8O5FMIO3q2pRDxvN1Hrqi3C0VBV9sGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5cLhcgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6638C4CEF5;
	Sat, 22 Nov 2025 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763803824;
	bh=Wm6slHa+RMsQOKGO9QM0Ok/dAlMRmwnMCBLQ/VVrhkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B5cLhcgK6nSQhhbo73iOLAIxCOfbu0d8QC1PMJr3ONYMhreGh3rvofIV2/30glg/O
	 RQpRP5puw173XETBlBHaUwWxVgzu3JdH/edswfh2HjMJ7gdFWHTi1Ag6r010PSNU8y
	 mbuCcS1swxuagFILVJLKQT7J0D0FY63Fz9oOoA2HQZTmEQPB1BmkV1tO/h/JKJD4+w
	 QPlXvd9f4amI9tQcbS/9+LtYgs3yMGHg96ocjT+x8J6KMOEuKdTs+maC5MF0KqNPck
	 sKXpUd7IwzawdnlgmA45CqMe9QE3UlE5x/EVZhmF7N87jRXssq96iZlGBj7G53Np+k
	 mSiBQYyZpcF1w==
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251120164907.28007-1-johan@kernel.org>
References: <20251120164907.28007-1-johan@kernel.org>
Subject: Re: [PATCH] dmaengine: st_fdma: drop unused module alias
Message-Id: <176380382349.330370.2404172650138380308.b4-ty@kernel.org>
Date: Sat, 22 Nov 2025 15:00:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 20 Nov 2025 17:49:07 +0100, Johan Hovold wrote:
> The driver has never supported anything but OF probe so drop the
> unused platform module alias.
> 
> 

Applied, thanks!

[1/1] dmaengine: st_fdma: drop unused module alias
      commit: cd3ba117688f7694f000293fd5c034f9f842dbb2

Best regards,
-- 
~Vinod



