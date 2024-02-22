Return-Path: <dmaengine+bounces-1076-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9760585FDF0
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 17:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974351C24C44
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EA315098B;
	Thu, 22 Feb 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b="s2tbDZaV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FF14C5AB
	for <dmaengine@vger.kernel.org>; Thu, 22 Feb 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619050; cv=none; b=ULQKHyvktAbwiyQD8uW+aRE2Djm9UfpXY9nj143gWGB6bI30QTNqgUhoecoc5CrrUF8h9aRYBzTDbZLRM5i5VprfUvV+W6PAsOXGkfl4Ma6gTJe3dLxvy91ju9HjnAtJTMRQJ+f/R0F3TtJEr3fM2e/PUqHYQoVWHfN2XW6mLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619050; c=relaxed/simple;
	bh=G8m3KQkWjv7BRhPW611QZ34S3V2Gg7ugNi4X4Ek4k6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhAHHtMvnFUaJ7QpV1S1V6HFdAReSeWN4zgZ78ZqTuL4XlQL+0cv2eBBqMKXNqnlvhZm1H3LVqxE+ul4ByLMzYoyA/LUTVo973tXFLGAVGp6A6hIQ4E3WyJe3a2bSvYm6V7Vc1G3MkrhS/N0QmwJOzpqVjWzktJP9waG3PBNzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com; spf=pass smtp.mailfrom=gigaio.com; dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b=s2tbDZaV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigaio.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so2911089a12.0
        for <dmaengine@vger.kernel.org>; Thu, 22 Feb 2024 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1708619046; x=1709223846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8m3KQkWjv7BRhPW611QZ34S3V2Gg7ugNi4X4Ek4k6A=;
        b=s2tbDZaVnn32tt+5zJlqIVPpmpZJfWulHh0pVWKls/qtSMwTb2VlT6CjqQaHhe7IJZ
         k8pkY9+Fhh9hIXDL1m6xhWG4BzFOtUA+hKIDw/9lGrxpx9LyRycz/8fkd9wdCJlVHqvC
         2Tr5c4u0Kaoh+n106OewFMFOuAPexcoXuUQcrvEiWXl6uAoLY3pGPA9Vsf6U/DW/eoQA
         CSkjeQtFpPPxFLhYiTA61VTUzxV05hrHrH8UFZjYKVv8dRhZBGJ12BVeVfkb0GvWm6Ex
         xYll4ydyfum9lEDipbTivfQcrvNU+X9rPJg53/jJkXyPf4XVOPrx7UGp/Uj5MOyD+wzu
         XRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619046; x=1709223846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8m3KQkWjv7BRhPW611QZ34S3V2Gg7ugNi4X4Ek4k6A=;
        b=D1i+WSe7V7Y1m1FekHZVaGSuok4RV7lnZJxYXcoQpEgGD8eLdDpDntEfi61RoU23WD
         Q1rimxvjLSb9AqXXAt7JoCDbMleRAgg/eANoALBFeR9YPbG9rItn3Tzy2iE94QbxGYj/
         pWmHfNxhIwYITqACMMINky2xLtItDWW7V1L9I6b+S77H2GLeLvkn6NLwiib4xxJpFVou
         5xT7MRozcO1tTftG2WVEg8e9gi7NyjRNFuCr0B9G7Vee3Mm9h3PApVGGnvPZ0yhVobct
         xk2foV/NPZ2YNuEax4QlJMohC1JiYnZvIIJnmpF4ZDAAanxJTmyrsX9RQK7OeLUXzSu7
         jACg==
X-Forwarded-Encrypted: i=1; AJvYcCWDKQnpJc+lbhj7PuAPO3eeM63aWRfvSm5KkiIveEpy+HCuHXIrRuC6MRfcRWzen3ZYBCWIz/ZkGzGwv17bN6egVGituiOLp6xH
X-Gm-Message-State: AOJu0YxYhOQ3btHQvif3Z4atSjOTIjaBmpr1TnZ4umgvHYWC33v9E0hx
	WJ2bKYAmuG9xM10O0bKCQVdrQ9jC2sjMb1gA/Mpe0wnchytyxjlq9fejqPciDyo=
X-Google-Smtp-Source: AGHT+IGzEZi9bsQsyZndEsMep6CrsR+JbJq6VZETkVdaA+y5zYTtO9TwqJ2vjCoLuBPqEDSV/0NOhg==
X-Received: by 2002:a17:906:2c0d:b0:a3f:9f38:ded with SMTP id e13-20020a1709062c0d00b00a3f9f380dedmr953165ejh.69.1708619045894;
        Thu, 22 Feb 2024 08:24:05 -0800 (PST)
Received: from [192.168.1.104] ([46.151.20.23])
        by smtp.gmail.com with ESMTPSA id lu16-20020a170906fad000b00a3d5efc65e0sm4763133ejb.91.2024.02.22.08.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:24:05 -0800 (PST)
Message-ID: <c1467910-760e-4a96-befa-9645aea70b95@gigaio.com>
Date: Thu, 22 Feb 2024 17:24:05 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ptdma: use consistent DMA masks
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Tadeusz Struk <tstruk@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Sanjay R Mehta
 <sanju.mehta@amd.com>, Eric Pilmore <epilmore@gigaio.com>,
 dmaengine@vger.kernel.org, stable@vger.kernel.org
References: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
 <20240219201039.40379-1-tstruk@gigaio.com> <ZddShyFNaozKwB66@matsya>
From: Tadeusz Struk <tstruk@gigaio.com>
In-Reply-To: <ZddShyFNaozKwB66@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 14:56, Vinod Koul wrote:
>> Signed-off-by: Tadeusz Struk<tstruk@gigaio.com>
> I cant pick this, it was sent by email which this patch was not
> signed-off by, please either resend from same id as sob or sign with
> both

I will resend with a proper "From" line now.
Thanks,
Tadeusz

