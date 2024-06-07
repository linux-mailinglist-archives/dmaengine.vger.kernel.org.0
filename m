Return-Path: <dmaengine+bounces-2312-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB292900B82
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 19:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14A81C22065
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302019B588;
	Fri,  7 Jun 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+B6pumu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1E19B581;
	Fri,  7 Jun 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782434; cv=none; b=AgZTtI1ONcbmLDUllmacXu46/dabVd6juyAm+S1HC5WWF8y3Rgme4bgsogxafRGhb7EVIwH8BQYQppP8dzrTL+Fbq0GsNrA5v4+JNPPBT4fgm2zeajtT9ebjzWZ27lgypYpVumtjG24USoa2gRCf4OUPZpRF5c5rRsRrxoCXmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782434; c=relaxed/simple;
	bh=b79FDe3I6GdhJSCi2760POW8m/nx3UZ1HZEeBdwMa1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tphTSiu+FOG/TF09JTKmziLs14UByYfuVk9KZS+8I6v9577KLtDpnh9V52R9/sUWWDBfoM9NR1cgkAkMMO2zyhiO8hc6d1fzlMZycNuSOupymF8gWlb743jE78Usgr80KY04LOlo6Hp7FFNxSQ4Kv6iZkCQbbExcLMYeVCQBk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+B6pumu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009C1C3277B;
	Fri,  7 Jun 2024 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782433;
	bh=b79FDe3I6GdhJSCi2760POW8m/nx3UZ1HZEeBdwMa1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k+B6pumu8RITfYnxc3/p5lr9BTVwPcarBYj7ytgC/1o9zs1B3ZdK4slRDqcyu44uf
	 bGIJS6VRioXnawaEj/++Bn+v4+IvnVRxqIg+mFcQXs2M3OYT7UDZB9zKSvN8RF88X3
	 sSYgB5EF6pm0/njzZL4+tRpd1NXXnW0PxeGh+icLlyorks+oFbsqz9ColNopGf7yae
	 nEO/wp18HC3lE8oJLqSKlTFaNWwkcqTvV/lAloeRmjkOS99fhW0x7l43YI9A79E9eZ
	 pwWIrgnf4vjcHNYDvnVkkhdT9v2nVkWZAyyzOVthbKf8xen03ek4AZbv7AZXn2Lwnp
	 NLMZlRFmi/y3A==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240604130714.185681-1-krzysztof.kozlowski@linaro.org>
References: <20240604130714.185681-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] dmaengine: ti: k3-udma: fix module autoloading
Message-Id: <171778243164.276050.6051118129133335618.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 23:17:11 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 04 Jun 2024 15:07:14 +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: fix module autoloading
      commit: a5dc404213192229aeac362bdca0b5fa95a42c2d

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


