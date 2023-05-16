Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A270446C
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 07:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjEPFBC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 01:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEPFBB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 01:01:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FBC273D;
        Mon, 15 May 2023 22:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wihNROgq+zlSDzTWmMP9dqi1SJvNx63H4aBgy1GMpNA=; b=eyoSXZiHHHuSOouLtPM248GNxA
        drIabQFrWdqk81FEunIAYAOGTB3q7Qx9yiPxILsdXC+OGBAEf+9+WJATvH0dhRaRRBJhv3pbZLPXS
        1WMWDuS5IvFYSpqBmY50qEq/GAB97tuulcpJYfKnCRslRpD4OhJmEK6T76JgrEMb/3ZUAZIu1ZLv2
        /m/Cka7jfi+x8u3uP7Om7dZkQ85lPKrpB9BPFVrBW7xlxRrPEzj8m4eOb5EenD/mGtopb802wR0v7
        qaAWTn7Y2UdgrSo6QKub8tyrgkm4Qm/9GdXqV2Jw7tXP/ckSqiSN4FOYRROq/6hTE50oVVhbVHahu
        qzw8m9/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pymnw-004NS2-32;
        Tue, 16 May 2023 05:00:56 +0000
Date:   Mon, 15 May 2023 22:00:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin.Cao@microchip.com
Cc:     hch@infradead.org, dmaengine@vger.kernel.org, vkoul@kernel.org,
        George.Ge@microchip.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com, tglx@linutronix.de,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZGMOCBAVvAxMa/lb@infradead.org>
References: <20230423213717.318655-1-kelvin.cao@microchip.com>
 <20230423213717.318655-2-kelvin.cao@microchip.com>
 <ZFH/xhyjm9VTZolE@infradead.org>
 <50e111a3cfecd0f232508d1b03e02d1e25d9d4a9.camel@microchip.com>
 <ZGJMKFrLfU2zc/2P@infradead.org>
 <0ee5aa616475cc39b04c6b9e84db119bc8fc4d53.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee5aa616475cc39b04c6b9e84db119bc8fc4d53.camel@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 15, 2023 at 06:18:07PM +0000, Kelvin.Cao@microchip.com wrote:
> > I find this rather confusing, especially as some code literally
> > switches on the op to fill in either set.
> 
> It's a hardware interface, and not possible to change it at the point.
> I guess I can make it look slightly better by grouping the related
> names together:
> 
> union {
>         struct {
>                 __le32 saddr_lo;
>                 __le32 saddr_hi;
>         };
>         struct {
>                 __le32 widata_lo;
>                 __le32 widata_hi;
>         };
> };

The hardware interface is simply:

	__le32 field_lo;
	__le32 field_hi;

hardware documentation might decide to give those fields two different
names just to confuse you :)

I think everyone else would be served better by:
	
	__le32 addr_lo; /* SADDR_LO/WIADDR_LO */
	__le32 addr_hi; /* SADDR_HI/WIADDR_HI */

