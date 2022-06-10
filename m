Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46445467AD
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiFJNuu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiFJNuu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 09:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374FE3B3EE;
        Fri, 10 Jun 2022 06:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D3361B6F;
        Fri, 10 Jun 2022 13:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411AEC34114;
        Fri, 10 Jun 2022 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654869048;
        bh=LzCCdkkAAeprqISPgnN2yFeiAhB311EBNR/1sQdRT4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0UBfmPE/5a6NxNONEGxZvGMBjagLWxYEWP55NdTV5Xwaeg1dEhJZoKBPHv+W7JjE
         +R1diErQ0wV9tAJwNvC92duP1S42R8zfKFlv3uket5Ve12Y3oyEfz2DTHuqt4hKU2p
         g0lvhEhDcyp6jX3hy+Siol3eBjD7EtWlcxhKOf6R/Rtan8WQTIn+wSn741Yqv4PcUF
         h6e1WD47UA4+guqopiuPpkrrv96n5qq27SEPv1Md85ozq/TpJIM3bAE4zAIdrAD1/u
         +qNVYPVaCpBLXKtuN9Ooa3b9OWO6zrexT2t5AFoScgdaHRjeYSM3oaYdEXbOFEAp6x
         drOZLTtJKk2rg==
Date:   Fri, 10 Jun 2022 19:20:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3] dt-bindings: dma: fsl-edma: Convert to DT schema
Message-ID: <YqNMM/FyIZVK5Y6X@matsya>
References: <20220527020507.392765-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527020507.392765-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-05-22, 10:05, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the eDMA controller binding to DT schema.

This fails to apply for me, pls rebase and resend...

-- 
~Vinod
