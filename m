Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F81736B97
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjFTMHu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjFTMHt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 08:07:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36557F1;
        Tue, 20 Jun 2023 05:07:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6039797e87.2;
        Tue, 20 Jun 2023 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687262860; x=1689854860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hIxyfJn46stbA6TKyi/zMvK8a4YI0RbVarM5jbmdCAI=;
        b=dkuIt6osufFzTki+hy/uy6RdR9DsDdJiZGrP6NI7OaCvLOdGgP7CfO0odxg7ldZoPQ
         QShVdSHclEcpPl+4R9CaSLRLxj6jhqVbwOLsSQyPDGd2hbGdJZq7n2Ntn+Xk1JhOWgmy
         jurch4Kqc5RXuHYmK0xOby9chWtbjUKeFO/8qFBTyuSGThWO+RwhZTf7Ccqmy1FnOjln
         Wr7WBeEMzA6AEcj434yracH0yzQoYPVLQ5JETmadZju+qBN6nAMv8MLcmDxpqOZ4ORS5
         lzvb28rZPyo1JkuofxIh7sAzPqlK1tvkPjRcAO6Bk4JpJY4S3VlwQpsERRqGu/B4nHvF
         KWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687262860; x=1689854860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIxyfJn46stbA6TKyi/zMvK8a4YI0RbVarM5jbmdCAI=;
        b=HjxWwvWH52ueVaQWs5DF19+DCiImYrN+aiMwHklK5+rZoMQUDQxePS3JUKADtCcP33
         +iZJ6HwV6yvHR/AhWW1/md/Rtzq53o1LTK4vEHz1dx5eU31u6N4fy+GCEpUPKaRo18Fh
         X8Zs8TInki/5MsV2qRqkk4Sx+3crqsB6nunpBtT0tQ3D4pJcQ4eVu0U1v/nGXsqA/qhG
         f5tHkrutCfnLL90sS1VTKcVgIpW3ct3GeSOAmdaYxi1aWzYYuEDjt43tGC+do+XYz0a3
         vc18RyyHwxKmZsOerXZ8DBGqstQ+H3FkDUNjfnbRLgdozNkFMDIf1m4uA7mbLME3IKP0
         7FfA==
X-Gm-Message-State: AC+VfDz/t8ibYEtzxNWawWfRbpkufI2FM+yNGdI/cJIhcLqjxIA6ihn1
        JDS1CBKBKRKjqeDyePt4vsM=
X-Google-Smtp-Source: ACHHUZ4IIgcrz0VmldYF7wcBKEgY95O5jWYzrGR+Szk9ZQiUVZrfiaKmKImH7VUgbVKmbK0ick+wfw==
X-Received: by 2002:a19:6909:0:b0:4f8:7513:8cb0 with SMTP id e9-20020a196909000000b004f875138cb0mr2555748lfc.2.1687262859758;
        Tue, 20 Jun 2023 05:07:39 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id f26-20020a19ae1a000000b004f3b3f5751bsm333936lfc.275.2023.06.20.05.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:07:39 -0700 (PDT)
Date:   Tue, 20 Jun 2023 15:07:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 5/9] dmaengine: dw-edma: HDMA: Fix possible race
 condition in remote setup
Message-ID: <wqixf5z7yjbcubjhpkormriptrcihcjezjujmwxihdcagzpzom@igfkbjwuwy7e>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-6-kory.maincent@bootlin.com>
 <20230619171550.3iyujmbre3dpe5oq@mobilestation.baikal.int>
 <20230619204105.620f87e6@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619204105.620f87e6@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 19, 2023 at 08:41:05PM +0200, Köry Maincent wrote:
> On Mon, 19 Jun 2023 20:15:50 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > On Fri, Jun 09, 2023 at 10:16:50AM +0200, Köry Maincent wrote:
> > > From: Kory Maincent <kory.maincent@bootlin.com>
> > > 
> > > When writing the linked list elements and pointer the control need to be
> > > written at the end. If the control is written and the SAR and DAR not
> > > stored we could face a race condition.
> > > 
> > > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > 
> > Once again. Is this a hypothetical bug or have you actually
> > experienced the denoted problem? If you do please describe the
> > circumstances, give more details. Otherwise it sounds weird. Here is
> > why.
> > 
> > DW eDMA HW manual states that the control LL DWORD is indeed supposed
> > to be written after the rest of the descriptor DWORDs are written. But
> > AFAICS it's only relevant for the LL tree entries recycling. Current
> > DW eDMA driver design doesn't truly implement that pattern. Instead
> > the DMA transfer is halted at the end of the chunk. Then the engine is
> > recharged with the next chunk and execution is started over. So the
> > runtime recycling isn't implemented (alas) for which the CB flag of
> > the control DWORD needs to be updated only after the rest of the LLI
> > fields.
> 

> This one is only hypothetical. It appears to me that writing the control
> after the configuration of sar and dar is more relevant to prevent race issues
> and should be the usual coding choice. Also you are right saying that it will
> be relevant only for the LL tree entries recycling.
> Simple question from non DMA expert: isn't cyclic DMA mode recycle the LL tree
> entries? 

Ideally the driver should have been designed in the way you say:
define a ring of the Linked List entries and recycle the already used
entries while the already enabled entries are being handled by the
DMA-engine (a similar approach is described in the DW PCIe/eDMA hw
manual). DW eDMA engine CSRs and LLI descriptor provide enough
functionality for that. Alas the driver implementation is more
straightforward:
1. Each DMA-engine config: SG-list, cyclic, interleaved is split up
into the "burst" entries. SG-list entries are directly mapped to the
eDMA "burst" entries. Cyclic iterations are unrolled into the
respective number of eDMA "burst" entries. A similar story with the
interleaved transactions.
2. If there is no enough entries in the Linked-List memory to fully
execute the requested DMA-transfers, then another so called DW eDMA
"chunk" is allocated.
3. DW eDMA engine executes the "chunks" one after another stopping at
the end of each one and recharging the engine with the next "chunk" until
the last one is finished.

It isn't the most effective architecture, but that's how it was
originally developed by Gustavo. Anyway discussing it is a good food
for thoughts for the driver refactoring though.)

-Serge(y)

> 
> > 
> > If you described a hypothetical problem then it would be ok to accept
> > the change for the sake of consistency but I would have dropped the
> > Fixes tag and updated the patch description with more details of the
> > race condition you are talking about.
> 
> Alright, I will do that.
> 
> Köry
