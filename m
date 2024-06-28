Return-Path: <dmaengine+bounces-2591-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE391BE30
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 14:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E0328278C
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E41581F3;
	Fri, 28 Jun 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4+L47Br"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88A1E492;
	Fri, 28 Jun 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576497; cv=none; b=Y/PESww6HT3+IYSkw5P643MePBs08tXw6evoC9rIM4e2DFdKxim05YEuRh2y484xlTyxX2++OyXpK9vcDlymFVXQfUIgIpIpeBMu/R6/kekXYVFjhrnKXsOQlJwRHRAO6VHPYrOPOgO1QuwyGLrRjH0lMFnJZTytewbMT0CsAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576497; c=relaxed/simple;
	bh=Rlq0WqzihhkeL6wZg4CBjygd+CaipHSo+ZHvvPst5+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3Q+oIfaoAzSRWtDRls9BkYWit0fLRBN8kqxJcftew7EGOEs9fFABOeGSM5SSeMMPoDNxqve8TW44adel15ce7Fzcv9zscZ7nDMhPav1TenpWdTmp0uTE5p+qDA7TimUmn7hogIafvqrHhVsfcBQT0kWr5Me8iSFsccqScLoU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4+L47Br; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso700041a12.0;
        Fri, 28 Jun 2024 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719576494; x=1720181294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/QwPiwzSZOk4Q6RbA8p937/Li3WK6XZCuDkf/fR6vE=;
        b=c4+L47BrHNlQV0RP8wPu6SjtrrJLr6IixOX97xCYvMASpze6paZM3dxgIYiO3Esf6m
         mx9y7ELypwdqV2OBnRnP2iDLnppWZZP5mlQIJkesy9Zf4WnOPLsawawNhA/P6bthSM62
         wyPg1sztcNRPMR9WKrROouarhfu6VeFosJIc6h9geZb4lUmoLjA6evQw5xMKUfYo6mCG
         HJxn2ORc98XJYREHfjfbOzYdN0XPMtM76v3G8AfbK2SR2ShESqO7v2GDRoeMOghDa7qL
         DJsIfIMuOoJU5lhmW+j9E63iM7WDyPCtWDeFJ/tMyD3PtJ84q42vj34hZc71BnME+Oll
         Y9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719576494; x=1720181294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/QwPiwzSZOk4Q6RbA8p937/Li3WK6XZCuDkf/fR6vE=;
        b=T8NPi3EtBniz9hMALQdUOv2uaxE7jmssTM8pxSIYRM/LwVZUD+fJ7HEosdfdAX2bj0
         W4uldbedC79BOPBZaWoawr1iQUfHCODSAysEbzGdi2arzcXfnv7T9xV0kxdFb7tQxcAt
         a6eqYfmrKUluqQI3d+2vugnDknkHGPrdzJb1wEuY7bT47RgOG8xw3VOtjw2g+F0kv2jx
         vV7RiRz47ZNjJ3ZMvVxRhuw+yfxGreogqN6RpvE/M5BfBRcoU7C3jC++6Fvs3hZrYtdb
         4m9bvpwKUM4RasiH3MagWMEcc5xEl3wFpdPzlJaIh9ZzI6Q0GKkAvJ+v/vKxGwr6qp3q
         X83w==
X-Forwarded-Encrypted: i=1; AJvYcCXzVlUmd36/7EhFx7FQ2nAJ/B/Ri7xDZQ9NDpd37B/12ktqenSEEI4jhL8Q8A+70YBIqFejJegCYC/zMCwZbj9KSSUnSa2CI82bZg9VpNO/5qIsaXmTi0yRWXETRlcLfCy572R6NA8JOV/vLotmxrjBf9sbQ1K186Em+uk/jzzmTRezOuEyEXnlTVCnSMb/5dLAGxc57RIlIZppmTTQ/uY=
X-Gm-Message-State: AOJu0Yyl8xPyqMqlV/ZSsW1a/+f5FV2Opsu2K2VAxWh3yO7xn5fIpp9H
	a7p8/GwN/S2ELX8FSc0aOVQ3G7o6pDHIokXWYg57zLsWkn3DDtNxglXZ9suj6cna1TAvdJzInAk
	1V+/HkNQL5Wa+z33O5l6i7Psqclw=
