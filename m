Return-Path: <dmaengine+bounces-5931-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A8BB183C4
	for <lists+dmaengine@lfdr.de>; Fri,  1 Aug 2025 16:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983DD1C83869
	for <lists+dmaengine@lfdr.de>; Fri,  1 Aug 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D726B75F;
	Fri,  1 Aug 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB6Nx8Ni"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C2E2472B1;
	Fri,  1 Aug 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058526; cv=none; b=saeb6PHyWP0odECn0ixDdKEJYcVoVPg95SaJKL5iNu+v2uB0uRWuaRqVA2d0bzzkB+N3Z2W0xH3+v+vwWGkIKgxvZ/iY+NA+Iq9NHhwsJifWXA6obu6R6c5sxzT8Y3fhLQQ3SK8hMeaRwRJ+3cJpi2A6bm1/IF1YHqktXi0g9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058526; c=relaxed/simple;
	bh=AIluz0CWTlkf+ryYSxTPKTsH1l3zg8Y6Xjxx3xiLVjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlb4pH9nQkfvqukzFwNIra0a5CQKnfp5qvYglVDBD2oi62Lm8tyO3qQ/2dMYkpTBJsBpTd5xugKeY0q4wHL9LLkJ5q4DAObSCumiUsQDl5eKaMmOQSbCNVG8sQIBZ/JvIz+qHrW/3zw1DBZ3DKgIRHcGY5/4yA2LWsnzL+j074A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB6Nx8Ni; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4fbf846d16fso1347539137.1;
        Fri, 01 Aug 2025 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754058523; x=1754663323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enklQFOwEVlBN/RmOFCGBCNOiLV3Zi/krrC4kYv0Lv4=;
        b=FB6Nx8NinIYMQSNoIkY1dbqB+rHRi/Ne5Pl7k/+hszP427bOdsN4QtxqYhcVbKA/lF
         UplR3QkJxcIX+f7a8D+27ten2hKCnXyJVNJ/7up0W5/ZNn46bQukXsjHrfbKGaeGQ4g2
         37MZRgVk9hcIbo1PvvC+WbqYNuZssQ45Gs0MxO16+4KSegs/doHkXS5K/8ZTI9x+hlR+
         qPdecxkZb9MYoUEtngXbGgM+CihJe3djtM4Gno7CxivimtYpAQ3ZxwV2iS+PCitKPTti
         oaVO2RTcN/ApsXveDUxnFjx0Gh/NKH9UZSUDn9NSb6nPSY4/I3FIGv0NZyHczw8h+wbi
         qTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754058523; x=1754663323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enklQFOwEVlBN/RmOFCGBCNOiLV3Zi/krrC4kYv0Lv4=;
        b=i4vMuE8qVmyXG6Nt7FQEUnWzeGZw3GqiU+IuUyLTVy6+bg7rsrExN8YH6j4SrcPLLh
         CkF9Z0nFhlBj6M4LWOz+p5yfVJsdWFD9reWItgLQhuCVc5P173s1DyxuCXnVGi8UvenC
         3B6/il+udkTUMCXvS4LFq5g7t2lAsg4GOvjlL/0P7140RPvDke2lxxVH7uOQG1Kri7za
         QW6pMnmp3DDeKW1wdpCINs3Oukho4A//fP/RQBjJ0djpmt9ZVCei1wD2JASHTjPKqvLV
         yyxF4V1WmgnfGTAXKxUkkmgt46p6JJLxTisCI9dfu+ZZ2Huum5+6uQ18uODmfShDCH7Y
         Q9aA==
X-Forwarded-Encrypted: i=1; AJvYcCUA00Xsj4iaFhSqWCIk0ljloACFQVWOFQurd+gr+HJB7WI7dIk5Lqomrl9cZbVsURtqPhozGI+skWO7@vger.kernel.org, AJvYcCUBr6ahO+Mahi2EEvGhdIr+SjH4NUk09CqLuC2qfThl4sERa1dg8TUsASnzm3URB0A6ATDI9GoUpe9u@vger.kernel.org, AJvYcCVHkaouqAyTk3PSpb+gdbhOT6WMaWo3Vyexkz4IwWvfQucXbEeps6cz1P/UmChN9mgohkmUez2f5BjGPStz@vger.kernel.org, AJvYcCXh3ltipxzdLkDE7f2RQRGoYYPN3L825q2pPH/uhFtFzm1zuBH1+olhQpXOa5SBGAuhMknAtRKT+OWMoUz/Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5c9xKOE9HKEBmXx7SmipvDBoI/75eOfjeAuRje3buMqBGZUD
	b+QU1dOcqJ4DTiuQPFfSht1ahpywSa8fj6DeuLYZyWDQM3/YK9MDbR+KzyFJzSB+bLP+ZHcLd5S
	Lu3+QspaUZIAR5Lsjs5pVcxtt1ovG+AQ=
