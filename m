Return-Path: <dmaengine+bounces-7040-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC500C202D3
	for <lists+dmaengine@lfdr.de>; Thu, 30 Oct 2025 14:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FFC3B221E
	for <lists+dmaengine@lfdr.de>; Thu, 30 Oct 2025 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1433C50B;
	Thu, 30 Oct 2025 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS1gYyNu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD382EB86D
	for <dmaengine@vger.kernel.org>; Thu, 30 Oct 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829784; cv=none; b=TX7aGePRUaiSRw6EVi4R79CPyWz8uqvNhjAtCVObNcjYkXNzNdwuD0EWrSiDtc2ni/ddziXKJS8ElhncWReNcxUwIHreQj0GhWFI9jIQZAjZFQ0c2eVUR/utIGd8K8gk5S865YnUmaljPLmSPo/+kXRlrOoCkNB7CwHEYXrCkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829784; c=relaxed/simple;
	bh=plJUa7lFoTCGcsfOcpff0Mmv8iijDqb9eglwUue1zUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCLLpq0lchi2IO1hJkR84BD8Lmt4ElaBycRe/XtWHB9tD0jxZKGP6ins7McspYFeRnbrf9Ytp9e4Ali36B6gUsXN19ButSldP89UOx8wGVgH8MsoLn74gO3SeIFtAc8B/e9hj6GTHQ49dDGx9kzke5e8p4iuPOMlaUBo5F1nDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS1gYyNu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1057343f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 30 Oct 2025 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761829781; x=1762434581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FvrWgtYM1o1H3GtR4yRdUrofDJ3VZExWe4rEvgf3XU=;
        b=jS1gYyNu1dhNyr7TrmrQC3YxaNzV/ACi7UqJs4TAkzRp2qcSXwdL3beFw0rCsnyabg
         CYBGGDy0FcZzUkibSNNztC4vjV1b6khmSSoDGSg9dluNwu75J+NxNPFucRqCEZjGAEeB
         mGG+6rIoDj+3tUPkmxl3SGsnLePoX8Vd+9sNjrJ2Dm0AyxcMsgHXRKHSlHpB9c8T/ua1
         MrWXktOGoL/ynxarz6tjDnM3FQQ6XRIQV9l54Jb5hFDKBCm/30aGbmmPP6TKeW5qvyqm
         tC8qHGlECpgQJSOAnRv2xqKXFJtXqLofuhTk2tMJwCtL1D9FG0lq1rn2wyPkjv+sLC7Q
         GpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829781; x=1762434581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FvrWgtYM1o1H3GtR4yRdUrofDJ3VZExWe4rEvgf3XU=;
        b=lKuOWfW4hl1wavgHYqA5jvUCR0L4Miu7emN5NQLmOMKNOFgx6h/g1cYgNr+mD3rR1h
         5hZh691HMBY6VDqdyVamUlytLIqfWpHoHTXCTjZ2gmkRbjnI1WSZiEqtT/d9EdrB/TF2
         V/VQ80sLB+T6k2T33HdM/l4fyMQT2UJNLidhSIxKaPyT/25ox6fegF5pnx5ml9LNvOdO
         i6KihhYC5+n0hCNS20RRYjUe/W0IKp7SRGEM9g5JFwZN8g+W6QE3eKAbLKq2B8bvtJDi
         k7cNhaNhYPRyIUtmsfCrIym6DRunBwZHL/TsDOQvJT02trVUtASnA6bTRRgSdiF70sSu
         vCdQ==
X-Gm-Message-State: AOJu0YzYr1szszCvVdihkp+dzhx0fxkPi/bjz4hoT/cnv1bWI0vnxLv7
	9d5mVBMvyN1kOEqZSV4NPbVfzbypQvQ/CVkb1PyI4CS/r4HO0HzPey+Q
