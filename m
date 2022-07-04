Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE66B56597E
	for <lists+dmaengine@lfdr.de>; Mon,  4 Jul 2022 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiGDPKR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Jul 2022 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbiGDPJu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Jul 2022 11:09:50 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40FA11A25;
        Mon,  4 Jul 2022 08:09:04 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 03C6F22175;
        Mon,  4 Jul 2022 17:09:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656947343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtM/v1+4WZK9BC0YUHLMqA8epAr6ytcz/wbNfrpgB9Y=;
        b=Eng3kpt8EktgSOgpk0IO/2kVPXBCuteNg7Sjgf+45R7PTMVdieA9dsLgnNrJeKKIOJFF5j
        CCLzh52VTd29sCPnN1C0Vb/VwIyV6mFaYF9n5TkvkQW7fLhPcJvPz/rNhT8qEO/8v5aIIK
        YowBALSMawxasc2T5heaRbNGSbep1k8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Jul 2022 17:09:02 +0200
From:   Michael Walle <michael@walle.cc>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdma: handle errors of
 at_xdmac_alloc_desc() correctly
In-Reply-To: <20220526135111.1470926-1-michael@walle.cc>
References: <20220526135111.1470926-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4060a926aba97cc1750d2964932ab40d@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am 2022-05-26 15:51, schrieb Michael Walle:
> It seems that it is valid to have less than the requested number of
> descriptors. But what is not valid and leads to subsequent errors is to
> have zero descriptors. In that case, abort the probing.
> 
> Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel
> eXtended DMA Controller driver")
> Signed-off-by: Michael Walle <michael@walle.cc>

ping :)
