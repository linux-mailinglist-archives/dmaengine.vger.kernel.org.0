Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B491B707258
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 21:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjEQTin (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjEQTik (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 15:38:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F921B8;
        Wed, 17 May 2023 12:38:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f26f437b30so1474660e87.1;
        Wed, 17 May 2023 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684352311; x=1686944311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQJ695KcI3BHYBzG7w7+hK8f+dLo9EP3mtkJ6GlEeMM=;
        b=FEoTIs3jqYZHn5b/tw5ANvwitlS6ZLEWAuqT48WYTezNNzY/7bDC9EzczQfvQZ15yz
         Dvqol4sTo946W9+gA4PwWMsitnMhRzVUlkza36pz7CxODDjvir4ZRD9lvUC2b7+i/Os3
         L4JQ/jOolvue/+rSqTWoQzq5pLqQd7g4PB0GosH1vAK8D/lj7G1R5xkWrfKF+gAu+l3f
         qJxwDQYpcQBBiPKzGa9DUgqGMqeGO7uftUzujXQapwIdoFzFiQCmXH5gGuCmC9TvHEl/
         n/mC015H2WmoVvHIsqGjK+o/Zj4YWVW2osFClHEpto4tLDqNKLEw7LwMRWp4umQlUg6h
         TqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352311; x=1686944311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQJ695KcI3BHYBzG7w7+hK8f+dLo9EP3mtkJ6GlEeMM=;
        b=iAA3yiZFdkMDDgo1C6bjVkuPYapehCs+Y4Pz02GCf60HXZBkcFfKgreFLvSLYgUzYb
         8x6i6OUb7vEp2xXM1e1N6KAltwVL2CEYD+/SLKKzyYAkYx3C7f9xL+R+ItykwQ3lH7Yq
         UxU4DSmN9zCHJ1rmfuUn3veyWlxPcbRqir+oIVSWeIkA0Qsvwr2MmpWchkp6geEXrGED
         IBCrhfmKnV/+YhG3BKUS/rhyuVh70zQYOCKYQB74eKrAVLxsL5qUqJydCpMQbJLwQcFl
         31mGo4abMISGcDLeZfzAY8ztueB6NQdYlRAoSJs0mkaHW6FuTJTqdAxSDEAP9nVKZ9+J
         QdXw==
X-Gm-Message-State: AC+VfDxx7mmQZIhJdJ3qKSJ+XY151K0Jgm2+tSH5IPVEecnWCRMNNyDt
        U77LNd8ZTPNG6uf75CvoUF0=
X-Google-Smtp-Source: ACHHUZ6iWLS8cmSrAAC07mVEE2/2vgmFh0Or+bdUPcvpXYk0j0f3yRpeBwKkgTTCrJmspTLTqq4cgQ==
X-Received: by 2002:ac2:55b4:0:b0:4f2:502d:f6c9 with SMTP id y20-20020ac255b4000000b004f2502df6c9mr548933lfg.13.1684352311155;
        Wed, 17 May 2023 12:38:31 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id e10-20020a056512090a00b004f00c854d34sm3470629lft.204.2023.05.17.12.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:38:30 -0700 (PDT)
Date:   Wed, 17 May 2023 22:38:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 13/14] MAINTAINERS: Add Manivannan to DW eDMA
 driver maintainers list
Message-ID: <20230517193827.rpjihsuw5c7ac7ji@mobilestation>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-14-Sergey.Semin@baikalelectronics.ru>
 <20230517052824.GA4868@thinkpad>
 <ZGSMd+mOQSq560dZ@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGSMd+mOQSq560dZ@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod

On Wed, May 17, 2023 at 01:42:39PM +0530, Vinod Koul wrote:
> On 17-05-23, 10:58, Manivannan Sadhasivam wrote:
> > On Thu, May 11, 2023 at 10:09:01PM +0300, Serge Semin wrote:
> > > Manivannan has been very active in reviewing the bits coming to the DW
> > > eDMA driver. Let's add him to the driver maintainers list.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Applied to dmaengine/next, thanks

Patch 14 of the series also concerns the DW eDMA driver. Could you
please have a look at it too?

-Serge(y)

> 
> -- 
> ~Vinod
