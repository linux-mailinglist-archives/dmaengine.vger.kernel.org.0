Return-Path: <dmaengine+bounces-221-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686B07F7529
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9884E1C20ACB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCC28DCC;
	Fri, 24 Nov 2023 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF+DS6vn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7120324
	for <dmaengine@vger.kernel.org>; Fri, 24 Nov 2023 13:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64500C433C8;
	Fri, 24 Nov 2023 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832764;
	bh=IVT7swiiMslQOoYmCSZAuXzD5cIHDs9WbVN/4614sJ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IF+DS6vnjgK4tDKl209LlG0bTkxcAyiUD9vW2GaEuTtVVy9YHb3FEHznwU5SHkhU6
	 YfbP0Y1Zxl00EaLNKixqgNTWUxxZfhmKMGuCBgRrhdZjJAkW/7VBVbN/c9XlFSonzn
	 f3IzTfFn6iI4ZOiLfbGu2NfMFADXs+fywgP9mNAij50janoEwpF9wbr3KJaJpORbJf
	 NZ7QxxJ9+BJU0XWrJAnpoB3XKx8DRynhcvZcls3UsvXLkKitsPvNnitGMFUS8MyydI
	 HPwyuao1C+epxP1jKq1YCnNHaqkPq1GjCE+S5Mmo4XG8hM6nBmd8EpghUirv1cOti9
	 tbhhGVvNItFjg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Ronald Wahl <rwahl@gmx.de>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20231030190113.16782-1-rwahl@gmx.de>
References: <20231030190113.16782-1-rwahl@gmx.de>
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
Message-Id: <170083276202.771401.991990874287880662.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:02:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 30 Oct 2023 20:01:13 +0100, Ronald Wahl wrote:
> AM62x has 3 SPI channels where each channel has 4 TX and 4 RX threads.
> This also fixes the thread numbers.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
      commit: 744f5e7b69710701dc225020769138f8ca2894df

Best regards,
-- 
~Vinod



