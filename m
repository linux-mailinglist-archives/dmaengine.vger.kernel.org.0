Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE6123B36
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 01:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLRAB0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 19:01:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45845 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRAB0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 19:01:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so72093otp.12;
        Tue, 17 Dec 2019 16:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DxfJPe+fLp7sS5LGmoHqh2JVFDd9HUExmcrr2ei05U=;
        b=knqTQloxlXbSePCUh01p+cnV09spdW4mHpxiqh+2504Fj0rwI/+NzdecUGUOF9YYpr
         zq95rcsBABDgmrGaVvpjRCM4I23Skq74opOvHADHReMoh2hJ6tFXP4o1hsECdOA5dpW3
         JV/9/leai5CBVt5efkee6aT0IywaZmudtPqyAdKMS5fM4JMcioqGxJHrHUz6+BhsvynJ
         vJZLPiZ927Kc8ut2YxdZGzEY0KbIlCV4PXnmIbH17zfgx0DcgfG/2qjgMp3OXYBRwiVM
         AMdKYwALUm9cqZ4a+PJkAeVRX1Vcmcaq00oKEaVetc/DdBZXTtwn/DfMtv3juFIfhbxm
         nqDw==
X-Gm-Message-State: APjAAAURpnf3zw14o6higG2jDxMU6+1PUh0cu7tchKPHcUGbEYSEzVSR
        mi5frlTGIlTGmwKPWGehYg==
X-Google-Smtp-Source: APXvYqw+qBUt2vWsfODrii4GKSLi4xoYT8NdjBgJ2LVmEiUcC9EsU5LCVPA5a9FubOjJkoUUwOOnnQ==
X-Received: by 2002:a05:6830:16c6:: with SMTP id l6mr182117otr.186.1576627285170;
        Tue, 17 Dec 2019 16:01:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 97sm126795otx.29.2019.12.17.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:01:24 -0800 (PST)
Date:   Tue, 17 Dec 2019 18:01:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/6] dt-bindings: dma: Convert stm32 DMA bindings to
 json-schema
Message-ID: <20191218000123.GA23208@bogus>
References: <20191217092201.20022-1-benjamin.gaignard@st.com>
 <20191217092201.20022-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217092201.20022-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 17 Dec 2019 10:21:56 +0100, Benjamin Gaignard wrote:
> Convert the STM32 DMA binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/dma/st,stm32-dma.yaml      | 102 +++++++++++++++++++++
>  .../devicetree/bindings/dma/stm32-dma.txt          |  83 -----------------
>  2 files changed, 102 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/stm32-dma.txt
> 

Applied, thanks.

Rob
