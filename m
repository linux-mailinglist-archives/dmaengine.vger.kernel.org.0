Return-Path: <dmaengine+bounces-5050-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF31AA8EA8
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C777D189193A
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08FA188A0C;
	Mon,  5 May 2025 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbt+1+ru"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B31EDA33
	for <dmaengine@vger.kernel.org>; Mon,  5 May 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435428; cv=none; b=E9l0BkshOwO+/S+14blrUopDAqzJ4udbfzwIjWrqx8490nqireKkidQyYUZI0hGtRWbSmbzJtjvDwORLe3IK7a3JmuRnkXT8yxumvTTsE2QTfqgD510FFWxoNtD3mRuHIE9yzSOBqK5ZrlbeIn28OsYDyIT+xdSCf5AO8rjDu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435428; c=relaxed/simple;
	bh=zwQ2WGMJRkig3reMsZHumtlh3zNCndRtN4zYIDuHLec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFGAoqfETxmC8R2xzlEFw9s8WI0mzRtwkzKs5bAmf8vXqBOedHL7Rh4wt7OKcc0S1nBhvQPB0aVi3WWecxCH9e1jDdEwFGntGog+E2EcfCjk/9renZUXm7syRnXsENVWlBu1kp87qJfgdw7aMBzZNFaZU2U5XZlJsMs6T8A0XWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rbt+1+ru; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso769392766b.0
        for <dmaengine@vger.kernel.org>; Mon, 05 May 2025 01:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746435424; x=1747040224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twFRaaGQAif63hrg13kb5IFUKfR33Ambpgl1WwN0LnE=;
        b=rbt+1+rulLi1Ty+KpoH8MhEjxhaIO6NTjneMqGWjgGXAsqOfgiWSCUChaEcjc0gDxt
         WvNwF5sYCfF1Z0eksKBatcf39px3IEfgeitePSz0LtJ9v7IQ+HoEHeIu/J1/gLiUEdkM
         2vHg2Ps5XW6ZdsW4eBGkI/of3OSaspGiZBe2bCOAfIXfRRZAWb9/dTyo4C3kx2dFC3K0
         NjIe6vX4ZpTvrBzss9qw/lxeR+/rkR2lwxA6mxJSjztSoHv1nlkz9o09hcAnn1zrN1+K
         P3UyC4RVjE3+upL8Fpb1SxZkvjT75KQTF9azti42ccPCAgtczPsAkpYaL84JZhvmGZhR
         dZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435424; x=1747040224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twFRaaGQAif63hrg13kb5IFUKfR33Ambpgl1WwN0LnE=;
        b=UvCO9Jx9utcuil5I63J/GaoYyqyqtGHtHMPz+rJ51WsHP/h07ROZI8/q3AjgHIrr23
         hROHvx2XoLwuUHAIu1to3oxr5AwosWed9E8J2H1DKEhHMgMOw0bmWE/FUTHVMMI2UBPs
         eguT0vkNfZaavum0SMT7s8Gz5IP6u3CIm+aVpJwvpF8Dvoac8MUCCYunUb6Av5qVEWBk
         BHVVG9bKh3BRE4xuSYIHuRt1qtZw8IXRIJmNHRonZRUr9JINK0nO0W9DfZNsBWeCmPhk
         p6mf18n0lYVOVk67VU+fi2tmyh+F/gx58BxBO9AcI7UmGrinruENZrtndkwfJGtQi0Sk
         hFag==
X-Forwarded-Encrypted: i=1; AJvYcCXu8ah/SwaNOW7ZCr9ZtZvA+hTttPkRpKv94ypzvd0OD6Jx6qdcesQ0p2xWlbabgbo0A+DpRjrFlLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwuCkDMRwJD/ogluqtfCUBxW9sE6gIlLld8Sa/f1Qy8e6jSzK
	Kqmsh69gM0DR9Kv1Ewvl3v/Rvvn/rHiuiKrdmwTCIOPySOHn3yN+p7/ZNnWN//0=
