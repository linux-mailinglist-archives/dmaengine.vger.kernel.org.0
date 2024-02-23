Return-Path: <dmaengine+bounces-1084-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28592860D73
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 10:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4A7B21205
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC3A1A701;
	Fri, 23 Feb 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF5oZam+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A9199D9
	for <dmaengine@vger.kernel.org>; Fri, 23 Feb 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679064; cv=none; b=IbgjGKl7rgRrdTUQkUTDoVy5O5ku0QkGm8fKkGQFEHIB3o6+dzyP7sQkOadYYRhv2GLaW+Zk1a9BIxJ5zjbig8k47Yis1ytHLmo1Yg4VMZc0hbcNpigJpvIbITJQZDdDS5CxLOZnKCsfY3hTieXTJqOwD0pMgNVL83AyOXNB1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679064; c=relaxed/simple;
	bh=dcX/U8zyvW1OHqtJvKfIGJ9iBgHc+E4Y1rDANzQ3p2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vvl/HBQmBVhqSb+jOdN+eC3UczrDuHGBfbNYzwNw5ubLBgNfToodUC6/PCW/1qID3gMO79zWMcG9I1a0wdQjzRGAf/dX45jwNJ/k4SgCsQZ7SzPUjsW1GQsHQB5Nqs8OJiitapYkukhU8tjnbQi+BZ8xlL8Rz0/L0jU5FztW0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF5oZam+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so15574666b.3
        for <dmaengine@vger.kernel.org>; Fri, 23 Feb 2024 01:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708679061; x=1709283861; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HUzOCKRdtW/SkotrFg9CZ9dV6uJOSuZ5twWrx7wxcNA=;
        b=SF5oZam+NLmjrYi0WNedInKPgU/KX2OKsIzlUdBFYi5DGW9xJNuipXTNeSgIudkRVD
         tO+EjGrEyqWfuNhVBQKy+YbOedhrV1S48pPUfyaQXLAS3tXbyLqcWiKk69c0Q08rUQv1
         SIX3Vshpjnv5eJhdxJX2jtuRyuje9+jdj2T+i2ZbtMoI9dyj+a/VZH3HgHvea+ip9l/h
         d7At1qtkCFLJH8WBqbYJcxfoS5jbx8AWXci9wOScDEwEGynW1mnSwyv+rwWK/HGPq+5i
         tAS7pjUqAhtRCof3tvWaXg1xgAYj7IefZMHI8FsPtxQx6NYK0rNV1O6EDgpd9Tbk5F2D
         DOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708679061; x=1709283861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUzOCKRdtW/SkotrFg9CZ9dV6uJOSuZ5twWrx7wxcNA=;
        b=QRTXyT92D0Wgpv1catqjDQS9MHuwP4dEwYisQFRxLvfEA9DE2V4b+na9D8CNrRRT2J
         yZ1j9H8+RPxpuq6rv+Hq0qnGDhAVS6ysR1dbRIE4BlQX6Fxi7eRyawxCA+lAKi1unqi9
         B0pKpZO0txq3Ek/CDz0Zy99Dw8rWMLj2O0ZOww8tkE21rO7aRTkLcRD5skQTDupOxTHF
         3W3k2qh0KUxe7v9mJ/U7DKw16dreng0CJNiWd3Gvp6LFhYnb+7VUQ7g1LZqVgnP5nBp1
         STZvvsBNo5P4kjJOql/IqjW1aciXCXYIyMbG3VnPKm7iq5Zjbf6yPNm7vAVex3nFG1cB
         RJhw==
X-Gm-Message-State: AOJu0YzvektNv3oprCskINjF00Yu6o/F4Hj9OEpr31Ox/HF0BntvJjSe
	tcNZ/bBuOJjbGveaxd5zZo2TCvfVaWf/niEpKWXhflY+UfQeARbK
X-Google-Smtp-Source: AGHT+IHGhs+CWwb6DOoqA6i0IeR7yqhWQALi3s3WbfPxP69T/up0ndd1lebeOwtDe2HlIMA/XTKKag==
X-Received: by 2002:a17:906:a88d:b0:a3e:69d7:3514 with SMTP id ha13-20020a170906a88d00b00a3e69d73514mr193677ejb.26.1708679060923;
        Fri, 23 Feb 2024 01:04:20 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906ba8200b00a3fc04c1828sm458605ejd.133.2024.02.23.01.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:04:20 -0800 (PST)
Message-ID: <b7a24cc765268fb425d528cd036fc8a27806649a.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] dmaengine: axi-dmac: move to device managed probe
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 23 Feb 2024 10:07:42 +0100
In-Reply-To: <ZdhE2m40lsxIgdr7@matsya>
References: <20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.com>
	 <20240222-axi-dmac-devm-probe-v3-2-16bdca9e64d6@analog.com>
	 <ZdhE2m40lsxIgdr7@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 12:40 +0530, Vinod Koul wrote:
> On 22-02-24, 16:15, Nuno Sa wrote:
> > In axi_dmac_probe(), there's a mix in using device managed APIs and
> > explicitly cleaning things in the driver .remove() hook. Move to use
> > device managed APIs and thus drop the .remove() hook.
>=20
> This one fails for me somehow (applied on next after merging fixes with
> patch1 on fixes)
>=20

Oh really?

They do apply for me (unless I'm doing something wrong):

b4 shazam 20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.com
Grabbing thread from
lore.kernel.org/all/20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.c=
om/t.
mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 4 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH v3 1/2] dmaengine: axi-dmac: fix possible race in remove=
()
  =E2=9C=93 [PATCH v3 2/2] dmaengine: axi-dmac: move to device managed prob=
e
  ---
  =E2=9C=93 Signed: ed25519/nuno.sa@analog.com
  =E2=9C=93 Signed: DKIM/analog.com
---
Total patches: 2
---
 Base: using specified base-commit de7d9cb3b064fdfb2e0e7706d14ffee20b762ad2
Applying: dmaengine: axi-dmac: fix possible race in remove()
Applying: dmaengine: axi-dmac: move to device managed probe

I just applied them on top of dma-next. The tip is:

("dt-bindings: renesas,rcar-dmac: Add r8a779h0 support")

- Nuno S=C3=A1

