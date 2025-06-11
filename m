Return-Path: <dmaengine+bounces-5348-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5C6AD4E67
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B09189B8A1
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2E23ABB1;
	Wed, 11 Jun 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfqRcl/D"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E85234964;
	Wed, 11 Jun 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630619; cv=none; b=REDNDT2I4GmLm+y5cfninUXBcZjSyyK30cRC7OTxAle0uJVHt2p2UX9RRQ3/eVSwVu8KJNdnfZtft3W5vlaFHW/Di1SERq6Q7Mjfkm+fTWDY3Jq+t+RHyQ/vBZ8bd5clWTaQ/axIpgBi7Hl709U5gKGAI5Lmn65GdU6wBFauHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630619; c=relaxed/simple;
	bh=jZ9Hv45HUZkteVQv6ya9VOMC0pxuG2odAMafRrZj2qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0Lb1eg6E+RKuBDENvB0oWP8Zzhxuw6z7hOC2JAjxlC4XiWFNPP7LP/TzvC2tSUJtzES0sUQOLE8cjSoUfEVFKt86l2bKfmOjyOKWWLdwzorY0HzYh6Je5zu0z1XpoBOkAeLE21w7d6rz0miisLmnELax4BafWT4ZGU1f5n2mzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfqRcl/D; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d3862646eeso220134685a.2;
        Wed, 11 Jun 2025 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749630616; x=1750235416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcSP2lVjFJ/bu0C3VkfzSJDndgidRs2bj0/IW68A3/k=;
        b=HfqRcl/DIq0pEUqS+MFGATn8ec+U1Y+bKQiSbrJu7oHVQExgo/lMXlmpIEfxrgIuEB
         V3VxFLApqvJgv1wfGof9mXeVK3gY/YhzBj8cWCffp+XEUwalaOLci0mUuBT3uroxYvKJ
         0bhEAQwGs6+NxEyFISxAX2772plxzh6XKtSO28B9KOqhqT7RI0P5fiNWR40ZSFbAhVQJ
         FvOEOQMZdFlYCsDdHzhxx9p+oAIuOB1HNqDDgHbEV/uioRy1lMSPsZ01B6h5Qrc6neRd
         7Uw7EoHpvWEwQbuQcHAFLgZDWX5mSgqBZSuEbp/NqovMvxM2XdiPk7IfDRLJdVpPsXBA
         hrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749630616; x=1750235416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcSP2lVjFJ/bu0C3VkfzSJDndgidRs2bj0/IW68A3/k=;
        b=U+54/Bttd6CagRgqtfUJZY7c4AmBdnsIAVQ/WEuQRcNJVFY18o6LiFtLWW2cMGv61J
         Wn1h9tpZy1cTf6xiiL5JDJcPi4KvvhFnlRSbq3J0JwCK7LFc0LGYb75MrAb0iejk6wz+
         VOSTkchiKgWxOscg6zn1E2+xBNOJNfpeYfRKoVhjNXMTH0nwllkoZRYVrn/0mE04kEUV
         TxgWBZb8Gq1CHKsX17PbNFsxab7altRjh7PZvGtJy6wiTyMk6+BStfBGKGb6KubOCkDP
         FCdsVUM0zyzwl+aigasr3Gx2x8LUfQqodbmD+0CQc0aeLBq9TvilNjrtYpuxebGMUTCh
         gGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK11/wROIWXFIcSSu3zx1Zg5ShhvTFFlsNpLDWAFNLJCuElnZBmg2UmAKJwRrONpkdYjpywZB2QOF04ksh@vger.kernel.org, AJvYcCXRs4kSRSsFIUz7F9ONn//+qBLItaIfzalbV3vP8pwJrcxXr8ZTwiBn8xIe128Lhk0BIRZcGOQ9H69V@vger.kernel.org, AJvYcCXoYCcRsNDDIVs1V2lfTaxKqhKhUoRg3YJ4a5vDDX1uaMfNwwAiCiQtiQWSEWtiID49qT6VXs8spXQ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyay4kU51ZsSRU1jxHMbB0LRsytRneGMRjBpKsxfhaETSsE7qfF
	wgHiIJM4xqzfoTqavsJe0YCce23B6zU0KR2VKRFBA2ZFRJSYv7JwMIyr
X-Gm-Gg: ASbGncu7gcUn43TgNnEjP0lfMDmQe/mR2TIelgt1IGeGDWyUFHRmbuCcLtmDHC2Pf+t
	jukcg0xnYv5DxHmAAzWcFDubJnxA9NAPdndDHSi3w4nICt1qJwtYFtYo6hQPCGwuhBfNrFWnmX2
	h27BjxWJAYcBgtiOXIGnm2RQEchQOT1wrrzNrg/n5x13maYdhtaZoH+9IlCOLFSvWLjkcboUMPx
	OxDB1Ousqv87+q4j5US0yJU1hglDFpXxxJW8Crdtqs3Dx5MwyRAI8zwBVkYub7wbVIZPE1/gNOI
	vQivOVrUyBoogltNfvzFK0L3uOvbfcy2/n1re1jgFEicBKJC
X-Google-Smtp-Source: AGHT+IGCumupGFYJr2miTmB5pZGshAqhyq5KGLzPXAmspYahxEndxqWSVq6p8juUyI8Wq6JrkTAl1w==
X-Received: by 2002:a05:620a:2489:b0:7d3:99db:c4c with SMTP id af79cd13be357-7d3a8805820mr382875185a.6.1749630615951;
        Wed, 11 Jun 2025 01:30:15 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09b2a085sm78890866d6.82.2025.06.11.01.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:30:15 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:29:07 +0800
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
Message-ID: <2v4hfzqgz22k6s776onexnhd5cnhfr7s7ggvcmh4mfiviigq66@a2ehkwbv7oll>
References: <20250611075321.1160973-1-inochiama@gmail.com>
 <20250611075321.1160973-2-inochiama@gmail.com>
 <20250611-brown-turtle-of-election-87c324@kuoka>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-brown-turtle-of-election-87c324@kuoka>

On Wed, Jun 11, 2025 at 10:19:49AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jun 11, 2025 at 03:53:15PM GMT, Inochi Amaoto wrote:
> > Add bindings for the reset generator on the SOPHGO CV1800B
> > RISC-V SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> > index 1d1b84575960..bd8dfa998939 100644
> > --- a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> > +++ b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> > @@ -17,6 +17,7 @@ properties:
> >                - sophgo,sg2044-reset
> >            - const: sophgo,sg2042-reset
> >        - const: sophgo,sg2042-reset
> > +      - const: sophgo,cv1800b-reset
> 
> Keep alphabetical order. That's enum with previous entry, btw.
> 

There is a small question for this: should I move this before the entry
"const: sophgo,sg2042-reset", or before the first item entry?

Regards,
Inochi

