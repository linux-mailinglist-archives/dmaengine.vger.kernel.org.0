Return-Path: <dmaengine+bounces-2713-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0207C933B01
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 12:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E70B21B5C
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61817F390;
	Wed, 17 Jul 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTry9gij"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80F17F362
	for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211216; cv=none; b=OskmjlakZTosSSvKwiid9kOf1AjQRtiLyHKpdYTM2MIfLCjCfNuJ310mNlumFzthNYFfoGJz8hjirNPGzZuQydFdimvNTVd80Bjcb8j51ncPsopEtFZia4herkAe6Agw7pJ0GOBOVcoC+CeKa0C+5VGaXaoCr5crLe345QO14wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211216; c=relaxed/simple;
	bh=hxNjZ66OWMZr/C2wZN8pEwfxToH7/kQfSytf/d2PWmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFqVgbqFsrjcsfX/JyH7WdbLWsLSmWECG2rzOgLOl0x7XEqtpFAkLLHj1DDst3HJG80R8bw3W77O5g3A6NJKShrjaeLBC8WMFt0JlKEaxzbr6Z/POAL+r62yVLThMEdRdg+DxUwt9+uJG12v8V1RlUVWY+j9ZlkuOV363bFFYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTry9gij; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso9377596e87.2
        for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721211211; x=1721816011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMZYKLKt5nFd5HxKUlHRZ5jJLcFrY6yg4Rsgp9kmoAQ=;
        b=eTry9gijch8j+EOLZTkQZOUnzQKoNg0mfK1Y9+lo+L5QSnhr2yw6gOT8UXcOBtDQXG
         S5eeFriSKDbBJbLkjRMqGlZyTsVpNcEOo2QXA0S58jtpyuAWDtkBCOA31+fihBcF24Fe
         ghFEkwPgkrJfLO6mpydx6GGK7KkbCg0nxZq3CvlZNDnLkW69qCb5AZNZZx+qhKdA0zj7
         64vBP1fd9T8pVQEJFLF90GqFg4IGF/LidLUpEjYgSM+ecXLWQK09B1wy8cgijdn+7+FX
         TW2OqYN9bRMRvLYcuNQjdB+aQqjgqB+uAShZlh4eFnIo75QIOZNk9WTu2JxV+Z7p+3Yi
         wBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721211211; x=1721816011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMZYKLKt5nFd5HxKUlHRZ5jJLcFrY6yg4Rsgp9kmoAQ=;
        b=Pwjbz/Ql/s+Nf2LWpK1Ii5U0F/32mVE4/n0oofohuLiXlMDEox1Qw0DGUto08aXPdv
         t74SMwK+ZB8bffiRI8jKpmIrtNCf4CJvszw6OaP2ORtcfSwp+fgDQs2duQkAXYNC/zZW
         m1sesnCTGRLStwZ/15Hl1HLt/GOrl37+PiQovmzYo4hcgxNPjlQ/+qK+d57VzWqGNYLX
         Jla+TVSjN1+EpA2qTN+iLyabi82TA5Ur+YUO6ytKBCkAKFs9Nj203qjkLO/C8dpj35IS
         gG694thZDWtmRIU+t4BGwjwIYiN3YzTWwiBL6vo1KgMU1EpcjDPvt4aYWbS2Vmqoc5Mu
         KzPw==
X-Forwarded-Encrypted: i=1; AJvYcCWyGtnvLnNy2cQHI+U+8xxCVkKq7raO3KvH/U4B5jl9Y9DI741+plTdzlPn3BPQUF0O+zQDehgg5bZVky+pPYa7sYc38S8HGPIi
X-Gm-Message-State: AOJu0Yzdt6vZ7u4H/KQqd4l09lV/cpE5h03hnDv4hF4JFX7RUFxYnrK1
	82oNqMTcDvfdBKjJgY73ZOiVduV277/zARfgwkn4i22UH45UXiffkoBwu7JwmbcA/pXHryBRTkd
	l
X-Google-Smtp-Source: AGHT+IELOSsF1rgKjRha5ckjNRdafXsWAIxx9DRlMPjsOekcKMHphs3bL5kmZxENhMXZN90ppLOydA==
X-Received: by 2002:a2e:8e8f:0:b0:2ee:d5c3:3217 with SMTP id 38308e7fff4ca-2eefd153332mr9815001fa.47.1721211210870;
        Wed, 17 Jul 2024 03:13:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee17b1ccdsm14243311fa.54.2024.07.17.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:13:30 -0700 (PDT)
Date: Wed, 17 Jul 2024 13:13:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vkoul@kernel.org, konrad.dybcio@linaro.org, gustavoars@kernel.org, 
	u.kleine-koenig@pengutronix.de, kees@kernel.org, caleb.connolly@linaro.org, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Handle the return value of
 bam_dma_resume
Message-ID: <nyt7tngjlglaksweiwgj3bfr4b2kbvbeejv32yrk6qv7rexlpw@fgl7v2iet3jh>
References: <20240717073553.1821677-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717073553.1821677-1-nichen@iscas.ac.cn>

On Wed, Jul 17, 2024 at 03:35:53PM GMT, Chen Ni wrote:
> As pm_runtime_force_resume() can return error numbers, it should be
> better to check the return value and deal with the exception.
> 
> Fixes: 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM underflow")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/dma/qcom/bam_dma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 5e7d332731e0..d2f5a77dfade 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1460,9 +1460,7 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	pm_runtime_force_resume(dev);
> -
> -	return 0;
> +	return pm_runtime_force_resume(dev);

Which function will unroll the earlier clk_prepare() if we return an
error here?

>  }
>  
>  static const struct dev_pm_ops bam_dma_pm_ops = {
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

