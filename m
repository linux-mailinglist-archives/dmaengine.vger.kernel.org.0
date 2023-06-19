Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0AF735D5F
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjFSSQx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjFSSQx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 14:16:53 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CF591;
        Mon, 19 Jun 2023 11:16:51 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687198610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3SJVVB3I/o7s3w8i6BUpeuEk9O3Ptdcu8ZoU9qVG5mg=;
        b=R+pvjwEI1DVQcIu0Qiu7cUrmHuBUkC/dahQCBVcJOHb5ZUkUXwRFH5VErAFRSC61udFh/6
        WPvpiGabmz5gizDNkft88ZO2spQp8EA04RE2TlKDDay2YjJQ597oWKIYhWx954/o3pHd0o
        UK5WTiTgm7jtZfhCNFd/tvEBGiVpMFGHJnG+09I4IF0iIGwyvKHw9NGPRUTUwNb/qvJl/E
        PvtQrH2YPloLyXrJSvsK3FXB0Cd4pvUnb0RTkck1A7wcqiW6uNr/PYc4WNt5yEs4ccClWx
        IZ9LtDk67XDRSxPJ1Y5tQwtzY01c86LonQvUS2ci3OinVIolvwyNrfzfaHi8mA==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA78AFF804;
        Mon, 19 Jun 2023 18:16:48 +0000 (UTC)
Date:   Mon, 19 Jun 2023 20:16:47 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 3/9] dmaengine: dw-edma: Add HDMA remote interrupt
 configuration
Message-ID: <20230619201647.7cfe12c9@kmaincent-XPS-13-7390>
In-Reply-To: <20230618214800.5h4ni43vu2admho5@mobilestation>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
        <20230609081654.330857-4-kory.maincent@bootlin.com>
        <20230618214800.5h4ni43vu2admho5@mobilestation>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 19 Jun 2023 00:48:00 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> Seems reasonable especially seeing there is a code with a similar
> semantic in the dw_hdma_v0_core_write_chunk() method.
> 
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Just curious whether we really need to have the local IRQs left
> enabled for the remote device setup... The only case I have in mind is
> that it would be useful to signal a remote end-point host of such
> event in some application-specific environment. It sounds exotic but
> still possible.

Thanks for your review.
Yes, we do need to let local IRQs enabled. I have tested to remove them and it
prevent the remote setup to function correctly on my board. Maybe it needs to be
set to know internally when the transfer is done, but it seems weird. I haven't
a full explanation for now.
