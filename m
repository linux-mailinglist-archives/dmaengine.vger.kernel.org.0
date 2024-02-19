Return-Path: <dmaengine+bounces-1039-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D255885A8CF
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 17:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885181F2120E
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863D93C082;
	Mon, 19 Feb 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K52xXHkm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C037704;
	Mon, 19 Feb 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359816; cv=none; b=hao0ooE0oc4+vxwPWq0IO7VlcfjUG3TI1rHS0RrcuhOUTdUoEnbhGYJJfpGI5ln64ixFwduQ62HUAW48Usc867R1NDDVverUcQT2UwzcpzmE5jz2IeMy4xQjHNXZGIxzn37VY8xTqv0p8wxTkNze0xayqlNec9diq4TWkmycNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359816; c=relaxed/simple;
	bh=+D5YYAsErOqCse+fPjYBEdC9kFrJx3mF+Nk1IPOoTbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsHGOS8Nl6OQ3brAG3rhRe9yKGKauDLIPJUvDWoTRGW7lleVKjzLXMoJ9eWyl83WwQXlDSNyBoCw69E8HPmeibpHT1OYHyi7hEDh91Zl/7Ju73Nd7sdE9Kjci35en+5l73jXVNpn3DXEfe0K1zJLSEsXseiMS4cZnd108mNRnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K52xXHkm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29936dd174cso389583a91.1;
        Mon, 19 Feb 2024 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708359814; x=1708964614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D5YYAsErOqCse+fPjYBEdC9kFrJx3mF+Nk1IPOoTbw=;
        b=K52xXHkmxfIU9BeXGcAQJ4wMGrJD4o2TELKl3Uk0xTdIHTADnDJbRjWm3F8ifQk3lf
         z19s7ZV8Vg36M4C+NQ31hRIkpiWd2j62i37aG3IDtmuTDykBYDyhLjHagmunSTHjt1x6
         D3AMyDLW/kSaouwMWEXPs2AAeDGgMCFjW3ZPXRA+o1hnFPau4FUDUCAEXFWNbDMkC8F2
         cPvZnjyd67eY9SVZegVZm7dwr1t7VfbOEllMo/6VHIGNuGyOHSVXWuYZQfnfs20y4dc6
         zMHbOhHxP50BWDZn+9Zra4ztNDS7nYnOTVa2PkghUwb5G+80xNIheioCruZo32636UTk
         yfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359814; x=1708964614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D5YYAsErOqCse+fPjYBEdC9kFrJx3mF+Nk1IPOoTbw=;
        b=DQIhEUdQuumVLdDzouQrbugZ9k3cUimwwTY5jplqIBDSM5PWCiP3LDF7useksU/4Z9
         a1TcZN9Wz7PTtLlwC5WbTj1guKYFi4+ET+APUv6WgSYM77G9EW3gyTya3GJ710rIIji9
         C5YCHy6R3pWY2uzuJimt9NFwEgKtTCVA+li5MR0kGQoXhWHpOAZcbeiDTitUkYR+cF8t
         IZ3VIEZdF3+51Jz0+cxmb09qhhq+bepH0/0hLCaPs7VYq0OmvMTRpfKjIle/NtlGGpkM
         dm7rMufxVK9lWbQkxR8sZ5teLvYvIY90eULiPQCtz/JvcRcoErl0fEvitD7yaJvq2wT5
         Bb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiwnnMIlcG+MDN7HH8AAFAgIlYL2Hfk0ZkTzLQ2No4+qVLAxVVcDrM2ZrD/5H6pRtdKEgyjHqY0CXkrEAEIElnQFpJNvIBGus5aGvI8tGbW9O0QfSBXxxrgqgm07MrrBceTLEzAkxR
X-Gm-Message-State: AOJu0Yz7/pUu8tCmaGQGseuR7ur4n4ER/6kvY+gAAInLRFNCkqJozS0/
	w03pEAMMVH4+D1nlFpJmXRYYOdTuAARQOlL3uFv/qnnRULeZPfQYukEJYbeWaNTE8gG4qpOwaDE
	gE31JaPtrK3MVICSc4nrtUedRLX8=
X-Google-Smtp-Source: AGHT+IGC4MiCOuJgMCaNYzE2gAv19LVxth2Ob5XBRgVfMJUNVLjwMVsCRccoio7XPQSJVvrQtek/awV3z4kI4V50KP8=
X-Received: by 2002:a17:90a:38e3:b0:299:3748:4ada with SMTP id
 x90-20020a17090a38e300b0029937484adamr6973062pjb.1.1708359813553; Mon, 19 Feb
 2024 08:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219155728.606497-1-Frank.Li@nxp.com>
In-Reply-To: <20240219155728.606497-1-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 13:23:22 -0300
Message-ID: <CAOMZO5C4XFGoWYgexdFLgHiXAoAP7-aMdi=K6CG3adQE_mHAmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dmaengine: mxs-dma: switch from dma_coherent to dma_pool
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, 
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:57=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> From: Han Xu <han.xu@nxp.com>
>
> Using dma_pool to manage dma descriptor memory.

Please clearly describe the motivation for doing this.

