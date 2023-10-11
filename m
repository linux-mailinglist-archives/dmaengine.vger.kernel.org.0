Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0687C5053
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjJKKiP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJKKiO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 06:38:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F63D9D;
        Wed, 11 Oct 2023 03:38:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5033918c09eso8453470e87.2;
        Wed, 11 Oct 2023 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697020691; x=1697625491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UAByv1I+aHmJjcNZyAEBlsSCq7nVeKJefcDEUNHdSLc=;
        b=A9aIBuAo+9QIIoLVIDNX14w/4CrsJsyB7Ttqs93+okej7qillpbLv9LB6OkubmsQIV
         eBzwMGGHrxGKkNBHjwKBxzq/ODEzeEZ5SNGz6xXbVVIe8kc/WA0h2efjpSBidRU2zevJ
         4OBCp1DZUue+4AYpIgLvMy2VRGne5Y5WGg/w3Cu7beZHweCfNFX91HUt6dSVDw4wNwyg
         78zoVRrIwV9jB2LFJlzSu3DXyXeEfpqzU5g9KuKfQPnlE2ffHJqj33D4PHxZPrIFPkGW
         GzoB1wUsl2n3/ga8m4mQcmvW+BEleMiPMRCTdirtKAF0Ji4py3j+3B8985ohqEFnC1lw
         B6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697020691; x=1697625491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAByv1I+aHmJjcNZyAEBlsSCq7nVeKJefcDEUNHdSLc=;
        b=CFmMI/uqYaRWoZQbh2GdoBu1hNHoHHWKAZg99wYh2rxnHaYSdQnn5aynQZHQe4VGfS
         qA+VZNr8NFrlgC/aLHvCS12aXPzacG62+8765Yvc0eQAHlAEw+5nrGUuFGf5FVQAbRZA
         pfzgJX9VJqr6wZ7Uj0BhROrgJ6f2LCgbzloigA1ODDkSSVTZ8qBZ85bs0+j6yRNIMuib
         t6XXPGcpZy1fyUwYM4+pTiN8nJLaoRnIKBhu4h6wz0cfSejbIk1mcf5ogQpezq7yIMoR
         hUxtmSLy96BHa7KGq1w8gkZCI8x0Y0mBqD+BO9gHkkHHqqcN+70mqZ9Kd2ZpfCN6WVqA
         /i3g==
X-Gm-Message-State: AOJu0YwHGhtGiRROqzsp8iwFbdLUXbkIpDODOsjUxJVbdE3YPYGtDI2t
        204+z33NUPOiI0qORaQGEkLnPfTl2X0=
X-Google-Smtp-Source: AGHT+IFZoTNkJ4yMietqGDtPBFUow7+4wWShdxOyhrcSDYk8LXP/KOiYZnq8qMROV50mz4LnyFjfBQ==
X-Received: by 2002:ac2:5bc7:0:b0:505:6ef8:2544 with SMTP id u7-20020ac25bc7000000b005056ef82544mr16584492lfn.63.1697020690422;
        Wed, 11 Oct 2023 03:38:10 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id v2-20020ac25582000000b004fe1f1c0ee4sm2212496lfg.82.2023.10.11.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 03:38:09 -0700 (PDT)
Date:   Wed, 11 Oct 2023 13:38:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 2/5] dmaengine: dw-edma: Typos fixes
Message-ID: <pa7nvziczcnj56oozkgy244avbeirkseviimwmaxxlm5ozrjuo@plvebecoc4ev>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
 <20231002131749.2977952-3-kory.maincent@bootlin.com>
 <20231010145906.GL4884@thinkpad>
 <20231011092350.18049672@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011092350.18049672@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 11, 2023 at 09:23:50AM +0200, Köry Maincent wrote:
> On Tue, 10 Oct 2023 20:29:06 +0530
> Manivannan Sadhasivam <mani@kernel.org> wrote:
> 
> > On Mon, Oct 02, 2023 at 03:17:46PM +0200, Köry Maincent wrote:
> > > From: Kory Maincent <kory.maincent@bootlin.com>
> > > 
> > > Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error.
> > > Fix "HDMA_V0_LOCAL_STOP_INT_EN" to "HDMA_V0_LOCAL_ABORT_INT_EN" as the STOP
> > > bit is already set in the same line.
> > >   
> > 
> > You should split this into two patches. First one is a typo and is harmless,
> > but the second is a _bug_.
> 
> Thanks for your review.
> Ok I will do so.
> Serge if it is ok for you I will keep your reviewed by on the two separate
> patches.

Yeah, it's ok.

-Serge(y)

