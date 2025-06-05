Return-Path: <dmaengine+bounces-5312-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5119ACF030
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861C03AE99B
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30C232785;
	Thu,  5 Jun 2025 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzqdjX1I"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6ED22DFA8;
	Thu,  5 Jun 2025 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129458; cv=none; b=eDlRTsUR/9jnzBujmgwFDU1Fv05QGhPUdIipS2W0JYtrvK2Aci07ylTyR6SAUrgUYRWMekAu8XpKwxeGdr3i6dYBLFEV2HseTRNFpHCL2PFXcxP2XHgWkiRBbILeETXAcE3Xv8sMNsUSIEUeBp8yXs+utkndMhjaOA9B3uNrfiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129458; c=relaxed/simple;
	bh=apxomogXK08HkqYkk8H5PnppUd06Nc1v47xX64SUkBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0VRb6hzAiTVC/9mogGSY4J2Xz1H4ZuBnj695ddiVJM35Wb7Jm28zhUNVRuIOJyAJXY7RALZw41cgze/Gl88qQstR2BhCOaEo+0YuvYN0Xn0yaPKsmq4kP2CZlfmqDgUViAOnxwoWrN7KKahTg7iZzH0YJtoMMahxi7wPC534P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzqdjX1I; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2351227b098so7411345ad.2;
        Thu, 05 Jun 2025 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749129456; x=1749734256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6dsfrsxfGyGAxnc1I7hE0hyYua0e5sCGjw2CSpD+/c=;
        b=VzqdjX1I/RSFn5wDhzKhyguznXXJKVuAMuzrUXzcfZytamEfYl4ZcIiplwmLbG7gR7
         TEQoIq6iHcCqt78csX1bIzuivJrhZbYPredYmhEDE6QyFABk29+I/uQutorI8HomI6vs
         X4jxF8mGB3ijaBKcDD3dFX91trD/dDvP/m/LBpzdOHxPGxIu1mo8WP0PgZTnLEgtzFub
         p/v55QW90h4E/F8lCyHyfjNDYBb/sIfzUz4foIttJPqLx38gBahaHIX861mFWqGelQmp
         JhQNgQJnF5p6ivR+CcFe2dbr3qbfy7vc78n6EpvDiZZuk2kKJOrFkdnyqqFqQBLpz8c8
         P/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749129456; x=1749734256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6dsfrsxfGyGAxnc1I7hE0hyYua0e5sCGjw2CSpD+/c=;
        b=Ic5m1axFbrN5roA1hAoj0yFpdLVCtuKW/CAXz21zMBVeEXEv4AnH7qMhCzfQ5UnExO
         OsdKs+PjvG4V1sf91PAM+LSM2T02o+EBBVPmNIaIpBNFAB9AmHym4cH8ozvwdOQlK/3o
         xhdBuufUqhgDqF2P74gWE+CVf9PzLrG1nZzEED729w6mauekuHhNOz6wzganiiYndjJI
         WIYYKUVJ5100HQnravv3cmGIBZaZY1d8QzKpVnVtkeECB2Av538fOee4Txie0wCrGZ/d
         0L++0mMsIkfxrfNjNI9hl3P+P+S8msTa2Y1oJ5SUsiG5+LctCzX9WsKc1Wml0KbTKb3q
         PVQg==
X-Forwarded-Encrypted: i=1; AJvYcCWxbNlD2+qzbTRK5S22MRjpo8A83EZldEn5jyQbLjKP98WXeVjyEQEHlrQO3BZlYdaL+lRO40M2ABwjrcVlvA==@vger.kernel.org, AJvYcCWzEy6jEwrrOHejkLKaV8ew6ZjuGwxpb0s3hVjT4PJwOOo0o7BF5YQGEQvpCileF0RU4s1TE91fsGpB@vger.kernel.org, AJvYcCXBv84+TEmMpkK4gQzYwGD2XTv0WWRj3TCQyDavnUhDyeRkzYBHgilSXGrbmQRs+3luER9sItjtSZiU3lk4@vger.kernel.org, AJvYcCXVtJU0yCwaBH/VAn5alkZ1ivfnJRRDZ6VDaMmazDY60sf72q+7UoQLKc4tjBUsebX+pNxvExeMrdCN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eYP9JGCIS1+ezjJevNY3cpuzgk0RBTR2+sDm0EwMRZLDYHZo
	31PBw6kl7uVRpmjEJoYfQOZwBDn3GNi2h5vlIkSVag0Z/x94wL7JE1MzKaMiVk6h
