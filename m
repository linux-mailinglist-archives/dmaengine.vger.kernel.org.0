Return-Path: <dmaengine+bounces-7903-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9DCD9856
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934C93072FAA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040892BF3E2;
	Tue, 23 Dec 2025 13:53:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777AD298CC9
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498032; cv=none; b=TZqbe8s+SEpOxbSrb9Occjf52OnQOrJ4p6Y3MEeqYcpDni/PbDufI5tHDpNyQYw0h1wMafkvQ7SRT3cOsxWI7t6eSaXHy2qz4OmxwLvnszvL7n27EO+F4m3D7eJeahBU84fHUEUe0kWgLiUnnShMAvmkCifksxOKEIHtZhiou1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498032; c=relaxed/simple;
	bh=a8FMrqVjKhSh+xBRWMkzRxeow3Vn9zz3nJEF4GxFrcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K99fLBnte5tgp/r1xvsPDaN2kbJkc9ItML2ahXzVxdHxAqcR4+i1u2mJaamldLerRQ/uXqzxnxzCe4WYRLC6ZoxFGtf9mHrvZS5q105EYocQlPmOpCtdB/rc76YTaMjmxQcqq0inmvLBvXp8ovnrweZAbxp4ApBl8xxrEaQcpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b73a9592fb8so944803966b.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766498030; x=1767102830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+ixeMsLCpQech4lVzSsQCsVyCManj4ccnQ8O83w1ys=;
        b=fqEKefDvPbfymRZGncOHN4mi4KxzTVDcmkdpJxAhN5QUdmMFY+ZATi3C5KDyZlhSeh
         y+n9YEz1i59069lnGQszvOlGGRZyCugjTxzsgt+NMyHtfFwQ9ZLmQK9bMcls/my+W03j
         S/npYwPyTskOVWUOkiPlTAq2ugFOqVoijohV6fMdsj+zB0jWzXxKs/DZDk+hxHW8bbNx
         Ts3f0ZDNbGn6kUF1tRaEormHJgtI4/Mpv20d85ExSKK1IlbRLsNd3MjYRctGeoux3tnQ
         L+YK5nTEGdLGIdRe2Cd9rApHWrWwBeRC/FeDqYUo4uOOiG/tT0lyAkGX4gepoPXSLpTD
         tBlg==
X-Forwarded-Encrypted: i=1; AJvYcCVmn6goCsA/eJJIBmD1HlFSMOrpvHbeIQioeloOJl0LcpRtiHE0p0/m0gNLsOPizySPf18Xlef11pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUzlNVqgBv1rRjebpfK5/0QfK9DF5CXZquaOVyGgyJDb0twnY
	XVVlS/8ZucsjFI4aiY1mQx/326y30R5mPD1RahvZINLF1ozGaPdgbgngkrA85J09l7KjTg==
X-Gm-Gg: AY/fxX7oYy0yvyudivHJLgzuGu1O0UNsPR5XfMrVRE6AjXUautiHfii++xdCyZ3RN6X
	y5iXgR7hUPQIdIjUCRrX/n0O79b/WllsNhjTy32j4g5c+Th1mS/oBfDh+Nxpp4C/y+vWzTPbS/h
	yQpmkB0Xz/CRkRc8UmwU5v5tFwHgID7DQSM2SZ2rIpgXP9ASJEZEm6TVOzibUmiDUbwW5iKwPWD
	eMqlbPxzGI+kHp8I/TLTLqNhKmIxBhync9pyqGibD0H0p+59OHusS7356EC15tIHv7DWt4T7OO4
	QZRL9aKwNa7TWSb1wOUCagAly4shGkLX/7yoCFKYU1Je1lqfc8Rtt47ceAbvIXKvD0Sp3vI4en2
	+sIYIWUJR0wXOlTZsTKT40Ml30e0Lv5/iDSfSCJzMQDGJsOgVrxQb+WeqE0rhxVQVWH/ZK7vQMT
	aFxZHQ/ZF4ew+FLTIEao2iGlNDOAbQCXq5khoK2HtNOjJ+MQUc
X-Google-Smtp-Source: AGHT+IFYOwU+Xvpv8tup9OBBQcDuI1Ci28BfMKQeJWwLAbUqMHVgTDd32oPbpEuVT70a1QvnZgX75w==
X-Received: by 2002:a17:906:ef09:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b80355b2500mr1798966266b.5.1766498029732;
        Tue, 23 Dec 2025 05:53:49 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0cea9sm1378542166b.50.2025.12.23.05.53.46
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 05:53:47 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso5299604a12.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:53:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3MGcYWSFvFHCfLRogYELCuscjqIR1TyQElwGVtOzC6M5gr3Ck+ApZvtswZF9xV36N+XZjCRagRvI=@vger.kernel.org
X-Received: by 2002:a05:6402:2711:b0:64b:a3ea:5086 with SMTP id
 4fb4d7f45d1cf-64ba3ea565dmr12657162a12.12.1766498026801; Tue, 23 Dec 2025
 05:53:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251201124911.572395-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201124911.572395-4-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 14:53:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXoeZRztr5vw=ApkUMcBFejTPdqTp1B7H_b4BCrp=CTxA@mail.gmail.com>
X-Gm-Features: AQt7F2pPAdRHTEKtZTIpjA8opdNaxGZqUaIcqPY8S0hZ4lPuFl8ZXn8vjc6i4OQ
Message-ID: <CAMuHMdXoeZRztr5vw=ApkUMcBFejTPdqTp1B7H_b4BCrp=CTxA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
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
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three
> DMAC instances. Compared to the previously supported RZ/V2H, these SoCs
> are missing the error interrupt line and the reset lines, and they use
> a different ICU IP.
>
> Document them, and use RZ/T2H as a fallback for RZ/N2H as the DMACs are
> entirely compatible.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

