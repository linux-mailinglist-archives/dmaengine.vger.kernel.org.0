Return-Path: <dmaengine+bounces-6000-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2845B228F8
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20C4587229
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 13:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6C288C81;
	Tue, 12 Aug 2025 13:33:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38554283FDB;
	Tue, 12 Aug 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005585; cv=none; b=HbeWuz3HSJPGrTIsaTNAYrobfRWrsDX54r+hm3fg85USWT5ILBn/huwK4M+5AtlyrnPCe+YelbT0mAfVZc20/NZdNkKwaJtCSVpinBDUXcLuc388FPnaAnloFNVTq0PfQbNKX9e7fXHoYJ30goGwuoXzjUjNmpS1GEdJuqkyAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005585; c=relaxed/simple;
	bh=azJu+fhlrpxcVL8tkf5V9HgKElWVE7T5uf5qkKB30WE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uz8Omgd7aecSbXZEGDY8EtxQf4nN0jywtGwU3PFkJFEM1qYEV66a96xYfrxR/zoSfzknL8ZVs3vfAw5ujV+xiILTk89fcZGcU4LQPenwaI6eheKNWk2RSwSK7tY6KvtMQge3/vr2iYeIi5nI3wZKFFr6+C40tnplhHt8yOPeadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4febcc4c93dso4290172137.0;
        Tue, 12 Aug 2025 06:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005582; x=1755610382;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxUnhAYsbqE1oebUrR3dSoY83+mPkLhSSJqVf05cClM=;
        b=VwvQYtnjACJfH+KG1Q2yriULKM1rdi9jm7eO/FSeFG4Ofdux9C+qIN6Dc8ziCB91et
         kCOHN4jpXCUiItJTyN5HLg8EIB/vW1r6SCGByJhRnjNApGADVkld/kjhZDLrabAh4DNa
         Zy/TXUavOy0ooAjnRAwqsyIB1MdYEP+w88Um00oN7tmpXN66PiqpXCJPnEQeRiMMRBoz
         2/28y7A4GhWdiNLsUv/wENkSKHUO7GDDUiG2e3NiSPI4dN5qDFoyjV+SIRIqp2VO5yCc
         en4PL9KEelhC2/QlCd0WTNOCQ/hGt+sVqdlk61zjXIeytR5wTO4FlPiENBazLmhTmCLL
         qV4w==
X-Forwarded-Encrypted: i=1; AJvYcCV1plLCEOWUlLAghApKCZyMyvG8mao8j4nw748I53mlEGDn1pjriCoVZR+uW0Fj88WtQbWLc+Hm2RjXet0=@vger.kernel.org, AJvYcCV3Cao4opeRFguCnbGIX1u5t51cmg0fnjwazt+pDW1Y6IELXkR97redDnahdO596vAh37hXMI68nuExFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvoFItrfJPnFwys8woEUgN7HOueicz6RSHgOwIOxjqVJiKelCL
	3wPmZzRWkZJEN07q3B0cAXLZJZlWs3AGMXnyMDXSBfdIZS5ZbX9B7+NU65rRRb7W
X-Gm-Gg: ASbGnctS3k//r909/kenuT07ExnS5E1K7S6CjPCa3bq2mBgARIRZzptdZz3co7/Hc2q
	EGHL5/+EVToOgYFDCJ/3xZACmTiatRpbt1sOEPMTuEhj+2UJK4Ti1fpjWoMRxCyZxiOkxuvP+af
	WmaRvPMrUtmCgVhof1sL1rgwfboMozuareYMVfp/eayL7mIHpaos9CKZMeQEb7QFVb/ox5vkzSq
	bDkBgMoYRVNtLSTTl/gqSAOjLlumb0DrbIiUWGnZ1YKrt25aCrrmSTWb0e+3ldFvG/+uIiNpdAu
	GjBRZoLCR4FdQO2F9mH/QBpAlQKe97aPUd9pDIM6EZxB1uFBNajvx/r6HR5Dy1ELUMnb7ktZLZZ
	NFjNF246iVKm/Dssm2eJywXeEy3UtMm6cEZ37ngOZYP6pve/o4vi9kFRbNUt0
X-Google-Smtp-Source: AGHT+IHpFaQBzKhpwKRUtPFSRqRnBV+bspWFoZtjFWHXiNOTw6TGKVXq3GyLo6y8YtkSg1r7GFBeNQ==
X-Received: by 2002:a05:6102:834f:20b0:4e2:e5ec:fa09 with SMTP id ada2fe7eead31-50cc53677bdmr953888137.6.1755005581104;
        Tue, 12 Aug 2025 06:33:01 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5062b6519fdsm2266776137.10.2025.08.12.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 06:33:00 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-88e4fb65341so470969241.0;
        Tue, 12 Aug 2025 06:33:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+06xI2nPzHK2Bq0iVzHaYJDpxpyZRkI3XRO/SaJ1/hRLSHblg9QaBD4/S+zJpTL4V3ArX55Qq/CjE9w==@vger.kernel.org, AJvYcCW/qm0BBItak5M901nuRrmKXHE9oSnAMDMiG2hy+epX265zVgIJQT9Cr2pgmAtI3KG9EmY4zJMZd+GaNGM=@vger.kernel.org
X-Received: by 2002:a05:6102:621b:20b0:4fa:3f49:a3b4 with SMTP id
 ada2fe7eead31-50cc46c0294mr978170137.3.1755005579826; Tue, 12 Aug 2025
 06:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Aug 2025 15:32:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSSVMK_ohHrna8DWy7KU697mnsVHhBrzNMzs1d07J=qQ@mail.gmail.com>
X-Gm-Features: Ac12FXy6WiMOmxcdzGmOeIuAczA6ZfHPkX867HQKbYVDkybGYZR6lDiSm0lMM0Y
Message-ID: <CAMuHMdXSSVMK_ohHrna8DWy7KU697mnsVHhBrzNMzs1d07J=qQ@mail.gmail.com>
Subject: Duplicate TI EDMA debugfs registration
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vkoul@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, 
	"open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

The TI EDMA driver registers two DMA engines:
https://elixir.bootlin.com/linux/v6.16/source/drivers/dma/ti/edma.c#L2525

This was fine when support for the second engine was introduced[1],
as it predated debugfs support for DMA engines[2].
However, both instances contain a pointer to the same physical device,
hence when the debugfs directory is created for the second engine at
https://elixir.bootlin.com/linux/v6.16/source/drivers/dma/dmaengine.c#L71,
it fails.

E.g. on BeagleBone Black:

    debugfs: '49000000.dma' already exists in 'dmaengine'

Note that this is not really a new problem, but it was brought to my
attention because the printed error message was changed in v6.17-rc1[3].
Before, it printed:

    debugfs: Directory '49000000.dma' with parent 'dmaengine' already present!

Thanks!

[1] 1be5336bc7ba050e ("dmaengine: edma: New device tree binding")
[2] 26cf132de6f79c06 ("dmaengine: Create debug directories for DMA devices")
[3] 59200f4526748158 ("new helper: simple_start_creating()")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

