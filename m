Return-Path: <dmaengine+bounces-935-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BC847574
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088FF1F225F2
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDF1482F9;
	Fri,  2 Feb 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b="PGUSzw+P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBB61482F8
	for <dmaengine@vger.kernel.org>; Fri,  2 Feb 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893036; cv=none; b=AvGxWm0/45fUKk+0QPqcgyxlssPqQENBk5t98McSWVC9MV2ZUtYCxif0XekaSc+yLurG8ma67A9sERNteRdElthnbyU+Q6S0VtRqQCRWhDpAAPtDJ25U1BmRa7f1pq5gTMCBHcMBIvnXsgrA7mZiulD9HkSGZOWIta8EQeLNdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893036; c=relaxed/simple;
	bh=fDK3fO6SzLEkn0PyA2smu3PbHzCIqdjXGL2c3LSqC44=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aIq214oQxy03BsYUW+TlH4/9CcuQwbZBvCkYKrHXk84uRcatazcLf7eVCI7S0CjX33hWqRm7pGtOQTb+1ViWRv/Q/iIigyaI2ydKpVra1RLoTYzmV5FAXxAP+8pMmwqDnUQxSoExxssDk4l5Q22GiPdgATHn52ny0FIqCqFnhYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com; spf=pass smtp.mailfrom=gigaio.com; dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b=PGUSzw+P; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigaio.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a370315191dso113092066b.2
        for <dmaengine@vger.kernel.org>; Fri, 02 Feb 2024 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1706893033; x=1707497833; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/j2yffF9APVtday5fePGXWrTMYep/RttzWXs8NSL4Y=;
        b=PGUSzw+PaV/AUdpHf+ofvyyPIkI7hB8OeC/QpuJijkq1VYEwc78bBzRRG+QKXvx5gP
         YwcLGs7g4qBrvhdBxz1anJ662YPhxJkPg4bULuz3oQVNUYVe1pFFQtvMZp8C2q2LDTId
         0D/K3Nxp/A1Wev77WJhym5bm+QCnNVc5fV0HLQ1Bi9GfnnbQsLW9ahF8yYiJwS9SbQxJ
         DW50rZ3mg3/4y4tpiP385iXmS7OjTN1ybl4evV9SMxGZAmCLEaBo8Wbl524A7KxttCym
         hVxpTkamK2nusWGLNYAuO0TXgDW6FARlYEVigZTD7Vm9+xRrFQ+nMa8bjVuh3hghnlzP
         lHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893033; x=1707497833;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l/j2yffF9APVtday5fePGXWrTMYep/RttzWXs8NSL4Y=;
        b=lnhgBRMHXETsotaJS6KA6J9ZG7v3ArGCvYMwPUPUqYD+ZOdnOqTD0TaHpMMObrvw4C
         ISNnU70JUNCkQUr1Vi+2PMngAQz4KY7NW4aU2+4D6EG7Nw4sd0SSeiy1qBgmmZbazVk8
         S+lCAPBiL5CAg5i4TOtgA10ZQ2DTIlyt0e2iwiK2/s7w+aKee4zfxlg1sW4t+R2Tralx
         eFiAEsLssy0A9+hZrKZsCRbgD9fnWrRVQcLLgXJAWI127DTu7y9EdXXh2IrKpmSumYo3
         h8bjLY7n6Dfwesn3+9b9z/SWSUKpNcJIFdviqCMK5xRZRrc7tu6YPZoD4/zlVxHJbGuj
         cf4A==
X-Gm-Message-State: AOJu0YyCvL0VgWNiPAGML5uj0h5micCkpQUaNdyoHuGR0GUk1SXwhvPy
	3v9P8e3TplzqEbKjTsGuIeaU+TTp3TYYtcAEzXHMNbUsf83pz0j7nr0tKMcuvtM=
X-Google-Smtp-Source: AGHT+IGuFgYOFuUc56jQOFR7ubtKGaDB+sFkQl2PqLIAWXKZ9jk10FiP5P+v/t2JFhMf1qY/W9T6dw==
X-Received: by 2002:a17:906:7f17:b0:a35:65c3:50f7 with SMTP id d23-20020a1709067f1700b00a3565c350f7mr4168000ejr.28.1706893033048;
        Fri, 02 Feb 2024 08:57:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUL29IQWmaEBmJeO+3JWP/VTWZ/4dk8Vnzrz/7/hjZW887rBEbxLbG3EsBkUxXWaRiIbiLvnW39969OJePOh6iOROyRR1OCaGmTNsi3unbNezNytujmjMpcXPsBgA08G/FfYpBHTJQprcne1Lu6ueZkPkQu1i32NcSojFulUNiLegUL
Received: from [10.0.0.11] ([46.151.20.179])
        by smtp.gmail.com with ESMTPSA id wn7-20020a170907068700b00a2e9f198cffsm1047379ejb.72.2024.02.02.08.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 08:57:12 -0800 (PST)
Message-ID: <1f0cdf3c-be91-427f-86eb-4982de13e446@gigaio.com>
Date: Fri, 2 Feb 2024 17:57:12 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sanjay R Mehta <sanju.mehta@amd.com>, Gary R Hook <gary.hook@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: dmaengine@vger.kernel.org, Eric Pilmore <epilmore@gigaio.com>,
 tstruk@gigaio.com
From: Tadeusz Struk <tstruk@gigaio.com>
Subject: Using PTDMA driver for generic DMA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I'm trying to use the AMD PTDMA engine for generic data transfers,
but I can't get it to work.
It fails for me with "ptdma 0000:52:00.2: PTDMA error: (null) (0x27)"
which, I'm guessing, translates to "ERR 39: ODMA0_AXI_DECERR"
After some research I've found a note in drivers/dma/ptdma/Kconfig,
which says that "...this DMA controller is intended to be used with
AMD Non-Transparent Bridge devices and not for general purpose 
peripheral DMA."
My question is, what is the "ERR 39: ODMA0_AXI_DECERR", and is it even
possible to use the PTDMA engine to talk to anything else other than
AMD NTB?

Thanks,
Tadeusz

