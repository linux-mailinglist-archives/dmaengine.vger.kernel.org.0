Return-Path: <dmaengine+bounces-811-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743A8396EA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 18:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAD11F2A51E
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48C811ED;
	Tue, 23 Jan 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrGKp2xg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFDD82D76;
	Tue, 23 Jan 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032241; cv=none; b=IVcAi8tTSAgDpgrgKlX2VdNFk34SXZYDz3uQOOyJS8DlZQUeffAF81segvx6uetNS3BgI9Ga5euexJ9YoJ46aLh4dN0xl5vF43luB8Q4U85cA8XgsKFiGfdN8wCwNRmfxcQfM+ZodQLe9J7+5V1VVqQiMrFRRDef3SaI7LCz7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032241; c=relaxed/simple;
	bh=vzbXOTr/hTcJB7Frwi93a5o2NZNJmUHLOIwRXVfnn7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ES6epY0//b05oHqz1dczkzhL4pY6KefXU3ABSMeO423weD/u1Ulz6/BD4i2d4sYsRMx2ODpsKwNTaXzY26SiqKsVuYp1DdA1v7qAGA8yGOm0dMj6O1Mzc5RCmaRMuJKYuK0CQxvHUAsBqoJVSegeDeK8zDuv3DMOHlZ8EnxJsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrGKp2xg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ec2594544so5629815e9.0;
        Tue, 23 Jan 2024 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032236; x=1706637036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqFQzFOYw01MT9nZZuoCXkcKWOvLnR25DA95X7Fl8/A=;
        b=hrGKp2xglSkq/XZFR2Xrlm6GbohbN6DopTvaiMZ0nSA1po9uishXaP6hmHz/d8JqCb
         Uh/cj3Fm+NtRolTSfLtwOLQ8ECwdssB9IMYtQixtx3yup5oSV8pch6ybo10d0Eg3e5Dt
         SImAjg/AwWnl/QSw6xbKaplwRIQx22gA36JevlkR0zBgh4YX7jRG3ylsM+8EZbu8Cu9y
         Ul2VBQa9R/iVLNmVlnViy0XK+ZJjMWIXDw2XO8mZaHpwnOrEae2tf+sgeMSudonRtqQ9
         K5Evw9R8LZknay/qDWmgHerrp/cKRmJkhe+/CTBsGiauYDOjfMTrHWXyYyotBXa2G43L
         2K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032236; x=1706637036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqFQzFOYw01MT9nZZuoCXkcKWOvLnR25DA95X7Fl8/A=;
        b=AMrkrD4duqL/W3tC7MWX43PT0wZ7OOUboxiIi+ws0X+jmQRKYtTq21ZuOzfr+a05Wt
         Gj9lMEYZnCYdFCJBu/PJHdG9lN+oOxThjcGDTWNqFyPNtKhe4OcfbCyhst/fSags6Ma2
         sDwQ0OVyT0Neqh+uqz9eQtgMa8FFwyXMuJwxx7z5NHTPVb3gz+yxkmKrEdbdu+gIYApG
         dkBI1O0gHhV5lklyMtRnPnJOepIs0sUB2qgCe6sstpxlyEuMvpzhCIWtBVTSNr08KYe9
         hEk34LHiJjj2t1shts8+aG6VHD3bug4pglqnFGPInnB8M+fH2jSDLAVLGxFg/VMWA7JP
         WA4w==
X-Gm-Message-State: AOJu0YwhsDMOABLcS2ggsIToN16ppGDRcanBmHrTEG6xnIp7UKdakfut
	+cVFRUyNYEIiF0CqyJQTUo/NeCnoZftH/ZpjI58BNPfxY+vDONx/
X-Google-Smtp-Source: AGHT+IEiz/ta2vrJl+XqiiC5CDVjxC8xoQM9kiT7Qfv/7eJ5lhHTm/bQV0Jzntqijrg4bnkk5MhVFg==
X-Received: by 2002:a05:600c:6a0b:b0:40e:3b1c:d3a2 with SMTP id jj11-20020a05600c6a0b00b0040e3b1cd3a2mr363930wmb.126.1706032236539;
        Tue, 23 Jan 2024 09:50:36 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c474400b0040d5ae2906esm47418456wmo.30.2024.01.23.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:50:36 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 3/7] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Tue, 23 Jan 2024 18:50:34 +0100
Message-ID: <2254185.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20240122170518.3090814-4-wens@kernel.org>
References:
 <20240122170518.3090814-1-wens@kernel.org>
 <20240122170518.3090814-4-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 22. januar 2024 ob 18:05:14 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The SPDIF hardware block found in the H616 SoC has the same layout as
> the one found in the H6 SoC, except that it is missing the receiver
> side.
> 
> Since the driver currently only supports the transmit function, support
> for the H616 is identical to what is currently done for the H6.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej





