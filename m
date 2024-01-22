Return-Path: <dmaengine+bounces-786-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08403836D0D
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD551C26B9B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E253818;
	Mon, 22 Jan 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZm/BiWo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C23FB0D
	for <dmaengine@vger.kernel.org>; Mon, 22 Jan 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940728; cv=none; b=K3qUBHrpKD6f2xLzDgQHe3GSqKO9qCrXN61KxcC64+Nas3vgoHsiVLYlwNVvvOSBWeyQLenQOU0ae/AwNavVNpJUhN0imun9ZNtzMBkmyMLOSJ0pHymF8ellgy730KorCnr1feJO24jSlZ/p24W11YRMdgSaeiUlT1TeJ2Q9uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940728; c=relaxed/simple;
	bh=9ZJdF7VcgcGFczBqyHnzP+ab9/+KTC8hGZPOAIBiWlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t8NipuKQv+3O/nRaRo4u8CFF03vmeEWwz9hfsgP0G/BoOQ2nO7qFRnVj3MKkkOcgcpPUfgcrVGTIv8JouSyElq3KRUqe4290wWsCiRLfU2pnZHYpF1f61pVoNwl2iPCwspAxI8/QKjNXwBzvMNvEkUgL53fnXgBOkmUU9Zd5+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZm/BiWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BFEC433F1;
	Mon, 22 Jan 2024 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940728;
	bh=9ZJdF7VcgcGFczBqyHnzP+ab9/+KTC8hGZPOAIBiWlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XZm/BiWo3dJBG7mAaxDfTQEzpnhS2m8hR//w8iIINYqbz9/rjap2u3xw9gqTpcSue
	 M4D6QxZ+JX4T+mCaP3W6A35jpPfZLbfVA4KCVt+pRTkN2ulRGzMS0+dj6+9q7LFT5I
	 QD1L4aZ+fOsqAOIONfzuHcAXqPMXSd0B7rhkwMO5K5ljW6+Lu4MKsBqTFYfSW2XqVu
	 eBY40BXwCMPBgTp3W3FieTMAD2lBZq0h12apatprKEM2foMY3ThnUkBXxm//TqHwXI
	 Y5f1lkBpFVzO4AhpM21cVNCpTgkGHmF7cCsf5M3XkMV+vRo9tN/BGnVvaT1AxN2jmE
	 d6IbIfbiymNOQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Daniel Scally <dan.scally@ideasonboard.com>
Cc: ilpo.jarvinen@linux.intel.com
In-Reply-To: <20240118112959.1027471-1-dan.scally@ideasonboard.com>
References: <20240118112959.1027471-1-dan.scally@ideasonboard.com>
Subject: Re: [PATCH] dmaengine: pl330: Clear callback_result for re-used
 descs
Message-Id: <170594072669.298019.1087632323375454803.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:55:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 18 Jan 2024 11:29:59 +0000, Daniel Scally wrote:
> The pl330 driver re-uses DMA descriptors rather than reallocating
> them each time. At present, upon re-use the .callback member is
> cleared, but .callback result is not. This causes problems where a
> consuming driver sets the .callback_result for some submissions but
> not for others, as eventually the function is invoked erronously.
> 
> Clear .callback_result along with .callback
> 
> [...]

Applied, thanks!

[1/1] dmaengine: pl330: Clear callback_result for re-used descs
      commit: 4728e3fe2ff1b02b84ddab876d8af5eeb74eee18

Best regards,
-- 
~Vinod



