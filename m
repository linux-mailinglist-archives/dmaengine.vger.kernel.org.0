Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E766272DF
	for <lists+dmaengine@lfdr.de>; Sun, 13 Nov 2022 23:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiKMWX5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Nov 2022 17:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiKMWX4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Nov 2022 17:23:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D925C1;
        Sun, 13 Nov 2022 14:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 275E1B80CB8;
        Sun, 13 Nov 2022 22:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8072C433C1;
        Sun, 13 Nov 2022 22:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668378232;
        bh=qy55WPYerqcowUha2cX++DDpKUAHFQlKC0fdFGVcpHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SoQ/8IZXKeJoAmMxfCyyKF45rJlVx7biYRJuwEa1vHJV+4VpmfIQJZU310sVIY461
         UyETUaEUL8pGSUYDnT5bL+wvSW9ndL0E7OfHKaVlxpUl1Gs/CI2MnkW3ORaFnkDB4S
         S7pizrgGDcS7NdbCPoe0rpol9vBOoYaDFhDarwxk0PhW8Na42UWF216GK6mMT7pS4/
         EgKyf0waOMFEZugZQfRz7wosYxYbPIyF8O5nwO987MxYz9LOm8vs+VSyFuFDxEzXnU
         7hGcgbCwaWcz0/keEnJhCZS0rVYtNdMsFVWqPnOTf5G3+/2GLOHcrEIaY3gI0fagRG
         X0BKamPIfaA5w==
Date:   Mon, 14 Nov 2022 03:53:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/3] dmaengine: Add support for immediate commands
Message-ID: <Y3FudBqc1vQ8fEgU@matsya>
References: <20221027051429.46593-1-sireeshkodali1@gmail.com>
 <Y2UIS7P0alvqT4jn@matsya>
 <CO97J91UP8IF.23GNHUUM2KTVH@skynet-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO97J91UP8IF.23GNHUUM2KTVH@skynet-linux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-11-22, 10:42, Sireesh Kodali wrote:
> On Fri Nov 4, 2022 at 6:10 PM IST, Vinod Koul wrote:
> > On 27-10-22, 10:44, Sireesh Kodali wrote:
> > > The IPA v2.x block, found on some older Qualcomm SoCs, uses BAM DMA to
> > > send and receive packets from the AP. It also uses BAM to receive
> > > commands from the AP (and possibly the modem). These commands are
> > > encoded as "Immediate Commands". They vary from regular BAM DMA
> > > commands. Adding support for immediate commands is trivial, but requires
> > > also adding Immediate Commands to the dmaengine API, which is what this
> > > patch series does.
> >
> > Can you explain a bit more. I understand you need "Immediate Commands"
> > but am really reluctant to add another interface to support a specific
> > use case
> >
> 
> Apologies for the delayed response
> 
> BAM supports both regular commands, and "immediate commands". Currently,
> commands are used by the Qualcom NAND chip driver, while "immediate
> commands" are intended to be used by the (yet to be mainlined) IPA
> driver. From the BAM driver perspective, both immediate and regular
> commands are simply a matter of setting the appropriate flag in the
> descriptor. I don't have access to the documentation on BAM to know
> exactly how these two modes differ, however I do know they are not
> interchangable. If a different API is suggested, I can change the
> implementation as needed.

Ok, can you please explain what is meant by 'regular' cmd and
'immediate', lets see what is required here

-- 
~Vinod
