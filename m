Return-Path: <dmaengine+bounces-171-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306FC7F4492
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 12:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2502810E6
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B021349;
	Wed, 22 Nov 2023 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88712C1;
	Wed, 22 Nov 2023 03:02:32 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35aec3397bdso19162385ab.2;
        Wed, 22 Nov 2023 03:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650952; x=1701255752;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JVDwt/Qt38aBUOo9jpTwyaM0Ouh2vfXOPldOgDrVQKY=;
        b=oJPkLOToy9cRC4a5qIba0iCtyuEMOv3ZRXW9mzjrHx8Intci3uSHvbEGkBeFICgj64
         cA7Tn0IU1JaQIRpQiYFnrZzP7NjFezHCh/BnDRWpHRkmbtwB320NWzh4WuqkPqiM1UXz
         lMxkLPRYvPPChZDg6N95Wqv185maiNc/IbPEbyZL9pgP8nJ5cZnELZ9/jbnebqVbwy9v
         OoYFjzPAaQTGNh8nM2XZCjKHHDZQoCXrN0idfybBDghoa7xRWxhJtTeOjdBQdOp8C1oL
         jSD9Gv9trEx0djIe7S8wtBOPj1Vc4f8f6mw17Am+M9Z5F6En/K3fRdGvA5WVpqAU9kXu
         9sWQ==
X-Gm-Message-State: AOJu0YzBXQrOgewYbOm51Y2LHmrCs++xQgTFrGmbn5gyc82mUpJ3Ky4U
	r8ZJeI/Cqlg0XD5PvZ7Ph5UpnnoVkQ==
X-Google-Smtp-Source: AGHT+IGYT5GGZv8RnKK1ZJTVXmzFHWlfgYVU+5P1QHOdJmCKysWraqvKEdUHvh14PO2Oldi0zB4+kg==
X-Received: by 2002:a05:6e02:2413:b0:35a:f49e:eb65 with SMTP id bs19-20020a056e02241300b0035af49eeb65mr2367835ilb.32.1700650951710;
        Wed, 22 Nov 2023 03:02:31 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s4-20020a92c5c4000000b003579f539222sm3750359ilt.85.2023.11.22.03.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:02:31 -0800 (PST)
Received: (nullmailer pid 116315 invoked by uid 1000);
	Wed, 22 Nov 2023 11:02:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@gmail.com>, dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231122-ep93xx-v5-8-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-8-d59a76d5df29@maquefel.me>
Message-Id: <170065093445.115883.17187140881548762663.robh@kernel.org>
Subject: Re: [PATCH v5 08/39] dt-bindings: dma: Add Cirrus EP93xx
Date: Wed, 22 Nov 2023 04:02:29 -0700


On Wed, 22 Nov 2023 11:59:46 +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC DMA.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |  84 ++++++++++++
>  .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        | 144 +++++++++++++++++++++
>  2 files changed, 228 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.example.dts:24:18: fatal error: dt-bindings/soc/cirrus,ep9301-syscon.h: No such file or directory
   24 |         #include <dt-bindings/soc/cirrus,ep9301-syscon.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231122-ep93xx-v5-8-d59a76d5df29@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


