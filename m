Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F61B6B83DB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 22:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCMVSB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 17:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCMVSA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 17:18:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC919009;
        Mon, 13 Mar 2023 14:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B035EB81058;
        Mon, 13 Mar 2023 21:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282C3C433D2;
        Mon, 13 Mar 2023 21:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678742274;
        bh=RNZgWd9QC5n0z3iGMl1kUYPuyhL0ukCDE3/3h54eF0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KNMtxtnX/gum2ytfefDUfh5kMrWWeGlxTc9Q9iF0ph9d51/2o/AXMAdiDHwkugx6p
         mTZQit9R6F5RonZ1/QM+zCaMAPeiChSlN4yBklCQ8JH6qTlla9q8J9pE0zGhmVtas3
         mwnpaYiTDHyCpCNZDm2aL7/IqXv8QM8HmPwkSOMJmVMnQ1T0g38U7ds+FkrNt0WT06
         XX+ne0kAUAytJjGiMU33WUsGsEbZ54klN3Qubr0T63YIUqYcwbwPZvgohv9iCSY+aO
         BO7b80GDC/UhCVPE/zRgUOg5ziX6/0+4JLOUAVvfewcpk9PDLn1uwbvwPUA6djG7iV
         369P15wwZDwCw==
Date:   Mon, 13 Mar 2023 16:17:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/11] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230313211752.GA1541360@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313200816.30105-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 13, 2023 at 11:08:04PM +0300, Serge Semin wrote:
> ...
> Link: https://lore.kernel.org/linux-pci/20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Rebase onto the kernel 6.3-rc2.

This is fine, but just FYI that there's no need to rebase past -rc1
because PCI patches are applied on topic branches based on the PCI
"main" branch, typically -rc1.

Bjorn
