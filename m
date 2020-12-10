Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5532D5CAA
	for <lists+dmaengine@lfdr.de>; Thu, 10 Dec 2020 15:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgLJOAM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Dec 2020 09:00:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33921 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389791AbgLJOAM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Dec 2020 09:00:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id a109so4917929otc.1;
        Thu, 10 Dec 2020 05:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E0uG63kxQcD1euovXuF5Hkbx9fLEVhzIKnnrQCV3Aec=;
        b=q1ov9ioZSutPl8ZNVbYPl9PRoiOrFPsIClPh0391ebE1GvfrcGLhL2Q8oramGiWQQO
         7dK8yrUOIXpOyuPDiRW2+aVj0dwzLsOp9mmHi44/uS8CnRrpjI6Ss+6tO92EVktnhO9u
         kbBGHiIRRZxxbzAiXP40fREwlkrg4LRqohpCyMAFtMq5wt3eqifk0d2DsTGdfnjoM0WU
         JqE8NZhHiY529vp8hoZVgCK7iVcaN/G1eTDIg4ClU2s0N+a6Uq7qqZlxm4tlEuwMzBWp
         sTp1/0XjMU0cis4w9SMxik9VlA/IFP52KXAet/Q3ZCMCJc1hK57p277JtFfHuwrpFxII
         gHzw==
X-Gm-Message-State: AOAM533giZ0+wGd9u4swPzh/aUZgr9TF9cqvRgKAWzhg1hy9ZtAIstJ5
        yQ2DhXgz/PUd8M8lGhYa+A==
X-Google-Smtp-Source: ABdhPJzwaO+G8CoiRqNw6FTHQQecwOhAFA3uke+/0LDylhq19cKPB39mlhG6qs/p4yPwb1bRUNNdZA==
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr5673967otr.196.1607608768727;
        Thu, 10 Dec 2020 05:59:28 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 73sm1084322otv.26.2020.12.10.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 05:59:27 -0800 (PST)
Received: (nullmailer pid 2420054 invoked by uid 1000);
        Thu, 10 Dec 2020 13:59:26 -0000
Date:   Thu, 10 Dec 2020 07:59:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     devicetree@vger.kernel.org, dan.j.williams@intel.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        grygorii.strashko@ti.com, dmaengine@vger.kernel.org, nm@ti.com,
        ssantosh@kernel.org, t-kristo@ti.com
Subject: Re: [PATCH v3 11/20] dt-bindings: dma: ti: Add document for K3 BCDMA
Message-ID: <20201210135926.GA2420000@robh.at.kernel.org>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201208090440.31792-12-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208090440.31792-12-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 08 Dec 2020 11:04:31 +0200, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 Block Copy DMA (BCDMA).
> 
> BCDMA is introduced as part of AM64.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
