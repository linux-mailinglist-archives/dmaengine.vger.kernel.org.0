Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B492769B2B
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGaPtn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGaPtl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 11:49:41 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDDAE57;
        Mon, 31 Jul 2023 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=twFza+B43PJVca/0XMZQfg0EG4BffzNr2MTjAkF3cFQ=; b=DJknpY2jAxri64jhi+WKqLlMnh
        EfPFjbLa44bTaJ0dDPg5RQoVo5S82hnJ7RG2tA3t98Pr6dMVMyCmT4PaP4zGZV9dI3kMQdovXNtM0
        FUuFG4m2uHsXhyN8t/iyLH9Ftn+uxt+QX0zcFd0GzEqINJ0X386p4Jc7UCrzPo8w80iIbUj9bR1Th
        1ZrsBV0ncI0CzBwLnH3XY4A8FF//81CHgve9laBIu7SNhpespuPTf/7MPNuKmTPivHb1lvluvmn8u
        F9fYyx95YgtHSBRRwuQZ5ekvTHtQsJEm+rWT84KzDZxStnPL0zW27SU4hNT5WLqOADACCosEAdAb+
        5x3IGOAw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qQV9N-00Fof0-KG; Mon, 31 Jul 2023 09:49:38 -0600
Message-ID: <ac8b230a-992c-66c0-4a46-f076890ce5d0@deltatee.com>
Date:   Mon, 31 Jul 2023 09:49:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-CA
To:     Kelvin Cao <kelvin.cao@microchip.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     George.Ge@microchip.com, christophe.jaillet@wanadoo.fr,
        hch@infradead.org
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230728200327.96496-1-kelvin.cao@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kelvin.cao@microchip.com, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, George.Ge@microchip.com, christophe.jaillet@wanadoo.fr, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v6 0/1] Switchtec Switch DMA Engine Driver
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023-07-28 14:03, Kelvin Cao wrote:
> This patchset is based off of 6.5.0-rc3.
> 
> Kelvin Cao (1):
>   dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver
> 
>  MAINTAINERS                 |    6 +
>  drivers/dma/Kconfig         |    9 +
>  drivers/dma/Makefile        |    1 +
>  drivers/dma/switchtec_dma.c | 1570 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1586 insertions(+)
>  create mode 100644 drivers/dma/switchtec_dma.c
> 

Looks good to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
