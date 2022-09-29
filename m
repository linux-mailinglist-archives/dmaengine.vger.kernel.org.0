Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC85EFB9A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiI2RIP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiI2RIN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 13:08:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F421CE915;
        Thu, 29 Sep 2022 10:08:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF7261F7A;
        Thu, 29 Sep 2022 17:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC068C433D6;
        Thu, 29 Sep 2022 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664471292;
        bh=vscq2et6oSamwmLIRjdpwIG1vCLfAuglQ9twz06Suzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ywx/Nj/IxLZ5E7ayWMNqefMNi535mMhvaSZiYM1djcYe1WYLEtVeZEMTpWUrJR1ee
         K4NzbPx6ubvJzBDmS+r74zG3fLJcxlnTYxLvQj6IKSQMa1ik5X6jeG03ss3m0Bsuzn
         cLRDwfKz63HTjiJ+sOVjGw/BfOzbYOHjmAsdhcVFNicE6O8K4mFL+Lpu9vNSm3lMtE
         jh8z4P2piu2aGX2ksRur6sMzGYjCW83eYg+Q9aFLyPxh0IgtW7AoTXPXFBNFOs30q4
         q7EusD69QR7c6xQw7fcLdgnwXEF5bqRuu55T7451Uy/V3uAdUuI5YOpAKMawgoicJE
         MSA3Tgzw8GgyQ==
Date:   Thu, 29 Sep 2022 22:38:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     gustavo.pimentel@synopsys.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2] dmaengine: dw-edma: Remove runtime PM support
Message-ID: <YzXQ+L27SKA2NOrd@matsya>
References: <20220910054700.12205-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910054700.12205-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-09-22, 11:17, Manivannan Sadhasivam wrote:
> Currently, the dw-edma driver enables the runtime_pm for parent device
> (chip->dev) and increments/decrements the refcount during alloc/free
> chan resources callbacks.
> 
> This leads to a problem when the eDMA driver has been probed, but the
> channels were not used. This scenario can happen when the DW PCIe driver
> probes eDMA driver successfully, but the PCI EPF driver decides not to
> use eDMA channels and use iATU instead for PCI transfers.
> 
> In this case, the underlying device would be runtime suspended due to
> pm_runtime_enable() in dw_edma_probe() and the PCI EPF driver would have
> no knowledge of it.
> 
> Ideally, the eDMA driver should not be the one doing the runtime PM of
> the parent device. The responsibility should instead belong to the client
> drivers like PCI EPF.
> 
> So let's remove the runtime PM support from eDMA driver.

Applied, thanks

-- 
~Vinod
