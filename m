Return-Path: <dmaengine+bounces-3740-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B69CE1A2
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 15:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB86E285FB8
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BE1D4324;
	Fri, 15 Nov 2024 14:47:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D11CDA2D;
	Fri, 15 Nov 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682050; cv=none; b=S3ZFEAQ1D0SjM42e0s+t1IolBefVjzjkerrRT6V4xzXr7GkiheFt6Uipk/jqBb8yfLvoProLifNLbewZQ8tSJRzvoS+i6IjMWHERpV2FW2z4IKtxew52TvhufI7f73OvYtiXDFMhABNLtgyGluPDKN4xZ3womdMrH2A40iB0ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682050; c=relaxed/simple;
	bh=zQZDdRBCh37MVZBEUYD77upHqd6p7XsUHugnENLQO/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2wQ/m6mZCmZsxipQdhWoon5+brCkpfaFJ3y/OJWIWlMtPQjLkYxgfH+cqxehy6DtKnmVagJvcTVfScto3IdQLP3xprJ87X3sVnjFe0Obv0SuYCV/JxZLiCaqPu4WPfjlHNpiYgzsu2V2Ew38zhdUKKkhOdCp/zHI+SPOm4ZrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e380d1389a1so704733276.2;
        Fri, 15 Nov 2024 06:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682045; x=1732286845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR8dDev0zJdSHldk39F9MFbJRmi5hrCGQqbut1uSX8w=;
        b=NUhpXYjlV44snijC8lWTohux805C3mv3Vg2Qtq/nvq5TogoiZNVwJpTSw7EZAEX9HH
         nTxUUj0cFyGAdZlnzUa4Q4LfsF06jzcrzctKcD73x6qSidzMZeqN+K5T/UtlkhtJSazQ
         M+bO9BwOzdFVmeQPp7M9WQcVdmnGDemYbLhyHeMRqPqBX0yM2JFYNTekBFvxOx135hUy
         Rlw2CLd9iDwLGwUQzmJ7gqPUFvNCzP5MPVYBaaefDZlrd6Ew1QyINLAKY5zKvfH5jAhf
         npPm+eO33zGB1MszImQXUjq+BaYuYR77lqlRwJeRbnQYITrHSaMlT1EXZCrauS1s+5rn
         Kl2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4HYzSLDjsZF9kEcjqrGP9KXaGyuzr8W+uAh0O581zNN4ycsPbz/MZlsMKzbcwH0VJBT1aB8sJrAal@vger.kernel.org, AJvYcCUfuhEpKzICFSVjiV5BtoFN76TvnTayEeF6+B6nJ8X+7VvvQnZb/tUu4kvx5UFgUwx+Aj1PSYHFjVHj@vger.kernel.org, AJvYcCVyhTQs69Nn+59mrSF4l+5Waz1sZO9PTkoYlbOGoLQXNaV00iCUlLy3skSUTKFHd7DjKhCCkaMJ++Ud@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFXa/QI9wbzsGET7WMleH0Dl2AnL6xL/tWWjfj2WR+23a3u63
	nKql3kM6ajcx8rgqQK09cZ5Go8psRsFxD7X2qJh253p4Oz6LAiPGR1Z4erOt
X-Google-Smtp-Source: AGHT+IGwAI8Hu5657QPY5LSYePkrrPBYUpBBQxRKMDwv1TBUyoZJ8cA9SbOAGh89dc4ku089xL2F5w==
X-Received: by 2002:a05:6902:1546:b0:e2b:d5ab:986f with SMTP id 3f1490d57ef6-e382636c2e8mr2267920276.31.1731682044850;
        Fri, 15 Nov 2024 06:47:24 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152ccce8sm929059276.22.2024.11.15.06.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:47:24 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso104403276.0;
        Fri, 15 Nov 2024 06:47:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8diKCe4WbsQREycfjYsEZnUGYyU7EuQRhV3/yZtRPQVmmEAjIyL4jEPrQy6sY6wO4qke2DVWo3S4M@vger.kernel.org, AJvYcCVnrgy6FGFR0IuGgQ7VXgRTKXiPN3ACA31eZsZYbmU1lM8MS8/9j3CDAb9hfRKD/J9WUdPncue6+s42@vger.kernel.org, AJvYcCWzI19Us2y3MxNVySg6Gx8bxzLHzzSvPl4w52xhd9iaRL173Y0yoTw807ngoT4R9wDwokhqRZD9jKuC@vger.kernel.org
