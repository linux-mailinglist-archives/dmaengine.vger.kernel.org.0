Return-Path: <dmaengine+bounces-6518-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1975FB5811E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBFF188B96E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64322068B;
	Mon, 15 Sep 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoeRc0gh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9C38DD8
	for <dmaengine@vger.kernel.org>; Mon, 15 Sep 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950827; cv=none; b=eeC8ZkpddsnN1MJF/8tyDoP0iTkUk33sIJNraE+a3thhKIUIGquRDK/hD7S86VMbT/pgRkzcXBv4OGaKiv3KZDM3qmiul+oL42COkz4h3ATkj/m9q2lu3ehprN5sO+uFFIWkkxmbkD073nDtkpk4NBhseBAO4Btzi7Vx3TApiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950827; c=relaxed/simple;
	bh=82L0x2oMofUwCXJw/yoY61w/+jPiOevKC7hOK80hFRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+YwGx2SWVoLUx+x0lGuqvSx3IgRQ5sYaVICcNgZinZZ53ZyByWuqFoaa47/05GzsjW7EOBA/bAn2L17p34qZejsajAe74upCjF68FS9j/qhWjgTvkaDC+aZopJPibNvaPMVJxhe5L9QLcPvXtbw5E6rS4A/1yqTuRGizM8le1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EoeRc0gh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso5268383a12.2
        for <dmaengine@vger.kernel.org>; Mon, 15 Sep 2025 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757950823; x=1758555623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbGW74Hx6FChjlot3Wj0dX/C4wldujvmwSh9HaBF/Dk=;
        b=EoeRc0ghNxrVvQGRoZ3nWN7eqYIX5Oa6KFej7hYaNXQm76ZcJz1QQ6SpLN/UylK1lv
         cQBhtLOe4LHPZkg6eBLA4jIZXsUxSvm/QruNxmHDdGg+WS2sDRnlgD3wGmekm9JnmRB/
         uKqosEePqZ9PoBtmn5YcSInWj169g8IlCVJbouzVjTU8wbSG2seP9w6KqDfUV4oRvtV5
         b362cEj4K0AQUx074KBCoujWXIsPUKFuS/xcN2FjCCtKktQoxACJO4kYowaswYdQhE5Z
         avfZwX7casjmBbLe/ygyNDoqDxGLpXhPhphWkrx3VTrnUAyDMI5PH/YmBYIHKfPXUmER
         IHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950823; x=1758555623;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbGW74Hx6FChjlot3Wj0dX/C4wldujvmwSh9HaBF/Dk=;
        b=W5m3yA+F22kC82pR+em7SKtHAIVXM35yBC8zcLgoTSDt1iAbdSHRCQ16cuGVHggo8d
         V5liIJu0wEj3E8eKfqNlL/iJZElps4se3YlOsf4hXPPmzL5GZ6jQXZDytzSpRvJJuCY2
         Rit8qNQrnQMHennmOG3s8glzhcTHfB+vV7QLIT4Eb/c4pbwH21YwOzV1pyKhuBwuzY6P
         rMpyRPIr8yZjuUuxVkSF1DTYfxvjIuD6RbpiL8P5L93sgScdcRzozsuWvTM2G1zsADMz
         U3ywGKWxTpeD91GyYNqZGFa4nwFSsq3xQ7II3zWmh4OH4XfKGIHXu8i/SMsbQQF4/a5p
         o/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVfL8d0BNqaWRekxcF9399iwtkbHxmKwNq8WeBXQcZUVXTGBbD+IK90NDdjmFJ8fzoEhSRNfuRwVv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xUIn5Yhhp9ioETcVd0idrQdNXgIszV0yBgueneqLg91VHKH0
	qvYs1sEajJUdJOxro5a97xSVfcR/Pi6iFWEIzzyt1qcHXVKYz+Mj3C1S7F9WYw7d7TA=
