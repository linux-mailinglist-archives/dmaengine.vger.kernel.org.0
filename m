Return-Path: <dmaengine+bounces-968-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B024384C699
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C047B209E3
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CCF208BC;
	Wed,  7 Feb 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOFyi2L6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40F208BA;
	Wed,  7 Feb 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295758; cv=none; b=ugFLogzuOwUa5ZZdZSVafxFCTClYcwtJ1TL/GxFmwo0CB+RQxs7c3bPQkv2rrYyVYApCwx6bvS+ZFSxbc2HC/KT7ZKtdy7sph3w0aCktBQb19RlAfYLkfnJ4/HG5IyDYC25FeKExUaNiOICAxNSozL1Hm2AVVCxvBm5kjev3430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295758; c=relaxed/simple;
	bh=N2UmQem2e+uq88ryx+p+eHtWXlWzYmH6j+nDfWSq+uo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mShdsRB2zoaVy3gCLNOhHd4fh0vZGJ1l/AKmIfYrDohy7KLxWyytcmMwIAlmmKyAykS9MjIj3/S7fYUNlp0C+2i/4j+3UJ7gS+WbVIpA8jSZeWjXn4yhj7j7PvyEkpJgBkaKgxwShf7VvrWHQySqVykcSeXS7keWJi1ZW7IuQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOFyi2L6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A25C433C7;
	Wed,  7 Feb 2024 08:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295757;
	bh=N2UmQem2e+uq88ryx+p+eHtWXlWzYmH6j+nDfWSq+uo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lOFyi2L65FKIZDw3m/NUm8s30sPTf1Rk1UYuDyjugi9jpOvFrorwpdHyRznMumkFE
	 7Cj58LUGPoegSSic35vgxfwWxa4tlF5PxUdu+jUWQJshv+jzBBoBHqRsMpEWf/rm9o
	 zGZNKnLSCeFPMRI69i6g2KoxJbqGSs1/XYRKKoJK+KcqK4jhKAz6aE+LI4QnuCWvPX
	 NHABAbqDCx8FtXx/hoyweiE66LABhRgTZh9ouf+RWGgTDgcBG1jtciafe5sQ6LIXcM
	 NPc+UBL3RHAxJyx7KlZzB0HjJy3joWid82qed009nkSDYpirft8TNzQDST843pQX2C
	 R+aqcL8nCpPbw==
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
In-Reply-To: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
References: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
Subject: Re: [PATCH v7 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-Id: <170729575467.88665.9946479404086930369.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 09:49:14 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 29 Jan 2024 17:25:56 +0100, Kory Maincent wrote:
> This patch series fix the support of dw-edma HDMA NATIVE IP.
> I can only test it in remote HDMA IP setup with single dma transfer, but
> with these fixes it works properly.
> 
> Few fixes has also been added for eDMA version. Similarly to HDMA I have
> tested only eDMA in remote setup.
> 
> [...]

Applied, thanks!

[1/6] dmaengine: dw-edma: Fix the ch_count hdma callback
      commit: cd665bfc757c71e9b7e0abff0f362d8abd38a805
[2/6] dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
      commit: 7b52ba8616e978bf4f38f207f11a8176517244d0
[3/6] dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
      commit: 930a8a015dcfde4b8906351ff081066dc277748c
[4/6] dmaengine: dw-edma: Add HDMA remote interrupt configuration
      commit: e2f6a5789051ee9c632f27a12d0f01f0cbf78aac
[5/6] dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
      commit: 712a92a48158e02155b4b6b21e03a817f78c9b7e
[6/6] dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
      commit: bbcc1c83f343e580c3aa1f2a8593343bf7b55bba

Best regards,
-- 
~Vinod



