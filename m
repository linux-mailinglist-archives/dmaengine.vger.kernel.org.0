Return-Path: <dmaengine+bounces-4170-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AEDA18296
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2025 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031EE3A732E
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2025 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536A11F4E32;
	Tue, 21 Jan 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmdKyGo+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BF1F540E
	for <dmaengine@vger.kernel.org>; Tue, 21 Jan 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479392; cv=none; b=jfoHzdhdR3xrWlSUSsLfiuVx4C64JLMJskU6Od7YJA0rs5j5qnZikHI8SBx33LZH1yShqqLFbePokH1T+YvpjXS1gf9a7INJtVFo7XrJ7P0ditM+UMfDbCklo8zlzPChNBVNLR24hU/I8OmZqaF+ae/eqkHEnKXftzJx6adVwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479392; c=relaxed/simple;
	bh=7dKpPLZ+N5GQFNDINCVCzU3UbGQB0t0GO+ItBx3qoFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tv6UmyQ3thlu8lw2owT3ZXYeX024YW3DKR8+lutHC70A95ak+kp9teGLwd4LZco3mRoyU9s0JhKsdWy94HKsGiUSR4sYnKFuG0CKUW4mNlzxkfHosivBGGVXpjEorw6AVeqD+o07SnPaQm5JdjtO+uYamHhPt3Ab9kFnGb9yVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SmdKyGo+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so1162006166b.0
        for <dmaengine@vger.kernel.org>; Tue, 21 Jan 2025 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737479388; x=1738084188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxDoLbkRPn9Vthle77mNklif41OmMgAe2bKS/TCk5eE=;
        b=SmdKyGo+Oh62Y9D0Ft21vXptE3BUu8e6fw75XCn4naDRysXdWiy9GH9u8rn8kQqTlW
         MlmwbPzX13wNaRQjHzT/VE9jLLP7K0t8l8d8k3zyswu5MkWqVIu+B4YULPlr9Sfzgp+Z
         d8SxEwDZpCtuSlgW+mapL+DuSP/lYKtdz/E3en311PX2rgwtJD+fpqN11mdXelblf91w
         9m6DS2lnmZ1NaaaD1hi90F8mUb+6vxqgmXHdbEulzN/bhDQTiSleLdeRiEfGA+H66FmX
         e3tJNz/+MMgjbZaijnaQkJ77PvYY8zDvtbA5Qjl/5OylYmL/AsNBBA2iUq0PADcK/m4H
         49vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737479388; x=1738084188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxDoLbkRPn9Vthle77mNklif41OmMgAe2bKS/TCk5eE=;
        b=sQ+spC9Zs8dNt22h2f447zA1S7SiLaDh0CWSOG0QAcoKasKVRXPfw6idGmomyPZ5/r
         LLaz6OyYQ0Gu24OlhyxHRcNMz9qWK9j+IexXCpZQoeQrbGvoIuxfuJW6JN9xfEqRNLi1
         RfhCnyql/pswBFNq3IFcOhxgrmqFcaw0dF4EfkBjZSc/MiXMaMCjxjaMysdCmtkI3/6+
         u+3nWmS07N+pePIxatKzUt5w27m7wMkX9sOM77E4FQvAxorqCZe1ggHVKnWrQtcXLauK
         iI5QsBCBX0EXiqo9MtdF5KqLSJiT13RpugBkOhPmIH72x/DIVddn86IXA/cOrSAeF3xw
         u+0g==
X-Forwarded-Encrypted: i=1; AJvYcCWoUA/m4CDkaz1pN9+zzIPn0dOoZ1f/ppE5UDGAx43jcSr5VAK17lyteLF3IpYdsXOmnsI/o4AV2Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQR+50EswiL8TT5FPN9DPY8BIPyCCbfHP15bdVIG2/tTTVLDb/
	v+vS5hZrB86qSf+2TkLQYDck+rluXCGFyNsfhdkE/YMVLHxpt9XPdu/7Cl4lqXA=
