Return-Path: <dmaengine+bounces-3488-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBEC9AED92
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED302813CC
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4BA1F8191;
	Thu, 24 Oct 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRntNKCC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CB1F9EAB;
	Thu, 24 Oct 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790336; cv=none; b=amkiLnah2Ud6xQ8lBaDDEd5JWLDccI2D/sizbqowEEC4MHTm4j2gSFl+vSPYbTkJcFSE0Pg8j9SMCNKvUhX1j2D33ppflciOAayBndTWIVNuBaEOPIa7Zw/GyPHagZ39KYXleBcIyaBRqaPud5srEPaJVXZeV82axwuJQBAxIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790336; c=relaxed/simple;
	bh=CwW7xf5pVxswj8CHaH7OyHsgU59O8BXxIvlim+vHjF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2crF3romaYhWalRr0/tL3VoEjk7WsA3IpyrYVDohw2LUusnWlmatiFK86zZYpclV+zuT1Td/ztAfL2ahfqVwbBR3vPmxatq8ISZ3m8z/vxtLBkNWD6If6tRzf1wcXni/uK4G05nEMp0aFFH5Q8HXsDwu6V/W6TDAsFVFRRhUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRntNKCC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c70abba48so9906605ad.0;
        Thu, 24 Oct 2024 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790334; x=1730395134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MUnL715/3LxfsngyI3qhOjpz6/8IYCMLAIoj+2ZIeFg=;
        b=jRntNKCC7Ln2nXCDsz/e6/hlJiulI3iBlD5V6um6ZEeyM9Mz1aLtQlA5/9rYiWOc+P
         06kg61lBxWNWowpLrQ0ZIuZTwhFJpulR5Ih5BlYqS/3eJ9gNEAP0e3Z1hz3uCQcW6mlQ
         GjrXoB5mkD8y8IEgoiFDeDIUJ7vw2wY7c7k5Dg0Xfh4Ff7gN9amG8sPJGzKiU3SrPU3y
         xTmumJh72I8PlFFf/wdUgd8mwrCQZ++QiZvbZ2r9m9rHoEmjheDA5SCL3m6kPIloEsW/
         cHIwvDE4Kkfce5e6brA5YZkVptw9KPRS4MfwAVcPvO947fO9YoTbuEp3faFmnaRlPGBH
         HrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790334; x=1730395134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUnL715/3LxfsngyI3qhOjpz6/8IYCMLAIoj+2ZIeFg=;
        b=S0NKjYj+/JNomDY6qkDri2CtkQGb9wXhPlXO7LT2yWAbrwTXBy83MRxL7K/c0Jm8e2
         GRMX4mEVtV+XDy59vKF/LWmkA0DbwXj8LRlaFyunsm9jV+iBCusoJAxUGo3NNiJCAhph
         bv943P8HY6yoda5zcKJVU4dYTVJ0izL/EEEF7Q9ni0rowoO2Tdp6A1APF9G5xNZzGBnt
         g5dvII3iq4I6yg/Z2DpYfeEvU/LGqD5RyVZVdBKDCbyU+w+evIe1hX3p9K4XyXbJ5DdN
         CGZkP3XCt7xUaKzPlha4e26xbnt/r1LoytfyjIAGro8P0vyb+/ZFolWpO5jREIxr32IK
         najQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQGJRakDuxeOnMLwkadAuwa7hQ8ne1nUDFyEzETw81afuV8MyMgIRb4zVtPa8LHNn1DldN3SEVE6h//F0=@vger.kernel.org, AJvYcCURhdVOxLgKzve8zSb7i8Hco4826d9cPnj5GiDN9VXWBmG76NmbTciCDo7ldIZEdQLDS9BaTTSHypeW7iJBHZt1s9Q=@vger.kernel.org, AJvYcCUcSu12jXZhxIZzvixdWz7W70vFBk8vZ8b1yWivG6OYmM0eft8Rp5qXQMI2WRM88m2DbEVm6myrLAI=@vger.kernel.org, AJvYcCUq7fUn8Ndb6TzmSTBIMqnM3LnTUAgMFriqN783lM2xx3sPmepxaoS2GWxe/Vn6CMClFviGikOt0lh0vHA=@vger.kernel.org, AJvYcCUsyyIfZEg64Dv0zsuu0hApGSP0Uuk1YvvCp45ra3d6CcpJAMaxeJ0hKIshxBjActIl2dfKvg5l73fEgTA=@vger.kernel.org, AJvYcCUtEKM71YnXEIMF7GOUTDsz/8Xm104qnXoVVQ/w59OdvZ2tJLtcOiAPNH7vU6CSQEQFRtq3fSDP10sI7g==@vger.kernel.org, AJvYcCW6IWfVfW3e7kbukeI0rH+gw5nEA0EDFr7tY/FakvUiN7K0/hkNKStKOysCZG+Z4aOv9TEDUYZUXe4N@vger.kernel.org, AJvYcCW8RidQHZpp8iQahT4WioDrnTTvl9MiCG5i/8Jlcr7xUkSldV23Ep1UhUbe49VzFrrqfLALpVgEpBN/@vger.kernel.org, AJvYcCWzgdxM6hQR/tDv/HzKhuDlLdeKLWM/Z+3b2k7KnR8cKxWtnUEVJElwyVRtjnf3ORK9KX7ErbxAaGta@vger.kernel.org, AJvYcCX3B5GG0fhNoayoQ5vj
 5HOXRG2nASh4pMdZTHjnlxQ8PvuN80dvJEu9bSKVsrlkCERyfcZsJyS2@vger.kernel.org, AJvYcCX3u3wGZUn0TfsJ1wFgBByPa+cOpAGPZXmLz1pBjwScACDLkpNz2Ehs6Tzhrv3QhvrphrieOQR4V4swzw==@vger.kernel.org, AJvYcCXIYaPiSbNfEBSFn1di7M10B14/pMv6bcoPMVALh8MVoEwjQ8i5wip0JGNUvAPS3zddJUVAEqhSPWjosQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSvsbqgcfA7DiBxfhdSkr9+HkvxOmJBMcAox130Ss4hxIisWr
	T3LvPk6LDSKMyvIDNzGS98VfpreD68Prc6U/ByqoKVLsP4PHZD5b
