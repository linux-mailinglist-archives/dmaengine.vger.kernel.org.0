Return-Path: <dmaengine+bounces-1033-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49699857D15
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B91C24485
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F4477F25;
	Fri, 16 Feb 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwv5QaAF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B011292CE
	for <dmaengine@vger.kernel.org>; Fri, 16 Feb 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088497; cv=none; b=eAL2sF041r7/7jXaRtKfk0zypKE4JF0fJXCmhzP72mwUcp4TUrZBSGI/OH3QJDJWgrlxPkV4L0eTnwHCA83+ue/+/BozKy6JeajepxTNSRgIeJsUQhsASdzsj2rVhZqOao3VyIp5iuKWBYvN1J297zhxzj4wgwdRl+hsol43SXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088497; c=relaxed/simple;
	bh=r8evepnKTdo5eSVTlP6hiRimjsynuUHwqD8ImaiPr94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c0ULV3G6lBKBnO09OU8qdJBqxpMVfcgWKAMS7frW/M8Ew1lAOH3ooc9XFxVQ/HH19GZgU7ESofWYeeJNDzxRJ50X5kv/vU5bl178vD/KNI9hsLe+oUJxCWmYtlYJPmTxvXVoEhw+N1uChvvb6134uhi2S2L7NlGFayhLUYmbQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwv5QaAF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso4625215e9.0
        for <dmaengine@vger.kernel.org>; Fri, 16 Feb 2024 05:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708088494; x=1708693294; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iQmWZKKSDqNbBGSl9IJ3yHfxwOBvYZqEicdX+texpws=;
        b=Wwv5QaAFgUFrFFODWnz0a+nw3qnUFyco6Y49rAiuXFfWqFhDvB1eRHgVsMqCtpgs24
         WaQVnBeB764Pcd5pB+9P8dPUCo4inPcPqxjoDdFBUbqiX6M5rcpt6XEaXSs735Jsscuk
         1/tT2UtFFOjUfr/1ViIYcx89uCdVcxXg3AcvXnSBk6lkF9CoUvIYptiYuZRXVEkTIHed
         NZolPUpeoGJWNhuGTDfLagu+etH4g42XExQm/aTtnFaLxo7wRd8KBzT8KQ20AEwTx8Qf
         3ZEoJrLsHjThqo31DgC9T0NS6qyOdl6iJbrCbzGeU+kTrX4AMexxKY8r9f6u2DIMdTY6
         qR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708088494; x=1708693294;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQmWZKKSDqNbBGSl9IJ3yHfxwOBvYZqEicdX+texpws=;
        b=KTb2kPt5fZJTHveyw6NbRnkrQhNXKngnSkbQjzPPLiLWU1bl7YT3mhXrXajuZwsRzz
         vlbofwaL/S1xLs+B8XcSGCNXyGP6HRbwGh+yPFBJLcfe9II7dmkN8vrwOZYpfXkKUaTO
         lrpR9xsqKNUkx+ZTxM7QjUpvh3myYXEptlCtDOciP/BJX+EV44WibXw+Kfe85wWP6q7+
         a9wrbDuEa4IPYq9FfPOZN6ZL8lZMIX5di8UOa1vE4zEng4tHYZ18j+EWAS/6tFkkicKW
         j337kpVP/68zeDqKiyo9h9QRZ9SCfGF1SU2sKS9bYL7ixToqw/lCqwaQ+6Q0PYIYuuCu
         pF2w==
X-Gm-Message-State: AOJu0YyUHSA1fdSZBBDtWRnZm1MecFSCaW55EFL/WYV8nutwRoc8I2+l
	rAnxNzcuDaX8Jyy3YEcUDMyeQsvGOmZwYxBL/YysbGpige0vSF+chxzZDVWKizbv6w==
X-Google-Smtp-Source: AGHT+IE4U6WDitPfBIbNEmk2s5LBfnEH28RU91KCepV5OvLYNwkemjC/yux2tNVUgFtSIqJ0BqonNw==
X-Received: by 2002:a05:600c:5246:b0:411:bd5b:d5e with SMTP id fc6-20020a05600c524600b00411bd5b0d5emr3305049wmb.17.1708088493806;
        Fri, 16 Feb 2024 05:01:33 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b004117e45f12esm2308303wms.22.2024.02.16.05.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:01:33 -0800 (PST)
Message-ID: <5168655a6e6b522d80c30d66ad733ae2fe547d8c.camel@gmail.com>
Subject: Re: [PATCH] dmaengine: axi-dmac: move to device managed probe
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 16 Feb 2024 14:01:32 +0100
In-Reply-To: <Zc9TaGFInAQA-Zik@matsya>
References: <20240214-axi-dmac-devm-probe-v1-1-22d633da19cb@analog.com>
	 <Zc9TaGFInAQA-Zik@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 17:52 +0530, Vinod Koul wrote:
> On 14-02-24, 13:29, Nuno Sa wrote:
> > In axi_dmac_probe(), there's a mix in using device managed APIs and
> > explicitly cleaning things in the driver .remove() hook. Move to use
> > device managed APIs and thus drop the .remove() hook.
> >=20
> > While doing this move request_irq() before of_dma_controller_register()
> > so the previous cleanup order in the .remove() hook is preserved.
>=20
> It is good that we are doing this, but moving irq to devm doesnt help a
> lot, there exists a race
>=20
> I would suggest you use the axi_dmac_free_dma_controller() to all free
> up irq explicitly, that will ensure things no chance of irq firing and
> scheduling tasklet when we are removing
>=20

Hi Vinod,

Hmm wait... Before the patch we had:

static void axi_dmac_remove(struct platform_device *pdev)
{
	struct axi_dmac *dmac =3D platform_get_drvdata(pdev);

	of_dma_controller_free(pdev->dev.of_node);
	free_irq(dmac->irq, dmac);

So, you mean that there's actually a possible bug/race in the above? The ir=
q is only
being released after of_dma_controller_free(). So, I guess I should not mov=
e
request_irq() at all and then I can still use devm_request_irq(). If I do i=
t after
registering the device then it will be released before of_dma_controller_fr=
ee(). Am I
missing something?

Thanks for the feedback!
- Nuno S=C3=A1

>=20


