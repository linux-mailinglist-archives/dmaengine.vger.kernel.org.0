Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32D875FC38
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jul 2023 18:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGXQdG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jul 2023 12:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGXQdF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jul 2023 12:33:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05371BCB;
        Mon, 24 Jul 2023 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zT9PRM5VKBXASCuna41nQx5+V+LYaU5MaTnb4Hysj5E=; b=WH+vK1ybKrHmSEAqrDSYib8wC6
        3eZja4rqaNoS7WeKeLM12649vlbzRO/eddOWGCBYl3P3/JNZxb5fsgmfUacMdAU9lWZAocWHfs+ji
        8jqAPUognQ9oT7n354uA5nBT3d/vcidPQ9qdzY7Jp5z4QJ+hIo7T+IsnX+CWc/uimWxcdlVI8bVoF
        X2YhG/jOmV9WGjeyHCHi1m+02pd/Ml+FLOlkMd92lqT7EeadI24CIA//rvDtyiqoKyiIKusfeWDC+
        oFH/anoQzcKIE4T5+QlG4Ocp46fPum1NtgLLFbgSsggrqmqmeugrRevqZ3UtpuAyPzN4dI5WxHz6G
        l7TE+TJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNyU8-004t5w-2u;
        Mon, 24 Jul 2023 16:32:36 +0000
Date:   Mon, 24 Jul 2023 09:32:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin.Cao@microchip.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        George.Ge@microchip.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, logang@deltatee.com,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZL6npI5YmWJOXB3d@infradead.org>
References: <20230518165920.897620-1-kelvin.cao@microchip.com>
 <20230518165920.897620-2-kelvin.cao@microchip.com>
 <ZGdb8c2JfPTRexJT@matsya>
 <0f04479bc1d0005f80caa984b83743653620555d.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f04479bc1d0005f80caa984b83743653620555d.camel@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Kelvin, can you resend an updated version so that we can finally
get the driver merged for 6.6?

