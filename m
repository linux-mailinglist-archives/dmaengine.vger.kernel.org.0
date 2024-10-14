Return-Path: <dmaengine+bounces-3348-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3299D690
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 20:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423461F23B66
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FB1CACCE;
	Mon, 14 Oct 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO7HGfER"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6331CACCA;
	Mon, 14 Oct 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930774; cv=none; b=SKNiRgpy70XuXqfzmFvv1Bu+hD1JmDc5r1mKh5cqAypqguBHGqgtVvPSpBO5/PZ/cPXgDP8fhWt+DmnTiBBJi3caty82E63Wn4Su2QId/FkcPL+RNj733VMbfbiKrdAewN0EYQe126WHPrS3Yw2sgbBsCted32w+iQyciaOvLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930774; c=relaxed/simple;
	bh=PnmPm4snomHx2auPbcRKagUMmY2ncSkpK0PMrYVESO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hk/Ql/UWsYRcRCJhpYytcjUs07uBpImPljij8FlSb4dseoZtC1UTyRDAS7RdzTrNrXR8ilxG/0jpcAfTwZB2ESzZeMfExHoDDohC0Eha7sU0a4wffvwvoYfKO8wbMNfGm/SAdz3+Wdv6IvCZGE7xYbB4rELPItHq+RIfmZj+APM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO7HGfER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1DDC4CEC3;
	Mon, 14 Oct 2024 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728930773;
	bh=PnmPm4snomHx2auPbcRKagUMmY2ncSkpK0PMrYVESO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OO7HGfERGzbp62XLGS18DveJYs8OlNoJqH0w6xx7NpcKjOTbBfNYPruT2T1CZGmQ4
	 S5cvneBMnvFb89PzAWTgNLuYatFmai0SBR9Zu7cYaQJ32Ot5gksO8SovOOCapYzIro
	 Rtn9bMGbCZMQquRe096a1pTdhgJ6FAS9iCvr/9cfE0BoZPJC5dBDCXL2vlypMlcMCU
	 R4rJqSxKxlrWPoT+B8St9Gtoc3yM73J3j/43zhO9AL/5CY5wt8bGYck0j4LR1CuUfn
	 iQ6njhGcs1Q3P0VFRO+Y8xDnM1+CGvrJ1RQ6BkvKsWnsd2yWJD3SXXzu+qRwA4HVh8
	 3Nghh02Epkhtw==
From: Vinod Koul <vkoul@kernel.org>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, anupnewsmail@gmail.com
In-Reply-To: <20241005093436.27728-1-advaitdhamorikar@gmail.com>
References: <20241005093436.27728-1-advaitdhamorikar@gmail.com>
Subject: Re: [PATCH] drivers/dma: Fix unsigned compared against 0
Message-Id: <172893077151.76035.9568068604504983423.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 00:02:51 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 05 Oct 2024 15:04:36 +0530, Advait Dhamorikar wrote:
> An unsigned value can never be negative,
> so this test will always evaluate the same way.
> In ep93xx_dma_alloc_chan_resources: An unsigned dma_cfg.port's
> value is checked against EP93XX_DMA_I2S1 which is 0.
> 
> 

Applied, thanks!

[1/1] drivers/dma: Fix unsigned compared against 0
      commit: 0aa4523cdb9683e35af91ebdfae8d2fb4e6c3b8b

Best regards,
-- 
~Vinod



