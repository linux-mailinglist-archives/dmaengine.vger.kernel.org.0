Return-Path: <dmaengine+bounces-247-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6EE7FA865
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 18:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6061C20AC0
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F93BB30;
	Mon, 27 Nov 2023 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B0B186;
	Mon, 27 Nov 2023 09:55:45 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b565e35fedso2707974b6e.2;
        Mon, 27 Nov 2023 09:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107745; x=1701712545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L26i2R31YBB32RHwf8xEa95wnS6W9yDbV0iLws6hOL4=;
        b=lPBmqeaDt0FwDc/LjvESwwy2aOFhGyFxjK77KJS39qAFQj4mFkTc+SPkbc3KXUx8sY
         gc/vRP29LwfWuSwGRPwT7xCjK2NZC/l2Jq5Ddix+BfNoqrsQn2QbdPBjbs4b7XACvnGP
         YIbq5RraazGc8zb6Xh0LiOt38arM3W9kNRdHD+uZkFnEAHTic5HV8OuRDIwC9WmySM8P
         tSJo4HLZhZzbtfWU5/uXeyuwJtQ8xCgAe1aiXl8iz4QQzwOTJYiYCuxRgGi4/deYbUpd
         HAmlcTx6bqVWqFBuOVJAxNVmyo/8wZnT9cw8uZmpcy1jhEQ5trAbgvrPgunzj4nm86GH
         fniw==
X-Gm-Message-State: AOJu0YxV9KwKDIaN2CtoVZasDHn7880rztDVoOT6rOwPShX1K2+QEGom
	wpFvnnHy2Fd+6ELhvaJk5A==
X-Google-Smtp-Source: AGHT+IHh5PLzpOWFfsx+tNMkyl2NpKyrg0r+4w5u4CMZNruFnsvNEiokfY7omCoyUGIRYIDk8GRdCQ==
X-Received: by 2002:a05:6808:10ce:b0:3ab:73a6:1469 with SMTP id s14-20020a05680810ce00b003ab73a61469mr18010811ois.14.1701107745157;
        Mon, 27 Nov 2023 09:55:45 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eh3-20020a056808274300b003b2e4b72a75sm1551295oib.52.2023.11.27.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:55:44 -0800 (PST)
Received: (nullmailer pid 1889222 invoked by uid 1000);
	Mon, 27 Nov 2023 17:55:43 -0000
Date: Mon, 27 Nov 2023 11:55:43 -0600
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org, vkoul@kernel.org, quic_gurus@quicinc.com, quic_rjendra@quicinc.com, abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, quic_tsoni@quicinc.com, neil.armstrong@linaro.org
Subject: Re: [PATCH V3 5/5] dt-bindings: interrupt-controller: qcom,pdc:
 document pdc on X1E80100
Message-ID: <20231127175543.GA1880474-robh@kernel.org>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
 <20231124100608.29964-6-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124100608.29964-6-quic_sibis@quicinc.com>

On Fri, Nov 24, 2023 at 03:36:08PM +0530, Sibi Sankar wrote:
> The X1E80100 SoC includes a PDC, document it.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v3
> * Rebased to the latest lnext. [Krzysztof]
> 
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

