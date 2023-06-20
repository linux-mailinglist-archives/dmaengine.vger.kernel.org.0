Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C986736D6F
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 15:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjFTNfy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjFTNfy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 09:35:54 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB4B7;
        Tue, 20 Jun 2023 06:35:52 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687268150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uv+fbauLcYmaB3LHoaOohcS26YMyzwdt/TWV8wgjBuY=;
        b=lUwkRQ0+JfbrLLNfjnrE/nWP3Wg13DCjxCOejSe3er/wIWAlWKpnX8vqtt1L8wvEKZHs0k
        u8kwYJO+d6N2sGG0bAauaWlTH/5crEoCFVjRNxh7nJkdFv1fHRh1KHYPf9OxZD8VH1W2e5
        pYkGEp1brBmzRYjoGTEldRb+uG4P0+dHdGogUbEYoZywOg7t1wolsKsiwtZRj4GUWRjdYC
        D1ZHq9yHysyz5WK5HNlw4tmZVXuLkEbgQ5N6Z3pKT7xQ86EpLQOGZp4bv2eQH6dahuvMfK
        ev9HGeogjFxVq9X/GsU4J6m7tbO1fvOvR926AfKqpBSC7c+q9r5DVi7eJr3ltA==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C58BE000A;
        Tue, 20 Jun 2023 13:35:49 +0000 (UTC)
Date:   Tue, 20 Jun 2023 15:35:49 +0200
From:   =?UTF-8?Q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 5/9] dmaengine: dw-edma: HDMA: Fix possible race
 condition in remote setup
Message-ID: <20230620153549.0677da97@kmaincent-XPS-13-7390>
In-Reply-To: <wqixf5z7yjbcubjhpkormriptrcihcjezjujmwxihdcagzpzom@igfkbjwuwy7e>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
        <20230609081654.330857-6-kory.maincent@bootlin.com>
        <20230619171550.3iyujmbre3dpe5oq@mobilestation.baikal.int>
        <20230619204105.620f87e6@kmaincent-XPS-13-7390>
        <wqixf5z7yjbcubjhpkormriptrcihcjezjujmwxihdcagzpzom@igfkbjwuwy7e>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 20 Jun 2023 15:07:37 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> > This one is only hypothetical. It appears to me that writing the control
> > after the configuration of sar and dar is more relevant to prevent race
> > issues and should be the usual coding choice. Also you are right saying
> > that it will be relevant only for the LL tree entries recycling.
> > Simple question from non DMA expert: isn't cyclic DMA mode recycle the LL
> > tree entries?   
> 
> Ideally the driver should have been designed in the way you say:
> define a ring of the Linked List entries and recycle the already used
> entries while the already enabled entries are being handled by the
> DMA-engine (a similar approach is described in the DW PCIe/eDMA hw
> manual). DW eDMA engine CSRs and LLI descriptor provide enough
> functionality for that. Alas the driver implementation is more
> straightforward:
> 1. Each DMA-engine config: SG-list, cyclic, interleaved is split up
> into the "burst" entries. SG-list entries are directly mapped to the
> eDMA "burst" entries. Cyclic iterations are unrolled into the
> respective number of eDMA "burst" entries. A similar story with the
> interleaved transactions.
> 2. If there is no enough entries in the Linked-List memory to fully
> execute the requested DMA-transfers, then another so called DW eDMA
> "chunk" is allocated.
> 3. DW eDMA engine executes the "chunks" one after another stopping at
> the end of each one and recharging the engine with the next "chunk" until
> the last one is finished.
> 
> It isn't the most effective architecture, but that's how it was
> originally developed by Gustavo. Anyway discussing it is a good food
> for thoughts for the driver refactoring though.)

thanks for enlightening me, then indeed we will never face the issue solved by
this patches as we won't recycle LL tree entries.
