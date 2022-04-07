Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5554F79BE
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 10:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbiDGIcs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbiDGIcn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 04:32:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA91578D1
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 01:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA3BBB8174F
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 08:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E9C385A0;
        Thu,  7 Apr 2022 08:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649320240;
        bh=IEmIfmvDjDAuODcnl6zPz7PmfjuZn6iSpv14hlqDUDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmCEXZbd408Zz2y7hnodiPy882CHg0C+PfopsvMnDPaEE36IKRWNmRgmjefa5e8bp
         2elEi791fTI90o3DC2iLIkXC64kbBUPxZbuNFuJ3dTGcCyrpooOJ+XCiSpriWdDc68
         7DsVThZQGdBk+lI3TF1BOBxbukY6cPpvMWR7v4eLZQ0cgBQ/uSohWsssqNpdcf7YXS
         tQlCJar531QE1liYKyurnBy4WwSA4NBTxJ+5Ly6JfuwGStS36D9IKp0m8uvTaB2n8d
         m6TQT8C/zjE3TL5cWf4d6XuvJUaLOJaE08G5W8sShAyMWxVWc53UkxpQe9RenZcQmJ
         3U9XPfhWQThIA==
Date:   Thu, 7 Apr 2022 14:00:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 10/20] dmaengine: imx-sdma: error out on unsupported
 transfer types
Message-ID: <Yk6hK58PR4oPb0iy@matsya>
References: <20220405075959.2744803-1-s.hauer@pengutronix.de>
 <20220405075959.2744803-11-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405075959.2744803-11-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-04-22, 09:59, Sascha Hauer wrote:
> The i.MX SDMA driver currently silently ignores unsupported transfer
> types. These transfer types are specified in the dma channel description
> in the device tree, so they should really be checked.
> Issue a message and error out when we hit unsupported transfer types.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
