Return-Path: <dmaengine+bounces-1275-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8E87309B
	for <lists+dmaengine@lfdr.de>; Wed,  6 Mar 2024 09:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42485B20D08
	for <lists+dmaengine@lfdr.de>; Wed,  6 Mar 2024 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6031B5D47B;
	Wed,  6 Mar 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdtcunEi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94885C057;
	Wed,  6 Mar 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713491; cv=none; b=WJUHAGILrJkDEZ+i0CuIc1FtxQpaVc+YsNnZ53gYV1NLDD9RWV3Ncj1Hlx8I6/v5fmey3zw8Ul58zFj5Oy87cudeiVXlZBcOpeOUWNBWQ9GBk7oeISVuoyKwqGTs9l/tDmWcjO08r24cSgI1ADY0ZavAVwRGwbVWOSkCbiGsGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713491; c=relaxed/simple;
	bh=k/HbIqiXk/wu0mDYWVOYPq1UOLi4MM2rdQIq1/sN4pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUZXP3hOZpCT7IfFZFmmWfXDhmZpTXOF3McoiLmp0ljX6gvTTdt0eau8bDTdpj+01jAC4w1Cp9bEFoVtCTrdR/QAu9ZJmS0vV1RYzqObAatV9XD2JFku0pEpVocPpkfMPalz1z5Bl2ZpFXJM3XlylPUO6h6ZuQ0LR5WwRyQzNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdtcunEi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a450bedffdfso403863266b.3;
        Wed, 06 Mar 2024 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709713488; x=1710318288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/HbIqiXk/wu0mDYWVOYPq1UOLi4MM2rdQIq1/sN4pM=;
        b=SdtcunEi6vU2MtqGoKD+IkQaB17j7zpv60kLRHVDRmZCHR/mc7Zmtq8FEj9PmtHzvT
         gnBxZP32LxNR8k+UioXhd3Z9Kw/H0lO12lG7V116j0g2/P8lsOVMcOFd7J8DIg705hWv
         hfssl1RS4LWKRVP8/o46qa65qN//sUdd22NPr4Fm+vL0214VGnJgCENwfxnrO3YiStk9
         f7+c2LuL33euMCGNHFMOQ0xEMaVceerrAwtjcGghCRTyL0QPF+7bbT6UFPJMBIoRnXw0
         AF/4IrRLHEjHE5aFmmz9/KaKmAjbemejwWxZutu2Z5tqijpi0NGxwX3boBRLXnaDvv+Y
         ylIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713488; x=1710318288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/HbIqiXk/wu0mDYWVOYPq1UOLi4MM2rdQIq1/sN4pM=;
        b=DzyphULBtVtgYAl4nf8YaInkFG3PfchaHANtqmTLbaafbtBHSUHxYwVo5fnL/sNJhB
         3gcjDU0vBvDgJ6g78l9vcFMqIrF+nAi97bleAyToyUNQ6dQzlhJ94yY+DRqS/mlCvtfz
         CoB+LhMRC8acqOY6XidojcZsyeJ/WfoQCnIetVBGMcbVhQsiLFXrdOEm6834iVRdzLhl
         5USXU1DZbr7CzVEWHbHHN2G8GKdxrPT6Ox0tXMeKX5xLRxvHCQIN47sOCRsGMsxKRWj5
         bCpZWx3x4C/DNgq0wF4AI3LEKo5gN4O7SawzYklJK/BUq2s1C5ZkzrwcHIbv/yDBdkgF
         K0zA==
X-Forwarded-Encrypted: i=1; AJvYcCXjtrdvFy0rGsQNpi5RLIbAoDGXLMYDR3sflFX1A2dAUN9mPGX100DR+9bgVWJa7M7v2BnaPaSiwPiWgWhv0lg3QPbCQnrcbMDjOob4zSB0eSDDlwW5YMEpGXCykfLRGQVbiFsUfWZm
X-Gm-Message-State: AOJu0Yy2LzrUAByJ8Q7Lix13BUHPs4UFRCRDNHV9/82hhLQQV+l1DGev
	bBHnRzrS9qEtmvYhu3didoyz+DxADPQGfUa+AjF7AIM8e4IegCi8JdzJiJCF9R/ftrswdjoQJYm
	rjKp949onaPCfD9wjl5LiiGsy60U=
X-Google-Smtp-Source: AGHT+IF1Fv26nqs+0M2KpaCDTRPR7Ax7eaJRl9mRZxqdztpvBOx3KHsG5Lj8D313IqZflw5h/azi5NbJ/GfBtDmQU3A=
X-Received: by 2002:a17:906:d9d0:b0:a41:315b:94d9 with SMTP id
 qk16-20020a170906d9d000b00a41315b94d9mr8666736ejb.71.1709713487809; Wed, 06
 Mar 2024 00:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
 <20240303-sdma_upstream-v1-4-869cd0165b09@nxp.com> <CAOMZO5A60zG+1u0NYPFaLsAgCxcF1RxxybVeatovTGj07oxqBA@mail.gmail.com>
 <Zec8nYk6gzx9IxOS@lizhi-Precision-Tower-5810>
In-Reply-To: <Zec8nYk6gzx9IxOS@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 6 Mar 2024 10:24:35 +0200
Message-ID: <CAEnQRZCZk4_Vc10dV3qbk56jtO3Rb7hhghz2zqzg6_gbyvxD4Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] dmaengine: imx-sdma: Add i2c dma support
To: Frank Li <Frank.li@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, Robin Gong <yibin.gong@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:39=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Mar 04, 2024 at 08:12:09AM -0300, Fabio Estevam wrote:
> > On Mon, Mar 4, 2024 at 1:33=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrot=
e:
> > >
> > > From: Robin Gong <yibin.gong@nxp.com>
> > >
> > > New sdma script support i2c. So add I2C dma support.
> >
> > What is the SDMA firmware version that corresponds to this "new SDMA sc=
ript"?
>
> sdma-6q: v3.5
> sdma-7d: v4.5
>
> >
> > In which SoC has this been tested?
> >
>
> imx8mp and imx6ull.


This information should be present in the commit message.

