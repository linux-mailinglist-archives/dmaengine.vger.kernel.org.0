Return-Path: <dmaengine+bounces-6033-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436CB2740D
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 02:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD216805C8
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348162BAF9;
	Fri, 15 Aug 2025 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NXDusvXL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A238DF9
	for <dmaengine@vger.kernel.org>; Fri, 15 Aug 2025 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217719; cv=none; b=p0YQqGUBXXQrFu0CBY+Kox9UpTNgmpmo4KFT0FmkUMsFM9dWemgB4Kalr2nXo7ULsizhRuYvDl4MY2tuA+wwqKu851mrAGGsYXVgfyVYwFpoa2zL5/aLSQtbojjDIRG9ARk0aAqsL7q3pbJ1wmOBXxAA54NYrL+u4EdhvtUHahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217719; c=relaxed/simple;
	bh=yVKMqWKrf5rQ1fctBmoCT+YVt0KEBHfv/Hl5qX2iIME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afbgH7DEO9KgrqkCQFEkKKbJNUciSYW1jBIG1ikhB1ibFteMjvRtpi401MoFVR9SZ155/wGuPTJydbhwzQJ8hhbpBPowHXYfs9oe4oQuOKHaecj8H7ZLDxwwSY7Vu+m7FX1ILDp6WCEQ5c8sp1wnCRsBN06OgmPYoH4ccGC4yaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NXDusvXL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e931cc1c508so1655958276.2
        for <dmaengine@vger.kernel.org>; Thu, 14 Aug 2025 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755217716; x=1755822516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhYHAOHHcTMvb/JsfZaG+H6/8e/UtvwiyrLLiJuYoaU=;
        b=NXDusvXL6RDgCRCDxKUzEN3WI/0qcEQ2PSOIsIplk50EGECaDRzbcUDEU3Zly74X6b
         SPQOPIrjBciSruYWWrG38SLwXySiwpcO+bGJOGrJ0yV72ChYATs/Ubdl0+/YwT5JBt+e
         T4lZPNS5vSdQgeq7O1CL4Jkjld8LLC4618XEjFGDObi8Ddd+u368ArYvz/E3wGH/Csvt
         NaUwTP2vssEsTWD0ED5gbpJTEOXHw6XhHMnk7MVmVe69ZPaD5zdhXD1BAv82PI/HJ/+G
         br9tNcr1lb45TBfub/uy9cnqllsnE54QUx+M3lHw4pkTqMEzbYT7H0OJgZraD6GGk7XP
         YRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217716; x=1755822516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhYHAOHHcTMvb/JsfZaG+H6/8e/UtvwiyrLLiJuYoaU=;
        b=nMPdlD6kKd2HFWy1kAbJr83ItfMuTC9M3SeyWvJjN+d0UkmczcbFTe0mll3Q6O0Qfy
         +tFtunnVG1UHqaxqkmKDWZvWs9e7uVPnxoyOnyGNKWJlwsSIGyOYClQ482eK7h8p4+RS
         OhGPcZj28qDsyfNOVB4EdfO7Gh6fH/xtQzMmhP2fFN8Oaf3iChJL4EasXtDbAUfX9oVX
         rHhGmJoTPgp7n6dIbLPOwQ2UNWpoAHIPcZJD5n+UCjeFAH9TTd7sFjiIcnzpQg9hzZ4p
         0AfeQrhfmDtEnQj1VauTqOcQ/ssnm5sefOLyMU/bcB7dHA9U4LU0h0l5Yk6M5ZTpthM7
         4lsg==
X-Forwarded-Encrypted: i=1; AJvYcCXcUmObqjI5cmQw/mXx1ZwKSNHOlBfW1VTVVunWxEobD9htKwtFnETyVyBUcrIbrBDqGQ7XvYDH9gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNq2GQZXfXL8NtLwNMEiJEP9wo4a6Gje7TJYxMIn/JdsB3K/va
	t015FdVHHkHWr4X1xoZ9eW6GCfmvxE73ck0dDbgyVDsjpn2FFJCbQB2icMI/WNw9MpgLHerJ4kD
	CZuw0LX4V/XDQooqmhdSvrk+rL+6uWnd71l1PplQMHA==
X-Gm-Gg: ASbGncvaYYdyDF8u0ywdqKHoiqY8uwVHvwvdngUq1PHXPEbJ5vuG/1cdsmZl7fzE5wm
	LGDFZ7zjTBIpBmvs6Xg/7FC+P3PJsJi5Ifb2bXTnQIImG3/jN3KLjAVJl0kvvDWRf+0cSCoKjH7
	Ppd2wyAA1H9MXyxYQChqnluKIvM45GKxdRaV9YM5TEBfnK7qECOufppHL9AJ6zqgbkb4rUMcyxR
	H5vsJ2g
X-Google-Smtp-Source: AGHT+IEWHgZsAdK4qEvDGvsR02TXcwc61mkjg/mahmDjUByNY1vc8hT9AhSsb4gPaZW5ujgSq5lJQRMSMiPVldUmqB0=
X-Received: by 2002:a05:6902:70f:b0:e93:2f07:3fd2 with SMTP id
 3f1490d57ef6-e93323846bfmr333872276.5.1755217716217; Thu, 14 Aug 2025
 17:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com> <268633D49B18C3E7+aJxMHPhItPq9ioto@LT-Guozexi>
In-Reply-To: <268633D49B18C3E7+aJxMHPhItPq9ioto@LT-Guozexi>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 08:28:24 +0800
X-Gm-Features: Ac12FXxnSnbbKz6jQ95n94znx3YpWdrJ0lK8qAhRBPKv8TxP7rZpNGXhbYfh50Q
Message-ID: <CAH1PCMaMm+aDXG4AfPbZ_iJQW2cuKY=VMU2_C1k6Vi3cBBSthQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] dmaengine: mmp_pdma: Add SpacemiT K1 SoC support
 with 64-bit addressing
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:26=E2=80=AFPM Troy Mitchell
<troy.mitchell@linux.spacemit.com> wrote:
>
> Hi Guodong, thanks for your patches!
>
> I have tested it using i2s and dma-tetst.
>
> Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>
>                 - Troy
>

Thanks Troy.

