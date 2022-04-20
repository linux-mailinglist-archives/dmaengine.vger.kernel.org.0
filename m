Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF85085A9
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377560AbiDTKVd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343729AbiDTKVd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE21B17E23;
        Wed, 20 Apr 2022 03:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F946178D;
        Wed, 20 Apr 2022 10:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AF2C385A8;
        Wed, 20 Apr 2022 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650449926;
        bh=fM8iwA7wpMED3bdRgkL0bBIGxLtGUbzgscjiJ7Sxghs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJ5mRG2lzNqqdeKzmnRYWjH8w9HFJ3Yy0EMdpV8oUo95U89pxlQrDscz1GwMRuWTF
         RkrdlsC37MQChS8Q39pix+E0bhjGrut3We9XUmxj4MxsbrwN9/ByzRrglh4LCu/uwc
         mtssJUUcE+4tW2rQQpZdCc5kawjUkQA4LA6+PbPDnWzCbBA5oX6HW53n0lXZH6pJwt
         BZ9s3J95M7MzHo5NLStKuv5zfd22MDfMqUARYbUC8RJTlqmfxYrbrOWqsllUMDWspg
         vUheAUWbbxwhSzaWHekSKUchFGx4QwntRnKJ8B9Pmsdu/pNEeCUHKMk6Lq5KgDDPqq
         DNioFJlMBYKtQ==
Date:   Wed, 20 Apr 2022 15:48:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 2/2] dmaengine: imx-sdma: support hdmi audio
Message-ID: <Yl/eAomzpAyDSDjW@matsya>
References: <20211021051611.3155385-1-joy.zou@nxp.com>
 <YXY2M0td08eDCi+9@matsya>
 <AM9PR04MB88757229F10CBB693F90E486E1F39@AM9PR04MB8875.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM9PR04MB88757229F10CBB693F90E486E1F39@AM9PR04MB8875.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-04-22, 04:06, Joy Zou wrote:
> Hi Vinod,
> 
> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org> 
> Sent: 2021年10月25日 12:45
> To: Joy Zou <joy.zou@nxp.com>
> Cc: Robin Gong <yibin.gong@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH 2/2] dmaengine: imx-sdma: support hdmi audio
> 
> Caution: EXT Email
> 
> On 21-10-21, 13:16, Joy Zou wrote:
> > Add hdmi audio support in sdma.
> 
> Pls send a series together and chained. They appear here as disjoint patches
> 
> The audio and dma patches always are separate. The audio driver owner will send audio patches
> after the dma patches are accepted.  

Please use the proper formating while replying, this makes it _hard_ for
people to understand!

Next, the whole patch series was not threaded, they appeared as disjoint
patches in my mailbox. A series should appear as a single thread...

Please fix that in next post
-- 
~Vinod
