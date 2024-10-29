Return-Path: <dmaengine+bounces-3641-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CA9B5494
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 22:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353081C2288C
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F42076B9;
	Tue, 29 Oct 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S/JEx9ys"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500A207A0D
	for <dmaengine@vger.kernel.org>; Tue, 29 Oct 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235609; cv=none; b=HJ856EKQs0QVY+MWSTmWBPFkTAyofnqaTUAxKr+5gtVX9XaNUlNIn24T1va5Djqc9dCit71Q0WnbMEplHBJ2v2VI5zfdCNZAByNcVcvD5rge1NF0g1OI/xk9WoGJ+lsG4bHOYb2lN8M/Ep3NEsuEldW3VjNs9e76Y9U6c+eiGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235609; c=relaxed/simple;
	bh=Ul/e2kCej6RPfHbTi51zGOAqEi3WrgU0ROTdX5hpnIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7JB5xlnP18oHoR7zKQf8yUsBRpVQ4TebE29HRVNVXKA3KiCxLtxjiMSXDmmknU9fX2vG2u0IlJoJ8nXnyNj09Eb2k9KBXKlgBQCf1tOKjKeMZIBDSyZhJVDezh3Z0tWFHfb/OdZST8hHPebYlczDf5duPMMCz0FmaZoKOq2x1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S/JEx9ys; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e60fca5350so3674813b6e.2
        for <dmaengine@vger.kernel.org>; Tue, 29 Oct 2024 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730235605; x=1730840405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAxk75unEfa1XvvzuInBPAEOVG8E7pAoUhieZqfU6ug=;
        b=S/JEx9yswfstefjmqmL0RQsQuHUu/9qHcjftkiLB5CSQocQy46HHk0HJ0IOo0UgwqK
         ov6Abg1Pj+prXxQpDRw4Dbkk1JczNFjF67DTX1mjnw4w9MPi6pRVXF1gp6BioZ064NAS
         Vkzt2L3bUeNM0klmZC6bIgWrHzatdfkHqKrp1pQvR90d39otOhr149AodrbboizLAqVX
         dcTNPacNeDrWhqYJxb7/v6OlrOv+bVLc77vP6RDDGz7d4obHN4KNGqkAcN6bAq/Rrr48
         2cn7lvMwn/nf8kgzOZ+/f7mNYVanaQcMWOg65tfHNNOWOD4ccKdo7ZRfwBEo3aVKFkU3
         aJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235605; x=1730840405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAxk75unEfa1XvvzuInBPAEOVG8E7pAoUhieZqfU6ug=;
        b=eXg5pQbSxVGXo/ar690rJ5gf03MkJJ1UjExRMCNvM2XJn5qD6kiIqBMoZDgvh7FCaD
         pmjL+QJHF7v7Y1B2Wzdy5+TVXziLGOEu5CxHRFtqqN0EHs4+GMawfcpkt8/2DdjayvJ+
         oaapiNhogBKbMER7jxUNQi/W/jewOGATU12KsTqs4JYT6MKccMveoDZQaVVVsn3MTwma
         M4K5auuCzRFVnJ5NXludmaMFehwz0vFvGUgknFDWyDfTmmcmwQxZYhfp8hib8/FiHBQz
         Z4hl2ENayea4I68PTY3SzkW/Ocn7YBvtuiLQLgRmN5vX1qev+/sS6G2UgZYPr4J1Qh/n
         avlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNBzX5XbH0Ye8Vao/+vU14CSssQXQp3MaUvIVMLhc7rBp2MFnT7hvs5ZYMRJ7mUvWW6GniWGJWWls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwQWgdhViQXwXEFyKFU8joVwqOoWmAlJs+TLrp/0H52eWSYNy
	qzj80/tDlAJR/Cme/CmdGGYDao/jGBfGX2LcBtTunQ66Alnk5vRljfTzbBBhrUw=
X-Google-Smtp-Source: AGHT+IEMmkghZbZJEfvDYim8gZjbJlptfiFRHUPCAvIJTQjMKXcxCdAv5Xr3BiAZgSrsCCnMSMf9uQ==
X-Received: by 2002:a05:6870:8321:b0:278:64e:c5ef with SMTP id 586e51a60fabf-29051d3bb23mr11805277fac.37.1730235604662;
        Tue, 29 Oct 2024 14:00:04 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-718618a3747sm2301153a34.57.2024.10.29.14.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 14:00:04 -0700 (PDT)
Message-ID: <28e6bf79-eac0-4ab2-8505-3d210cf145a9@baylibre.com>
Date: Tue, 29 Oct 2024 16:00:03 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: adi,axi-dmac: deprecate
 adi,channels node
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>
References: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
 <20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com>
 <173023455618.1620887.12454823992375368491.robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <173023455618.1620887.12454823992375368491.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 3:42 PM, Rob Herring (Arm) wrote:
> 
> On Tue, 29 Oct 2024 14:29:15 -0500, David Lechner wrote:
>> Deprecate the adi,channels node in the adi,axi-dmac binding. Prior to
>> IP version 4.3.a, this information was required. Since then, there are
>> memory-mapped registers that can be read to get the same information.
>>
>> Acked-by: Nuno Sa <nuno.sa@analog.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> For context, the adi,channels node has not been required in the Linux
>> kernel since [1].
>>
>> [1]: https://lore.kernel.org/all/20200825151950.57605-7-alexandru.ardelean@analog.com/
>> ---
>>  .../devicetree/bindings/dma/adi,axi-dmac.yaml         | 19 +++++--------------
>>  1 file changed, 5 insertions(+), 14 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/adi,axi-dmac.example.dtb: dma-controller@7c420000: 'adi,channels' is a required property
> 	from schema $id: http://devicetree.org/schemas/dma/adi,axi-dmac.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Ugh, somehow lost a line from v1 in the rebase and didn't notice.

This is the part missing from this patch:

@@ -109,7 +113,6 @@ required:
   - interrupts
   - clocks
   - "#dma-cells"
-  - adi,channels
 
 additionalProperties: false
 

Will wait a bit for other feedback and then send a fixed version.

