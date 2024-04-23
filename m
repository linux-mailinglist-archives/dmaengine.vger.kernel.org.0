Return-Path: <dmaengine+bounces-1937-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74F38AEB54
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1525B1C21BEA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996F13C3F1;
	Tue, 23 Apr 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmjb/b1f"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4B13BAE8
	for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886980; cv=none; b=EdMoCXlZNlspWInpgtTeXnV4EFN3PuLcJ9m+BQDBlgvQ2t+wQYPAtHA7GFstdJytkENT+5BU6gedTe4Yd6Gj3MLzKkl3eITG//BPQx3S2GHIioQXMFhPTGXW72nh4HcydxYvyNaJYad8eUPnpBNWPUZDOxf2xnSwzbvfPvgXYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886980; c=relaxed/simple;
	bh=am7vu4X0EijXhe/RIj+FrdLdripPgY+xTLVPCprAGFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNiG1k8Ts0aj+YgAM5LyjB+A2Aaij8iCP/u85qI5rwGyOMgYHqugB7GZElYhExH7N5het9tHqTJ/RQ3H4Ghwdz4X8RtcGzmjeBUUM/jza1Una7AD/vmsVH5KATYks8whLagyifZbvpNchArodE/obMS26jlTGB3710aL9DguyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmjb/b1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5E2C116B1
	for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713886980;
	bh=am7vu4X0EijXhe/RIj+FrdLdripPgY+xTLVPCprAGFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zmjb/b1frpP0d3J3IFJBqPkmvuQNH0kMcvnaB6qKs57KH9JXG1xJt+JKRdx7dx6sZ
	 NFK+ZO3rksD/DtPzupNpxfOxAq6mXQRmEG64X3gyDGR9lepsIEpMaxhj45y6aLV+yZ
	 PCl66xaWqQ/UsmqsqrQIXA7SyaSjAQ0cHfJOIXmGzWIb5qwGny25r+ZJBX9BP8oRMg
	 9QfMXSU5OCnCt5PQB8FLd9rpT/wy21clAgeNs2PLo+coBHkxY25x4+D+3mGSA01fle
	 TJ7Kj7IjmP7MvDtm8W03qrSXIgfDWJyn4VD7E7Po6zi5OdkTMKccpLN4bXI/6vlIi0
	 pPNDLUNkS5p6A==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2da08b06e0dso69713901fa.2
        for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 08:42:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YzUkzAO1KkphhDfjWMxuIRH1n5gZkX4ztS8gK2JmUclXibfsFTn
	uQ1ra5DX4lYTHtHzeD1lgxzvW0SCq9Yski9D+6vZNHfJILWQtVFwNLMJH6Nxgv+qQfO7geeUoSx
	6Its+mSSFbm1+h1YrHHAxtpuu0g==
X-Google-Smtp-Source: AGHT+IERDgZ5dwV2XxRtDMFHE9qHnB8bJcPwlcV3sj0/Ju7qnvGC5QKzoGh08ee6QP7E6x+JVyzPFztUvmhkKMOFOas=
X-Received: by 2002:a05:651c:200e:b0:2da:8dd:4281 with SMTP id
 s14-20020a05651c200e00b002da08dd4281mr8131800ljo.5.1713886978396; Tue, 23 Apr
 2024 08:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71169d0e-e751-4c08-b6ce-36c37f63879c@moroto.mountain>
In-Reply-To: <71169d0e-e751-4c08-b6ce-36c37f63879c@moroto.mountain>
From: Rob Herring <robh@kernel.org>
Date: Tue, 23 Apr 2024 10:42:45 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+a1fsZMSPRrqw9_4=mcn7XD8WD+ziNXV-gaAzCzLEDOw@mail.gmail.com>
Message-ID: <CAL_Jsq+a1fsZMSPRrqw9_4=mcn7XD8WD+ziNXV-gaAzCzLEDOw@mail.gmail.com>
Subject: Re: [bug report] dmaengine: qcom_hidma: simplify DT resource parsing
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 9:32=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Rob Herring,
>
> Commit 37fa4905d22a ("dmaengine: qcom_hidma: simplify DT resource
> parsing") from Jan 4, 2018 (linux-next), leads to the following
> Smatch static checker warning:
>
>         drivers/dma/qcom/hidma_mgmt.c:408 hidma_mgmt_of_populate_channels=
()
>         warn: both zero and negative are errors 'ret'
>
> drivers/dma/qcom/hidma_mgmt.c
>     348 static int __init hidma_mgmt_of_populate_channels(struct device_n=
ode *np)
>     349 {
>     350         struct platform_device *pdev_parent =3D of_find_device_by=
_node(np);
>     351         struct platform_device_info pdevinfo;
>     352         struct device_node *child;
>     353         struct resource *res;
>     354         int ret =3D 0;
>     355
>     356         /* allocate a resource array */
>     357         res =3D kcalloc(3, sizeof(*res), GFP_KERNEL);
>     358         if (!res)
>     359                 return -ENOMEM;
>     360
>     361         for_each_available_child_of_node(np, child) {
>     362                 struct platform_device *new_pdev;
>     363
>     364                 ret =3D of_address_to_resource(child, 0, &res[0])=
;
>     365                 if (!ret)
>     366                         goto out;
>
> This if statement seems reversed.  It will exit with success on the
> first iteration through the loop.

Indeed! Obviously no one is using DT with this driver as it has been
broken since 2018. It's for a server platform as well, and DT usage is
rare to begin with on them (excluding all of IBM Power of course). So
I'll send patches removing DT support in this driver and the
associated binding.

Rob