X-Received: by 2002:a05:690c:46c4:b0:6ea:ef9d:fcba with SMTP id
 00721157ae682-6ee55a2adc6mr37906977b3.6.1731682044347; Fri, 15 Nov 2024
 06:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Nov 2024 15:47:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5PhRT0B+ua=MyTeTZF+BOFEzQ8XyWtBGOiU+YKbathg@mail.gmail.com>
Message-ID: <CAMuHMdW5PhRT0B+ua=MyTeTZF+BOFEzQ8XyWtBGOiU+YKbathg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] dmaengine: sh: rz-dmac: add r7s72100 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

CC linux-mmc

On Tue, Oct 1, 2024 at 2:43=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> When activating good old Genmai board for regression testing, I found
> out that not much is needed to activate the DMA controller for A1H.
> Which makes sense, because the driver was initially written for this
> SoC. Let it come home ;)

[...]

> Adding SDHI
> is still WIP because RZ/A1L usage exposes a SDHI driver bug. So much for
> the value of regression testing...

I had completely forgotten about this, so I just ran into the same
issue while trying to enable more DMA support :-(

The SDHI callback does:

    static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
    {
            ...

            wait_for_completion(&priv->dma_priv.dma_dataend);
            ...
    }

i.e. it assumes it is not called in atomic context.
On R-Car Gen2, that is true, as the R-Car DMAC IRQ thread does:

    static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
    {
            ...
            spin_unlock_irq(&chan->lock);
            dmaengine_desc_callback_invoke(&cb, NULL);
            spin_lock_irq(&chan->lock);
            ...
    }

On RZ/A1, the RZ DMAC driver uses virt-dma, and offloads this to the
vchan tasklet, which does:

    static void vchan_complete(struct tasklet_struct *t)
    {
            ...
            spin_unlock_irq(&vc->lock);

            dmaengine_desc_callback_invoke(&cb, &vd->tx_result);
            ...
    }

However, the tasklet runs in softirq context, causing:

    BUG: scheduling while atomic: ksoftirqd/0/8/0x00000100
    CPU: 0 UID: 0 PID: 8 Comm: ksoftirqd/0 Not tainted
6.12.0-rc7-rskrza1-08263-g3b9979a62f8e #885
    Hardware name: Generic R7S72100 (Flattened Device Tree)
    Call trace:
     unwind_backtrace from show_stack+0x10/0x14
     show_stack from dump_stack_lvl+0x34/0x54
     dump_stack_lvl from __schedule_bug+0x44/0x64
     __schedule_bug from __schedule+0x44/0x48c
     __schedule from schedule+0x28/0x44
     schedule from schedule_timeout+0x28/0xdc
     schedule_timeout from __wait_for_common+0x80/0x108
     __wait_for_common from renesas_sdhi_sys_dmac_dma_callback+0x58/0x84
     renesas_sdhi_sys_dmac_dma_callback from
dmaengine_desc_callback_invoke+0x6c/0x7c
     dmaengine_desc_callback_invoke from vchan_complete+0x118/0x13c
     vchan_complete from tasklet_action_common+0x64/0x90
     tasklet_action_common from handle_softirqs+0x164/0x1cc
     handle_softirqs from run_ksoftirqd+0x20/0x38

I am not sure if the SDHI driver or the RZ-DMAC driver (or virt-dma)
should be fixed, as the documentation[1] states:

     Note that callbacks will always be invoked from the DMA
     engines tasklet, never from interrupt context.

Thanks for your comments!

[1] https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/driver-ap=
i/dmaengine/client.rst#L164

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

