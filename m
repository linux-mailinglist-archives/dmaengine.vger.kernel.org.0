Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4A7123B3F
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 01:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLRABs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 19:01:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33342 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRABs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 19:01:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so154576oie.0;
        Tue, 17 Dec 2019 16:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JP0u5snGp+xc8yKUTmrKXjEUcHiiNAHT0AftIoZKcgY=;
        b=BvdAlb7z5/O4XifyFQN8cWZtnIofdVCJXnsVu5nH/l9+CXSvafkzsnEdYx5cK6nKpy
         HRMSz11H7haKp+057iNP1PGccvSB6wdDUhKlOsC9wCwV4KBj/YCdqhV9iNg4Ce0/9OAx
         kEDGVNrEEEkVF79KG/A7wnXN33gYi943aBsVZ5ozd6lczZGDxAXU/tC4bb1MktA51JIh
         jn0JWQPTQFbSJFpEUnwq+5QrEI1kwEJuZE3Yh11nXyuArobbELiicYc9OSf4kbr0I3CX
         HzjT31gWMJUDkS1QVg/3yR19zBc+md3iTj2C7cFurmz+rv/6cn3liyamSEAXvO6ndyzu
         /Opg==
X-Gm-Message-State: APjAAAURSum7r1IUzfwWhDM5rx6UT4eoImdGit6fork7boqyPH3cQkDg
        0RjiIXaNL9Q1XDlnW5id8g==
X-Google-Smtp-Source: APXvYqwuKoimb/fkC26Ulk74P68DdyeLLteEpSMqe8rqs1CwILHTcp7X1D54Jd94iGGt4cUdrtCBCg==
X-Received: by 2002:aca:bb08:: with SMTP id l8mr3144897oif.47.1576627307437;
        Tue, 17 Dec 2019 16:01:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11sm169161oie.20.2019.12.17.16.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:01:46 -0800 (PST)
Date:   Tue, 17 Dec 2019 18:01:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 3/6] dt-bindings: dma: Convert stm32 DMAMUX bindings to
 json-schema
Message-ID: <20191218000146.GA24153@bogus>
References: <20191217092201.20022-1-benjamin.gaignard@st.com>
 <20191217092201.20022-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217092201.20022-4-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 17 Dec 2019 10:21:58 +0100, Benjamin Gaignard wrote:
> Convert the STM32 DMAMUX binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/dma/st,stm32-dmamux.yaml   | 52 ++++++++++++++
>  .../devicetree/bindings/dma/stm32-dmamux.txt       | 84 ----------------------
>  2 files changed, 52 insertions(+), 84 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt
> 

Applied, thanks.

Rob
