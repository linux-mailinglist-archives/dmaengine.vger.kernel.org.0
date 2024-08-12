Return-Path: <dmaengine+bounces-2848-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C394F665
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2024 20:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F4C1F22BD4
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2024 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39912190047;
	Mon, 12 Aug 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm94uMtc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1218F2DD;
	Mon, 12 Aug 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486364; cv=none; b=sPhdDuUQeiK3DJuGkMqY4J2nhoMssTwzUqIgRwtc8bNEQj0mfJMQvC5GhFlTP0SYCBO8wEKL9o4GsBdhyUPztjELLXza5Sbg2XKkHJcb0C3erNrCjgsPZjQRJYu43CfuSI172NKs2wVqzgky0wWw5BGoHiWnB9T/gHmBAa/X6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486364; c=relaxed/simple;
	bh=g0XHzIpUs5eYiW9UQlfz0vWRfgRQzN1dVhSEmnmVHow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCdwzVNDKySf5qv4wzT5RMbIrfGqB7BTtg36l+oS/u0jWYSO2GA08+fEnwBuRSvH2k4+9RvV7ZELVCrSxzw90QDA+pLYgIN9r6YcaP9Dd63bKdJUutU+ZHxQsH4fwuU49j3nundB0JBz1vNppgyqyBFmjxEhFvZuER7L7LB8Hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm94uMtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BCAC4AF12;
	Mon, 12 Aug 2024 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723486363;
	bh=g0XHzIpUs5eYiW9UQlfz0vWRfgRQzN1dVhSEmnmVHow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gm94uMtcYmIt+6LMyxQ9EVa9yh4TAeRVzZzmN2OC86TNUXCFKPudnG0pgR2aSq/7i
	 RVQfFDkMD3Dp+JpaasLwCFt7yCWw6MSOvROhRH7AZeSqg1DdWIQQBfnM2A9x8XrfNj
	 KMcHi9JLd1jKSch5n6s1e2c5Stoxk6ll5Z5Tp4E6p5qWJvkF/qZ8RgNG7EBGd+7QFK
	 2rPUtsQlK/zmtP6f97EW/3DHqZ6kEvp1Q96TjZI8tCy3f4Ii1s70bOyNdp833LBO81
	 PykyBxc2T6di+OkYMnej605xtlXkDhsfWs5rncwC4JAbjb7mcPRhNG39m9S3tl+can
	 9EmIL0jLfTZsQ==
Date: Mon, 12 Aug 2024 11:12:43 -0700
From: Kees Cook <kees@kernel.org>
To: Amit Vadhavana <av2082000@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	ricardo@marliere.net, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, vkoul@kernel.org,
	olivierdautricourt@gmail.com, sr@denx.de,
	ludovic.desroches@microchip.com, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, wangzhou1@hisilicon.com, haijie1@huawei.com,
	fenghua.yu@intel.com, dave.jiang@intel.com, zhoubinbin@loongson.cn,
	sean.wang@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, afaerber@suse.de,
	manivannan.sadhasivam@linaro.org, Basavaraj.Natikar@amd.com,
	linus.walleij@linaro.org, ldewangan@nvidia.com,
	jonathanh@nvidia.com, thierry.reding@gmail.com,
	laurent.pinchart@ideasonboard.com, michal.simek@amd.com,
	Frank.Li@nxp.com, n.shubin@yadro.com, yajun.deng@linux.dev,
	quic_jjohnson@quicinc.com, lizetao1@huawei.com, pliem@maxlinear.com,
	u.kleine-koenig@pengutronix.de, konrad.dybcio@linaro.org,
	gustavoars@kernel.org, bryan.odonoghue@linaro.org,
	linux@treblig.org, dan.carpenter@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Fix spelling mistakes
Message-ID: <202408121112.480CE2FAF@keescook>
References: <20240810184333.34859-1-av2082000@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810184333.34859-1-av2082000@gmail.com>

On Sun, Aug 11, 2024 at 12:13:33AM +0530, Amit Vadhavana wrote:
> Corrected spelling mistakes in the DMA engine to improve readability
> and clarity without altering functionality.
> 
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>

With a quick skim on my part, these all seems correct. Thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