X-Google-Smtp-Source: AGHT+IEeOmHcYeyBM9vdMvSUCMXEjfEksvTMrtTl63tXcl5SMpXT8DoHqdqha8zQeeVtKUpRgDLSBKLuB/8RprKcdsM=
X-Received: by 2002:a50:d503:0:b0:57d:4d7:4c06 with SMTP id
 4fb4d7f45d1cf-57d4a2815b1mr13818662a12.13.1719576494290; Fri, 28 Jun 2024
 05:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-loongson1-dma-v9-0-6181f2c7dece@gmail.com>
In-Reply-To: <20240613-loongson1-dma-v9-0-6181f2c7dece@gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Fri, 28 Jun 2024 20:07:38 +0800
Message-ID: <CAJhJPsWMs0=k+7051mxG+DiOG8oNrPoG_3RUoC-ni7t2_3dyDg@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Add support for Loongson1 APB DMA
To: keguang.zhang@gmail.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vinod,
Sorry to bother you.
For this patchset, is there anything that needs improvement?
Thank very much!


On Thu, Jun 13, 2024 at 7:50=E2=80=AFPM Keguang Zhang via B4 Relay
<devnull+keguang.zhang.gmail.com@kernel.org> wrote:
>
> Add the driver and dt-binding document for Loongson1 APB DMA.
>
> ---
> Changes in v9:
> - Fix all the errors and warnings when building with W=3D1 and C=3D1
> - Link to v8: https://lore.kernel.org/r/20240607-loongson1-dma-v8-0-f9992=
d257250@gmail.com
>
> Changes in v8:
> - Change 'interrupts' property to an items list
> - Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7-0-37db5=
8608de5@gmail.com
>
> Changes in v7:
> - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai Che=
n)
> - Update the title and description part accordingly
> - Rename the file to loongson,ls1b-apbdma.yaml
> - Add a compatible string for LS1A
> - Delete minItems of 'interrupts'
> - Change patterns of 'interrupt-names' to const
> - Rename the file to loongson1-apb-dma.c to keep the consistency
> - Update Kconfig and Makefile accordingly
> - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-0-90de2=
c3cc928@gmail.com
>
> Changes in v6:
> - Change the compatible to the fallback
> - Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> - as well as .device_pause and .device_resume.
> - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> - into one page to save memory
> - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> - Drop dma_slave_config structure
> - Use .remove_new instead of .remove
> - Use KBUILD_MODNAME for the driver name
> - Improve the debug information
> - Some minor fixes
>
> Changes in v5:
> - Add the dt-binding document
> - Add DT support
> - Use DT information instead of platform data
> - Use chan_id of struct dma_chan instead of own id
> - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> - Update the author information to my official name
>
> Changes in v4:
> - Use dma_slave_map to find the proper channel.
> - Explicitly call devm_request_irq() and tasklet_kill().
> - Fix namespace issue.
> - Some minor fixes and cleanups.
>
> Changes in v3:
> - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
>
> Changes in v2:
> - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> - and rearrange it in alphabetical order in Kconfig and Makefile.
> - Fix comment style.
>
> ---
> Keguang Zhang (2):
>       dt-bindings: dma: Add Loongson-1 APB DMA
>       dmaengine: Loongson1: Add Loongson-1 APB DMA driver
>
>  .../bindings/dma/loongson,ls1b-apbdma.yaml         |  67 +++
>  drivers/dma/Kconfig                                |   9 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/loongson1-apb-dma.c                    | 665 +++++++++++++++=
++++++
>  4 files changed, 742 insertions(+)
> ---
> base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> change-id: 20231120-loongson1-dma-163afe5708b9
>
> Best regards,
> --
> Keguang Zhang <keguang.zhang@gmail.com>
>
>


--
Best regards,

Keguang Zhang

