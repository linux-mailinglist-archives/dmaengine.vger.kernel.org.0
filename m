Return-Path: <dmaengine+bounces-5308-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E147ACEC67
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F983A5F65
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111582063F3;
	Thu,  5 Jun 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="S4wVXBiU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CC201261
	for <dmaengine@vger.kernel.org>; Thu,  5 Jun 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113803; cv=none; b=Bux9r480K+/e4MpR+tsSZG7SltijA9d6Y7/nD3IPtk3RA4uBbJJ0ceYz4xK2mnUIkWy+CEn1Qhw1QDo+U1CRN3ld9GcBCpIVD00hMArat1D6NH27AeDYvzHhYZx+p0EI57H4Z4ZYj9rtPMLAZYLdhVcZ9LB2ruOxYcswCBrErQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113803; c=relaxed/simple;
	bh=HZzpiwdDOiE5Yz9hjtHxpuCTZ1QFZs+k4sCFU0dN0Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4WzX1BRhzzn3Dn6Ho4YguTX22kE1Fk/J1e2xPYsaoTZN1E8PFcRrTB+djQCwKZ8RVLvSCt0cr0KNR+pmZLfDz4bTw3aV+DbE8EylWofoX8aaGJpFqv4ceE3kaTiP/uXZkEvscW1MJFcn0LYhLRV5FRPzDas9MmjZcKLeGR3Xe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io; spf=pass smtp.mailfrom=foundries.io; dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b=S4wVXBiU; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60ef6bf2336so544278eaf.0
        for <dmaengine@vger.kernel.org>; Thu, 05 Jun 2025 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1749113800; x=1749718600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXO/BSPvcKdKi8LzY3iQkSuLgTjUSqLbfLK33KnraBY=;
        b=S4wVXBiUlLRutazK5hifcJw2D5JNzzElL0eqRbO6PHGP7Tki+17W7B1wXLBigVkP7+
         wamFU+thHI0/1OL1mbL8V3WoxgClpvZBtisGhTDrK+MnsmZBEcjCVfusA3mbsSfiJRKr
         Tj8jjxF3iGChAGz9Ruf/qY1CdtxjyfQpTjbwxX+f8dA/66p7CgO++ccEVYLOCUnxZC68
         ma794OTnM5lN1bIl6/P8rCd61tL9ptxkcMm6nXVbLAvjKpZeFCsf+VI3NwFqUGiim9Lv
         kdnO35YvSgnmLIm1ao71LF+3810YJ4ssqAsg9SBVAH9+o0dpDkZHjgBDbTsmIbjd6GxV
         /zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749113800; x=1749718600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXO/BSPvcKdKi8LzY3iQkSuLgTjUSqLbfLK33KnraBY=;
        b=dq51zrTmxV5b6XF3LMzXUM7QTSsHCqYvlsBoT/q0UfvCax8+3aNFMwC8D7dxLaCv68
         AsVwTJ0z74CFqyqUkiHk39ck9nTq9w18NAqCsmuq8SSlXIe+Pt/gCHdOFvAdyFV/8rWm
         HTN/bb5E4qB350LjfZOZdKYkfXhq1uDJRlroWVvtjS+2seG8DgJiDlHSGZqP3dWOXgal
         2v7qc7zngKxwn+9Lf9DgJP5GMxq/yIK2zmw7Q8HxlhCg6LZW6GuxQ6m0uW1nyUEPD3nU
         KIQtbgqRChXOmV2v97NmQtWiuovEMuACb2m83MOyB/HnHe9QH+pXTle1AGmPn6Sac3Ye
         pUIg==
X-Forwarded-Encrypted: i=1; AJvYcCUZWu4aEqkWdg2kt6Rz4w9LgH5Nllco+dNxEqDggOdPTnUEv7bL2o9bv5EFNUAU8k53TAA+NP/8sGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLPewSuXRKzfryy9I5uXzHwrC9lCOFGMr2FX/W0RlqCugR8vhM
	CtQRf+rwVkS5d29wXiKpaTq4LEXjx3LBhYxZqlIpivYYdxnVMsUp5DdyFr4bIBO5EEJKE7t5hA6
	cC0IeJJl+fuzke1guhkC2xk/+6yBdV0o/JuJiZglzEg==
X-Gm-Gg: ASbGncsGgjH/uKGdXvzx9V2aErzUFvLCt7/J17gcwL7GKP+Stb/o3qwZiG21IntCjmR
	yKuFCjiXtt5nhJfpxv5rzcch8nwlhsm2xIzcKq+Bf4PYGaLXl+W4q1F/iRJqzA8I0Am/uUvZtAL
	mw2HGM/TfHonBQ1EL+ZHnGNz5QZ0AVPw0L3w==
X-Google-Smtp-Source: AGHT+IF8W9Kgqr3UhuTzE8rUUoqG6pf4kyDG1m5TVs7MD/SkPuEv6xmyR4osr5A3wZxLQrDAEbWseicelzibxl5/PPo=
X-Received: by 2002:a05:6820:1804:b0:60f:3442:96b9 with SMTP id
 006d021491bc7-60f344298acmr473284eaf.3.1749113800444; Thu, 05 Jun 2025
 01:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605075434.412580-1-mitltlatltl@gmail.com>
In-Reply-To: <20250605075434.412580-1-mitltlatltl@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Date: Thu, 5 Jun 2025 11:56:29 +0300
X-Gm-Features: AX0GCFsbvH6NQZycfznXDqSOLQq8s8pahdhgC2jk-Poorbr8RsI9U3sRbkZzVbg
Message-ID: <CAFbDVTBGR2ke2Uak+GrsJTVG6ujMfVymRsM_rGu9PwHDE+bGtA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/3] arm64: dts: qcom: Enable GPI DMA for sc8280xp
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 10:55=E2=80=AFAM Pengyu Luo <mitltlatltl@gmail.com> =
wrote:
>
> This series adds GPI DMA support for sc8280xp platform and related device=
s.
>
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
> Changes in resend:
> - document dt-bindings (Dmitry)
> - enable it for sc8280xp based devices
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20250605054208.402581=
-1-mitltlatltl@gmail.com

If there are changes, it's a v2 rather than a resend.

>
> ---
> Pengyu Luo (3):
>   dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine
>   arm64: dts: qcom: sc8280xp: Add GPI DMA configuration
>   arm64: dts: qcom: sc8280xp: Enable GPI DMA
>
>  .../devicetree/bindings/dma/qcom,gpi.yaml     |   1 +
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  12 +
>  .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |  12 +
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  12 +
>  .../dts/qcom/sc8280xp-microsoft-arcata.dts    |  12 +
>  .../dts/qcom/sc8280xp-microsoft-blackrock.dts |  12 +
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 368 ++++++++++++++++++
>  7 files changed, 429 insertions(+)
>
> --
> 2.49.0
>


--=20
With best wishes
Dmitry

