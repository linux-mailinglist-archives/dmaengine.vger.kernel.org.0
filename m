Return-Path: <dmaengine+bounces-118-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A87EE783
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80D41C20866
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 19:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470D24652A;
	Thu, 16 Nov 2023 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D1518D;
	Thu, 16 Nov 2023 11:30:29 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5869914484fso616393eaf.0;
        Thu, 16 Nov 2023 11:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163029; x=1700767829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7FbFMZyOm4y21zxxd4fG3rlnBc8F2We8GtC4w2SS1w=;
        b=CUXn+IvEB2gF6Mdi90bgE05Bt/4p2b6TiQq5UXsvyofO9GUGk0sCjK4wJqpCKs7hzo
         kJd91qICEjOji06tBZumxJoT30gcD9Grz0PbxQZQqY2fth3RrxHc73vYOr58nxSiNkyI
         EDI/4jVreJCoz1mbj9Lj+mzCEIExF7QlQbi+4HOooUUE/Bpp7vKMOtCYtznTN9FPfDb7
         uyVbrRqg2ZY4aFNpdOj2Tg+uCr69J6lGo53aRlaLRET06DG4ok/ZCu1XgV7MCFGjLEAa
         ABR2y6S2Y2VMdeIcMJyxF4rpPlYucRrnk4OGMVmUvF5rUPEAAzEbETXlzkqAIzaIYhfg
         y77g==
X-Gm-Message-State: AOJu0Yy/ZXVhaKc+3bLkv35pRgrBsAVmRoqpDlgQfy3q8OnzhS8GDoYR
	lmzquc9OIm61LbEiIBkc+A==
X-Google-Smtp-Source: AGHT+IFSp1f7TbpivIjIY//huUNmDslsDMxVBCti4nc7OSLQ6yL118JR1HPflrHOkpP+ls1MaiRwBw==
X-Received: by 2002:a4a:85c1:0:b0:57b:eee7:4a40 with SMTP id u1-20020a4a85c1000000b0057beee74a40mr15895111ooh.7.1700163029011;
        Thu, 16 Nov 2023 11:30:29 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ch1-20020a0568200a0100b00584078d1e17sm10580oob.45.2023.11.16.11.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:30:28 -0800 (PST)
Received: (nullmailer pid 3079204 invoked by uid 1000);
	Thu, 16 Nov 2023 19:30:26 -0000
Date: Thu, 16 Nov 2023 13:30:26 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org, joy.zou@nxp.com, shenwei.wang@nxp.com, krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, festevam@denx.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, peng.fan@nxp.com, shawnguo@kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: dma: fsl-edma: Add fsl-edma.h to
 prevent hardcoding in dts
Message-ID: <170016302591.3079151.39706037865284534.robh@kernel.org>
References: <20231114154824.3617255-1-Frank.Li@nxp.com>
 <20231114154824.3617255-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114154824.3617255-3-Frank.Li@nxp.com>


On Tue, 14 Nov 2023 10:48:22 -0500, Frank Li wrote:
> Introduce a common dt-bindings header file, fsl-edma.h, shared between
> the driver and dts files. This addition aims to eliminate hardcoded values
> in dts files, promoting maintainability and consistency.
> 
> DTS header file not support BIT() macro yet. Directly use 2^n number.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/dt-bindings/dma/fsl-edma.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 include/dt-bindings/dma/fsl-edma.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


