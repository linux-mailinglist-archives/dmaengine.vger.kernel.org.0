Return-Path: <dmaengine+bounces-1341-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4668790F3
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 10:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C51F2270A
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9EA7826D;
	Tue, 12 Mar 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQGVnjDQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA98464;
	Tue, 12 Mar 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235706; cv=none; b=czb69FxyuONlz3Ax4W/7SZJBWDudf/fMI8WfCzzmumUiCgQLR+8X6VL6RFTYu1lJYDtGMx47EGH/AnaK2sGz6yJ8gDKeuRUFglFxpC+PStdE25eWsw9TCl91KOPV69u02DkWITmfkgjKm77/Y769fBAsPyjKU0AUnByvdSCKu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235706; c=relaxed/simple;
	bh=lOb/wLij4QiyTntQtdEH4T0DBOmfeMvCyGzvtevrdlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvNi+8QaVSbzQ2bHpMvJygxQc5wkjl3JiR5WvVdOnmpjXgYFdAtIgm3VtiN1B0DhJNYZ8Wgi1gRde+L2h7V/I0BsZTbNBU2w3CnDOOf1M7Ze1hn901N7p8Qg3u46QP3beWJ0cLlV+FotQnbseDCF6aR4PpfknEgodcXQySbkvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQGVnjDQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512e4f4e463so7229213e87.1;
        Tue, 12 Mar 2024 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710235703; x=1710840503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vypzRSmygKV0lPftTIj3GZMtWC14VrjuyGuYtz9gYZI=;
        b=RQGVnjDQNpbDWN9CC2pHpD1X04lB9ZG0dSa3XRc25JVP2wdfbvPTgk2ImJbGyTmPMd
         xScAsn17Y8T7chcQE3ds6eXlmCrIETI7pP65e1HJG8qubAV7zRM/VgqiFM5YbzdeMD6R
         N/Tz5Wqxof1ySM/tImM+NbbfvIllvDLCV/+txQ22UjsDyBrJE8bH7OtwdBCTnyKePFq6
         ihkScWr0KmvGZatwspWRr3oWBUkEyFKxnlnAtpZraDY+SKFvWi7tVc0QXAHTY0OckmwF
         RxPQJn4HzXXz7w3JxWk/4Pb8MNGwp7putzac2ipOs+814TJxt58xg/X5xLd03zVmBVmE
         skYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235703; x=1710840503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vypzRSmygKV0lPftTIj3GZMtWC14VrjuyGuYtz9gYZI=;
        b=alxe3PgMa/9sR4WLuTc/tUV15HASSDEqkkTwPjDRueqs28Tqm8605NWPsCSergqO7K
         wnRQbTVcxVeAdV6dW2Pd9NZTkdMEpvjskPBWlJk8wCnaFCWXC5Gt6kr+qesR0W/nLXSW
         edeCxQOCRL3TUhVaWeB5llpOFKOq4Uujx1mEOpLRSb8EsR28ROTkkGdHN0ZWSoEVwu2l
         C+Z4s7E8sSDcrj140hnbXkg3x4at16kspbRhD9QW2rr9S2X0Q93+PGyxklrMNdclHc7c
         atogS3rSSxMQjTQFqkQ0yvyv87iKqoIWvb9mAtrEhdjYWqKnRn9McGaJiZ7iy/PiYEaT
         bblA==
X-Forwarded-Encrypted: i=1; AJvYcCWXqxscMxnAppm2uFBOpVXAKknc0jlw/0hkWMZ39NWbwig/wvaQfACKFRzrAb0yKH9TyXZL6LJMXMqhqsVO6ZWAKpYUeQkgHdsKRg3dXcI4hUFOWnOlOADIzo626o0S1un6PhOFtIUoy7A2hbmRe9zskxlv1D0LFoBvAmyXgqdqOTGRRQ==
X-Gm-Message-State: AOJu0YwxvMzlQ7VVYsreRRcsqwlQbRHvzYR50Lgo7OzGxg8Ovuhk8Zlc
	lpDsIdrOokGrEO0E2zj7rgNzc5og7Fy+S/Ou/JRtfSn7XGtvcK9e
X-Google-Smtp-Source: AGHT+IGtRkGYkdMwkStxreKfnlfTpKe7ly77/KT/i5Sci+pS0MCZOhWw102gaE9pYvHRg+q+/Lz8Bg==
X-Received: by 2002:ac2:5e6d:0:b0:513:91c4:aa6 with SMTP id a13-20020ac25e6d000000b0051391c40aa6mr1680002lfr.63.1710235702881;
        Tue, 12 Mar 2024 02:28:22 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b8-20020a0565120b8800b00513b3928e36sm444420lfv.266.2024.03.12.02.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:28:22 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:28:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width
 schema
Message-ID: <v32llcm32lrgxx7inpndjyl4bj2jq3m4sncb7h23hii5k4krlo@gavzbjsuq3sr>
References: <20240311222522.1939951-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311222522.1939951-1-robh@kernel.org>

On Mon, Mar 11, 2024 at 04:25:22PM -0600, Rob Herring wrote:
> 'data-width' and 'data_width' properties are defined as arrays, but the
> schema is defined as a matrix. That works currently since everything gets
> decoded in to matrices, but that is internal to dtschema and could change.

Can't remember now why I didn't implement that that way initially.
Probably because something didn't work back then during the
DT-bindings check procedure. Anyway thanks for fixing the schema.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/dma/snps,dma-spear1340.yaml      | 38 +++++++++----------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> index 5da8291a7de0..7b0ff4afcaa1 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> @@ -93,10 +93,9 @@ properties:
>    data-width:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description: Data bus width per each DMA master in bytes.
> +    maxItems: 4
>      items:
> -      maxItems: 4
> -      items:
> -        enum: [4, 8, 16, 32]
> +      enum: [4, 8, 16, 32]
>  
>    data_width:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> @@ -106,28 +105,26 @@ properties:
>        deprecated. It' usage is discouraged in favor of data-width one. Moreover
>        the property incorrectly permits to define data-bus width of 8 and 16
>        bits, which is impossible in accordance with DW DMAC IP-core data book.
> +    maxItems: 4
>      items:
> -      maxItems: 4
> -      items:
> -        enum:
> -          - 0 # 8 bits
> -          - 1 # 16 bits
> -          - 2 # 32 bits
> -          - 3 # 64 bits
> -          - 4 # 128 bits
> -          - 5 # 256 bits
> -        default: 0
> +      enum:
> +        - 0 # 8 bits
> +        - 1 # 16 bits
> +        - 2 # 32 bits
> +        - 3 # 64 bits
> +        - 4 # 128 bits
> +        - 5 # 256 bits
> +      default: 0
>  
>    multi-block:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description: |
>        LLP-based multi-block transfer supported by hardware per
>        each DMA channel.
> +    maxItems: 8
>      items:
> -      maxItems: 8
> -      items:
> -        enum: [0, 1]
> -        default: 1
> +      enum: [0, 1]
> +      default: 1
>  
>    snps,max-burst-len:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> @@ -138,11 +135,10 @@ properties:
>        will be from 1 to max-burst-len words. It's an array property with one
>        cell per channel in the units determined by the value set in the
>        CTLx.SRC_TR_WIDTH/CTLx.DST_TR_WIDTH fields (data width).
> +    maxItems: 8
>      items:
> -      maxItems: 8
> -      items:
> -        enum: [4, 8, 16, 32, 64, 128, 256]
> -        default: 256
> +      enum: [4, 8, 16, 32, 64, 128, 256]
> +      default: 256
>  
>    snps,dma-protection-control:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -- 
> 2.43.0
> 
> 

