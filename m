Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D2768D4B
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGaHKp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 03:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjGaHKF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 03:10:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D2170C;
        Mon, 31 Jul 2023 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HZ0fHzEF1IDA+OwOdO/wmBaqmw
        f+RwsFGQXCDRt3W0lBlu8eY3r3mavsFYM5RrvZa0KqhnmYBowCNI2otSBFOQ3TkcDi3YJHAgH1Jtp
        zJxNE+ou/nIc/fqDXKZv8u2Tz9BhILnnt3Ow4RrqTXKNywErYltNSwsDwzDwsZu7J+waCP8mU2XJf
        cOPrYPfLbxX30XiOiXKO7ZLNVYVixsd5vF9GOgcSifscuZlTrfSkZIYlzXXw7yz/H0rZ+7aQrl+m1
        wWgpXihx/+Nm/TBzDwexehREoLjp/wkWqLquWpYQewgfTZ7G3iMnyS1caIrvnUEDpIWdFFI8QNo/X
        7CmrZFXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQN0r-00EGuv-1j;
        Mon, 31 Jul 2023 07:08:17 +0000
Date:   Mon, 31 Jul 2023 00:08:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin Cao <kelvin.cao@microchip.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, logang@deltatee.com,
        George.Ge@microchip.com, christophe.jaillet@wanadoo.fr,
        hch@infradead.org
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZMdd4SpqhLnOxqwb@infradead.org>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
 <20230728200327.96496-2-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728200327.96496-2-kelvin.cao@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
