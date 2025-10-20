Return-Path: <dmaengine+bounces-6907-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9308CBF2D43
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5112D3B8BD6
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD563321D2;
	Mon, 20 Oct 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3yeKzs9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B8331A7E
	for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983122; cv=none; b=m/CgSlL+i5wtO84n2NXxplYlZs/KEEcuOxEd4yUf0ngfUZ50D3zfHEHjCz0AAwLnlqJe5Fg81Hvt9H9xu5mTy6K5ENBHuXN8EoJwmjafyBUQc6TGPEXqDB2fFeLQZtwljK4ZhP2ZOXTao9FQyfb8geaOyX7olI5FdgbnGS9BmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983122; c=relaxed/simple;
	bh=V0ywM16huaA6vxoSrQo9VcxXEvOPk2Rt5CdRZIoeNHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJewvLQeltLw2lWdoMjJNOhM1IBofXrLb4qPRisQQwv6iigZjNn+RVthkinTcmlFaGLpUGeJVnsQGb7KcongMkOxyYeOwQ7/uAvWYY76nFFfBW2JnYvpzlN80NPuy/GiYiBntl8894Ak2hIGZ8rOQVdRM2MqZPbkTwZE/G5+5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3yeKzs9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42706c3b7cfso1510703f8f.2
        for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983119; x=1761587919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0ywM16huaA6vxoSrQo9VcxXEvOPk2Rt5CdRZIoeNHY=;
        b=c3yeKzs9FPBDpm8NfVTZjIYNE6HCojwEl7itqNZrHDIWTKGQXhd2ltwrRkFF8QCtQD
         Ny9+scbR1rdywhRHMBiNfWPOQzcqGGadc2c+aHUcB43siKJXSuLZyUBYOzZ36lTOxwnj
         ibGvhkO4KHt6Wgi7t56hlv/L877HrL3iq220+uWlidFv6c8QZEzaCv0/O/SdWbvtYuk9
         tv09hFo9/cjPwzt+UEzVwEWeWPdOH3Bx2HPjCIEb89ZOSZ6Htrjr+vnlHpwy8FcnTNyB
         WuHdhsRb3qMjs3lH2jtsmBPiCxoqZLJ6xH4OHZh/7TodH0DycyKrwd7fMJSJuOPVz8M4
         sfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983119; x=1761587919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0ywM16huaA6vxoSrQo9VcxXEvOPk2Rt5CdRZIoeNHY=;
        b=WLeZ2YbuL8Wu23JlgsawZVzNNWXz0eJQNgOqCCqHDteH0NkKiR6Ahz5pleiQ0lZ8AG
         Dd5ZPvlS36sOjMOPIEAZphqX3Y1jq6D6NR4Q34Zsxg/d8rEX+e0n8WOheqFNJGLGvWYL
         iAkD1YhgB9WMm2KQi+mc/Jmn+K9jKN188W6ZDSA4mR1N2k75ZLs0DOg83yf1zcR6dR8V
         Ax3DncWSj1Xl2CtdtlfwDuA5U/rAiiVPmijVRRXOKV1Ca5+Zc7zpm39UhtTWRXF6MHiP
         WuAJUs0wcmmRSDA+GpFgKkp4E6OCA27U/Uw3z44SCCAmvh5gOVnJ1fCQfGchqd7wJSgQ
         8GKA==
X-Forwarded-Encrypted: i=1; AJvYcCVMYHI+JoiBbhAD7/m7iBS3zXVZrCMZ7wvt5pntI14vI0+p5+br6KlDXKbM5BZrJiRvfkROcYsWTsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk4B4mri2VpTqG+3wfMNkweyp30+6sMIDE0KS158FSq4wJTalX
	YHmW0FI4RA41mw4QnavMyYul//DwBEIcsECRJg9M+LkxHCUI/FpA47bp
X-Gm-Gg: ASbGncshpEKm2d2glZ2VLPJljdIuyqRXGJUsZB/KjiXy80HuOc1ZPWLLaUubhIObJpL
	0J26JI8pjF3BRAB4LKKnvUnDgOAiwAHEOKruXTWGHOE+1rosKcHCCZOJ6cWgHMyKkWeH95aAKaZ
	BL9o8QetoU4jPN7OQkBSK897Vzilyg/+lh6Dbw6CAJ/T18Wig52tuapxTHxitmD1b143+qFsK+V
	N/B/WBPnDwnpgxnTMTU3ag9b0oWhqJPbrJPqVFrENuyxAg2/KB8qweRLa/WjOu1JrJyAvIaKjJq
	4qKWYIqeXFgyzFpwNk1tjWLJ5M8QebpFX75DHdjRC1W59df2xR2Jhp1vdPU0ZUnBJIFJ6j1xkHF
	siGvciIfR2fccYT5/bFNXNWGJRiBCtTGcS7/uyPkjen7CRWli7/gv+veBnSTaFbqKiP/r+Iaprd
	qHRMCMCvit4d6GVVOCgisaTmHFvNExYkCWbpcARTbqxxG/1JTXao2VQt9IMyPdyzH08CQtPh2Up
	WpiGA==
X-Google-Smtp-Source: AGHT+IFevLoNtuerBsIw1VuRArXCqqtvXfnOs340pTPBnyLhuRUJ7DD12vxDIIoA4Zumvg8MBc0QBg==
X-Received: by 2002:a05:6000:2406:b0:427:a27:3a6c with SMTP id ffacd0b85a97d-4270a273c43mr7686143f8f.63.1760983119338;
        Mon, 20 Oct 2025 10:58:39 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f7dsm16168108f8f.4.2025.10.20.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:58:39 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 08/11] arm64: dts: allwinner: a523: Add device node for SPDIF
 block
Date: Mon, 20 Oct 2025 19:58:37 +0200
Message-ID: <22871360.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20251020171059.2786070-9-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-9-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:54 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The A523 has a SPDIF interface that is capable of both playback and
> capture.
>=20
> Add a node for it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



