Return-Path: <dmaengine+bounces-3433-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BC89AC7FC
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEF61F28372
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C219E80F;
	Wed, 23 Oct 2024 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGLvvY2X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BC155393;
	Wed, 23 Oct 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679360; cv=none; b=TaQyEd49kN+bgtVMj78XsyuT+dYW8Yt8MZzkVrtcdRlldJC56PpBw36uURX4LRv3yOJq3K4/2NzQc/Fv5rj4s6FcQ7DepJSwQfQ7pNcPk8Z2DWoXfWK25m4zoIx8xGIXt7ut6RDHCNtnZf9vzfW3oT+5A1HkPZEir1p0HEcKNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679360; c=relaxed/simple;
	bh=Gut0VnewNuT0LdmLi16hq5QIvsI+I9WMoZnZJlOfPAs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ghq5PP6Xz6FU7XZsmsJfuMQ4r58nm+3yCFZ+zIvT+QDr6w4g2S7kD9NYK57M9eLSUKtNU4werdqjSXtlsIa+s+110/f3wfj4ZphQzMUHW1SBQaD8ZrL823xMdqiZEXzDIyVUr6Bbfa0gONIewBDSc8aSiARnTUIXJrigmLJ+wwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGLvvY2X; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d47b38336so4521502f8f.3;
        Wed, 23 Oct 2024 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729679357; x=1730284157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gut0VnewNuT0LdmLi16hq5QIvsI+I9WMoZnZJlOfPAs=;
        b=BGLvvY2XVjFH4hmvaimwDv76C123Wa20iKKA3hv1rUzL+6a/0Ah38whQGDZ1LSgMGS
         XfGVKg/Nnj8V+iNonIZSOezh+RqYmWS0jkfN8fhhBd1ZXCLu43IF7SfWOA1Z1O9dgWTX
         t3hcyn9m4Y7x71ET7DrLG5GMRsJmuGJhNyrGytH5GtEiP49eAzv4eaeYMONSLreCFkta
         qIszBx2D0WOQZ0WQneAUleJ0H4u0KIbSI477pPsrY0E4Ay4NJarEzgsRujOIlIwnDAKQ
         oqmqD/1cr25yNR/+ijyV/gIQ8rLGX9Fd9Ce/4uQ5wtD4VxhJf0vUvOOUCkr14TCTCN2m
         ZIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679357; x=1730284157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gut0VnewNuT0LdmLi16hq5QIvsI+I9WMoZnZJlOfPAs=;
        b=ouxYB5VqO3X06A6AWVDDkaRyD9fVIeGdRWNfzuO6mI6dDSiky32gxUjEVie2pE+1PW
         XCnDlmQ6qNUSZ0RYNurWHkDCOYU8BpZJQlyvqwIfUrlezdfB6q6J34RpZRZFKKers5Q/
         xHcM9R5EmAENMkKxjlnPqsvIM8RB6j5XtL60KA1w+KuP1KrJpdgr76mFHAQ7TGKYeHmd
         NclmPQW3a1nkMUE2hcIog4Bie59BGM0ErWhUSYdWBEraWf3YVXh/l6Zm2RMLviKppJZw
         Tl2zpCwCSdrt+B5W07tWCY04F9Yk4xDgC4WdCpSoBWPBgulAKxcp8BxNxSm6YGG1FyfD
         QjRA==
X-Forwarded-Encrypted: i=1; AJvYcCUSsmcNEroJ+sf04nvx4BS1rZ7lZKxRGMi7C0S2DCCYA+3+kvK0MDGXPvSwARtIAKDDkTbDYcUwSWrP@vger.kernel.org, AJvYcCVVrDlR2vupVDxE/wzgZYcBRWFc9ks08XpnCMsDmeYFY9/qvxTqHI3lugJJt2InSGgNhPf/kJI8pbvS@vger.kernel.org, AJvYcCX31zTtVWF89ao8W0Ynxm0ZDcc86S7kaujq4h0FYUDdxLTxerPywpD8ozXfsa1t79Cr9TeX9kC2VyagWsBs@vger.kernel.org
X-Gm-Message-State: AOJu0YynhXeuAphQsm00r96Pq5pEu7UENdixJh807DQL0vd97K1WdN/c
	b06i2kvwspryNAuEKIcJjS57d6Elg4MFDSNQcK8cq8rihltLivAx
X-Google-Smtp-Source: AGHT+IHK3wCNc3RpQVpZ454cZp0zMtJu7nlGiRTUxZethjnQCgS4SELAAgxTJwdbVnWRkrmDEj0+bA==
X-Received: by 2002:a05:6000:ac2:b0:37d:52e3:e3f0 with SMTP id ffacd0b85a97d-37efcf7ba39mr1572374f8f.44.1729679357155;
        Wed, 23 Oct 2024 03:29:17 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a587f4sm8640688f8f.52.2024.10.23.03.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:29:16 -0700 (PDT)
Message-ID: <e58d43d19daea622719f26193c49aa4fcacdaf3c.camel@gmail.com>
Subject: Re: [PATCH 0/2] dt-bindings: dma: adi,axi-dmac: convert to yaml and
 update
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Oct 2024 12:33:35 +0200
In-Reply-To: <20241022-axi-dma-dt-yaml-v1-0-68f2a2498d53@baylibre.com>
References: <20241022-axi-dma-dt-yaml-v1-0-68f2a2498d53@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-22 at 12:46 -0500, David Lechner wrote:
> Convert the ADI AXI DMAC bindings to YAML and then update the bindings
> to reflect the current actual use of the bindings.
>=20
> ---

Nothing to add on Rob's comment. Basically adding my ack to show that I'm f=
ine
being the maintainer for this:

Acked-by: Nuno Sa <nuno.sa@analog.com>

> David Lechner (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: dma: adi,axi-dmac: convert to=
 yaml schema
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: dma: adi,axi-dmac: deprecate =
adi,channels node
>=20
> =C2=A0.../devicetree/bindings/dma/adi,axi-dmac.txt=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 61 ----------
> =C2=A0.../devicetree/bindings/dma/adi,axi-dmac.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 127
> +++++++++++++++++++++
> =C2=A02 files changed, 127 insertions(+), 61 deletions(-)
> ---
> base-commit: 52a53aecddb1b407268ebc80695c38e5093dc08f
> change-id: 20241022-axi-dma-dt-yaml-c6c71ad2eb9e
>=20
> Best regards,


