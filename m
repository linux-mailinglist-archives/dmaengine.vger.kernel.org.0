Return-Path: <dmaengine+bounces-3060-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7809681D9
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7CDB213A6
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 08:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26456186E32;
	Mon,  2 Sep 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0E/fMkM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9C1865EA;
	Mon,  2 Sep 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265758; cv=none; b=S917JwyjsgIGEI2tFB6FKK8IhROKPuEjEtb6ooOYUA5Voj5k046ZOj6RLLjyV89BinOAUnARbhBGYxcqW3mdHyOG8gcYwf2Hv6tQn4DxLHJrX6+LjkOT3wpN8hkQGHxxyuEMAZocoH07KHjpzX1humKUBYbLYntrU2IkbwKGxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265758; c=relaxed/simple;
	bh=cxKDCdCiqIYOE5vwlnqkPpcgy/ZNa0A4fziYZeuC258=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m/a31xVUMyym8GE8BMi7mrsuzW1YbWEZor2JkdTridR9E9AZIPlTF1tgcM7lGILPsMVa6hzGw8XN2UnJ/jmowAiz8VcWkrSYJjapn3YeDUD/BAZHllSTYE9dQg7gsQ/zdUVTDDXO+tU3fHc+SCP+gwIN3g02LPIH6I4tSOYq/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0E/fMkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62960C4CEC8;
	Mon,  2 Sep 2024 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725265757;
	bh=cxKDCdCiqIYOE5vwlnqkPpcgy/ZNa0A4fziYZeuC258=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K0E/fMkMAVtRD/E0g2t9G1nI2nuYeKPDLA7N1xTHwYgSeerdXkGgInLCjPD7H5LF6
	 cKuLUHBjBGwUiS8n9lpvvCLRGq4H1OgPifoRItKxem5U6AhbKXlPVcoJZJOWqk18Cw
	 OhsAmW3Roc1m6mmUuzwjqDidi7bF87RC02nwbXJTJb7IbZBAd3s+rcVdEYWKfT3hrZ
	 JkxQYWGWpu0MPDwhFjKEHKwBu4oK9ZiYqXdI3reyTXMrHQn/pKj/1D40ClgiTiHd1L
	 R36AjBJdtKmZaZyNI6YrHP3BuJAKNokIroLepJePgXtHPH0uvibSXL+u6udtWEAd0y
	 t6N18NItgbIQg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ricardo@marliere.net, Amit Vadhavana <av2082000@gmail.com>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 olivierdautricourt@gmail.com, sr@denx.de, ludovic.desroches@microchip.com, 
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 rjui@broadcom.com, sbranden@broadcom.com, wangzhou1@hisilicon.com, 
 haijie1@huawei.com, fenghua.yu@intel.com, dave.jiang@intel.com, 
 zhoubinbin@loongson.cn, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, afaerber@suse.de, 
 manivannan.sadhasivam@linaro.org, Basavaraj.Natikar@amd.com, 
 linus.walleij@linaro.org, ldewangan@nvidia.com, jonathanh@nvidia.com, 
 thierry.reding@gmail.com, laurent.pinchart@ideasonboard.com, 
 michal.simek@amd.com, Frank.Li@nxp.com, n.shubin@yadro.com, 
 yajun.deng@linux.dev, quic_jjohnson@quicinc.com, lizetao1@huawei.com, 
 pliem@maxlinear.com, konrad.dybcio@linaro.org, kees@kernel.org, 
 gustavoars@kernel.org, bryan.odonoghue@linaro.org, linux@treblig.org, 
 dan.carpenter@linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20240831172949.13189-1-av2082000@gmail.com>
References: <20240831172949.13189-1-av2082000@gmail.com>
Subject: Re: [PATCH RESEND V2] dmaengine: Fix spelling mistakes
Message-Id: <172526574398.510261.10954732298871538.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 13:59:03 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 31 Aug 2024 22:59:49 +0530, Amit Vadhavana wrote:
> Correct spelling mistakes in the DMA engine to improve readability
> and clarity without altering functionality.
> 
> 

Applied, thanks!

[1/1] dmaengine: Fix spelling mistakes
      commit: a688efea0f2a084aee372e5b7b12d4d2d172f99a

Best regards,
-- 
~Vinod



