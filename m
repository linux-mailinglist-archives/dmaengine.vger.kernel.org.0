Return-Path: <dmaengine+bounces-1778-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585FF89B317
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7511F22D3B
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3D405FE;
	Sun,  7 Apr 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtCdde+h"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598D405CE
	for <dmaengine@vger.kernel.org>; Sun,  7 Apr 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507960; cv=none; b=kOtqCDXRFitzxhJZN3MTfoHxlwiGrTvr4yqVS1pf3cJJ6Jee9jIqgqHLFdCXpj5zRHsvvy7ZyYHdew45tbYSDHI84qjf0VRVodjK9Xwj4enlGkzz10+s+g9gzJfjmwtIw490qwRSSsWvJU46TM+hO3dfC2/cYlHdyxoRTUZaFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507960; c=relaxed/simple;
	bh=bwF1vctdgUTdFtHp69WUClkdGNATUOpsiF6EnIfSzLg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uF9rVnQqxHEP2kG3vIXnPCvLav3ZLXB2Et6vqqAGMZstj8mHeAqE58JiwzKYKXe5fsys96cJfBoSvAlDqAUrvs6Nkru2p3cU1mzebfVJ0h8c6FpAZmxbC1CQczPubgWszjpiZ3vLenShit+OMI+z3t9qTNAM6qn6nl8HjmG6yVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtCdde+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EADFC43394;
	Sun,  7 Apr 2024 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507959;
	bh=bwF1vctdgUTdFtHp69WUClkdGNATUOpsiF6EnIfSzLg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AtCdde+hHBEh9KYIl4IomTDN6J52VUD2LKyMSAXntH/BOwBHig7vc35Cv73xHtlN+
	 Aws68zIKgVLkp2X1TT26yAucsiA5tzEmxcuCbdD9sPJW4O44ZBsHjI6KNbqUAvQDDf
	 9IqWTsWpN9kL/vuYat56DIjCspTe0DWyGHJz+s/4HDke5XOrtpoLRxceHHgiGSpGmq
	 kjgS/840MGmexgL51K9IzafyOrdNR9+VKNfwEtJBgrooRDnZMCh3FNDr4C0MrzoLXn
	 0oq8ayOgyRfKxxXe9iTPdD4XhJhNR4u3YkNkuV66wZRWdz1akERhXpSUU12z1uFIoA
	 cglxBEj6/rjEA==
From: Vinod Koul <vkoul@kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: dmaengine@vger.kernel.org, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <ebab52e886ef1adc3c40e636aeb1ba3adfe2e578.1711453387.git.baruchs-c@neureality.ai>
References: <ebab52e886ef1adc3c40e636aeb1ba3adfe2e578.1711453387.git.baruchs-c@neureality.ai>
Subject: Re: [PATCH] dma: dw-axi-dmac: support per channel interrupt
Message-Id: <171250795812.435322.16276390649677397732.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 26 Mar 2024 13:43:07 +0200, Baruch Siach wrote:
> Hardware might not support a single combined interrupt that covers all
> channels. In that case we have to deal with interrupt per channel. Add
> support for that configuration.
> 
> 

Applied, thanks!

[1/1] dma: dw-axi-dmac: support per channel interrupt
      commit: e32634f466a9cc22e6d10252bee98d881e6357b8

Best regards,
-- 
~Vinod



