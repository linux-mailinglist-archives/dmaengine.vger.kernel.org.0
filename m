Return-Path: <dmaengine+bounces-5638-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F560AEA9E6
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87291C45E1F
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8D26FA4C;
	Thu, 26 Jun 2025 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF71iFGU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1F221DB9;
	Thu, 26 Jun 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977897; cv=none; b=Xz59XZeoTqg/kKkoRxk4E8Kj/hMSxxhnSqi8QlmheTQzQ8tmdzWB8i8ifvfJzgoKXAoAbhsD175seLMOzfDCVqpi2NJD+8B63eedns9QUaE07Pm7/cbabDDscK4mrKpkupEcekTcl9G+NxVu2C5E/MEmn05frl8022zDDYGTvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977897; c=relaxed/simple;
	bh=iIVxK75n9yifPDH8xfQqAE4cWRG5nMYGTwZryyQ4vxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=coTFEJeUbB6blUzI4IOoVsZnn/8JYInfl4iC2WodOtMU9rcv6hQU8pYIslSEzljCDbpoW2BGYDmSkXpgTAPS+MvzQqCo05WANpwGqtHa4I25NBwvdFSQg66D6wlElUuAmxAK19eWY1PaOXRbMfU1mPM/xJE5gPjRHwA1cdmIZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF71iFGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D903C4CEEB;
	Thu, 26 Jun 2025 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750977896;
	bh=iIVxK75n9yifPDH8xfQqAE4cWRG5nMYGTwZryyQ4vxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oF71iFGUJtNGLoUJckRGl4g6TBbZB6rRaYacVDiaeV+RJuIdIun5xbEGgLq6owLoZ
	 TPrmGyojuS3ZO95jLuPwmJVwsceBa9jXH4SHOpXyAy9e5EXbpy6GQzoGndU4cou+3z
	 3CbOlOzGg62A+oEYfq7ZQOS4w8y+mxniEAiSEArs6YDh6BFP4N5tWiOZu57ihil281
	 e9HosDW8+Mu27iNNbUBSxg0xDL4f45m5ALWSEbDVl/Ty3KojXZqujnXxTeH6/NeyUV
	 NaQgdFV6yFyjA0qnzqeEulDsfjr3P2gQwvPi+6B5yatq5f5Wkf5EaX7pGDEEyOccE7
	 ugIJe5IsQ+3Og==
From: Vinod Koul <vkoul@kernel.org>
To: sean.wang@mediatek.com, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, eugen.hristev@linaro.org, 
 Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 baijiaju1990@gmail.com, stable@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20250606090017.5436-1-chenqiuji666@gmail.com>
References: <20250606090017.5436-1-chenqiuji666@gmail.com>
Subject: Re: [PATCH v2] dmaengine: mediatek: Fix a flag reuse error in
 mtk_cqdma_tx_status()
Message-Id: <175097789639.71042.9318764811054484272.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:44:56 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 06 Jun 2025 17:00:17 +0800, Qiu-ji Chen wrote:
> Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.
> 
> 

Applied, thanks!

[1/1] dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()
      commit: 8eba2187391e5ab49940cd02d6bd45a5617f4daf

Best regards,
-- 
~Vinod



