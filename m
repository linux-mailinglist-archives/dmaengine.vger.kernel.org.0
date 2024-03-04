Return-Path: <dmaengine+bounces-1242-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0F870087
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654E01F26663
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBB39FF5;
	Mon,  4 Mar 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHO2BRlY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76228374C1;
	Mon,  4 Mar 2024 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552481; cv=none; b=JdqHU9oY4MzNdgCArDPH8qtD4/AxJfJ75F4AG/v4+Dr5KozGuoMMxC/NzH6N1Ne4t/TwFfhsrth6uUXzudXMBWrRqzC16skpNpYWiyXhQm2LK6nqqlARp8B+uImR0mXUi4PSb+K3p4HuM4Pk7W95HhXhMy/BJzc6TC1jRLYjG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552481; c=relaxed/simple;
	bh=cYUSVmUyifdM6nM2L9Q0Fp5Qhn4DCDVKnUNjXiArGkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF5o85AKv7cE0i2GWbym2GaxOXeizz24jVTup1XFH2ilr7DiPRG1ej9gJ1U4c5ATfQO0bBU7Has9XWkCMiX2lUKC0KKKz5HW5MHYYbtdtrsF4RIfBwl5J7PmUlRQEUAfjs40BiMb6F8wq54EXrLBpnn6a4C8GkoAAhApzYpC36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHO2BRlY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a45670f9508so69348566b.0;
        Mon, 04 Mar 2024 03:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552478; x=1710157278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYUSVmUyifdM6nM2L9Q0Fp5Qhn4DCDVKnUNjXiArGkU=;
        b=gHO2BRlYpgYFZTp1l2TgnsZLxhtmycGRtAs5avk0gntchwNxdGb73vF5LjcN7EpyWj
         Nl13HxgpCFR71Yctg1MgbnYM69CarK6mgDduxXUA3bSBWbz5tQQr5uNz8i6Y9XfweP5G
         x7HHV+7T8hmkVBMYtEQh9c3Uxu46n4/ldcyxsFqWU1dT1uf/tmpaPLfpaf4l9UolTjY5
         NfJoBOQN0pH1DRlQEwnFOiURRXC/4RoFs2kYnBpQab0HBsRPDQDdm12acLs9qILoKBJ3
         eeMK4b/V4h13Wy42kzXlT03EDiwB7U7yYZAzeJ7rud6d3fZKzs7jATwfA5pYWi0Pxky/
         4f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552478; x=1710157278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYUSVmUyifdM6nM2L9Q0Fp5Qhn4DCDVKnUNjXiArGkU=;
        b=wLpUFkb5MuSM8QCMk4dP+KSJjUvnkhsSEPgSMc+pEp5/mkNSFr3iVIcFaJ5AiBsjiG
         KfCHL87+aRIUoEddwUFBxAylphXjJBf3gijYEswF2DtFnnVulf9aRNBuTui52poKs3VF
         3h8C/RTjS5YmrWq4EGjd/j/l1odVcUvdH3Fy1V6XVRrzsW1lsw7fb3IdcGNCiEc0e9fW
         0+2krcz1xzbNawpewNWL8wW+L/Ml2o1Opu/O6yN2vcPBnybAgr3xjqrvOyTl+f6iagTn
         HDjdwvgWrrZFXnzWALeilzc4YHDBvcPJhNfjKR47eaLRivLkBwOAKK8jgQZnNSGoRy6U
         LetA==
X-Forwarded-Encrypted: i=1; AJvYcCWWPaiSIaT8a/z2TXXLkEwcpJxtWvU90+/aSNjjDgrPygmQypL2vb4DkbxV3xDUg0mB3PGYYkyJvOdO6ylY07D/ZOsVJ3Ikg4Py1d5px8J3QhSU/28RpkRpG/tomgqpBRu+fuxJuNes
X-Gm-Message-State: AOJu0Yz8u0I2ljQYWLqi9QeKnWX8k9f6TxTqBBSEFXK9RkAZt2I44lc5
	WH6Bt3QCMoydFbxGqReXMmTjxHdhRpRf5x8qYF5yUbOAQrhxXlYzAXFDbtOrJ7+dt34zhACNr+z
	KhFe4WH0KoZk6kRdp4y6ClGNz2LE=
X-Google-Smtp-Source: AGHT+IFmtUOyrS0e7mKw+lMMoMxfQ/YtHECP4CbZJ2nw54XaxiiPhL5Y89uhub/Ny/OhES4OZfvtxUI+UzxFM+Y17uQ=
X-Received: by 2002:a17:906:f81b:b0:a3e:d7fe:4c4d with SMTP id
 kh27-20020a170906f81b00b00a3ed7fe4c4dmr6225743ejb.57.1709552477581; Mon, 04
 Mar 2024 03:41:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 4 Mar 2024 13:41:05 +0200
Message-ID: <CAEnQRZCtxbHB--ZwkCtfF2RG+7GYkSjH6r6KY1wrp=H3Y2-_8w@mail.gmail.com>
Subject: Re: [PATCH 0/4] dmaengine: fsl-sdma: Some improvement for fsl-sdma
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, Nicolin Chen <b42378@freescale.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
	Vipul Kumar <vipul_kumar@mentor.com>, 
	Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, Robin Gong <yibin.gong@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 6:33=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> To: Vinod Koul <vkoul@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: imx@lists.linux.dev
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good to me. For all patches in the series.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

