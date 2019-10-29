Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D32BE9225
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2019 22:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJ2Vfg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Oct 2019 17:35:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46402 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfJ2Vfg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Oct 2019 17:35:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id 89so209683oth.13;
        Tue, 29 Oct 2019 14:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uitwfAkLbCLnEl4obZmwBP7OPXyIb+02Vzy0XuAro1c=;
        b=oXAFGW4MJUyrv+WN3bQEY4H6fnAq/oQpNm+RYfNLS4+aplx2/KqLXQNjWNAsowhxms
         96RYFZiduTN06iJeDECXRVOsUGJ+Kqio5oGnzb0xbR8Ry8RC8xEV3gUaCNeb1+6B28Nh
         AHnl9gd8rvRHn9Kmv3BMvYCOb8mSF8QYTtz4ILVW0uoqinkl9nQYFuBNfO1qtFRAAf9y
         UkwU5OmStowFcepdRMNZLlXOaf2lPw6zPLtt0ANYcjA3wW8+UsnfHYSVEwOXFaoj0S6x
         ytkcWDOg1+GLMNsGcYMRYHSlgbgAvNJDsRlhDESC5a13r/66Y5fFRUfz2fZbHmvk2J1O
         C7mQ==
X-Gm-Message-State: APjAAAU5SzBleie/Cov1A8Kx6LRyEYHkWsj68S0FfMRge6yLRvZsXshi
        Wj9JjlknYG5NPaiio9ckSQ==
X-Google-Smtp-Source: APXvYqx8H0GIKskqmdZ3mYCF6FghPBywADezj85hdLx2P/pNi9HefI09N6elZzA1fx+IpvomXxgMcg==
X-Received: by 2002:a05:6830:1003:: with SMTP id a3mr20140587otp.166.1572384935460;
        Tue, 29 Oct 2019 14:35:35 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c19sm77613otl.6.2019.10.29.14.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:35:34 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:35:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, vkoul@kernel.org,
        paul@crapouillou.net, mark.rutland@arm.com,
        Zubair.Kakakhel@imgtec.com, dan.j.williams@intel.com
Subject: Re: [PATCH 1/2 v2] dt-bindings: dmaengine: Add X1000 bindings.
Message-ID: <20191029213533.GA8640@bogus>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
 <1571937670-30828-1-git-send-email-zhouyanjie@zoho.com>
 <1571937670-30828-2-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571937670-30828-2-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 25 Oct 2019 01:21:09 +0800, Zhou Yanjie wrote:
> Add the dmaengine bindings for the X1000 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  .../devicetree/bindings/dma/jz4780-dma.txt         |  3 +-
>  include/dt-bindings/dma/x1000-dma.h                | 40 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/dma/x1000-dma.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
