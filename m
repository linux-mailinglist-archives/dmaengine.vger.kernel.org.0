Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31F554E09
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 16:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbiFVO5L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358227AbiFVO5K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 10:57:10 -0400
Received: from neon-v2.ccupm.upm.es (neon-v2.ccupm.upm.es [138.100.198.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F43D495;
        Wed, 22 Jun 2022 07:57:09 -0700 (PDT)
Received: from localhost (82-69-11-11.dsl.in-addr.zen.co.uk [82.69.11.11])
        (user=adrianml@alumnos.upm.es mech=PLAIN bits=0)
        by neon-v2.ccupm.upm.es (8.15.2/8.15.2/neon-v2-001) with ESMTPSA id 25MEoQsf031852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 14:50:26 GMT
Date:   Wed, 22 Jun 2022 15:50:21 +0100
From:   Adrian Larumbe <adrianml@alumnos.upm.es>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: remove DMA_MEMCPY_SG once again
Message-ID: <20220622145021.r42vlkmokd3eqmqe@sobremesa>
References: <20220606074733.622616-1-hch@lst.de>
 <Yp4/JW4P12s4siRz@matsya>
 <20220606195455.qmq3yu6mc6g4rmm2@sobremesa>
 <Yp7OFYFp7oyjyKx1@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yp7OFYFp7oyjyKx1@matsya>
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 3.1.7 on neon-v2.ccupm.upm.es, sigver: 7.92179
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07.06.2022 09:33, Vinod Koul wrote:
> There are no clients in mainline which call this API. There is a driver
> which implements this API, but no users...
> 
> $ git grep dmaengine_prep_dma_memcpy_sg
> include/linux/dmaengine.h:static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_sg(

This is true, when I sent this I thought my at the time employer had already
upstreamed their driver changes which make this of this API call, but apparently
it never happened after I left.

In this wise, this change series should probably go away altogether, even if
that means it leaves that driver feature unutilised.

Adrian Larumbe
