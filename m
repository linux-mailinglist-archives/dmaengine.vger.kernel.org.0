Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A9671560
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 08:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjARHs1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 02:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjARHrC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 02:47:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C454121;
        Tue, 17 Jan 2023 23:15:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC5D1B81A7F;
        Wed, 18 Jan 2023 07:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCFFC433EF;
        Wed, 18 Jan 2023 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674026123;
        bh=oswTGct7uqfO1zJc7lc+OiWYf2C5d3wtbTuKilVFf2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uoCyU4c5xyWQfUmOagIswgZwedE5Dvg3e3KhOXKdFYdGy2TWV4wsaQWBRDw8bOk2z
         aJgnuXB2DUwKDU/sRs6hSjmTl8hqVC5YInezrDxl6bswni7OlAhjgrkha18x0VcbiT
         vLbFJFuNp+TzmcExiJkuq0m/j1cpfXT/QrItfysHQS3/dMyMMO84DwIl8D0wF/YHqd
         mcvk08qUdh/0Ag4SmwGfDIEU64hfh2pXaDBdGOKjBi4XlolfA9l8OqibnviCIZG/df
         RrBouVv0L06O1AwHFFlQvn9vJrUXi+AEcDu8R0Fhr7zzdfaoWm1QuSJz0lml5htA9s
         2fx3CfwTS+ddQ==
Date:   Wed, 18 Jan 2023 12:45:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: remove redundant config PCI
 dependency for some Synopsys DesignWare eDMA driver configs
Message-ID: <Y8ech6XHg7gMgruI@matsya>
References: <20230111121637.24708-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111121637.24708-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-01-23, 13:16, Lukas Bulwahn wrote:
> While reviewing dependencies in some Kconfig files, I noticed the redundant
> dependency "depends on PCI && PCI_MSI". The config PCI_MSI has always,
> since its introduction, been dependent on the config PCI. So, it is
> sufficient to just depend on PCI_MSI, and know that the dependency on PCI
> is implicitly implied.
> 
> Reduce the dependencies of configs DW_EDMA and DW_EDMA_PCIE.
> No functional change and effective change of Kconfig dependendencies.

Applied, thanks

-- 
~Vinod
