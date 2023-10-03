Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9207B6D83
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjJCP5O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjJCP5N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 11:57:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2928A9;
        Tue,  3 Oct 2023 08:57:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bffc55af02so12369121fa.2;
        Tue, 03 Oct 2023 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348628; x=1696953428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3z8xey7888ReZ3hOd59GeN1rUxRivvGJ0nZ5YMOr8kY=;
        b=DmRUVYDHBvolfE18U3baN1cilY2O5MN9jX/sWaqIOmgkCE+A7xJeD3ld3rqJZDN5v0
         mM5OIXEvlZ7cdy1XvQ+O7F7Z8unMDJGaqnXu6MaJoNroVS9ZNbCFfA8NgHpvgxdb5Pfa
         rBeL7K+EUaaQsJamV3ZBaD8zPSfQLi9bDuygo9LJxHcenp1afOpHl8jX+wGvcJRiUOA2
         Z4zoFrT/5h5r476yuOKey9brNJ3OyY/jwkIjUrPcarknsBeixwEnRjED3Os6SXPtj1Bl
         W2msaBGOkbg9Ii1HLmljShxvHoIizncXMEEYmruv+SRmp5EHIp1IeZoo0KZ8LV24VOBc
         oH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348628; x=1696953428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3z8xey7888ReZ3hOd59GeN1rUxRivvGJ0nZ5YMOr8kY=;
        b=Q1jR/hVvDceTikxSybLu0rNDCryi9tpDXOXUpx0I0oIrStbKEs3OUIq2fqacpF4yQB
         7MycE3FYFtOGdMHgOTiTFF67w0wQMCnV2buShDO7bLB3xLOOojVcEuQCdtRgjePzs2OX
         KLZMmBuMc95BLfgj6m8Ge7JaZumdRUMVCn4dN2FZ0C9b1SuVkkM/LCkrAbZELrajRKu+
         BP6n9Kw58OqFDbjqeGGUP3Xe7IyLKbEek9saim3a+mpN4oR6+J0vais2EG8tCW9o1tte
         IbQ9kA+M4x4OIarDdjC8AbLlVjv+T/NTxPP+Z9WVW1DM7nLDHljpwlt4XG2SAXB//o3N
         SqCw==
X-Gm-Message-State: AOJu0YwybH0X5T77VDGcIjn+DPIUGaxUaswBjtIj+ECqdVr8+AdS0JVy
        JWKFkibo8ChKPn5z4jmDAJBpnOGkbAU=
X-Google-Smtp-Source: AGHT+IHlWoh3zMtziDQkY+4SnrzOvIP06BmKFTuJ/fLEXqtaBT7Vx/+xohz55kjr70aCTFa3bfkN7g==
X-Received: by 2002:a2e:bc03:0:b0:2c2:a557:e947 with SMTP id b3-20020a2ebc03000000b002c2a557e947mr7640644ljf.1.1696348627772;
        Tue, 03 Oct 2023 08:57:07 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o17-20020a2e90d1000000b002bcd94f9714sm285215ljg.126.2023.10.03.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:57:07 -0700 (PDT)
Date:   Tue, 3 Oct 2023 18:57:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 4/5] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <lq7imquio2e2y4heczk27nsiutzng43cyz2sgmxa7azn3d3tnu@6hnvyzkuzhxv>
References: <m6mxnmppc7hybs2tz57anoxq6afu2x63tigjya2eooaninpe4h@ayupt4qauq7v>
 <20231003121542.3139696-1-kory.maincent@bootlin.com>
 <2yh3lus7qqhvewva6dr4p2g7azbgov4ls57xvzefbrw24h2t7m@cbx26pwj73zn>
 <20231003173432.18480fa1@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003173432.18480fa1@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 03, 2023 at 05:34:32PM +0200, Köry Maincent wrote:
> On Tue, 3 Oct 2023 18:20:23 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > On Tue, Oct 03, 2023 at 02:15:42PM +0200, Köry Maincent wrote:
> > > From: Kory Maincent <kory.maincent@bootlin.com>
> > > 
> > > The Linked list element and pointer are not stored in the same memory as
> > > the HDMA controller register. If the doorbell register is toggled before
> > > the full write of the linked list a race condition error can appears.
> > > In remote setup we can only use a readl to the memory to assured the full
> > > write has occurred.
> > > 
> > > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---
> > > 
> > > Changes in v2:
> > > - Move the sync read in a function.
> > > - Add commments  
> > 
> > Note you need to resubmit the entire series if any of its part has
> > changed. So please add these patches to your patchset (in place of the
> > 4/5 and 5/5 patches I commented) and resend it as v3.
> 
> Alright.
> Should I wait for Cai's response for patch 1/5 before sending v3. He seems to
> never having woken up in our discussions.

Ok. Let's wait for Cai for sometime. We are in the middle of the
dev-cycle anyway so no reason to rush.

-Serge(y)

