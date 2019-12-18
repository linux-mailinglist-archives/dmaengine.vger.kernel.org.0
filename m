Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62938123B3A
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 01:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLRABg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 19:01:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37262 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRABg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 19:01:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so106797otn.4;
        Tue, 17 Dec 2019 16:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vg2WtMo4ZpT0ZxliZmTf/NuvDxUCffHyo9DOYsxFcQ=;
        b=kJJgZUvfGB0ZdKP11oJOdFBPZ0muhqZZBH/89QItdE+O/hk3KQqFvmwPHmBZ8tKQeL
         IroQb60GzldxSrOEAEqaS7gxh6+DMZTHib11yW34RjG4r7FRENXuktAC2KIujYO7lJgW
         b7NH6s4e4zF6SNgV7+WGeA5C2n5byHBtuPUvhl7nyGuXUnIADtGP20ldnuIjNvO6R6mi
         0Ubb8++4opApnDIxlIfBPJLv8//9r8wcSxKRTGgy2zrbs8VE4oY4D5+u6yQo/QVkOqqa
         Sgs3Bs/U7QbmT3QAFVDAurVW/YGz0jtoGjVFNKl/NU0jbAYLAWQ6Ddu9Agjk48DVDyaE
         WM4g==
X-Gm-Message-State: APjAAAXDatZ1j/hDVq4lGpn+s7bTgeA+mOHJ02kS6WPHaDp5yV4iSn3k
        luFMMfryOyurssZK9QKObQ==
X-Google-Smtp-Source: APXvYqz4KsCKLuH3i+DvdRRLBPycXfz72EfHac3NLerdd5D5i9FdA8OPgGvOfr8jCfsIYQiq+hO6Gw==
X-Received: by 2002:a05:6830:109a:: with SMTP id y26mr123322oto.227.1576627295508;
        Tue, 17 Dec 2019 16:01:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q7sm128986otn.9.2019.12.17.16.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:01:34 -0800 (PST)
Date:   Tue, 17 Dec 2019 18:01:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 2/6] dt-bindings: dma: Convert stm32 MDMA bindings to
 json-schema
Message-ID: <20191218000134.GA23692@bogus>
References: <20191217092201.20022-1-benjamin.gaignard@st.com>
 <20191217092201.20022-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217092201.20022-3-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 17 Dec 2019 10:21:57 +0100, Benjamin Gaignard wrote:
> Convert the STM32 MDMA binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/dma/st,stm32-mdma.yaml     | 105 +++++++++++++++++++++
>  .../devicetree/bindings/dma/stm32-mdma.txt         |  94 ------------------
>  2 files changed, 105 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt
> 

Applied, thanks.

Rob
