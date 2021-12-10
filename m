Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D29D470613
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243899AbhLJQru (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 11:47:50 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36779 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbhLJQrt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 11:47:49 -0500
Received: by mail-oi1-f175.google.com with SMTP id t23so14008622oiw.3;
        Fri, 10 Dec 2021 08:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mm8SQmiLhjU20BvDtVazDvNimPphReV+xWj5pzJFCQ4=;
        b=teumkqxGEULFbt80aB983J0vBRQWoUai4i91HsRZgtn0Hx10EVjYxE3+ygXmgxkA6T
         57r3ejj7R217M7SYFB6hC5k/JVvKnE4gpZYhmfSOlOKMEYvFveNjcPbMXi9tghcHK/k9
         9tnbq1f2ItzEQV/r7I7m3OWav4uHy1Mzfa1vfTWzu8gqv9uwzIaOwmgpQ5L3NgwaBfzE
         Z5tqiEzNKHM7e8QdO7qnnThkl6LOlKdSOqyZagCHdZESxQQS5rAySuayJsHmcQd+9OT8
         BUXIdBa8f9Z6USo6zU0SRjwRqjSD8noEp1uJ1m0SPJonhQcWaz+IMTY8GFGPWRnqu6wL
         +F9Q==
X-Gm-Message-State: AOAM530tzi8TYlpxMq8OH5SntWwVszTWfAPPPjTm4xx4WdoEAE3yybcf
        14oYpmA6np+wwQGoScmVWA==
X-Google-Smtp-Source: ABdhPJy8HYzrYSz/WeaRmKgp2Gue2wXup/OLnqK1pePjZ+PMhr/kETAotUtsNeRaSSB7jB1G2/YZ8g==
X-Received: by 2002:a05:6808:2205:: with SMTP id bd5mr13249606oib.12.1639154654011;
        Fri, 10 Dec 2021 08:44:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h3sm610770oon.34.2021.12.10.08.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:44:13 -0800 (PST)
Received: (nullmailer pid 1499436 invoked by uid 1000);
        Fri, 10 Dec 2021 16:44:12 -0000
Date:   Fri, 10 Dec 2021 10:44:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     rgumasta@nvidia.com, robh+dt@kernel.org, ldewangan@nvidia.com,
        thierry.reding@gmail.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, kyarlagadda@nvidia.com,
        dan.j.williams@intel.com, vkoul@kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Message-ID: <YbOD3F2DvkAz3tLK@robh.at.kernel.org>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
 <1638795639-3681-2-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638795639-3681-2-git-send-email-akhilrajeev@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 06 Dec 2021 18:30:36 +0530, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 110 +++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
