Return-Path: <dmaengine+bounces-7013-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C393C0FCFD
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 18:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BE5188EB6D
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626323164DB;
	Mon, 27 Oct 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS5CI5rQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F250314B80
	for <dmaengine@vger.kernel.org>; Mon, 27 Oct 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587814; cv=none; b=J/fTxQdflbf94swImX0SiyzwF7yqOOK/I5AiZ18wdpfDW/uxsVFBFt+rNFOozrQsu7cvWflkt2e36eD/cgbqt4DaL/FuWIPRqptst6IwehKdsCa8FJNQL4LiPUO6CwiFtStGjZ+cdYfyZWIWKbi9+QJAjevKq9o+AWK6wpoNV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587814; c=relaxed/simple;
	bh=SCIPeksxx2uDarfAhuXFCN/oVVLcwA7r7uPbkIEyGqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I76Hyt57PLHsyXebhAvy/VgYggsPUXBwF7kz4A0Vye5Rt6beBkGKOKzDex2GAR9bYXF9QylV/nxcqC8xT9GnmfVo3O5kh216K8B8n3Nldcr6rDIv4ZsrYr0tqvKjEvD21NugT1ljudMFGyJtZxefAVPSGOSP4lntlICAh5JjyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS5CI5rQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47114a40161so56085905e9.3
        for <dmaengine@vger.kernel.org>; Mon, 27 Oct 2025 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587811; x=1762192611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCIPeksxx2uDarfAhuXFCN/oVVLcwA7r7uPbkIEyGqU=;
        b=IS5CI5rQdF27eg/WCpXgLI2Zyv+9BcInRCb9Eu9VOCfKCHxPuKzd3ul3LeVDp2Rz25
         gv5lDFoGKy+UukPfyev+KGMqnFRw8ZBsw49dGyuiQERap0Ekw2dz9pzDLupUR5pqeAfG
         tsJloMnfa2Bi7Mo3FtfHqxVSuOLOVuePsGJzdqNtmAQT28TIyIJ1uddZevmBbmJDzSUx
         KIFizCr2A6Axgcwcj3YBPoyk7AUqNr4zLmghZ827LJZ7qi+z9A6hUVc1akUwjUFQ+Qu/
         JUhawW2kDFauJuWErOZ9Ho2AYfzYlK3l7gmMQYL9r/QAbDv9ycriWM3IWUOQ9O7tZind
         H8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587811; x=1762192611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCIPeksxx2uDarfAhuXFCN/oVVLcwA7r7uPbkIEyGqU=;
        b=GWu3WMNy8joGZTVRVz89V01WHzdBVWcw5bUYURu9re4oTv37RY4BiD7/DbJMLSd82I
         NAhFl8pSMNWFsCPSdsp7pGDpwNQ5dyTSF/EZUWTCzPdmScPjOh/eQfUSoYU53zVCxHXF
         7UsxQwGDB9jh9nUX6UJ3JHwbShOJ0frlEhKSn648NDjdHo2mVXQEL5xPbZPL+VzO5yH0
         3E4Ck5COFBwrondeMAJNo+GDZv1VpmMRo8GkLAdFJ5nCSrL0G9pubZiIliElb9KmeY5h
         E2hyBexwnHZx5lc2k1C+141zy8/jYkQyMFLF+4U6IwPjfaslsT+f3zwR3aZbfPo+oYar
         pvNg==
X-Forwarded-Encrypted: i=1; AJvYcCVOMDjVDIeP+7CIlpwRwXT7Elot3JbHw+fHRveULUIHrPvxlIfAooNKK7Y5F+ZzpsBrnz826wFil94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7OLpD7uQKjqfGJZ7F2WDOwlGBOafHm1XPro91GQDcbF00JWRI
	BnmKUp+91VAqCj074Brv7UvpX7N3jwRcP9KP5TR3/2FUUYbUmJnbgAuI
X-Gm-Gg: ASbGncvSiyXRfA/DMsD4XNw0sFkF0CWdLbCfKu2LBqsQrlvb39iC8t0oGcUNSjK85le
	+eX2NFo6GErhsPNe/1aXXvOVyLpvyje9A+hBw+dzn9JqskZdWJcw68SI5wsoSBQyQHyL0xwTWlX
	8QieGodl9gvh3wFtG95ZOhToSmA4d3iCk7+MyAGsJZGZfkBmVLwMTGevC3t5N/3Z8GrD0PwRfav
	z2rSOWgXfcMJrOdgvFdE9+rZVmarHKLQ4VvlfBeklSNj02e4zfbbMxSlPc9FIGcWEzgByKFLo4c
	AV0hL1GnO220pXk6MRNwfCgJkX1R7V9b+qeSluri3pD0ANa0ugxc2TmuuRIFEoNT5KUO65vQ7Ru
	pZCh3RZf9ErMm3+2ALV94C2b0P6d4uV1PLv7BicXUvBOKb6MdT5BkAmX84mrrh8m0bqDv/UjlRi
	zUvM8U0RB8/LExRy3IZ+EBz8GTPsOQMsYvovLc9AyxLtCuFZdXhnyEUm6YDQ==
X-Google-Smtp-Source: AGHT+IEihm/mMfPTi4flOTdp91sIkNaqwi2a8InYOu2pJ2ai1utyKQHaHYaafUG+/91FRnDBC8gdGw==
X-Received: by 2002:a05:600c:64c4:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-47717e512bamr4754785e9.27.1761587810623;
        Mon, 27 Oct 2025 10:56:50 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4cc596sm152270065e9.15.2025.10.27.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:56:50 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 04/10] ASoC: sun4i-spdif: Support SPDIF output on A523 family
Date: Mon, 27 Oct 2025 18:56:49 +0100
Message-ID: <6204310.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20251027125655.793277-5-wens@kernel.org>
References:
 <20251027125655.793277-1-wens@kernel.org>
 <20251027125655.793277-5-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 27. oktober 2025 ob 13:56:45 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> The TX side of the SPDIF block on the A523 is almost the same the
> previous generations, the only difference being that it has separate
> module clock inputs for the TX and RX side.
>=20
> Since this driver currently only supports TX, add support for a
> different clock name so that TX and RX clocks can be separated
> if RX support is ever added. Then add support for the A523.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



