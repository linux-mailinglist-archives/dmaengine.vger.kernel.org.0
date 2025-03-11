Return-Path: <dmaengine+bounces-4703-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F35A5CA1F
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 17:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF1189B1CE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C3260394;
	Tue, 11 Mar 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjUToyOu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53141260391;
	Tue, 11 Mar 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708840; cv=none; b=RDcYMFreZZFS633AyOzKvTOOKdx6TDHYfWRiSAbLaDC23gY97xNQu8jnRW+2dV3bOJTwpT3zIglCakFU7C78oZ487aaETOxIG/D1POriI6cMgQI7odM0yugBtqfUdasZQVoX5YM8LktapnLiQf+qqSKNiRzwJ28HEwbMazfe8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708840; c=relaxed/simple;
	bh=BDMhoO7pIZbqZYNpvEkPEFUNG/YjPB1RjCNjXcRcmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puUCTJA8t9vf12L4t7T4QOb5YEimERxnucY8+Wp9Pqbj/XbHJEhF79PRP2wrMKo5IU4kFInIBm7Ple6z2KtjuSiK1ZfodliNTe7A0IPEds2Zqf4Rk4e4DLkOuasgwnpuQB4HmE4UgrlHtAs3T4DG6s5RS4TJ+HLfsLuhrgvhtl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjUToyOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8B5C4CEE9;
	Tue, 11 Mar 2025 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708839;
	bh=BDMhoO7pIZbqZYNpvEkPEFUNG/YjPB1RjCNjXcRcmGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjUToyOuRndCb0D0NHcn5OXJ3UFFcwrRuj2x+aM3hfCp2U/TrjJRU96zznSeqBcSn
	 tQjsLyB834+wfB30Kt9YeMnXZIPvhKYgAzJv+vvx0mSNZLDX0v0kP0xgh5FEEnGNtI
	 1+hfX8E7Lg4CZossdIVrDlAZuiqg1cKeQoG+6xVQB55Q5B4l4Klx4LU5ckY9g3XbHw
	 fwX13jdY4+yG9GFvL6LqTG1rx9gHCOwVM3AbtpQNdco536oRrrH6VLqXBSkaDR/wnX
	 MhbTXW2yH9L+GSo5kp+pA0s1jJYT/dJoWZIOXqIkgqbIp+azNesTM9uwESUH686vKG
	 ZZDXPhjr8Rvag==
Date: Tue, 11 Mar 2025 18:00:34 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Md Sadre Alam <quic_mdalam@quicinc.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 2/8] dmaengine: qcom: bam_dma: extend the driver's
 device match data
Message-ID: <kzrpoodomeonorvho35ivoe2qy4ycu3lcsxma2hgwhtbkanq3g@dr7zf4pocbim>
References: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
 <20250311-qce-cmd-descr-v7-2-db613f5d9c9f@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-qce-cmd-descr-v7-2-db613f5d9c9f@linaro.org>

On Tue, Mar 11, 2025 at 10:25:33AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In preparation for supporting the pipe locking feature flag, extend the
> amount of information we can carry in device match data: create a
> separate structure and make the register information one of its fields.
> This way, in subsequent patches, it will be just a matter of adding a
> new field to the device data.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>

-- 
With best wishes
Dmitry

