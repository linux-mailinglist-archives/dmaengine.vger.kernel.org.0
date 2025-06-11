Return-Path: <dmaengine+bounces-5350-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C33AD507E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 11:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAB188855D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493E02405F6;
	Wed, 11 Jun 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzq/UKss"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0E229B13;
	Wed, 11 Jun 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635232; cv=none; b=iwoTcphnElmSrWcy1vwLyi1QerHkHx7vXoDYqeNSK9eP0+MP4mw2d8ZQAtRTYcISIKO6dJUSFd/4I7pWdSZlnurfDVY2hyDO7zrKJOji5JgCrNisICNYYki5NrQsG3H6fJokhgI6t74LyVlV7WaHG0Zq19wxgAqNjY1kO/ttkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635232; c=relaxed/simple;
	bh=QY+5Tek/02AwNhLeuvLKVoyIRN55q5XqE2CxxS2Khq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWiHID7SxFPW2DOWpiXKeR1xQhmLlF0JhQdCgq4bJQs589haDX/7hVSSajV0XMUEKCtZIJ+ckslg3Uv6es29nXLhzkYV7qT3REyFSy3vII4fVn7xL9bUeVDUPuSjaqwTYdcCuryiN02E3OXVKe/T3kqhzpnkiEA/O4gIyYigEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzq/UKss; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a6f6d07bb5so38529031cf.2;
        Wed, 11 Jun 2025 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749635228; x=1750240028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n9rPiGNTaPA7/GngQM8aAU/prJJW46EXooVz3Uq/Q3M=;
        b=Jzq/UKssfnFewDURRWKfInIsY+4gt6/t3ZjHVjkPetU1Z5y9Sd5bxA5EGxrfAwBMxT
         4HZV5ogXPZpUV47HwZfOJXxQVMFyPXVvo2Y4B0eFVHf7iv67H7wt9SRXVdipBHhMaSUG
         2S37a/jIaZkAnPbWzV8COJyEhNEylfRxuShSx6Upbd5rqO0yz6LH1Ow/4SoOvpcxE2na
         SenaUpeVwtmtfklRb2+zALUeJik7z+m3jhSo0GF8UeOKbecj3BhvwB0INld6x6ExtqhA
         QqZxXjLhgeISm0Bk3ldCfKTULfcrl967XaJYtgl6wDGyCcPOYHCDPEjqVXNgfB5SDR1s
         OZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749635228; x=1750240028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9rPiGNTaPA7/GngQM8aAU/prJJW46EXooVz3Uq/Q3M=;
        b=PxZym4fYipP2ryUely1HMToykdiqUr8v8NdnG6B0lsp2JayAjdnY2xK5gANbl9lJYF
         xI2PSIlXi+ROB8I/SMGEjCIayTjxEpkUFMZnW+IMgDHvmrHwylfQB112YmLmAdh5eseh
         FcJ8Z/Tb8540uARMh9P77LTxWAl+KT8PrPk57DLkzDzV9qozb6krxLqeGsQvemjcMBPF
         +dVpFcrsnwv14Tc0jyyg/2CIqL24b3pEjSZ4c6vyUAQx1NgNYrnNKivtFcb+BvSlSrqW
         UgXQ31BmWzkQgbHu/MNEAzaTYkrHl5RiiMPwPyHhgAp/GGQtG5j6sGDXVzqT7wPQ6OBm
         TEcg==
X-Forwarded-Encrypted: i=1; AJvYcCUqG+2Q9YWosbD3YrwC3TCPNWGRPFSwN9uy/nvzR082Xt1q/5A1Zq/EjDfS9UWNrX26N2Wah9E9XG+nlwLb@vger.kernel.org, AJvYcCV/yj+TOithtZcnEFvwjuYv9Rxs2aSrogtkUcR+Z/YJYatKRNh3Rng8fmk6puTBguiw+N3y0qsRDwtN@vger.kernel.org, AJvYcCVYZbd5F8AkYFQr+swEBNT0yWI2gpZyEK3c5UrOz5vnWKXk0gIymFR6+fKdzfLWIYk/281IPo6jzEN0@vger.kernel.org
X-Gm-Message-State: AOJu0YwYet7EJI7PJUW23X4Y69SWjZOVRylV04FkEStU39bgYVLpS2HH
	IhRnYTZVMJcSaoZXXGhqrmZgCSV2KYlFX6PmkcZEv4wJ8kGH/TgxNeXB