X-Gm-Gg: ASbGncscHP1DRTBBJiSNhSTuc9uLSoIlxTWuvEXLqEpBslu6ZZmfaPHf87gN037OEBR
	LeJOUrKMMyXLEb34RhJ8LrHPehE+MhBfPqpDWvp0wjPHsr/AdE51ejFbc8XejMwLMZ91fdGnGI/
	hQX6+OOvLbfPuBRoqIh5kc6zzjfZC235sNR5k8QDx9FD4KXna2AXlt8A1e2dYyp7yVx5zYFIuCo
	S1R7DugauwfQEDKDVFGrMM3BoBacH1WM2TSAbZRwTFkn7oc9y5zM5Myc7kqM+Aehoj8EKA7pVF/
	uzjlaAStKzPEz1S/dS/0rxo/i2MM/OCwzvzmqysZLnBGJSsUfA==
X-Google-Smtp-Source: AGHT+IFmF2Yx1J8tgFedpLQgoWF5hr6djBCGM6Z+OnN250Ss98AgpB8XDpjnTUZTh+alh99cRxR8Ow==
X-Received: by 2002:a17:902:f609:b0:234:a139:1215 with SMTP id d9443c01a7336-235e11e64fbmr114982545ad.35.1749129456367;
        Thu, 05 Jun 2025 06:17:36 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdce12sm119666605ad.99.2025.06.05.06.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:17:35 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: eugen.hristev@linaro.org
Cc: andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dmitry.baryshkov@foundries.io,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mitltlatltl@gmail.com,
	robh@kernel.org,
	vkoul@kernel.org
Subject: Re: [PATCH RESEND 2/3] arm64: dts: qcom: sc8280xp: Add GPI DMA configuration
Date: Thu,  5 Jun 2025 21:17:18 +0800
Message-ID: <20250605131719.472132-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <550a7ead-99a8-44ac-af49-c0e9d79c35c9@linaro.org>
References: <550a7ead-99a8-44ac-af49-c0e9d79c35c9@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jun 5, 2025 at 8:48 PM Eugen Hristev <eugen.hristev@linaro.org> wrote:
> On 6/5/25 10:54, Pengyu Luo wrote:
> > SPI on SC8280XP requires DMA (GSI) mode to function properly. Without it,
> > SPI controllers fall back to FIFO mode, which causes:
> >
> > [    0.901296] geni_spi 898000.spi: error -ENODEV: Failed to get tx DMA ch
> > [    0.901305] geni_spi 898000.spi: FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode
> > ...
> > [   45.605974] goodix-spi-hid spi0.0: SPI transfer timed out
> > [   45.605988] geni_spi 898000.spi: Can't set CS when prev xfer running
> > [   46.621555] spi_master spi0: failed to transfer one message from queue
> > [   46.621568] spi_master spi0: noqueue transfer failed
> > [   46.621577] goodix-spi-hid spi0.0: spi transfer error: -110
> > [   46.621585] goodix-spi-hid spi0.0: probe with driver goodix-spi-hid failed with error -110
> >
> > Therefore, add GPI DMA controller nodes for qup{0,1,2}, and add DMA
> > channels for SPI and I2C, UART is excluded for now, as it does not
> > yet support this mode.
> >
> > Note that, since there is no public schematic, this configuration
>
> Device tree should describe the hardware, not hold a configuration. If
> you are configuring hardware, DT is not the place for this. Same goes
> for the commit short message.
>

Since I am just an amateur, so I followed some applied examples, like [1]
If you mind this, I will describe in next version.

[1]: https://lore.kernel.org/linux-arm-msm/20241021102815.12079-1-quic_vdadhani@quicinc.com

Best wishes,
Pengyu

