Return-Path: <dmaengine+bounces-1241-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75441870004
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 12:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30017286F3C
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAD038395;
	Mon,  4 Mar 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCDPP+yA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2BE381A0;
	Mon,  4 Mar 2024 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550742; cv=none; b=EHRqxLyCpUShQXKwWuz36XsfERdxkR8iHauVBQh3vVVVCyE1HKD+Zo/3KEYNlr8ego+e9dJxm9JvcT8p0vithmcpoBJo+5/1LB9BCWbD6Ha+6+B3ABt/S8Kv8QrUPuFwGzDuqANg2wl7oxeeX9LasUWFVpeNvp64wnV/JNnCCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550742; c=relaxed/simple;
	bh=6ZkCzawr70iVhSytkJbWHHAWdAJp5VaXL802KLG6CSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfei8aatF2GRtoaePULSf803INjWK4v8W1jDt9y6EVmnx7fv25Spwz92TqzpN5sLfQX7kDN7WiogxviY7REzq5bGm9HZv0j6vEjyjdW8W/rIqkY6or55bzByWwcgQZ94JE9Q2clTlAXXSsFZviptoFoUowuLtR40cgSaC5HTmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCDPP+yA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dcc0d163a1so14380785ad.0;
        Mon, 04 Mar 2024 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709550740; x=1710155540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZkCzawr70iVhSytkJbWHHAWdAJp5VaXL802KLG6CSM=;
        b=iCDPP+yACbwZlzhY6yw/dr1FZXjzf6sUw08SmgzuXPGGaqO4DYGZkhyMZi1n6HMrHH
         XU4A5zbOptNRipWHEZUC+7lR25K58wJK+ArrQ+Ve5ugnoDHINNrpm6yV88DcTNlZ6KMs
         IJ07f7NQacuV6SeGZXMHdrkzmmMv+IQXj0RmcMpimyN0GEEP5t3rECodlAmsNNQa8a8Z
         rI2/Udcq+O2PWvSVl8itdVshM5kzL3aULbE3jCisN/4XrlOddXqqiveN2SCJ+UH47bT6
         miVEHgE3DfejfGPnab+w2YP1v51I6K6aSMyy0hsafwPznUR0UjSv1P3YgGh4D8nxwy0I
         ai6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550740; x=1710155540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZkCzawr70iVhSytkJbWHHAWdAJp5VaXL802KLG6CSM=;
        b=jEBkpQLFlF9z/EiuRq5t3DfrFBbGMGo62xoLmxPvF4R14AF6wWWNqQX+Eqknu9Ik+h
         /xSJSW+QGubnvFc7wUEZ8xFr4CEcj/uNst8u4xnuT5OJHGrmZHxkPtL2pKs/UrjO0L2Y
         CjcD9GVbrZBF1Y1AgbhEMz9GpNNRGfn37WQFJm8gsfsEJc/SE4WooRo2tXq/S2ZfZurN
         qDXA2kLP8f8e9b4/cyMryNSMRQtCIy4HpwE9rWRkQ6qUXT/lBCteRpDLklZL4Zbw5/oD
         o6VLOobWiNQ41CFE5Yue/gkPIi8jfitQGTiOdNaGX7aBLEYhqbq0yuoUUvNU8eP4hF1D
         gqIg==
X-Forwarded-Encrypted: i=1; AJvYcCWuYlhwnglfadbtxSRZIlOxQgwjDhuQ6hq9g3WU8PgP35d6hQbxTi7mL0lw82QQbG4O0uu78SLvISye0IIfnMY+iiEWEFon7nxhUzG15IpHf/YSnf17Z4QATOsBZSfrcJr0UNmID25a
X-Gm-Message-State: AOJu0YykHtxalqyDhei++4dMfHqL0FxQNvB0pKBLeniuigzpuQawYDkR
	lTsbWBFTkprq0Z9rnDxCdyuniFCYXxs+lacYQxucQDm0Zo5OLTu9Rj3CfLBALzizYffzbKli1GN
	xa71YuIB+hK6t+Yxh2YmmlW/kCKA=
X-Google-Smtp-Source: AGHT+IEU/vpzfP1RaAkx+T0jQDm+f6dkz0d4veGwrfAmSyfH5tKFgW+VMU5rqKHIALIH3Q5NIoakElFocN33G1QYmAc=
X-Received: by 2002:a17:90a:9e3:b0:29b:f79:2ec3 with SMTP id
 90-20020a17090a09e300b0029b0f792ec3mr7088904pjo.3.1709550740384; Mon, 04 Mar
 2024 03:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com> <20240303-sdma_upstream-v1-4-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-4-869cd0165b09@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 08:12:09 -0300
Message-ID: <CAOMZO5A60zG+1u0NYPFaLsAgCxcF1RxxybVeatovTGj07oxqBA@mail.gmail.com>
Subject: Re: [PATCH 4/4] dmaengine: imx-sdma: Add i2c dma support
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, Robin Gong <yibin.gong@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 1:33=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> From: Robin Gong <yibin.gong@nxp.com>
>
> New sdma script support i2c. So add I2C dma support.

What is the SDMA firmware version that corresponds to this "new SDMA script=
"?

In which SoC has this been tested?

