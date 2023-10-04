Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F0B7B78C2
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 09:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbjJDHcn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjJDHcm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 03:32:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDE398;
        Wed,  4 Oct 2023 00:32:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A05CC433C8;
        Wed,  4 Oct 2023 07:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696404759;
        bh=c0sblUv/k3X4rxTQo+ycwCdkeBNEQJr2yNqOWAvpvUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GUkqFgUUE8h0HfcvopN8fByxCJBWsDAt9UKULj1nw1/yX3zaDtTlGMKBi6RC2grO3
         Zk5c5QDAQ4QZT2PER4+fHZvqU2SS3/h+lWtEu9xD7LT5EmEvNX+UH9MgfIhBr2WrjK
         G+vkNn+ImkA1OU3JYFiLFwb44uaa3VTJH0Yv4yQyw051ti9MC0Lv/F2Jqy5he97lWC
         L7OhjaAqAyHV6D/o5Y8AUeRLI8tYKPx2vs5pOk5QmOk1ktgaGImN+mbODXDNCf/Bnu
         /OAQlgmwJQGpnfRVLhvbtyY5E8NNn1wY5rMpWzLGmv/2q9ZBRy8AuyygpKO/6xBNGE
         JLSO2VQF6IZ9A==
Date:   Wed, 4 Oct 2023 13:02:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, shenwei.wang@nxp.com
Subject: Re: [PATCH v3 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA
 drivers
Message-ID: <ZR0VFKzbl7Dt5KkR@matsya>
References: <20230824145834.2825847-1-Frank.Li@nxp.com>
 <b1c5ba0d-748f-ae2e-4a5f-e1e853161d16@infradead.org>
 <ZRWKH1gSwdLMhBCt@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRWKH1gSwdLMhBCt@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-23, 10:13, Frank Li wrote:
> On Thu, Aug 24, 2023 at 02:01:20PM -0700, Randy Dunlap wrote:
> > 
> > 
> > On 8/24/23 07:58, Frank Li wrote:
> > > Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Thanks for fixing. :)
> 
> @Vinod:
> 	ping

Can you please resend

-- 
~Vinod
