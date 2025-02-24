Return-Path: <dmaengine+bounces-4568-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2657CA41F43
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 13:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B820B3AD54F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20ED23370D;
	Mon, 24 Feb 2025 12:33:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269318B46C;
	Mon, 24 Feb 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400417; cv=none; b=q2twD4PVVs1YN+DXJLdhS8Yvza/6Eii+bz4sqHevLGmAXfThShmZEcQKO1p8yYtJbudT3j7D2nKHi4v4eocAhd4jaCnNHx59qYMAFRF5n1r3fw/efIV4XN66cYscmhw20YvIgz8YHt+QL1mSL0o+EVNDvdU0mkHE7afKnWQevn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400417; c=relaxed/simple;
	bh=zKICrTUO0dio0O5VBw12PobjkyCYy17ahopjYifg0oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeQmEo1ioEqd/qchFEWGshC3w+KRQ4RjopSkfcxUizbk2wBvoFE1eskLqgeqbbkBS4gwVuDbzfuoXOb8ajAy4b71cNKortUA+QITlvndSUf0G9WCqkzg6yBLUEbg+TynqN3n0jCytA3bbJa8wevubIaYeOO+k8/b2lNwZlWdt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-521b3ebb0f3so1115458e0c.3;
        Mon, 24 Feb 2025 04:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400413; x=1741005213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqNrN0YZII2Gmux/VqhK+gimAMSlxBCMXbfMpvaB6G8=;
        b=IT2ihSsQmFd3/bXsLO4XY7D6bndUkuIo5CK34E5KcKqEWgClX7TW6QGd0XaP6l43xq
         9NMye7Rej6PWMlg/O7cAb1NB2tL6sE7WxXzbwnjBYUKRpNWvGGx4XHqP4nsWR27RLOKQ
         119CmCl7mD3093iRR2EQTwjjrwSu0YXSjm03bgcZaKxcOqPVltNKiFsA2EwceEBpO184
         fGyjYklBPY8gBwhXFsVD/aWHQyDbGDjuAYp7hjssxNH0BHeEx8zX2M1dTJ7sdRCjLif7
         RtCRIradAhgmluXEvg5EY9vExiz+oWJrdWm5/Rux1lf63C894Jr1S4r6uaCRXHlDuxTO
         XcmA==
X-Forwarded-Encrypted: i=1; AJvYcCV/W2g5xKwC5DGFXWhUBgS60lrxPpYec8QhNX5Oy2Q6EYlAu5y0ey9W53mSM1hjvUAHN7NjvXyK9YtV@vger.kernel.org, AJvYcCWDIcMDc/7uT+aYdwcOlPdHG2fkdPcixsny8pmtFee3mZ6VGfR4IvEzj/jhoHJKL+/Vr4SHhv7SkZnRdWD0E9HGzVs=@vger.kernel.org, AJvYcCWNWMR8Y6qjyaJ1znrLhtAbRXpDxl+RgzLC5UkdQzzwvYl5fgCIf1Ll7c74r8MmAQUVCKtSfBI+RBC4@vger.kernel.org, AJvYcCWzaTkPb1QRP19ZGQc6JuUDU+FeStrRhQmRLnEdgUK7p0iJte7gFPqj+huUpwboqF3PnSFY1bspSIN7XlxZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlHyG/NkHbUijICMwgGxexromNeD0DuD7VX9P92C6Ut8K0Gxj
	Ue6m/FXxoBlpx+3oYtlGmVlCFIPeyggmCseMFH8uXUFanYObn2k6rrz8w6yKBNI=
X-Gm-Gg: ASbGncvFyXWKIUUHVz5o/OV463vPotTSk86g0gp42FzS8+sZEB/dtK/c6kODr2XyR9i
	74g/fNFPS1H6++SAgv9MIh0R/8Z+BOlElw73/w0CzlYcHj806Uaf6ugbWlsoQXugMEFk9gKz4ix
	7ZU6UAI8ByeJZkLMSJvw23RCNR/peB30y2SEhAoRU7h4ODHguDziDpuUAk0d6vxstsKielCu9fi
	/IWOT7HvOR/kcPWzp2rCN8qv1z6DNfT+5ggLY+yULy8Lnopo+sL5NkzRKApFReI9cTppuDqd4aO
	M8uw8MyQ6Y58wJkmuLPO3zvCNQBSes4YM9LEOwprryKGLeOUFZx3mOmS+gwukl5R
X-Google-Smtp-Source: AGHT+IHP8GPjYy+gXxcZvxZf3DJRPbQepzhimm/L1YuMPyS7Es1tLp9LUA/e27EJpU5PZFPNNlHW8g==
X-Received: by 2002:a05:6122:3c42:b0:518:a261:adca with SMTP id 71dfb90a1353d-521ee46d098mr5140353e0c.8.1740400413330;
        Mon, 24 Feb 2025 04:33:33 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e8547fedsm4566805241.5.2025.02.24.04.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 04:33:32 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8671441a730so1310312241.0;
        Mon, 24 Feb 2025 04:33:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUF3RWFanIyHiON2JLOtB1kVy+a4i8iRqJO5Qtb+Vn+kcVR9dyLGLFRwKJQV4/8f3c72BKxaTh949Gf@vger.kernel.org, AJvYcCVnakRNWeAy3DSJRQdZF1YfTrEBJRYWaFE2vvoVMveQtmS2PQvmi28r0StuxrpB9AZFBfLe7Pync40M@vger.kernel.org, AJvYcCWWZlZD215VeF0bK1enb4c7rVvQZPaih5CKjF6TYXFpDaVJdowpLZffjIc5S9r7gQoU6CCwLz9uOZUngtiGhfsaP0o=@vger.kernel.org, AJvYcCXegs+9DBtaGMOu7bbmnWXN1XoBnAdNMJMib0eZnXxj4cr+OiH6C18jwSkr8R0HVyS8a7Sh5GY4YCzZKNpK@vger.kernel.org
X-Received: by 2002:a05:6102:f12:b0:4bb:d394:46c5 with SMTP id
 ada2fe7eead31-4bfc0079779mr6254680137.9.1740400412556; Mon, 24 Feb 2025
 04:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com> <20250220150110.738619-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-3-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 13:33:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUTm4-a3pmXfC4CfhR1G76fA7u88bu3kcve-VzN2QO3Tg@mail.gmail.com>
X-Gm-Features: AWEUYZm8TkB7ICd2bDg6WbWq93ip5Ss1XFowf7DHvb70VcthpxFlGGcskoYPSyw
Message-ID: <CAMuHMdUTm4-a3pmXfC4CfhR1G76fA7u88bu3kcve-VzN2QO3Tg@mail.gmail.com>
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

On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Make sure we don't allow for the clocks, clock-names, resets,
> reset-names. and power-domains properties for the Renesas
> RZ/A1H SoC because its DMAC doesn't have clocks, resets,
> and power domains.
>
> Fixes: 209efec19c4c ("dt-bindings: dma: rz-dmac: Document RZ/A1H SoC")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