X-Gm-Gg: ASbGncvMAhTGMHCStkxreqVumTEm41eK3vhI+oBTR0tVmNSs0QlNSYMPLnzQ0JaGr+z
	/6YlZrlwcCT/ndeJjhKppbVjIu/oZIsRLcR1thV8z9kMR5dnGXjj9GE1wTpPujpWcj1ssDwAw50
	8umrGfFNnuSXwrSv10xVuZ684SVOc05PLkFVwYyi3ZNFq3+brmf12OJcZb0LAjd+d6dgboxNmqK
	a669ZWZ+ktDDWIVXKxzs8BeTH5g/cG8NRPV/hvDOuSsXF+KcibA/Q74yjnhRAjurVdSBnCjmbtl
	xtU1EDelG0osSsQfHLewgVIX5pxsRS5zivC3NvHdqo1FSBB9lTO7ZZNjOVJ1JSJiAWva4JmG9VI
	RnSWpiBKwpeMVtbXNIlF1tvKefc2lSnVBSXI8jWpIXEQPztOkiX3SweypEGCmxrOGaEa4Xdi6cL
	M340gmI0FehDJgxHfDiHHJfkSO7Q8KrG8LlIep8fEOFSUIVfiA+93qqH4Tj446za4WB5JKAm3NN
	xXWcyhooZBrXdHdJPMmmikiA026IRzBWqylSNCdxFmn1nU=
X-Google-Smtp-Source: AGHT+IHt0qZj97JBfhSm3bU2Z3jejv68CgVJx0PCPzKZeY8wdWN+4MGQv4dUD3at1v6e8mwpzpu6rQ==
X-Received: by 2002:a5d:5f96:0:b0:429:8d0a:8108 with SMTP id ffacd0b85a97d-429b4c8a0acmr2867282f8f.24.1761829780332;
        Thu, 30 Oct 2025 06:09:40 -0700 (PDT)
Received: from ?IPV6:2a02:8440:750a:26fd:c3f7:5627:ab4b:232f? (2a02-8440-750a-26fd-c3f7-5627-ab4b-232f.rev.sfr.net. [2a02:8440:750a:26fd:c3f7:5627:ab4b:232f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca979sm33491156f8f.14.2025.10.30.06.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:09:39 -0700 (PDT)
Message-ID: <287da4e3-0a28-42a3-8f59-7e41dde4d20c@gmail.com>
Date: Thu, 30 Oct 2025 14:09:38 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: stm32-mdma: initialize m2m_hw_period and ccr
 to fix warnings
To: Amelie Delaunay <amelie.delaunay@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20251030-mdma_warnings_fix-v1-1-987f67c75794@foss.st.com>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <20251030-mdma_warnings_fix-v1-1-987f67c75794@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/25 13:26, Amelie Delaunay wrote:
> From: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> m2m_hw_period is initialized only when chan_config->m2m_hw is true. This
> triggers a warning:
> ‘m2m_hw_period’ may be used uninitialized [-Wmaybe-uninitialized]
> Although m2m_hw_period is only used when chan_config->m2m_hw is true and
> ignored otherwise, initialize it unconditionally to 0.
> 
> ccr is initialized by stm32_mdma_set_xfer_param() when the sg list is not
> empty. This triggers a warning:
> ‘ccr’ may be used uninitialized [-Wmaybe-uninitialized]
> Indeed, it could be used uninitialized if the sg list is empty. Initialize
> it to 0.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>   drivers/dma/stm32/stm32-mdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
> index 080c1c725216..b87d41b234df 100644
> --- a/drivers/dma/stm32/stm32-mdma.c
> +++ b/drivers/dma/stm32/stm32-mdma.c
> @@ -731,7 +731,7 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
>   	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
>   	struct scatterlist *sg;
>   	dma_addr_t src_addr, dst_addr;
> -	u32 m2m_hw_period, ccr, ctcr, ctbr;
> +	u32 m2m_hw_period = 0, ccr = 0, ctcr, ctbr;
>   	int i, ret = 0;
>   
>   	if (chan_config->m2m_hw)
> 
> ---
> base-commit: 398035178503bf662281bbffb4bebce1460a4bc5
> change-id: 20251030-mdma_warnings_fix-df4b3d1405ed
> 
> Best regards,

Hi Amélie,

Thank you for upstreaming this patch.
You can add my reviewed-by tag:

Reviewed-by: Clément Le Goffic <legoffic.clement@gmail.com>

Best regards,
Clément

