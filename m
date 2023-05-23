Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2370D385
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 08:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjEWGCH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 02:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjEWGB6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 02:01:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1D811F;
        Mon, 22 May 2023 23:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OaOMCR7fpn4AH8lOHYhg4P7LtL82TVT9xgUTAlrYnFg=; b=aE9a38dovcUEa3oKik3KzpykBZ
        kWp8f6lHaMC+6RJ6YdI1wUnt4H+wRL5TeBoQGvNMeZo7TE8NZ9aSHfPCrD2AsGrP0njpes+V5zdsz
        KzG/LGKF1xZrBErxXFEjlMooGiOb5p1/vDwGDH1RQtXfD/LZGj2znEvGZcAbM1BUPB69m+Rj79YFa
        a9PTQJZrjEITvp2mNfuh7oGKt0T3Zq51SPhyrggZtBYAfFX1RoFXSVcz6op2MOjLOoTgAMDLoCYRS
        iiSYYDHyLwBZJtkgYyKrt3u/Pk3aVf5uSrFWLuJ2gZEMyCTwkZOLlivkaotmQs/He6HHE6YJEGd2+
        L3utU1oQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1L5n-00920N-1t;
        Tue, 23 May 2023 06:01:55 +0000
Date:   Mon, 22 May 2023 23:01:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kelvin Cao <kelvin.cao@microchip.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, logang@deltatee.com,
        george.ge@microchip.com, christophe.jaillet@wanadoo.fr,
        hch@infradead.org
Subject: Re: [PATCH v5 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZGxW0wAosLt/v2I1@infradead.org>
References: <20230518165920.897620-1-kelvin.cao@microchip.com>
 <20230518165920.897620-2-kelvin.cao@microchip.com>
 <ZGdb8c2JfPTRexJT@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGdb8c2JfPTRexJT@matsya>
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

Hi Vinode,

I've tried to read your review, but as you're not trimming the
quoted text it was impossible to read.  Can you resend it following
proper mailing list ettiquette?

