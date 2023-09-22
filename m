Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65BA7AB60E
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 18:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjIVQeH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIVQeG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 12:34:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845A114;
        Fri, 22 Sep 2023 09:34:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32008e339adso2304862f8f.2;
        Fri, 22 Sep 2023 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695400438; x=1696005238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkDZtszQ+UHkMPtdGr7RA5ZQQqpUUNchTvgj6snT3r4=;
        b=iZfMstvZFrs6WMN+DRIfjxSHkncKo9HFg/Cwxtmlo87X0CHvfK7bVYPHtELj2YAwSp
         set9eXdSZUXHr6toWU/xFgUIkwuIQwkPi0KnWwPXZHWo4afsUF3XlrkdYE+z85P0Rp4d
         YRgvICCn7CXeYWCzVy9CI7vRg8JeBBBhsARLiAlNds2RpChq3XQVOpR79MX9lfjmWnBc
         AGFNqMYsJeNPot8SIYBWs6sd9ekA8PQuf8lyrniqXk/1qzJM/Oxgfd5YPm/ksxlBbrod
         OKqNVddhef07w85/bOJgmnsnfrqGXHjArFL4oiisGDBpjTLFvtgfCqbRqRevYYSAizVT
         9rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400438; x=1696005238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkDZtszQ+UHkMPtdGr7RA5ZQQqpUUNchTvgj6snT3r4=;
        b=svsSNcdpz5om+FXRufbD+DKYpl2r6KRJbRzaR16HZuJTP96amvwp+xSz9vaYO0+q3E
         l7UNua/Ev4Sr7Y5++c6Ucfa5y8ib9uESBSRfqqNO7FcOgFcNneGXfW1a2e3Yn14aK1ix
         zcCIiSBspVK1hp3edFSBdFLodWVQqHduZwVSPM93wJmPeAbzgzRD17IcIPjXM9nSdfGL
         vmo18EBQmmFjNPZvx3LDZdX+AZVR3i+U93xEXEmjS0IvE8soTFA3v8bBP+EUGUX8Bmsr
         27cNr9I8FMPNH8b9lCe9anxwgBjjRdIy1WI16NNAR0SFtuS/isPA5zeqTSj4e47HBaDd
         6B1w==
X-Gm-Message-State: AOJu0YyVw4LYSLtfgq0aiuvJ1qN5KCF1luw6O5Yk0IVxn/qyaR8O2vOx
        q/elTrM/OIdrPszIdK6cUC3oxDgu6942VINa
X-Google-Smtp-Source: AGHT+IEzVs58OCT4qIw+qVb7rJWnifIFxLH/lm7FSkAJ2vjb/rKjkFs+p1w/R40zERMnyKBkYnY1ww==
X-Received: by 2002:a5d:6a8c:0:b0:31f:f2dc:db7d with SMTP id s12-20020a5d6a8c000000b0031ff2dcdb7dmr132107wru.65.1695400438208;
        Fri, 22 Sep 2023 09:33:58 -0700 (PDT)
Received: from freebase (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.gmail.com with ESMTPSA id p14-20020adfe60e000000b003197b85bad2sm4857547wrm.79.2023.09.22.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:33:57 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:33:56 +0200
From:   Olivier Dautricourt <olivierdautricourt@gmail.com>
To:     Eric Schwarz <eas@sw-optimization.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] dmaengine: altera-msgdma: fix descriptors freeing logic
Message-ID: <ZQ3B9NWVmLvaVhJX@freebase>
References: <20230920200636.32870-3-olivierdautricourt@gmail.com>
 <22402987-305b-024b-044e-53db17037d90@sw-optimization.com>
 <ZQyWsvcQCJgmG5aO@freebase>
 <8d18106d-444e-9346-26cc-3767540df5d8@sw-optimization.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d18106d-444e-9346-26cc-3767540df5d8@sw-optimization.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Eric,

On Fri, Sep 22, 2023 at 09:49:59AM +0200, Eric Schwarz wrote:
> Hello Olivier,
> 
> > > Am 20.09.2023 um 21:58 schrieb Olivier Dautricourt:
> > > > Sparse complains because we first take the lock in msgdma_tasklet -> move
> > > > locking to msgdma_chan_desc_cleanup.
> > > > In consequence, move calling of msgdma_chan_desc_cleanup outside of the
> > > > critical section of function msgdma_tasklet.
> > > > 
> > > > Use spin_unlock_irqsave/restore instead of just spinlock/unlock to keep
> > > > state of irqs while executing the callbacks.
> > > 
> > > What about the locking in the IRQ handler msgdma_irq_handler() itself? -
> > > Shouldn't spin_unlock_irqsave/restore() be used there as well instead of
> > > just spinlock/unlock()?
> > 
> > IMO no:
> > It is covered by [1]("Locking Between Hard IRQ and Softirqs/Tasklets")
> > The irq handler cannot be preempted by the tasklet, so the
> > spin_lock/unlock version is ok. However the tasklet could be interrupted
> > by the Hard IRQ hence the disabling of irqs with save/restore when
> > entering critical section.
> > 
> > It should not be needed to keep interrupts locally disabled while invoking
> > callbacks, will add this to the commit description.
> > 
> > [1] https://www.kernel.org/doc/Documentation/kernel-hacking/locking.rst
> 
> Thanks for the link. I have read differently here [2] w/ special emphasis on
> "Lesson 3: spinlocks revisited.".
> 
> [2] https://www.kernel.org/doc/Documentation/locking/spinlocks.txt
> 

This chapter [2] says that our code must use irq versions of spin_lock
because our handler does indeed play with the lock. However this
requirement does not apply to the irq handler itself, as we know that the
interrupt line is disabled during the execution of the handler (and our
handler is not shared with another irq).

Kr,
Olivier

> Cheers
> Eric
