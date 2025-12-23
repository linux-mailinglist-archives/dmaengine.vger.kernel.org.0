Return-Path: <dmaengine+bounces-7880-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C71CD91C7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C93D73059502
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C693314BB;
	Tue, 23 Dec 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWuLuXdc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631213314B7;
	Tue, 23 Dec 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489303; cv=none; b=PU68VCSTYQzHEs2mv+SH1jB7OHyTN8qaGbjavzHleEf5hKrLjOKyUPDAi77tYeoJhsX66unGUjxNBagmDu3Dzt82EvOGTHsStyJTFZfwA6bDZsP2Vy/np6H6KjhbekGfyavqF83IRqU/SAjEaVaqQyI9hm6MCf0QhzqZALSRraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489303; c=relaxed/simple;
	bh=3aHaU2K3mzEQdrebTm1zRL81apIMrnHUsIlEm/uSDCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CofNIYDNYMTFYPrvZ8UH62uMykSDRmOObwm7SSqDlkLvTt2+NoQ42vFwg34S/SN+5mlfPf84Hw+zTyIJ/wRxANtb70UiGyiQWzQHUyieKMh0p6/g5wCEZ74Z5vXrMHIQYOsUbtpzUyMbbJSlZxbm8XAkm4WY5P12MYoBstt3Swk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWuLuXdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4640DC113D0;
	Tue, 23 Dec 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489302;
	bh=3aHaU2K3mzEQdrebTm1zRL81apIMrnHUsIlEm/uSDCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YWuLuXdcMkI6FiYaqNy2I8a2qYw5mbdEb9CitKLjPg0gSuUxo2i55TVGYHGEEcplR
	 ej6iTj2Q+i38YIhQ4MTGj0tQUOcPL/5Ly6qOfafbK40MjII4jPSKvGlya+3I4vdRWY
	 XCAnwijZU6cGHSPN8r3Jqe4dR9/EpDEd5LsYJySkpYbxUFwVk7XzHakiA8dsmq0mLh
	 F/OmHk2tJwdcWcnaEs1idrNxEB8m3fETSoRKmLYmmhiaLacjmrhW2d9G2tkZgMCZWs
	 ev6TOwQ65c1IiTAqkvQmQMvcgpG68H05GHXisYyeF2n/SsJQYN1/kJ56XZxvQ+qD82
	 jzZeRYqRzEoUQ==
From: Vinod Koul <vkoul@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
In-Reply-To: <20251221064754.1783369-1-wens@kernel.org>
References: <20251221064754.1783369-1-wens@kernel.org>
Subject: Re: [PATCH RESEND] dmaengine: sun6i: Add debug messages for cyclic
 DMA prepare
Message-Id: <176648930092.697163.4869399888360483655.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:20 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 21 Dec 2025 14:47:52 +0800, Chen-Yu Tsai wrote:
> The driver already has debug messages for memcpy and linear transfers,
> but is missing them for cyclic transfers.
> 
> Cyclic transfers are one of the main uses of the DMA controller, used
> for audio data transfers. And since these are likely the first DMA
> peripherals to be enabled, it helps to have these debug messages.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sun6i: Add debug messages for cyclic DMA prepare
      commit: 7105e968d1f6f6753f8fc3c47b8a705b6dad36d4

Best regards,
-- 
~Vinod



