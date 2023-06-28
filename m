Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F11740F91
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jun 2023 13:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjF1LC6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jun 2023 07:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjF1LCy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Jun 2023 07:02:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926651FCD;
        Wed, 28 Jun 2023 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OjshFGISJ/qtJIee/CUzi6GtoPX/MHew0Bsta1Jvsfg=; b=yn0gV3wpaCQWMUh0Fg/AzYfxb8
        6CISsIPZMNCkKVee+RyGOVprK1JXROr/VAxH19hDNag82NfTUu+CWo29Lu2glfhOT/W/q0o+wia6e
        tCTq+4fmjwJttF0lwZx8P7I9TKY9iqvezVEcbGpCWhFr/eACeS+Tlk1xWKnerPmuLbNJrELtnB0dU
        h7aD1F1EJ0BJmwXcCTrMXXJacDrphakL+79zrUJIDkyRdMe6Fb7eTjsshEHCcGEaRot/84LRsF0Wo
        wxbgssq+qA1w7D4nKvZ1Yirexug/goORl42ceb7pxCav+hJXhPHNWLjKixAp7YNJBeUeRA4Xx9YJD
        SmSLPDxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57630)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qESwi-0007CA-37;
        Wed, 28 Jun 2023 12:02:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qESwi-0006hD-0w; Wed, 28 Jun 2023 12:02:48 +0100
Date:   Wed, 28 Jun 2023 12:02:47 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Li Chen <me@linux.beauty>
Cc:     dmaengine <dmaengine@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: Should dma_map_single take the dma controller or its consumer as
 an argument?
Message-ID: <ZJwTV59xRlUBit+N@shell.armlinux.org.uk>
References: <18901a6cbf0.c9e3e099688173.4166132371304083225@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18901a6cbf0.c9e3e099688173.4166132371304083225@linux.beauty>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 28, 2023 at 06:57:35PM +0800, Li Chen wrote:
> Hi all,
> 
> I recently encountered an issue where the dma_mask was set in the DMA controller's driver, but the consumer peripheral driver didn't set its own dma_mask.

It should always take the device that is *actually* performing the DMA,
since that is the device that has restrictions on what addresses can be
accessed, etc.

Devices that "consume" the data from a DMA controller don't access
memory - they are merely the targets, and they can't on their own access
host memory. Therefore, their dma mask _should_ be irrelevant.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
