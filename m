Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E380364E7D8
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 08:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLPHkM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 02:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPHkL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 02:40:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438413B9DF;
        Thu, 15 Dec 2022 23:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8blW/F/+PwS1X5UjK3Cc7amh31WnyYbXAljrienDktY=; b=E5OMUfst49yaCfkqXi77SZaxJT
        0H2MxSDDIR0HbIiad0RvN2WLGjqw/Rj7X4um9Swgb4Yp3aupHCobR28+O6bVV+bF+AV2dFzCKP+g9
        d76Hvr7umyrkD2EbX1FjwwB60EiiYIwH6D96oIr2fuks0pBvn1yh1ZOmwgwpwKPixL5RwMQIUfmPV
        po1+ZVueIWcbMfwp0zOkSHb8fPV2DSADfFkcP5UEf33/Mnz0juOefPyMz3sEoaDB4E7ax3+ixF00L
        PTb7IBzIXnWLxNmCWvflpKt+2FMBnOkThFcHplIJQbmRFL002F8uLZ5x4Ek8lqGV4L2Q7qDaAOjhT
        V+A9amNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p65Jm-00DPrG-0W; Fri, 16 Dec 2022 07:39:42 +0000
Date:   Thu, 15 Dec 2022 23:39:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data
 allocation
Message-ID: <Y5wgvdnMWQDxkUd+@infradead.org>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
 <Y5rJJfZeVqliA5Rg@infradead.org>
 <20221215092721.tvz3hpaql3kotgnu@mobilestation>
 <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
 <20221215235218.wsuwy5uckqfxjnb6@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215235218.wsuwy5uckqfxjnb6@mobilestation>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 16, 2022 at 02:52:18AM +0300, Serge Semin wrote:
> Got it. Thanks for clarification. I'll resubmit the series with only
> the streaming DMA mask restoration.

Note that even for that we need to make sure there are no outstanding
mappings when you change the mask.