X-Google-Smtp-Source: AGHT+IEKCAZFjKxo/Nyr/QfETLSbnXhkrol1AjduntpjOaMi5BDqrJIxxdVcVIotS2EHx7dz+GdLtg==
X-Received: by 2002:a17:902:da8a:b0:205:8275:768 with SMTP id d9443c01a7336-20fa9e6990amr87460475ad.21.1729790333794;
        Thu, 24 Oct 2024 10:18:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f12ea2csm74665655ad.62.2024.10.24.10.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 10:18:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <68e35542-d360-4a37-9ff1-16fe76594b6f@roeck-us.net>
Date: Thu, 24 Oct 2024 10:18:49 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Ivan Epifanov <isage.dna@gmail.com>
Cc: andriy.shevchenko@intel.com, aospan@netup.ru, conor.dooley@microchip.com,
 ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org, dushistov@mail.ru,
 fancer.lancer@gmail.com, geert@linux-m68k.org, gregkh@linuxfoundation.org,
 hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, jeffbai@aosc.io,
 kexybiscuit@aosc.io, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, mattst88@gmail.com,
 netdev@vger.kernel.org, nikita@trvn.ru, ntb@lists.linux.dev,
 patches@lists.linux.dev, richard.henderson@linaro.org, s.shtylyov@omp.ru,
 serjk@netup.ru, shc_work@mail.ru, torvalds@linux-foundation.org,
 torvic9@mailbox.org, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru,
 wangyuli@uniontech.com, wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <61a622bd-7597-45e2-96d9-9cba02fba407@roeck-us.net>
 <20241024171301.241949-1-isage.dna@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241024171301.241949-1-isage.dna@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 10:13, Ivan Epifanov wrote:
>> I really don't want to get involved, but this misinformation really goes too far.
> 
> Then don't.
> 
>> https://en.wikipedia.org/wiki/Finland_in_World_War_II
> 
>> provides context. And it does sound familiar. Turns out the Finnish defended
>> themselves against invasion from the Soviet Union. Sounds familiar ? Guess it's
>> the same as those alleged Nazis in Ukraine nowadays.
> 
> Especially if you can't read beyond few pararaphs.
> 

Yes, everyone should do that, and I did.

Guenter


