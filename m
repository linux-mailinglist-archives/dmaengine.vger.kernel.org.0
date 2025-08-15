Return-Path: <dmaengine+bounces-6032-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45221B2740C
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 02:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF65E3A7CA0
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 00:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92481C6FE8;
	Fri, 15 Aug 2025 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="IychTDyE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C61BD9CE
	for <dmaengine@vger.kernel.org>; Fri, 15 Aug 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217671; cv=none; b=p/0tvtvIeVVB6ldyfbyfgd8j9p8k44S0//43ZKUEMqX5IcUh163UPMyTizXviO605JpXO1kgsTMcfiadgg5RbUj35r3DK1ukEgF2sFMS+pNcmE7qqa6u8lGSBiXTyZvS2X45ClnuPcrV+mH0/pk4uwW7XOAfY5RHmjl/s+1EX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217671; c=relaxed/simple;
	bh=X8L6NYOi7CRlSxcL8t2PnnNxl7kf+iXyLMU7O1KY670=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQdzChAkxhooJXLw32xi6aX710VnF1Pd83FMMxUi5vx99cUcMu5d79pgSUM9ZKzUYV4j+RQPkOTvxj7uVWVBh+Ffl27qAY+/Z+4buXtqebEvIVBwwAJkLmhDeEtyKXSzVfkQu5jeraoKd3YDJ8zByZvnDQV1uDHD8RFphc2Rb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=IychTDyE; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e931cc4c572so1493249276.2
        for <dmaengine@vger.kernel.org>; Thu, 14 Aug 2025 17:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755217667; x=1755822467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUCl8OpntS8ItAPbimfsEK2ia5Dsdkh5KT5jw4r6KqE=;
        b=IychTDyE8LEwUC0ljnzrLg8gSJm55v46fBpcDL+JWDHlRkK/17IrMbHs+DOfahXB4z
         qgssZJThVGUc4fZIH4huAaXEce2nJy1QveB9AkbpnP63KeaQTS9LzZ7NlCfz4AzP0e8T
         ZmCxf3nZX63yxKt47sEe/Y8clQyYm0bxXkWUyNHkRFEoO7WxZxPYC7QxFR+kX6kxibxs
         GfwJ6PuZpKNm4EBVy5nSMtfw4eEWEFDUVxYPMLCOV5Bbti3Yv+2Q9+lvO+kcxpkDqmLm
         X8w5jYcsd5gEUQunQquM20wQ+7RdtT91eDB/VQ6RJZHPi/P3nWLlJHuhL7zkOroyqVX7
         ehJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217667; x=1755822467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUCl8OpntS8ItAPbimfsEK2ia5Dsdkh5KT5jw4r6KqE=;
        b=NF5j+9iJGpkvsPAVrGf+pp93vfUJxd/nCY9WTUr+WSXqzwDWze9xFu0yKso3e0ZnSN
         eLk9P6rkErwHooSmCgD2fC56SsmVQSk2ZS+guYqZ7UIdcAW+cXqFU2gu4AqzEdEOS8L4
         3ow+IPw0yncqQ1bxZtFwbcPWQ9a1rxhAa9b+XTVODAw9X0ZRU1Rp1AnjUssGJv4+Fmx/
         3IwJmdnWj16fBa6u9bco6IyNxOnBj8F4AJApw1P33d3dXfy6Ivx5B9ZkOSmIua0j0Urh
         TkCtnr8oZblBM7jdPn/U7QCZwAa/x8EdZ4Yk58ZlXAmVzGcWIn/b0ihgommA5iltmS56
         uTig==
X-Gm-Message-State: AOJu0Yx5+p/BZSUffdrwUuksfGuDYKGCvDKdB1blbvpkwKZ/87BsIi2F
	e1wnX0ijnlcA3I1hOonQRbkEUH7k4Uymzp30P5eWURuPI9e1RzanGZbhNp12QHJD5CIppgOesS7
	c3NXpsppIOUJdb25geDgGFshLQarLKHqcfZV1NnbKmA==
X-Gm-Gg: ASbGncvtbs95FdbaNPx6HFFSNn6FINJR/xo/V7fhoJsQEGFUf6Huoo7L4Vu4BdMWg/S
	JWYCq5P1VVdhjNFwqgpRvHFm1GFe1X7kSF+3aidueB2ayGL9BUK9b5RSE7qDmpWtu0hUQJTOLDU
	ck3v64yVf5jOB1IGudyptOlqb+SsAHmorLfb5wh/y25jPUpQpVVD7g6mbNWwrm7W/wAZmseS5Qh
	Fk1U+m7
X-Google-Smtp-Source: AGHT+IFr4Z98dVmGfz60J9x6/CkZNbrFkAtGVlc71VNieoJ/ZNAByVYswqD8H1LwHZHBqhIOt7I8+tOkzgyQcZyNca4=
X-Received: by 2002:a05:6902:270a:b0:e90:8278:5f2f with SMTP id
 3f1490d57ef6-e933251c90bmr227607276.48.1755217667411; Thu, 14 Aug 2025
 17:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
 <20250714-working_dma_0701_v2-v3-1-8b0f5cd71595@riscstar.com> <175255113305.1485.18050987625765048681.robh@kernel.org>
In-Reply-To: <175255113305.1485.18050987625765048681.robh@kernel.org>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 08:27:35 +0800
X-Gm-Features: Ac12FXwajLIeOVETGqUxgx2qIW1SxmU-t78A8xhxjUwRc93jsVMDeN2uzl944DA
Message-ID: <CAH1PCMbpxUHfFbBCDYYE6F+DCJHyHoesf=9f-Sw0p=147vEQag@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: dma: Add SpacemiT K1 PDMA controller
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Alex Elder <elder@riscstar.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:45=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
>
> On Mon, 14 Jul 2025 17:39:28 +0800, Guodong Xu wrote:
> > Add device tree binding documentation for the SpacemiT K1 PDMA
> > controller.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v3: New patch.
> > ---
> >  .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  | 68 ++++++++++++++=
++++++++
> >  1 file changed, 68 insertions(+)
> >
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>

Thanks Rob.