X-Gm-Gg: ASbGnctaux+P8qa3UM8lAhHf9sJCWsFb421LAXZWQZNNfdzFC0I0ixi3TpOK33X8u2G
	zEE630zASaubapLvduD9xvGIjMvcY9UTkeMeVN+NGuHuNZDkDLjUjq1jkv5CMmzptHURT38JcZP
	GIBw8bwn8crswFsI0b29qomBbRB3H7Al6ps/xgODT8g9zTqxI0bj9nRDz9ZX7/GNV0RE2sx4P9A
	36RhEc4NYdRHy6RAdLZIdYyu/67Kfn1c7xpFdXuAN6VsycjhTAIX8Sc/8tnsHR89n4a410YDfEg
	hWb3yHMzWTbA484sVxl+ZV1qZ55GuIk+vTSgrw==
X-Google-Smtp-Source: AGHT+IHoucd0pTsqUEMuvaSjWbfTQOjCUx6k4huksi1dJ/QwFsl1H1FuuHsdR5T8wu60/r37DLUb9A==
X-Received: by 2002:a05:622a:5595:b0:4a5:911d:52f6 with SMTP id d75a77b69052e-4a713c5ecc3mr52302751cf.39.1749635228486;
        Wed, 11 Jun 2025 02:47:08 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a61116bc4esm86576941cf.28.2025.06.11.02.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 02:47:08 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:45:59 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vinod Koul <vkoul@kernel.org>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Junhui Liu <junhui.liu@pigmoral.tech>, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: reset: sophgo: Add CV1800B support
Message-ID: <mbvzlggbisa4zvvbjvlg5lrmhb455av37mrtwmphqiqi53iuyu@ybql2m773x4c>
References: <20250611075321.1160973-1-inochiama@gmail.com>
 <20250611075321.1160973-2-inochiama@gmail.com>
 <20250611-brown-turtle-of-election-87c324@kuoka>
 <2v4hfzqgz22k6s776onexnhd5cnhfr7s7ggvcmh4mfiviigq66@a2ehkwbv7oll>
 <ec60631a-7e55-4dc0-83f7-6e6cb156dbf2@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec60631a-7e55-4dc0-83f7-6e6cb156dbf2@kernel.org>

On Wed, Jun 11, 2025 at 11:09:50AM +0200, Krzysztof Kozlowski wrote:
> On 11/06/2025 10:29, Inochi Amaoto wrote:
> > On Wed, Jun 11, 2025 at 10:19:49AM +0200, Krzysztof Kozlowski wrote:
> >> On Wed, Jun 11, 2025 at 03:53:15PM GMT, Inochi Amaoto wrote:
> >>> Add bindings for the reset generator on the SOPHGO CV1800B
> >>> RISC-V SoC.
> >>>
> >>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> >>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> >>> index 1d1b84575960..bd8dfa998939 100644
> >>> --- a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> >>> +++ b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> >>> @@ -17,6 +17,7 @@ properties:
> >>>                - sophgo,sg2044-reset
> >>>            - const: sophgo,sg2042-reset
> >>>        - const: sophgo,sg2042-reset
> >>> +      - const: sophgo,cv1800b-reset
> >>
> >> Keep alphabetical order. That's enum with previous entry, btw.
> >>
> > 
> > There is a small question for this: should I move this before the entry
> > "const: sophgo,sg2042-reset", or before the first item entry?
> It does not matter where you place the enum. There is no convention for
> that.
> 

Thanks. I will fix it

Regards,
Inochi