X-Gm-Gg: ASbGncuIVw20pn9+QncMMELB7/EYq8yGpxIc/ItvpPXEM9QI846gHkijIezA9gXRq6v
	ryU61EJuSxNiK1jOpGMaM5x7fUSqVQz6Cr2R2pblASm+yKkPnhsDCDNjp2v8meB1vDTWrvCRm5b
	+CpH66KWp6Pm8QhKd6FbN4SEBXAwkzaP5MLydq10VY36UKVcFTtVhrM7MGFTnfYuLJkMmqf6sG3
	SPun5OSpqvUVV1Gkuh7gegDG3T6PA5XnM6Fq4bsFITc23enhVyfPu2m1qO0rSJg3mlxl2n/4DcW
	CpliNxOZHrAmrSyRxAMOwLFppPi87HAQe1nNKJo9Sq88TSTe/7qiAx0wnaUuo32dYu+CQTWENrE
	oELKLWPHaoIfoHT4dFeg+KdZJAp2zaVAN
X-Google-Smtp-Source: AGHT+IFaP0APFcnnHzepInFuNe9QRhF2cHCwrhbwHtmb3MUXGYc0B2MoogMChIbOb59TPPzqTW7arg==
X-Received: by 2002:a17:907:9444:b0:b11:4d6f:d7 with SMTP id a640c23a62f3a-b114d6f01efmr309182766b.16.1757950823214;
        Mon, 15 Sep 2025 08:40:23 -0700 (PDT)
Received: from [172.20.10.3] ([109.166.130.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07e1aed5ffsm568146666b.81.2025.09.15.08.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 08:40:22 -0700 (PDT)
Message-ID: <aadda4c7-a5b0-458c-bea7-59f1e983c1fd@linaro.org>
Date: Mon, 15 Sep 2025 18:40:20 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaegnine: fsl-edma: add runtime suspend/resume
 support
To: Joy Zou <joy.zou@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250912-b4-edma-runtime-v3-1-be22f7161745@nxp.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250912-b4-edma-runtime-v3-1-be22f7161745@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 13:55, Joy Zou wrote:
> Introduce runtime suspend and resume support for FSL eDMA. Enable
> per-channel power domain management to facilitate runtime suspend and
> resume operations.
> 
> Implement runtime suspend and resume functions for the eDMA engine and
> individual channels.
> 
> Link per-channel power domain device to eDMA per-channel device instead of
> eDMA engine device. So Power Manage framework manage power state of linked
> domain device when per-channel device request runtime resume/suspend.
> 
> Trigger the eDMA engine's runtime suspend when all channels are suspended,
> disabling all common clocks through the runtime PM framework.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes for V3:
> - rebased onto commit 8f21d9da4670 ("Add linux-next specific files for 20250911")
>   to align with latest changes.
> - Remove pm_runtime_dont_use_autosuspend() from fsl_edma3_detach_pd().
>   because the autosuspend is not used.
> - Move some edma channel registers initialization after the chan_dev
>   pm_runtime_enable().
> - Add clk_prepare_enable() return check in fsl_edma_runtime_resume.
> - Add flag FSL_EDMA_DRV_HAS_DMACLK check in fsl_edma_runtime_resume/suspend().
> - Link to v2: https://lore.kernel.org/imx/20241226052643.1951886-1-joy.zou@nxp.com/
> 
> Changes for V2:
> - drop ret from fsl_edma_chan_runtime_suspend().
> - drop ret from fsl_edma_chan_runtime_resume() and return clk_prepare_enable().
> - add review tag
> - Link to v1: https://lore.kernel.org/imx/20241220021109.2102294-1-joy.zou@nxp.com/
> ---
> Changes in v4:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v3: https://lore.kernel.org/r/20250912-b4-edma-runtime-v3-1-2d4a4f83603f@nxp.com
> ---

You have a typo in the subject, dmaegnine/dmaengine

