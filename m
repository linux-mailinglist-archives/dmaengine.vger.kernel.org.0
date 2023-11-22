Return-Path: <dmaengine+bounces-179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844BF7F4B52
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 16:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66C81C20AA3
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F4456B71;
	Wed, 22 Nov 2023 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72F19B9;
	Wed, 22 Nov 2023 07:44:14 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7a6907e9aa8so241885739f.1;
        Wed, 22 Nov 2023 07:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667853; x=1701272653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4dpS05p/mJ7BidAcig/071dpPmGFzFkosRDxb1BEXI=;
        b=cmvAVTBaCabTtpTvTqLBgX6mlD08OCIZyZdOT6lfHc0bBvy89GI8ennHWNok9N46rw
         WLOtNNTZD+0ATSCbZdJOW1GpnZpQcBFDMpTIj4tUMi0/DizokhwuU3ZnkP1xZj88ma42
         cLHUeOJ8ppW8MFLM5xLOOyGOwoOcD+d4t+9Aq1+VbyqjzW/y7SaJjs5cxRo8lEL+6LkD
         pfGOV9aKBAX8y2EMThec7BlcKXrmnq2yCMlOloeLJVf86sOpU6www4M8sB39ItG3zNOB
         /ZQY5ptpRB47UCkvRHzrj8kCjtdFhiMr8DkHqD6n7NbRfz/gD/GU5QlX/rcWITEgetDJ
         tSTg==
X-Gm-Message-State: AOJu0YyhdVBbJP7C64YVHMwnvzn6iG2ElLEjQwbOkDD2p0OKkkinwLlz
	Xljjl7gH0sJrwbCqkXoCdA==
X-Google-Smtp-Source: AGHT+IFdvsmjGjiZbPH6hIOUd4lxrv5HA2eflYLz9TZQB1KYCeHxxAAixdP1WRqZ/Jf3MhCvgDT6JQ==
X-Received: by 2002:a6b:7402:0:b0:792:9a1a:228b with SMTP id s2-20020a6b7402000000b007929a1a228bmr2457321iog.2.1700667853692;
        Wed, 22 Nov 2023 07:44:13 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056638451200b0043167542398sm1925471jab.141.2023.11.22.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:44:13 -0800 (PST)
Received: (nullmailer pid 1179989 invoked by uid 1000);
	Wed, 22 Nov 2023 15:44:11 -0000
Date: Wed, 22 Nov 2023 08:44:11 -0700
From: Rob Herring <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@gmail.com>, dmaengine@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 08/39] dt-bindings: dma: Add Cirrus EP93xx
Message-ID: <20231122154411.GA1155942-robh@kernel.org>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-8-d59a76d5df29@maquefel.me>
 <170065093445.115883.17187140881548762663.robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170065093445.115883.17187140881548762663.robh@kernel.org>

On Wed, Nov 22, 2023 at 04:02:29AM -0700, Rob Herring wrote:
> 
> On Wed, 22 Nov 2023 11:59:46 +0300, Nikita Shubin wrote:
> > Add YAML bindings for ep93xx SoC DMA.
> > 
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> >  .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |  84 ++++++++++++
> >  .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        | 144 +++++++++++++++++++++
> >  2 files changed, 228 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.example.dts:24:18: fatal error: dt-bindings/soc/cirrus,ep9301-syscon.h: No such file or directory
>    24 |         #include <dt-bindings/soc/cirrus,ep9301-syscon.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

These can be ignored. Looks like patch 6 got delayed or something and 
didn't get applied with the series.

Rob

