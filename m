Return-Path: <dmaengine+bounces-1089-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5DF861112
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8072B1C21BCD
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0710A7B3EE;
	Fri, 23 Feb 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFmwcVpH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C97E779;
	Fri, 23 Feb 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690111; cv=none; b=M5umEEN3ymE8Z12CZhWFgBicEpZPJpaAG4bOMJwsV24RYvspKpDdod8/EgMh6subFEx0IdfBMPrLJ4gMRxD4DBD9FvTX2nmH0hXIGYAoY5YFZ+6qbmi5VU4pYG9qZOYiQV/ZFXLS9orbu52SXhwe20Yu7EFBD7th5eIw0K/RWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690111; c=relaxed/simple;
	bh=J/rPf8/KIVOA/sYjkOjBSAd10WY/zQUZn82ZiXvJ25s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RhMfUiCGa+ywgnJx336IpAeQGNmtk4n6/2jCnZg8qc1HMyQRBlGbDeQ4mWwKsXy7PsZRtx+cJWmKl3PwfP3zkVZpoht9vQ0OX5TC/+6dv7n0sHkTET0NHx91Y7iQlEXn+G4gz3uNFue++Hol51mJkdQnNwpc9H1aDie034BkSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFmwcVpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F1C43330;
	Fri, 23 Feb 2024 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690111;
	bh=J/rPf8/KIVOA/sYjkOjBSAd10WY/zQUZn82ZiXvJ25s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RFmwcVpHyGTpwGoXW2ouik9uOnpVwn5uESe2GCEpMvuAMoVfOJeU8nhmdK+M5v703
	 sSq8cyNN9VUAZeB7imz++Ou+AqCjXljcBe92e8+Edfd+vmcpMMJ0d7Ki21sbA4cWQa
	 VtDVeM5/EWhFtnOcxt5RD+DeJ4mkqZ1sTAfZBMzzwKQumqQxGNOL1GiLStkmjZZwmU
	 JE6pnesbpx5WM2oZzX727BQ52cnDdnxe27udcEhQfeENoTlRvHr7Je2yphQDgNhckp
	 NpVrwBEC432zXJnRZywW/t7xkUV6DNkpwts1036FYTxIHhXxLII+X8iDq+qpqR2xfK
	 x0fxdGyb/PbbA==
From: Vinod Koul <vkoul@kernel.org>
To: Tadeusz Struk <tstruk@gmail.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Eric Pilmore <epilmore@gigaio.com>, 
 dmaengine@vger.kernel.org, Tadeusz Struk <tstruk@gigaio.com>, 
 stable@vger.kernel.org
In-Reply-To: <20240222163053.13842-1-tstruk@gigaio.com>
References: <ZddShyFNaozKwB66@matsya>
 <20240222163053.13842-1-tstruk@gigaio.com>
Subject: Re: [PATCH RESEND] dmaengine: ptdma: use consistent DMA masks
Message-Id: <170869010887.529426.9005710614380749711.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 22 Feb 2024 17:30:53 +0100, Tadeusz Struk wrote:
> The PTDMA driver sets DMA masks in two different places for the same
> device inconsistently. First call is in pt_pci_probe(), where it uses
> 48bit mask. The second call is in pt_dmaengine_register(), where it
> uses a 64bit mask. Using 64bit dma mask causes IO_PAGE_FAULT errors
> on DMA transfers between main memory and other devices.
> Without the extra call it works fine. Additionally the second call
> doesn't check the return value so it can silently fail.
> Remove the superfluous dma_set_mask() call and only use 48bit mask.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ptdma: use consistent DMA masks
      commit: df2515a17914ecfc2a0594509deaf7fcb8d191ac

Best regards,
-- 
~Vinod



