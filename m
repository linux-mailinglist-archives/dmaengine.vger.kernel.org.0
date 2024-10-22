Return-Path: <dmaengine+bounces-3404-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06169A9893
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 07:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C7D281C24
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D3155315;
	Tue, 22 Oct 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqO9CuC7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB51552FA;
	Tue, 22 Oct 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575184; cv=none; b=R2jWs2VEdGBq3i+szgdItQhRvyKt7g2bw2CaQ2NfhEShAZcV65Lk4jlAZGvIC3NDA6rPqzmv68024rAlCogQJXd8FC+KIohffWd7vOZW/hVaJVCLdHJnUzAsmykG0E8qn0b+eG0kTxxguX537eEswZOxdbtYS8i200NrjvnomLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575184; c=relaxed/simple;
	bh=DqPOw5Afx12BpuzF6xGu5Io93p3y6bip4Gvpl3L7H6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uB04cRgN575OvIUiresc0Kz72EQE/S7j685Ev8fJug09k4UyaPi2OMZXc/8jB0Y8dAJAH6dPicG63+xJjVJ0o89BrQ7dTeYiayUz1F6LWADSs9spKTkpjOHLM5id0awhfMN5USKTknrxo1JzyUHCqFpVOOoEafcQKYpiJ1YMdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqO9CuC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23829C4CEC3;
	Tue, 22 Oct 2024 05:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575183;
	bh=DqPOw5Afx12BpuzF6xGu5Io93p3y6bip4Gvpl3L7H6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TqO9CuC7N7TpT4tpOx92kXJM76C3MzBenpDiuzwPEnz18DnJgNovrbdTVHe1Qys0M
	 CpAfzbiu8BfNoRoOoRE92v9eIzY+W2rAfNvWU79IuOLvma/aB+xG3xmfzNfjY4+HwK
	 JW7QsFI4GYTale/cZx9XVCtTdpXYLNcvP6zPvcgGTu9awlbdz46XyCCIVzjo9Ew+HO
	 G8Tc4a/odoHjZt1uC3tdzCtGkkuiRm3cRcl0XyXCGR5bSegBr/fltepqiIR1d5ioYd
	 OKd2aK2Rcjp34sgl8dRFJBc/nEOnc1Mh34v+NQy7LixO85mLL8fEjwqoUQRe853M4L
	 zSXwhUAry2ctA==
From: Vinod Koul <vkoul@kernel.org>
To: paul.walmsley@sifive.com, samuel.holland@sifive.com, 
 michal.simek@amd.com, Yan Zhen <yanzhen@vivo.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 opensource.kernel@vivo.com
In-Reply-To: <20240918034114.860132-1-yanzhen@vivo.com>
References: <20240918034114.860132-1-yanzhen@vivo.com>
Subject: Re: [PATCH v1] dma: fix typo in the comment
Message-Id: <172957518103.489113.3611474825352477788.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:03:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 18 Sep 2024 11:41:14 +0800, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Replace 'enngine' with 'engine' in the comment &
> replace 'trascatioin' with 'transaction' in the comment &
> replace 'descripter' with 'descriptor' in the comment &
> replace 'descritpor' with 'descriptor' in the comment &
> replace 'rgisters' with 'registers' in the comment.
> 
> [...]

Applied, thanks!

[1/1] dma: fix typo in the comment
      commit: 39d283d146922a266e8196e7fd29b31feff528be

Best regards,
-- 
~Vinod



