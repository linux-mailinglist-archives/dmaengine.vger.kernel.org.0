Return-Path: <dmaengine+bounces-7902-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E561CD984D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC4830A39FA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4572C0F7E;
	Tue, 23 Dec 2025 13:53:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF227E05F
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497985; cv=none; b=DSUTzdgFHg/pHg59R2Fwx6oKyhO4nkNhJX06FysKuui5xCaqbeNues3OgA8j7m9nLZt2iJEF3JOasw9Y3L+vYC27etMugIUq8i2tOzTPM0qQK+VHdWFj48NLOVaoDl7mHyBGyrt19wOWv9uuHy/R3Q3Tl+r3VkfybbNeinDLcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497985; c=relaxed/simple;
	bh=U4SfYmuMnXUUFIkmYEIYImOxbbZck0BsbU1+cFVeHuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goJpH1w0ze+4vtQ44ek25EsDk0POBSqxtCMmeV0jlxEyifCeaC5F/j95tVUlqcOy4PQeNAEkwldCFHSQBQD1wUHWf7ZekszVrFrJCrqSr8S+/DDgYD0SHIgPYylr/o1xS/lKnHqK3QMNOigNU8/Qdji6uFR7vQiO19RhytZTf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8010b8f078so615525166b.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497982; x=1767102782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRN28FWPMAx4S3xSEvODZwJug4RA84MF55jfYOksySo=;
        b=NT7scpGYd2YaHbPzhIgD6tWsJznbhsAYFrYublCqlOOyC/QGSQCKUIsvYyNz/at9pf
         kk6b6bOGzkGESq7qBsjvXq+COb8ALs0YQ2REaHowwM44Wt2bsWpFM9pQt9aRVG3BB5Gz
         FcyVfTROErdQcbq0JOmcxjs4m3ztFc6kK2O9esF+B/YStm4SMqmPnNsTGFQvBnKn96DF
         5IMdOV0Z8nB2c3Y/XATAa2GG64RtxSaPS2LDsYXpW7jfFccHpd8jZj3ofTm7SXZEch/8
         j+Ud4n+tZIZMlH+Rokpl0NvHz3IkLnznl+AV6R7ebFxLkNTkUv30nZoaG2SjhlalsWlv
         0TzA==
X-Forwarded-Encrypted: i=1; AJvYcCXUCfE3sKOgdJwR77CZ5p8RLIOXiJDYcamO7GGkGhXDeJ2XMtF5ONxqZBX56TuOTcxu+10g34OaffI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7TWq4GFqMsBaL5GFFqqZDmGZOfLGF1MNOfd0u64klQK4n4OZ
	TjG2GMJpkkYbKlQKjyI1O3/oFs8T9wv0WLnbmilI28yoNa0CgJECyKxs/PrRMVUXyMg=
X-Gm-Gg: AY/fxX7Bfb6CqfW+Ulo5YLZfzeu7svi2T8+Py1Dt34UAWyeZiIi31J7IveA059v2XdP
	tfPPfgZKvg9nsF4Th7SZGkGTpEsdobQSYxOWMQLA/6CyKTtStmunujCPPsQzoBx9FDVFMimJSm7
	1XXoGOzUEKRm4SVwz/481RjWYzbdDV/vMoG3QqGeOVLsZ8gwVGc2SwWWFGMQ4LXyVfsmR0JVf70
	Sqp3eOGX8i2q4lTZMI8kjkPMGLCZKCWK0DtX57GVU+f+2UiGRNqNtgFqmXqhJULcB9vUQdqXhlx
	zSunykrKTv1URsWLNb5xGM84Jm1Sgn/2nmS4k/CjRutmKXYxyIFA8jEJvSgEGq4eaOEtIFDTbx6
	qW4VecFRTAKT91Go8QFbdGNE8O7zjfM4+Se71sq4aqHizXg8qgtdgxGvk/x8NRF+RqnjDywWcXK
	2ctxfm+BSEBDi5p+8sYbw5P3Le5/S+evI73cOJcIxrGPlpFuiv
X-Google-Smtp-Source: AGHT+IGzBCe160/kxkFEGO1eMkKTfB8VDs7nqmHNi8GXnc98aIoFBcpxEmb2bavbNzxZa7gHH+vpZw==
X-Received: by 2002:a17:906:c116:b0:b73:7f1c:b8d8 with SMTP id a640c23a62f3a-b803695c89dmr1560577966b.0.1766497981837;
        Tue, 23 Dec 2025 05:53:01 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f3ffbasm1431863666b.61.2025.12.23.05.52.57
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 05:52:58 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so4518674a12.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:52:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV91SCFBwCZca9exy73q4U7D5RDrYLM6ZBzQlCM7dQWi5JaUIhjnJD7/P5IhuYMSq6IO/UH/eWDvSE=@vger.kernel.org
X-Received: by 2002:a05:6402:3596:b0:64d:2889:cf42 with SMTP id
 4fb4d7f45d1cf-64d2889d183mr8234029a12.2.1766497977682; Tue, 23 Dec 2025
 05:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251201124911.572395-7-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201124911.572395-7-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 14:52:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXwi-0DcCRgsGat0tzBu-UOpd6Vws8Dny5zDyWwTuJ+3Q@mail.gmail.com>
X-Gm-Features: AQt7F2oADPw68F4-oj_Q3CgG6voCKpe7dhfvSuflJPl-MkOYCou6cY57D35QDac
Message-ID: <CAMuHMdXwi-0DcCRgsGat0tzBu-UOpd6Vws8Dny5zDyWwTuJ+3Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: renesas: r9a09g087: add DMAC support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 13:50, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/N2H (R9A09G087) SoC has three instances of the DMAC IP.
>
> Add support for them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