X-Gm-Gg: ASbGncvr+Cdtx6ysp+hp6kDT5JXlz4YIa/fTVQLyEYoZwJlGGzwhG2GWw6usYoOdZzK
	ETRFqQxpyBbpeQos4LEvBPs88qz9+ci59Ok3iSNGFwq5HaQUL1rWkQbMni/WJouTcANxn01IMAO
	nLFFaD+hgW4dExEEPERC/bSU5WFqI5YXDDxaA7e8u65UlbWyoJfjjNiYqqBsqnIhachXAPr9hDT
	JMt0/OUOkJiP4jm35gEF59NPHQUxHfCZK4cQVE1rnnpN3EvQ479Y74yBEzS7g1eeXazaIjnO7EZ
	cTtJ5w==
X-Google-Smtp-Source: AGHT+IH0PhEqAuio/NY68g9K8TEUUQseAncr8hzLqANeAT9Z16preh/Ch2TLNFbDs1DK+8j/H3CYgA==
X-Received: by 2002:a17:907:1b03:b0:aaf:1183:e9be with SMTP id a640c23a62f3a-ab38b1e8f64mr1917260766b.2.1737479388529;
        Tue, 21 Jan 2025 09:09:48 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:7b2d:11cb:e91a:7e24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c5c3e1sm772097766b.7.2025.01.21.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:09:48 -0800 (PST)
Date: Tue, 21 Jan 2025 18:09:43 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, kees@kernel.org, fenghua.yu@intel.com,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, djakov@kernel.org,
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH v3] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register
 handling
Message-ID: <Z4_U19_QyH2RJvKW@linaro.org>
References: <20250121091241.2646532-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121091241.2646532-1-quic_mdalam@quicinc.com>

On Tue, Jan 21, 2025 at 02:42:41PM +0530, Md Sadre Alam wrote:
> This patch resolves a bug from the previous commit where the
> BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
> mode. The issue was reading the BAM_REVISION register hanging if num-ees
> was not zero, which occurs when the SoCs power on BAM remotely. So the
> BAM_REVISION register read has been moved to inside if condition.
> 
> Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
> Reported-by: Georgi Djakov <djakov@kernel.org>
> Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

I'm afraid there are still two open problems here:

 1. In your original commit, you added the if (in_range(...)) checks to
    make the BAM_DESC_CNT_TRSHLD register write conditional. With this
    patch we only read the bam_revision for the !bdev->num_ees case.
    This means that even if we have e.g. a remotely powered BAM-NDP,
    we don't initialize BAM_DESC_CNT_TRSHLD anymore.

 2. Aside from BAM-NDP and BAM-Lite there is also plain "BAM". You
    mentioned we should only skip the register write for BAM-Lite, but
    the plain "BAM" isn't handled anywhere yet.

I would recommend inverting the in_range(...) checks to check for if
(!in_range(BAM-LITE) rather than if (in_range(BAM-NDP)). This should
also work for the plain "BAM" type. It will also avoid regressions if we
don't read the bam_revision in the !bdev->num_ees case. (Although
ideally you would lazily initialize the bam_revision to cover all the
configurations.)

Thanks,
Stephan

> ---
> 
> Change in [v3]
> 
> * Revised commit details
> 
> Change in [v2]
> 
> * Removed unnecessary if checks.
> * Relocated the BAM_REVISION register read within the if condition.
> 
> Change in [v1]
> 
> * https://lore.kernel.org/lkml/1a5fc7e9-39fe-e527-efc3-1ea990bbb53b@quicinc.com/
> * Posted initial fixup for BAM revision register read handling
>  drivers/dma/qcom/bam_dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index c14557efd577..d227b4f5b6b9 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1199,11 +1199,11 @@ static int bam_init(struct bam_device *bdev)
>  	u32 val;
>  
>  	/* read revision and configuration information */
> -	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> -	if (!bdev->num_ees)
> +	if (!bdev->num_ees) {
> +		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>  		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
> -
> -	bdev->bam_revision = val & REVISION_MASK;
> +		bdev->bam_revision = val & REVISION_MASK;
> +	}
>  
>  	/* check that configured EE is within range */
>  	if (bdev->ee >= bdev->num_ees)
> -- 
> 2.34.1
> 

