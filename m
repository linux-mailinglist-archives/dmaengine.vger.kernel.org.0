Return-Path: <dmaengine+bounces-3009-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD61963C4B
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 09:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1CC1F22928
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41931741D5;
	Thu, 29 Aug 2024 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JudAdnL8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778716F84C;
	Thu, 29 Aug 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915549; cv=none; b=eT16ILS9nrjABLuz5cgzdr+dFbL2kUOOJpByPnRrwT6XoaNyhV1ilP7cBZiL/BZwXSvo5SJpGCXY/PMVsYZkceANqngV1wmvQamBCcaYJDtDOvptXP0aD1na1On2mN+Lw0+3Lo9KhCUIjNvXZaaQ0j6bBMpPY6uQiQhpS0i+cak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915549; c=relaxed/simple;
	bh=9co1P+gsEElJWQz3aCKdVbHmq5v0U0eVe5GCFZD2reI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYiHVf4jrEvDQhO1ZBfo5kKYqb+5KOX+m3Iqrn2mNkr+GhdCQM6jNJo2xetRgvpct7RgXTf0KiuARmrEG9kccRRhNxPj9veq7bNdiAR9wDWym9WE1evJchoWa/YSRz3m2nw+zBAdYikbZZt4WZULdmu/3O8/pB86Vmvvchmk5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JudAdnL8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f409c87b07so3822541fa.0;
        Thu, 29 Aug 2024 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724915546; x=1725520346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inpQImvFciw23meNvL+FEqOxB3sls+T0q/wERHsKE/k=;
        b=JudAdnL8VJXE/Eu5EoM9XaHtQOArvKNDo1rULGUwz0dj5Q6HKtEAY0FimzeIJaTWxm
         qs4TSiJndjgfWnk1DD5XcmCmcgwhtW0DgajAHE0r0IHYDP9UusG+HAVq0pFeADfCLoLu
         6huHrGGKLOSA8SPH08VAWF1G3+KaIPJEBeSoKAJNl+da5YgWZkotAnFBF1/vbmsuXPEz
         +aKv6eRpEfDCf3lNgpXDYyEfMxiqgJuSY0Bcg9p509nngXGXtoozBBcgaiS9BPFJk/ji
         n3UbYjZL2dC/HTTUVTDJecKE1oDvaaCHDvS7+YLYErXmkXbdCVQa2guxWDbZbLII3ZM0
         PArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915546; x=1725520346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inpQImvFciw23meNvL+FEqOxB3sls+T0q/wERHsKE/k=;
        b=mAEPk43nLGGFSyA6EcZrgwyIzE+eOAlZhnEqeKEiiFuIDOQPs0p7DNRN0ct7WRVp0T
         ScdT4YDF9JjvJPU16pGUNNrRwHnGRTuDK1RQ/Nj4hsPKTtu3WnI0EplvVEhqpM2gtl8K
         KKG7fuNtv2DT6BDavubPLppJf0GIssbvOo3fSh8+QoDtFQTbPssme1hAqcVe7pSQpo1O
         P+hPCF3kT03iLpBLJdAk/DAsm4u9G6F73y/pStn0OVc5b4gzu1/NlxK2XBp7kZV3tY4Q
         ZZ8MokLB+yewD3UDspaRMgRx/y9WUwqKeU+YLS5bh/7Y8FgZ98Lr/FkjD1OcToz9vzwU
         oMHA==
X-Forwarded-Encrypted: i=1; AJvYcCU36LGaoJ+wNECBbabnYM3a2oTupyM9T11ltgaOJDU5498mi8DfNy1ZHVrXAQKWu8TU22EQNWhY9//rsUXv@vger.kernel.org, AJvYcCWmIywlEsPbQE7a/U30d1M0DY+92DF5TLUvHusg/CV3EDyWw4H2s5oYXkhwHOelrk3EtcN5K99XcIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJUI55M0vr5I/o92bxzl8gQVq3gscxCWWcGWPNaYoe4mHUg/Z
	Kcopw+9WFL9DdjxswHhZQbXbbRbUsybqHVyDTTtzmRPcR+HoiJVx
X-Google-Smtp-Source: AGHT+IF/pJrZaVpF46AkrbMNGYnsIaOXPPC3Awfu015A0Ff7UAu6377Hna1afmai4OTU01axuyJk7w==
X-Received: by 2002:a05:6512:4003:b0:533:4b70:8722 with SMTP id 2adb3069b0e04-5353e54d8f4mr1114983e87.15.1724915545275;
        Thu, 29 Aug 2024 00:12:25 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841332sm75157e87.203.2024.08.29.00.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:12:24 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:12:21 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Fix unmasking interrupt bit and remove watermark
 interrupt enablement
Message-ID: <xadu7yiqbwwywemcmgfpz2x637dutntik7mdii4xp2vyipq4he@4gmbreitlui7>
References: <1724674261-3144-1-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724674261-3144-1-git-send-email-quic_msarkar@quicinc.com>

On Mon, Aug 26, 2024 at 05:40:59PM +0530, Mrinmay Sarkar wrote:
> This patch series reset STOP_INT_MASK and ABORT_INT_MASK bit and unmask
> these interrupt for HDMA.
> 
> and also remove enablement of local watermark interrupt enable(LWIE)
> and remote watermarek interrupt enable(RWIE) bit to avoid unnecessary
> watermark interrupt event.
> 
> Testing
> -------
> 
> Tested on Qualcomm SA8775P Platform.
> 
> V3 -> V4:
> - convert IRQs unmasking in a clearer way as suggested by Serge.

Thanks for submitting the update. The patches have already been merged
in, but anyway here is my tag:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> V2 -> V3:
> - convert 'STOP, ABORT' to 'stop, abort' as suggested by Serge
> - Added Reviewed-by tag
> 
> V1 -> V2:
> - Modified commit message and added Fixes, CC tag as suggested by Mani
> - reanme done to STOP
> - rename DW_HDMA_V0_LIE -> DW_HDMA_V0_LWIE and DW_HDMA_V0_RIE -> DW_HDMA_V0_RWIE
> 
> Mrinmay Sarkar (2):
>   dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
>   dmaengine: dw-edma: Do not enable watermark interrupts for HDMA
> 
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> -- 
> 2.7.4
> 

