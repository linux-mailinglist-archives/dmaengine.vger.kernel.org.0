Return-Path: <dmaengine+bounces-4558-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3110A40153
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 21:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECA617C8C2
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE0215F43;
	Fri, 21 Feb 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwEQsBy8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D0A1EE028;
	Fri, 21 Feb 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170928; cv=none; b=F1rrkDWv8LO2L6y1R/mryo+kYx5ciyScgq9QmOZosiQxFUeqkxoJpe8ZwtLJUx4TUUsjzrwpEit56wgg6qPtZRb4SnZsx0O2UcMC3v8QfiunTdQfSaHCIvVLBvPiHQ1bYJWu8NqdfU8Yb9WM4+/3yYZa1eo9ML+arlU90MVAl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170928; c=relaxed/simple;
	bh=SbxxSR6UlVOTyDC0umpE2D/Efl8Gy+5ksp6Nhjeam6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlrwYZlgLQQg/Zapyak9d/xaMIBbxN8BKVmJYZh4EwqfMGxLuss5DUb+w1HDBo4YyAT0QZzjzS+nUIPmM4Ht5TlQF6sWrlnnN176p7qwKEzDvojFG2wg1G9d6JNz4cz9A6FGVmWK3VZe8MEi2IIAD8xdA9H611nFeWuyFR0XhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwEQsBy8; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52088c0aaa3so1449012e0c.3;
        Fri, 21 Feb 2025 12:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740170926; x=1740775726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/iCHBPFuLorNTUcfCCYjYnDaLq7xu6QwBWdt3kJRVc=;
        b=mwEQsBy80hfd8YGMiJ1YyPKKQNwz7KFYdd8QEzZ56LbYtS+2Nd2qvhHqmbjuRFK7ia
         lmXgRlEYLRrSZR7okkOxxUU5T/tdScN3FJoNTF0jW+wAV2UhdpdxVRiXYo8i/enAMhSg
         xpRufQs/Ed6qfxuFhO6QK2stb+VFktCTfs4PmYEOR7dbMD8YM5kiyxd+fucZy+bQbwpJ
         KwYEYKOzQbzLPdsCOoInF8ufoGJFYUqKI/FMXZo8RLFHUEFYfTWbucJTmZnvix3zUIl+
         7WDolzwu3QrJYxDHsV59IDOqGopd2KFtF2KcwBZWyjrE+BEYIpjHUMcvgP7E2WiKDQl8
         JyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170926; x=1740775726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/iCHBPFuLorNTUcfCCYjYnDaLq7xu6QwBWdt3kJRVc=;
        b=uoRb0UEk2bLGMr9aLkeMWG7+XEWHgbJcGt5mSDshxb5IyVRderezx1uDxBE+8ZOaXY
         Bg1g8Uj9H7qA1Fx6W0feFcCOE/ujCgGfCgncYOOVfmS98W5BvSnUNvTZcU/d82C1GrLH
         ERykuyttVkaunf7rgEpe4krIPA0Ci1tYWyn/0iiNhKGzXLwNF3Unz+lD58jdTLcQcqDR
         1SY7C8eGauS0Z6nj8xYNfX+ssiJrybq9KRgQI0WG8q6qZc3B8p+u3v2Y6RtEjPo9+GBX
         0yZDPQH1zFJu958uDEYXtGAQI3EhtXUJuMsfT9M/cUYLHdhEMTB3xo6NsE26rmoN9JLo
         Gm3w==
X-Forwarded-Encrypted: i=1; AJvYcCV+2XDcmgtU1xmA+Q4SpJGdcOWJILOYIq0ornxkOHKqWg38+69LWsM4HThMRibseTL5amjFcGB+Zy7+RWYp@vger.kernel.org, AJvYcCVYz7704QZY6vFiCEk1m51CH64TdCigewdjMiczxOXCSjRrNhUbOS8eAGHau+mwMrTkZEG7URRVBKXWmADD9yddEuU=@vger.kernel.org, AJvYcCW1ct4JJCnjK5IbCSyjPsYLTD3/Tf5qkGn7GTbmJCUEq8IVqDBkx5k32NSSwj+TMHgo68SDydTNJJBR@vger.kernel.org, AJvYcCXcIeDbdbf2CtbY2UowNOoIQ4EUVTqUkGgQ8xNJj5dr78oPjc3XZRHVUfxMFJjG2+KTGNQv1qAs003w@vger.kernel.org
X-Gm-Message-State: AOJu0YyB56K4nMzYNcO6VwXoTIiKyL3t4nxkusBO1/sEygMHsx8MB6lO
	vvX0czzAn6A6ZqizkqEMS69em1UGqGeNrMHBI/xpGj28slVgN/3wIehZNzoR7qcQbXmBgLFUQBS
	RODo1uzGYEhAlA4lSgKfHm8q2dqw=
X-Gm-Gg: ASbGncvvEMuuMstGMoSI3GG9hFgXjZ94BPVJxu9KM8I43TyPuqrnI09OXxYN/8seKRt
	Qnc/YManbsL6HXkBlE2Vj7UK1b3uP1Bkg+5U9dM5AKLAvBtoSqCUbizEUh7p0u+6i3hJ8ZTo/D9
	PqHfEVWaqUMzjHKIRp97IKRw+PbC+rySuYdc+nmAzz
X-Google-Smtp-Source: AGHT+IFnaqXISjQiDZgk5wTk5BuBvFo5GhismdmqShdnjYpNbfvT/ETGznMHTSEr2ABh/qaI/uxU0qsTBvAthkuASeI=
X-Received: by 2002:a05:6122:320a:b0:520:8a22:8ea5 with SMTP id
 71dfb90a1353d-521ee491232mr3269159e0c.11.1740170925862; Fri, 21 Feb 2025
 12:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com> <20250220150110.738619-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-3-fabrizio.castro.jz@renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Feb 2025 20:48:18 +0000
X-Gm-Features: AWEUYZktxNZsGsy_ofBaTRQA_KKe6harHFKTJUF5r2etz0d4RdGpD36zLim4JW0
Message-ID: <CA+V-a8sWwK46LHATQ_RGzXOfC=kkuagvgjWFe+YE7XZ-kaOVSg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:02=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Make sure we don't allow for the clocks, clock-names, resets,
> reset-names. and power-domains properties for the Renesas
> RZ/A1H SoC because its DMAC doesn't have clocks, resets,
> and power domains.
>
> Fixes: 209efec19c4c ("dt-bindings: dma: rz-dmac: Document RZ/A1H SoC")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v3->v4:
> * No change.
> v2->v3:
> * No change.
> v1->v2:
> * No change.
> ---
>  .../devicetree/bindings/dma/renesas,rz-dmac.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b=
/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> index b356251de5a8..82de3b927479 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -112,6 +112,14 @@ allOf:
>          - resets
>          - reset-names
>
> +    else:
> +      properties:
> +        clocks: false
> +        clock-names: false
> +        power-domains: false
> +        resets: false
> +        reset-names: false
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.34.1
>
>

