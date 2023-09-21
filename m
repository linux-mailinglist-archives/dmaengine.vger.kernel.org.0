Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8D7AA298
	for <lists+dmaengine@lfdr.de>; Thu, 21 Sep 2023 23:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjIUVWT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjIUVWC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 17:22:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F12B100A42;
        Thu, 21 Sep 2023 12:17:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401da71b85eso14388775e9.1;
        Thu, 21 Sep 2023 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695323830; x=1695928630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENmOmmDyO4dkcD1BpyQlNPkn3uQwit51bry3W/ndj4k=;
        b=SDjx4jzKKf7zErScli/HMCzeFCL8iE/OKs31+eJyVAWt8GnJfwbu4UheOvK9owIfuT
         S8S5sxbuFmocpAR83VNquLxEKCiTHvVeNCt+16jSxsjcnHN9iCli10eIDr7zQvqhhxnq
         MF5pG9WMz95JTpE4dYR2ZSGrYV0Icsg20TixG4VOPBYg3u6YM0lYKHWx/Iq6dKdbz+LI
         Fr2E5LFKUUW58e50htN4u/XSAaER4W29IQ8V7L6L6pTKR9JT24z3JDN1PwX9EtjYa3Iw
         C/DhKnuEVGtxqv8FL0J69MnOGDj6WVDQyNkXnY3X6TNBBLhzXM5nCzhFOEcqEx1izra5
         Hq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323830; x=1695928630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENmOmmDyO4dkcD1BpyQlNPkn3uQwit51bry3W/ndj4k=;
        b=WbkHm0Cr3JW/gORMh3aUF9zWKcQMv3P4PsbuaXB9EAW4fNmwAXGlytlOHtxR4toXPx
         +l/91oh+sq1THe/FLhQUwJ32AqyxNUiAPL3MEda+v1YpiigfPnc0kn0k5pKF4Y1psiv3
         omf9fx/w0+KJS9jq65CHtUDO60mLuSAgtS7W76T+CKDTLoGSrbn8ijcvp8dAIOgdcUfn
         JYVC5R2worue5TP3eYoig2iBDT47SVNOfVenoOxElloNNSZX/Zj+ofN1GkbKw6Cwfnbu
         ISJS0upzT1Rpmf5JCt7EVckaH5xIjjTNn3uF50I0BSulTVbtK1p7TPvtjV0SeMNoAnRL
         D5JA==
X-Gm-Message-State: AOJu0YyGmWvFcKoN6bakB38XACnzPcPlUooMd9aRxhFXrUsDWmDWpN58
        y+G9/489N9X97e6Tfm6F4DI=
X-Google-Smtp-Source: AGHT+IHz3TLJG+ziEtoS9dFznj7pMmUdXA3BCjDrGwVomS3vMGyxNpUFAZCye+dXZh/r/eGoltERuw==
X-Received: by 2002:a05:600c:46c6:b0:405:36d7:4582 with SMTP id q6-20020a05600c46c600b0040536d74582mr1921439wmo.15.1695323829463;
        Thu, 21 Sep 2023 12:17:09 -0700 (PDT)
Received: from freebase (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fef19bb55csm2621945wml.34.2023.09.21.12.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:17:09 -0700 (PDT)
Date:   Thu, 21 Sep 2023 21:17:06 +0200
From:   Olivier Dautricourt <olivierdautricourt@gmail.com>
To:     Eric Schwarz <eas@sw-optimization.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] dmaengine: altera-msgdma: fix descriptors freeing logic
Message-ID: <ZQyWsvcQCJgmG5aO@freebase>
References: <20230920200636.32870-3-olivierdautricourt@gmail.com>
 <22402987-305b-024b-044e-53db17037d90@sw-optimization.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22402987-305b-024b-044e-53db17037d90@sw-optimization.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 21, 2023 at 03:07:15PM +0200, Eric Schwarz wrote:
> Hello Olivier,
> 
> thanks for following up on my comment first. I really appreciate. - I don't
> have access to the hardware anymore, so I cannot test changes myself.
> 
> This patch addresses IMHO three fixes. - Shouldn't it be split up into three
> small junks so one could also later work w/ git bisect / separate ack's? -
> That way it is an all or nothing thing. Please regard this remark as
> cosmetics.
> 
> Am 20.09.2023 um 21:58 schrieb Olivier Dautricourt:
> > Sparse complains because we first take the lock in msgdma_tasklet -> move
> > locking to msgdma_chan_desc_cleanup.
> > In consequence, move calling of msgdma_chan_desc_cleanup outside of the
> > critical section of function msgdma_tasklet.
> > 
> > Use spin_unlock_irqsave/restore instead of just spinlock/unlock to keep
> > state of irqs while executing the callbacks.
> 
> What about the locking in the IRQ handler msgdma_irq_handler() itself? -
> Shouldn't spin_unlock_irqsave/restore() be used there as well instead of
> just spinlock/unlock()?

IMO no:
It is covered by [1]("Locking Between Hard IRQ and Softirqs/Tasklets")
The irq handler cannot be preempted by the tasklet, so the
spin_lock/unlock version is ok. However the tasklet could be interrupted
by the Hard IRQ hence the disabling of irqs with save/restore when
entering critical section.

It should not be needed to keep interrupts locally disabled while invoking
callbacks, will add this to the commit description.

[1] https://www.kernel.org/doc/Documentation/kernel-hacking/locking.rst

> 
> > Remove list_del call in msgdma_chan_desc_cleanup, this should be the role
> > of msgdma_free_descriptor. In consequence replace list_add_tail with
> > list_move_tail in msgdma_free_descriptor. This fixes the path:
> > msgdma_free_chan_resources -> msgdma_free_descriptors ->
> > msgdma_free_desc_list -> msgdma_free_descriptor
> > which does __not__ seems to free correctly the descriptors as firsts nodes
> > where not removed from the specified list.
> > 
> s/__not__/_not_/
> s/seems/seem/
> s/firsts/first/ => Actually I would omit it.
> s/where/were/
> 
> "Fixes: <12 digits git hash> ("commit-message")" is missing [1] isn't it?
> 
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Thank you for your remarks/corrections, i will take them into account
in next version of the patch.

Kr,

Olivier Dautricourt