X-Gm-Gg: ASbGncu9B1fUTwuyQu95K2vngbmp9u1EKe25RUddMzEtSmOlxLGlmEb3nDvZusMu/wX
	8+Xaluc84Hp0E4U7MUlGoyH/ldHNksVc6sAJ2+5dDQPIERRJQJApT3MdK/1uDBpOclrE7ensKHz
	of8GlzjoKMHtWZ1ZOD0acFgYL0+p/JkAdSSb6988+lsmUPZK525XhxX7FLxOEm1UPc+Veelic9k
	+nwRPf8Vg1zUdh97YG5VSVFh7Tu2IjDh/ZjQbHSScJeCLpL0WyLfG4e5C7mxbPWWXcZgN9NpwOS
	C7dKVF6asS36GmujZ7CKJiMmGIKiYIZMQ8xhbqoAS9EhZThXdg==
X-Google-Smtp-Source: AGHT+IE7wNqWzTYqeQUTRoeCnQGzyN3VhgiWSTOZ9M/mvZ4hW4jHw55Y7DRHPzUaVluMv512tH+2nw==
X-Received: by 2002:a17:906:dc8a:b0:ac3:afb1:dee7 with SMTP id a640c23a62f3a-ad17b5dbc98mr1130736866b.28.1746435424095;
        Mon, 05 May 2025 01:57:04 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:d6d0:d270:a4d:dbd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189508d03sm458777866b.133.2025.05.05.01.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 01:57:03 -0700 (PDT)
Date: Mon, 5 May 2025 10:56:56 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: keep remotely controlled units
 on during boot
Message-ID: <aBh9WL2OMjTqBJch@linaro.org>
References: <20250503-bam-dma-reset-v1-1-266b6cecb844@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503-bam-dma-reset-v1-1-266b6cecb844@oss.qualcomm.com>

On Sat, May 03, 2025 at 03:41:43AM +0300, Dmitry Baryshkov wrote:
> The commit 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM
> underflow") made sure the BAM DMA device gets suspended, disabling the
> bam_clk. However for remotely controlled BAM DMA devices the clock might
> be disabled prematurely (e.g. in case of the earlycon this frequently
> happens before UART driver is able to probe), which causes device reset.
> 
> Use sync_state callback to ensure that bam_clk stays on until all users
> are probed (and are able to vote upon corresponding clocks).
> 
> Fixes: 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM underflow")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Thanks for the patch! I actually created almost the same patch on
Friday, after struggling with this issue on DB410c when trying to add
the MPM as wakeup-parent for GPIOs. :-)

How is this issue related to _remotely-controlled_ BAMs?

The BAM clock will get disabled for all types of BAM control, so I don't
think the type of BAM control plays any role here. The BLSP DMA instance
that would most likely interfere with UART earlycon is
controlled-remotely on some SoCs (e.g. MSM8916), but currently not all
of them (e.g. MSM8974, IPQ8074, IPQ9574, ...).

The fixes tag also doesn't look correct to me, since commit 0ac9c3dd0d6f
("dmaengine: qcom: bam_dma: fix runtime PM underflow") only changed the
behavior for BAMs with "if (!bdev->bamclk)". This applies to some/most
remotely-controlled BAMs, but the issue we have here occurs only because
we do have a clock and cause it to get disabled prematurely.

Checking for if (bdev->bamclk) would probably make more sense. In my
patch I did it just unconditionally, because runtime PM is currently
a no-op for BAMs without clock anyway.

I think it's also worth noting in the commit message that this is sort
of a stop-gap solution. The root problem is that the earlycon code
doesn't claim the clock while active. Any of the drivers that consume
this shared clock could trigger the issue, I had to fix a similar issue
in the spi-qup driver before in commit 0c331fd1dccf ("spi: qup: Request
DMA before enabling clocks"). On some SoCs (e.g. MSM8974), we have
"dmas" currently only on &blsp2_i2c5, so the UART controller wouldn't
even be considered as consumer to wait for before calling the bam_dma
.sync_state.

It may be more reliable to implement something like in
drivers/clk/imx/clk.c imx_register_uart_clocks(), which tries to claim
only the actually used UART clocks until late_initcall_sync(). That
would at least make it independent from individual drivers, but assumes
the UART driver can actually probe before late_initcall_sync() ...
Most of this code is generic though, so perhaps releasing the clocks
could be hooked up somewhere generic, when earlycon exits ...?

Thanks,
Stephan