X-Gm-Gg: ASbGnctJNUREPrYykz+1UZbZcserLnCz46i4m+8NloU69Oe6YWkf0bnqNQFbKfBK4gc
	FCgl/CVoEALyOkYk/TGV2Qzh2HGXJpL/VZoivCp+H9Vu1GQTH2RrI3tHQFh3eOpp2GiD8Umv/lw
	LbV+A+XCNjhzKlXyvOMbOIicsIsKkDGE0sxyFOfhdiIEwIBR71rRBKwxKQQdukkh/yXrYa7DxvY
	TxP5MkwDybu4nqTiPiLUgOS8Q==
X-Google-Smtp-Source: AGHT+IFE74O+sbnSVic7t4Vc8ApRGNLfpxfLAcrdxoJjnrrGm5LNrQWaWD7dOtDZh3n/VkhweJi4vQ+qTHbbNZBzVmc=
X-Received: by 2002:a05:6102:6102:10b0:4fb:f495:43ec with SMTP id
 ada2fe7eead31-4fc1014a568mr2223339137.12.1754058523415; Fri, 01 Aug 2025
 07:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617090032.1487382-1-mitltlatltl@gmail.com>
 <20250617090032.1487382-3-mitltlatltl@gmail.com> <36f3ef2d-fd46-492a-87e6-3eb70467859d@oss.qualcomm.com>
In-Reply-To: <36f3ef2d-fd46-492a-87e6-3eb70467859d@oss.qualcomm.com>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 1 Aug 2025 22:27:55 +0800
X-Gm-Features: Ac12FXyEiR7WBLYRTG7PF-J5G5Sq4Cm7xfdTtw6UG5leGd5p1jqsinBxIETuVjs
Message-ID: <CAH2e8h50mtsEpAZoUvYtD-HRMeuDQ4pcjq6P=0vsjvtZoajC-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc8280xp: Describe GPI DMA
 controller nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:33=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/17/25 11:00 AM, Pengyu Luo wrote:
> > SPI on SC8280XP requires DMA (GSI) mode to function properly. Without
> > it, SPI controllers fall back to FIFO mode, which causes:
> >
> > [    0.901296] geni_spi 898000.spi: error -ENODEV: Failed to get tx DMA=
 ch
> > [    0.901305] geni_spi 898000.spi: FIFO mode disabled, but couldn't ge=
t DMA, fall back to FIFO mode
> > ...
> > [   45.605974] goodix-spi-hid spi0.0: SPI transfer timed out
> > [   45.605988] geni_spi 898000.spi: Can't set CS when prev xfer running
> > [   46.621555] spi_master spi0: failed to transfer one message from que=
ue
> > [   46.621568] spi_master spi0: noqueue transfer failed
> > [   46.621577] goodix-spi-hid spi0.0: spi transfer error: -110
> > [   46.621585] goodix-spi-hid spi0.0: probe with driver goodix-spi-hid =
failed with error -110
> >
> > Therefore, describe GPI DMA controller nodes for qup{0,1,2}, and
> > describe DMA channels for SPI and I2C, UART is excluded for now, as
> > it does not yet support this mode.
> >
> > Note that, since there is no public schematic, this is derived from
> > Windows drivers. The drivers do not expose any DMA channel mask
> > information, so all available channels are enabled.
> >
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > ---
>
> [...]
>
> > +             gpi_dma0: dma-controller@900000  {
>
> Double space before '{'
>

Ack

> > +                     compatible =3D "qcom,sc8280xp-gpi-dma", "qcom,sm6=
350-gpi-dma";
> > +                     reg =3D <0 0x00900000 0 0x60000>;
> > +
> > +                     interrupts =3D <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
>
> The last entry is incorrect and superfluous, please remove
>

Sure, I can remove it. But the last entry is here in qcgpi8280.inf

[Hardware_Registry_Base_8280]
HKR,QUP\0,"NumGpii",%REG_DWORD%, 13
HKR,Interrupt\0,"0",%REG_DWORD%, 276
HKR,Interrupt\0,"1",%REG_DWORD%, 277
HKR,Interrupt\0,"2",%REG_DWORD%, 278
HKR,Interrupt\0,"3",%REG_DWORD%, 279
HKR,Interrupt\0,"4",%REG_DWORD%, 280
HKR,Interrupt\0,"5",%REG_DWORD%, 281
HKR,Interrupt\0,"6",%REG_DWORD%, 282
HKR,Interrupt\0,"7",%REG_DWORD%, 283
HKR,Interrupt\0,"8",%REG_DWORD%, 284
HKR,Interrupt\0,"9",%REG_DWORD%, 285
HKR,Interrupt\0,"10",%REG_DWORD%, 286
HKR,Interrupt\0,"11",%REG_DWORD%, 287
HKR,Interrupt\0,"12",%REG_DWORD%, 288

> You can also enable the gpi_dma nodes by default
>

Got it.

Best wishes,
Pengyu

